Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310535AbSCGVEC>; Thu, 7 Mar 2002 16:04:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310544AbSCGVDx>; Thu, 7 Mar 2002 16:03:53 -0500
Received: from smtp2.vol.cz ([195.250.128.42]:53521 "EHLO smtp2.vol.cz")
	by vger.kernel.org with ESMTP id <S310535AbSCGVDj>;
	Thu, 7 Mar 2002 16:03:39 -0500
Date: Thu, 7 Mar 2002 22:00:15 +0100
From: Pavel Machek <pavel@suse.cz>
To: fchabaud@free.fr
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: swsusp is at it... again and again
Message-ID: <20020307210013.GB451@elf.ucw.cz>
In-Reply-To: <20020306233509.GA576@elf.ucw.cz> <200203071402.g27E2rr12847@colombe.home.perso>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200203071402.g27E2rr12847@colombe.home.perso>
User-Agent: Mutt/1.3.27i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >> > After about 20 resume cycles (compiled kernel with swsusp making
> >> > machine suspend/resume) I got that nasty FS corruption, again.
> >> > 
> >> > So... 
> >> > 
> >> > 1) Maybe your ext3 patches are not at fault.
> >> 
> >> I suspect all this come from suspension failure and immediate resume. I
> >> have reenabled your panic ! I believe that if a task isn't stopped and
> >> suspension is aborted (calling thaw_process and so on) something is
> >> altered. Maybe resuming assumes implicitely a state that is not
> >> completely reached when a task cannot be stopped.
> > 
> > I don't think that's it. But I have another suspect:
> > 
> > mark_swapfiles in do_magic_resume_2. Oh, and you should also kill it
> > from do_magic_suspend_*. Its writing on filesystem during resume, and
> > it does not seem too safe.
> 
> Sh... That's a mail I sent you and that was lost: all the oops I have
> observed occur with calltrace
> c0123398 t do_magic_resume_2
> c0123694 t do_magic
> c012389c t do_software_suspend
> c011a8bc T __run_task_queue
> with EIP
> c0122754 t mark_swapfiles
> 
> Do you mean we should simply not call mark_swapfiles any more ?

I gave it second thought...

We *must* write to swapfiles during suspend. Doing it during resume
should be very similar to writing during suspend....

If you simply comment it out, it will refuse to suspend second
time. If you comment out even "SWAP-FILE" check, it should work... I'd
be very interested if it helps, but it would also confuse me a lot.
									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
