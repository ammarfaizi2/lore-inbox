Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265544AbTIDVHe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 17:07:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265529AbTIDVHO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 17:07:14 -0400
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:25050 "EHLO
	mail-in-03.arcor-online.net") by vger.kernel.org with ESMTP
	id S265323AbTIDVFM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 17:05:12 -0400
From: Daniel Phillips <phillips@arcor.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: precise characterization of ext3 atomicity
Date: Thu, 4 Sep 2003 23:08:54 +0200
User-Agent: KMail/1.5.3
Cc: reiser@namesys.com, reiserfs-list@namesys.com,
       linux-kernel@vger.kernel.org
References: <3F574A49.7040900@namesys.com> <200309042216.04121.phillips@arcor.de> <20030904131052.6ec6426d.akpm@osdl.org>
In-Reply-To: <20030904131052.6ec6426d.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309042308.54002.phillips@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 04 September 2003 22:10, Andrew Morton wrote:
> Daniel Phillips <phillips@arcor.de> wrote:
> > On Thursday 04 September 2003 17:55, Andrew Morton wrote:
> > > Hans Reiser <reiser@namesys.com> wrote:
> > > > Is it correct to say of ext3 that it guarantees and only guarantees
> > > > atomicity of writes that do not cross page boundaries?
> > >
> > > Yes.
> >
> > Is that just happenstance, or does Posix or similar mandate it?
>
> Happenstance.
>
> It's semi-trivial to do this in ext3.  You'd open the file with O_ATOMIC
> and a write() would either be completely atomic or would return -EFOO
> without having written anything.
>
> The thing which prevents this is the ranking order between journal_start()
> and lock_page().
>
> It's not trivial but also not too hard to change things so that
> journal_start() can rank outside lock_page() - this would also offer some
> CPU savings.
>
> Can't say that I'm terribly motivated about the feature though.

I'm relieved, I have always thought that some higher level synchronization is 
required for simultaneous writes.  So Hans might as well tell his fans that 
Ext3 makes no official guarantee, and neither does Linux.

Regards,

Daniel

