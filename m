Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932196AbWFUPnh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932196AbWFUPnh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 11:43:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751324AbWFUPnh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 11:43:37 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:24523 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751294AbWFUPng (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 11:43:36 -0400
Date: Wed, 21 Jun 2006 11:43:20 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Ryan McAvoy <ryan.sed@gmail.com>
cc: LKML <linux-kernel@vger.kernel.org>, linux-mips@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       john.cooper@timesys.com
Subject: Re: realtime-preempt for MIPS - compile problem with rwsem
In-Reply-To: <642640090606210804k282085efm84476af3a8fa08b1@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0606211125590.29348@gandalf.stny.rr.com>
References: <642640090606201208g31a0a57bm268910b026ccd335@mail.gmail.com> 
 <Pine.LNX.4.58.0606210354050.29673@gandalf.stny.rr.com>
 <642640090606210804k282085efm84476af3a8fa08b1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 21 Jun 2006, Ryan McAvoy wrote:

> > First, whenever sending mail about the -rt patch, always CC Ingo (and
> > perhaps Thomas Gliexner and myself).
>
> Thanks, I will do that.

Ingo is the important one.  Thomas and I are just the janitors
Although Thomas is chief janitor :)

>
> > 2.6.15 had lots of problems with -rt.  Mainly the patch went through some
> > major rework, and Ingo was busy getting mutexes into mainline.  So the
> > 2.6.15-rtX was sort of neglected.  It would be best to use 2.6.16-rtX and
> > maybe even 2.6.17-rtX
> >
> > Which also comes the question: Which -rt patch are you actually trying?
>
> patch-2.6.15-rt21 .  I have also tried using the 2.6.16 kernel and

Hmm, 15-rt21 may have stabilized a bit. But I do still think the 16 series
is much more stable.

> patch-2.6.16-rt29 and have the same problems with it.  (I may be
> constrained in having to use a 2.6.15 kernel ... but would be happy to
> get 2.6.16 working /stable as a starting point.)
>
> > Yep, try the following patch: (completey untested since I don't have a
> > mips machine).
> >
> >  config RWSEM_GENERIC_SPINLOCK
> >         bool
> > -       depends on !PREEMPT_RT
> > +       depends on PREEMPT_RT
> >         default y
>
> I did just that when I first started with these patches and did
> succeed in getting it compiling and booting.  The resulting kernel,
> however, is very unstable and hangs frequently with no output.  (It
> will hang within hours if left idle.  I can hang it more quickly by
> attempting to use it).  I have deadlock detection turned on and have
> confirmed that it does produce output at least for some deadlocks:
> http://groups.google.com/group/linux.kernel/browse_frm/thread/1559667001b7da2d/2558b539a5adc660?lnk=st&q=realtime+preempt+mips&rnum=2&hl=en#2558b539a5adc660
> In the more common hangs though, I get no output.

That output looks like it had a deadlock on the serial output of sysrq
key.  But that back trace looks screwy.

>
> I decided to review the changes I made in getting it to compile and
> was hoping that this one may be the cause of the instability.  I
> thought that perhaps this change was incorrect because
> include/asm-mips/rwsem.h is introduced by the rt-preempt patch and

Ha, you're right!  (added John Cooper to this so he can clean up this mess
;)

> would only be used if RWSEM_GENERIC_SPINLOCK was off.  [As well, it
> seemed like something fundamental enough to account for the general
> instability I am seeing.]
>

Perhaps you can post all the changes you made as a patch to see if
something else is wrong.  It might also be best to see if you can get the
latest working (2.6.17-rtX) and work your way backwards to the kernel
version you really need.

-- Steve
