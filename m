Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274743AbRIUDO3>; Thu, 20 Sep 2001 23:14:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274670AbRIUDOU>; Thu, 20 Sep 2001 23:14:20 -0400
Received: from blount.mail.mindspring.net ([207.69.200.226]:51991 "EHLO
	blount.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S274669AbRIUDOO>; Thu, 20 Sep 2001 23:14:14 -0400
Subject: Re: [PATCH] Significant performace improvements on reiserfs systems
From: Robert Love <rml@tech9.net>
To: Andrew Morton <akpm@zip.com.au>
Cc: george anzinger <george@mvista.com>, Andrea Arcangeli <andrea@suse.de>,
        Dieter =?ISO-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
        Chris Mason <mason@suse.com>, Beau Kuiper <kuib-kl@ljbc.wa.edu.au>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        ReiserFS List <reiserfs-list@namesys.com>
In-Reply-To: <3BAA95E0.5BEB8990@zip.com.au>
In-Reply-To: <20010920170812.CCCACE641B@ns1.suse.com>
	<3BAA29C2.A9718F49@zip.com.au> <1001019170.6090.134.camel@phantasy>
	<200109202112.f8KLCXG16849@zero.tech9.net>
	<1001024694.6048.246.camel@phantasy> <20010921003742.I729@athlon.random>
	<1001026597.6048.278.camel@phantasy> <20010921011514.M729@athlon.random>
	<3BAA8BDA.5EED2879@mvista.com>  <3BAA95E0.5BEB8990@zip.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Evolution-Format: text/plain
X-Mailer: Evolution/0.13.99+cvs.2001.09.20.15.42 (Preview Release)
Date: 20 Sep 2001 23:14:21 -0400
Message-Id: <1001042065.7291.35.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2001-09-20 at 21:20, Andrew Morton wrote:
> This may not be practical.
> 
> Take, for example, zap_page_range().   It simply has a lot
> of work to do, and it does it inside a spinlock.  By doing
> it in a tight loop, it's optimal.
> 
> There is no way to speed this function up by two or three orders
> of magnitude.  (Well, there is: don't take the lock at all if
> the mm isn't shared, but this is merely an example.  There are
> other instances).

Agreed, but...

> It seems that for a preemptive kernel to be successful, we need
> to globally alter the kernel so that it never holds locks for
> more than 500 microseconds.  Which is what the conditional_schedule()
> (aka cooperative multitasking :)) patches do.
>
> It seems that there are no magic bullets, and low latency will
> forever have a global impact on kernel design, unless a way is
> found to reschedule with locks held.  I recall that a large
> part of the MontaVista patch involved turning spinlocks into
> semaphores, yes?  That would seem to be the way to go.

This would be the situation that solved the problem with little
complaint, huh?

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

