Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264850AbTIDU2M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 16:28:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264884AbTIDU2L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 16:28:11 -0400
Received: from fw.osdl.org ([65.172.181.6]:64967 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264850AbTIDU17 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 16:27:59 -0400
Date: Thu, 4 Sep 2003 13:10:52 -0700
From: Andrew Morton <akpm@osdl.org>
To: Daniel Phillips <phillips@arcor.de>
Cc: reiser@namesys.com, reiserfs-list@namesys.com,
       linux-kernel@vger.kernel.org
Subject: Re: precise characterization of ext3 atomicity
Message-Id: <20030904131052.6ec6426d.akpm@osdl.org>
In-Reply-To: <200309042216.04121.phillips@arcor.de>
References: <3F574A49.7040900@namesys.com>
	<20030904085537.78c251b3.akpm@osdl.org>
	<200309042216.04121.phillips@arcor.de>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips <phillips@arcor.de> wrote:
>
> On Thursday 04 September 2003 17:55, Andrew Morton wrote:
> > Hans Reiser <reiser@namesys.com> wrote:
> > > Is it correct to say of ext3 that it guarantees and only guarantees
> > > atomicity of writes that do not cross page boundaries?
> >
> > Yes.
> 
> Is that just happenstance, or does Posix or similar mandate it?

Happenstance.

It's semi-trivial to do this in ext3.  You'd open the file with O_ATOMIC
and a write() would either be completely atomic or would return -EFOO
without having written anything.

The thing which prevents this is the ranking order between journal_start()
and lock_page().

It's not trivial but also not too hard to change things so that
journal_start() can rank outside lock_page() - this would also offer some
CPU savings.

Can't say that I'm terribly motivated about the feature though.

