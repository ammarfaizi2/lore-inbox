Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263632AbUEPP3w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263632AbUEPP3w (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 11:29:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263629AbUEPP3w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 11:29:52 -0400
Received: from nacho.zianet.com ([216.234.192.105]:31502 "HELO
	nacho.zianet.com") by vger.kernel.org with SMTP id S263642AbUEPP3e
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 11:29:34 -0400
From: Steven Cole <elenstev@mesatop.com>
To: Andrea Arcangeli <andrea@suse.de>
Subject: Re: 1352 NUL bytes at the end of a page? (was Re: Assertion `s && s->tree' failed: The saga continues.)
Date: Sun, 16 May 2004 09:28:21 -0600
User-Agent: KMail/1.6.1
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       adi@bitmover.com, scole@lanl.gov, support@bitmover.com,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200405132232.01484.elenstev@mesatop.com> <Pine.LNX.4.58.0405152147220.25502@ppc970.osdl.org> <20040516052220.GU3044@dualathlon.random>
In-Reply-To: <20040516052220.GU3044@dualathlon.random>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405160928.22021.elenstev@mesatop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 15 May 2004 11:22 pm, Andrea Arcangeli wrote:
> On Sat, May 15, 2004 at 09:52:50PM -0700, Linus Torvalds wrote:
> > 
> > 
> > On Sat, 15 May 2004, Steven Cole wrote:
> > > 
> > > OK, will do.  I ran the bk exerciser script for over an hour with 2.6.6-current
> > > and no CONFIG_PREEMPT and no errors.  The script only reported one
> > > iteration finished, while I got it to do 36 iterations over several hours earlier
> > > today (with a 2.6.3-4mdk vendor kernel)
> > 
> > Hmm.. Th ecurrent BK tree contains much of the anonvma stuff, so this 
> > might actually be a serious VM performance regression. That could 
> > effectively be hiding whatever problem you saw.
> > 
> > Andrea: have you tested under low memory and high fs load? Steven has 384M
> > or RAM, which _will_ cause a lot of VM activity when doing a full kernel
> > BK clone + undo + pull, which is what his test script ends up doing...
> 
> An easy way to verify for Steven is to give a quick spin to 2.6.5-aa5
> and see if it's slow too, that will rule out the anon-vma changes
> (for completeness: there's a minor race in 2.6.5-aa5 fixed in my current
> internal tree, I posted the fix to l-k separately, but you can ignore
> the fix for a simple test, it takes weeks to trigger anyways and you
> need threads to trigger it and I've never seen threaded version control
> systems so I doubt BK is threaded).

I'm getting the linux-2.6.5.tar.bz2 file (already got 2.6.5-aa2) via ppp,
while running the bk test script on 2.6.6-current and no PREEMPT.
That takes a while on 56k dialup.  I'll leave all that running while
I go hiking.

> 
> In general a "slowdown" cannot be related to anon-vma (unless it's a
> minor merging error), that's a black and white thing, it doesn't touch
> the vm heuristics and it will only speed the fast paths up plus it will
> save some tons of ram in the big systems. Pratically no change should be
> measurable on a small system (unless it uses an heavy amount of cows, in
> which case it will improve things, it should never hurt).  As for being
> tested, it is very well tested on the small desktops too. Probably the
> only thing to double check is that there was no minor merging error that
> could have caused this.

Andrea, I did see a significant slowdown with Andy's test script (with DMA on)
on my timed test of 2.6.6-current vs 2.6.3.

> 
> > It would be good to test going back to the kernel that saw the "immediate 
> > problem", and try that version without CONFIG_PREEMPT. 
> 
> Agreed.
> 
> Thanks.
> 
> 

Yep, later this evening, I hope.

Steven
