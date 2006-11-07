Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753866AbWKGXPM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753866AbWKGXPM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 18:15:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753867AbWKGXPM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 18:15:12 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:65496 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1753866AbWKGXPK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 18:15:10 -0500
Date: Wed, 8 Nov 2006 00:14:56 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc: Albert Cahalan <acahalan@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: 2048 CPUs [was: Re: New filesystem for Linux]
Message-ID: <20061107231456.GB7796@elf.ucw.cz>
References: <787b0d920611041154l69db46abv4c8c467809ada57c@mail.gmail.com> <Pine.LNX.4.64.0611042332240.20974@artax.karlin.mff.cuni.cz> <20061107212614.GA6730@ucw.cz> <Pine.LNX.4.64.0611072328220.10497@artax.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0611072328220.10497@artax.karlin.mff.cuni.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >Lets say time-spent-outside-spinlock == time-spent-in-spinlock and
> >number-of-cpus == 2.
> >
> >1 < 2 , so it should livelock according to you...
> 
> There is off-by-one bug in the condition. It should be:
> (time_spent_in_spinlock + time_spent_outside_spinlock) / 
> time_spent_in_spinlock < number_of_cpus
> 
> ... or if you divide it by time_spent_in_spinlock:
> time_spent_outside_spinlock / time_spent_in_spinlock + 1 < number_of_cpus
> 
> >...but afaict this should work okay. Even if spinlocks are very
> >unfair, as long as time-outside and time-inside comes in big chunks,
> >it should work.
> >
> >If you are unlucky, one cpu may stall for a while, but... I see no
> >livelock.
> 
> If some rogue threads (and it may not even be intetional) call the same 
> syscall stressing the one spinlock all the time, other syscalls needing 
> the same spinlock may stall.

Fortunately, they'll unstall with probability of 1... so no, I do not
think this is real problem.

If someone takes semaphore in syscall (we do), same problem may
happen, right...? Without need for 2048 cpus. Maybe semaphores/mutexes
are fair (or mostly fair) these days, but rwlocks may not be or
something.

									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
