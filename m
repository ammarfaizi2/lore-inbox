Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264147AbUGIEwp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264147AbUGIEwp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 00:52:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264251AbUGIEwp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 00:52:45 -0400
Received: from fw.osdl.org ([65.172.181.6]:25001 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264147AbUGIEwm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 00:52:42 -0400
Date: Thu, 8 Jul 2004 21:51:28 -0700
From: Andrew Morton <akpm@osdl.org>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: nickpiggin@yahoo.com.au, petero2@telia.com, linux-kernel@vger.kernel.org
Subject: Re: Can't make use of swap memory in 2.6.7-bk19
Message-Id: <20040708215128.3eefda8b.akpm@osdl.org>
In-Reply-To: <20040709025046.GU21066@holomorphy.com>
References: <m2brir9t6d.fsf@telia.com>
	<40ECADF8.7010207@yahoo.com.au>
	<20040708023001.GN21066@holomorphy.com>
	<m2briq7izk.fsf@telia.com>
	<20040708193956.GO21066@holomorphy.com>
	<40EDED5D.80605@yahoo.com.au>
	<20040709015317.GR21066@holomorphy.com>
	<40EDFDBE.5040805@yahoo.com.au>
	<20040709020905.GT21066@holomorphy.com>
	<20040708191254.2475c8d1.akpm@osdl.org>
	<20040709025046.GU21066@holomorphy.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>
> William Lee Irwin III <wli@holomorphy.com> wrote:
> >> Enumerate those more basic things.
> 
> On Thu, Jul 08, 2004 at 07:12:54PM -0700, Andrew Morton wrote:
> > 1: work out why it's prematurely calling out_of_memory() when laptop_mode=1.
> 
> The obvious difference in writeback policy.

The writeback code isn't in the picture with this workload - there's no
dirty pagecache around.

> I've apparently touched on policy, and paid for that mistake with an
> overpoweringly Sterculian whiff of penguins. Now backing away slowly...

Not sure what that means.

The problem is trivial to reproduce.  Killing these lines in shrink_list():

			if (laptop_mode && !sc->may_writepage)
				goto keep_locked;

makes it go away.  Something's out of whack in there, and the removal of
the free swapspace test exposed some prior problem.  I'll poke at it some
more.
