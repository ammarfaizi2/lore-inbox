Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750816AbWGCVeF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750816AbWGCVeF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 17:34:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750755AbWGCVeF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 17:34:05 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:27284 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750775AbWGCVeE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 17:34:04 -0400
Date: Mon, 3 Jul 2006 23:33:53 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-acpi@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.17-mm3: swsusp fails when process is debugged by ptrace
Message-ID: <20060703213353.GC1674@elf.ucw.cz>
References: <44A2B9AF.50803@goop.org> <20060628212616.GB30373@elf.ucw.cz> <44A2FA20.3020809@goop.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44A2FA20.3020809@goop.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >Does it also happen when you do strace? ...I remember trying to solve
> >that, but 2.6.17-mm3 is very recent...?
> 
> I could suspend while running "strace sleep 100" without any problem.
> 
> I think the issue is when the process is blocked in T state,
> freeze_process() tries to kick the process with signal_wake_up(p, /*
> resume=0 */ 0), but with resume=0 it will only wake processes in
> TASK_INTERRUPTIBLE state.  With resume=1, it will also kick STOPPED and
> TRACED processes.  I also tried suspending while I had a process in T
> state caused by kill -STOP, and that worked, so some part of the puzzle
> is still missing.

So... does signal_wake_up(p, 1) fix it?

> I noticed that when I ran sleep 100 under strace over the suspend/resume
> cycle, its nanosleep() syscall was interrupted and not restarted.

I'm afraid there may be more problems lurking in the refrigerator.

(If this is going to take more than few mail iterations... perhaps you
should start bug at bugzilla.kernel.org?)
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
