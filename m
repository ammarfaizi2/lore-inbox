Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267112AbTAVArp>; Tue, 21 Jan 2003 19:47:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267130AbTAVArp>; Tue, 21 Jan 2003 19:47:45 -0500
Received: from air-2.osdl.org ([65.172.181.6]:10895 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267112AbTAVArn>;
	Tue, 21 Jan 2003 19:47:43 -0500
Date: Tue, 21 Jan 2003 16:51:38 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Jim Houston <jim.houston@attbi.com>
cc: <linux-kernel@vger.kernel.org>,
       <high-res-timers-discourse@lists.sourceforge.net>
Subject: Re: posix timers patch comments.
In-Reply-To: <3E2DD8CB.5B984772@attbi.com>
Message-ID: <Pine.LNX.4.33L2.0301211613360.30777-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jan 2003, Jim Houston wrote:

| "Randy.Dunlap" wrote:
| >
| > Hi Jim,
| >
| > I'm reviewing both George's and your POSIX/high-res-timers patches.
| > I might not send you comments every time that I come across something,
| > and I might not cc lkml on every comment (unless you want me to).
| >
| > Anyway, here's a beginning.
| >
| > In functions get_eip(), check_expiry(), and run_posix_timers(),
| > the <regs> parameter is a void *.  Linus generally doesn't like
| > void * parameters, so they should be avoided as much as possible,
| > and I don't see any reason that <regs> in all of these can't be
| > declared as <struct pt_regs *> instead of <void *>.  Is there a
| > good reason?
| >
| > BTW, when do expect to have any updated patches?
|
| Hi Randy,
|
| It makes sense to include lkml in the discussion.  It's an
| interesting balancing act.  If you openly criticize code that you
| hope will be included in the kernel, you risk having your arguments
| used as a reason for its rejection.  If there is no visible discussion,
| the patch will be perceived as un-reviewed.

Yes, I'm aware of the tradeoffs and I expect to discuss most of it
openly, but I don't know that all nitpicking needs to be.
It could have negative effects, as you imply.

And some of my comments are just questions about "how does so-and-so
work?".  But I guess they won't be any more noise than we've had
lately.

| The code that uses get_eip() is just debug.  It may go away soon.
| I was feeling lazy and didn't want to chase down the header files needed
| to for "struct pt_regs".  I just made the change and it was easy.
| It turns out that pt_regs was already defined. I also found the
| instruction_pointer() macro so I can get rid of the get_eip() function I
| added.  The timer code has to deal with timer overruns so it always
| calculates the amount of time that a time interrupt is delayed.  I'm logging
| the EIP values which correspond to these long interrupt lockouts.

OK, thanks.

| I'm not sure when I will do the next patch.  I only have a few small
| changes in the queue.  I'm tempted to put it off a few days.

OK.


Here are some more comments and questions.  I still don't understand
all of the code, so I'm not commenting on the guts of it just yet.
This is mostly about style.  I do have some code comments, but
I don't want to mix them in here.


1.  In include/linux/posix-timers.h:

Keeping with current style, these should be all caps (for "linux"):
+#ifndef _linux_POSIX_TIMERS_H
+#define _linux_POSIX_TIMERS_H

No other files in include/linux/*.h use this "linux" convention.

Same header file:  I think that you can lose this comment.
+/* This should be in posix-timers.h - but this is easier now. */

Same header file:
Why is sys_timer_delete() the only (new) syscall that has a prototype?
+asmlinkage int sys_timer_delete(timer_t timer_id);


2.  In include/linux/sys.h:
Increases NR_syscalls by 6 more than needed?

3.  +#define NSEC_PER_SEC (1000000000L)

Would you use NSEC_PER_SEC instead of "1000000000" in the source code
in several places?  My eyes get tired of counting the zeros.

4.  From include/linux/id2ptr.h, ID_FULL is unused.

5.  From include/linux/time.h, MAX_CLOCKS is unused.

6.  (general:) Use of "return(val);" : lose the parens.  No, it's not
mentioned in Documentation/CodingStyle, but it is the preferred style
by more than 10 to 1 in my quick research.



More tomorrow...

-- 
~Randy

