Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751802AbWCOQ0q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751802AbWCOQ0q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 11:26:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752128AbWCOQ0q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 11:26:46 -0500
Received: from rwcrmhc13.comcast.net ([204.127.192.83]:2023 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S1751802AbWCOQ0q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 11:26:46 -0500
Message-ID: <44184002.4010109@comcast.net>
Date: Wed, 15 Mar 2006 11:25:38 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mail/News 1.5 (X11/20060309)
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: 2.6.16-rc6-rt1
References: <20060312220218.GA3469@elte.hu>
In-Reply-To: <20060312220218.GA3469@elte.hu>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

So Ingo, when are we going to see these in the mainline kernel yet?  I
am particularly interested in priority inheriting semaphores; it seems
like brain damage to have something spin_lock() and block a higher
priority process while other mid-priority processes (i.e. higher than
the blocker but lower than the blocked) are given execution priority.
As I understand, the PI code fixes this by inheriting the priority of
the highest blocked process on a lock into whatever process is holding
the lock, which sounds like exactly what should be happening.

Ingo Molnar wrote:
> i have released the 2.6.16-rc6-rt1 tree, which can be downloaded from 
> the usual place:
> 
>    http://redhat.com/~mingo/realtime-preempt/
> 
> again, lots of changes all over the map:
> 
> - firstly, the -rt tree has been rebased to 2.6.16-rc6, which was a more
>   complex operation than usual, due to the many changes in 2.6.16 (in 
>   particular the mutex code).
> 
> - the PI code got reworked again, this time by Thomas Gleixner. The
>   priority boosting chain is now instantaneous again (and not 
>   wakeup/scheduling based) - but the previous list-walking hell has been 
>   avoided via the clever use of plists. Plus many other changes and
>   lots of cleanups to the rt-mutex proper.
> 
> - the rt-SLAB code got reworked too - hopefully for the better.
> 

I have not heard anything about your SLAB code before.  Think you can
give me a basic idea of what it's supposed to do?

> - there's also a completely new PI-futex approach included, ontop of the
>   robust-list futex feature. All combinations of PI and robustness are
>   supported: default non-robust non-PI futexes, robust+PI, !robust+PI,
>   PI+!robust futexes.
> 

I don't know what non-robust futex means.  Also don't you mean
!robust+!PI (00), robust+PI (11), !robust+PI (01), robust+!PI (10)?  The
last two on your list look to be the same thing :)

> - new latency tracer feature: print every function call done by the
>   kernel to the console - useful to debug early bootup hangs or other
>   nasty bugs.
> 
> - plus zillions of bugfixes (and no doubt new regressions).
> 

Regressions are going to be the answer to my "when is some of this going
into mainline" question, aren't they :P

> to build a 2.6.16-rc6-rt1 tree, the following patches should be applied:
> 
>   http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.15.tar.bz2
>   http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.16-rc6.bz2
>   http://redhat.com/~mingo/realtime-preempt/patch-2.6.16-rc6-rt1
> 
> 	Ingo
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

    Creative brains are a valuable, limited resource. They shouldn't be
    wasted on re-inventing the wheel when there are so many fascinating
    new problems waiting out there.
                                                 -- Eric Steven Raymond

    We will enslave their women, eat their children and rape their
    cattle!
                                     -- Evil alien overlord from Blasto
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iQIVAwUBRBhAAAs1xW0HCTEFAQIVPw//Zi/pqBvMlu0kPIlDQ6jfe5LuU1aJ8iaV
g/1K7G0RV+PVkUE6LFgeTwtYPBaCCjELY6aU1zQa/8pPKofOXB7Rd5PYSXqzoVtr
n0Wdpjwkz7sTjY15b6WtfymHgPxukin8JytFzdmITuD+oYOuP5W1zfXgHnYmghpM
QnCuEmvbmpEQmLHrLgAjpjT4h9dwbCGqMm3RWk1mE6vo08hU7P8bX+qtYJ20kOXJ
dYh/ZU0TkFxIoa4GC1eSe+w5zawyIpldHthswwom61MXz8yb5cNfXRwv+zv1TpHW
lvnefxkQLya1cRQME34Pb37PRnylg2TH7DRmPDxOfZ4hTFHoZ6nGWSRBIBe1PQT6
Za+aeSqFuYKI4qevDXrzwKoEb4AqLsVdvhl/+/HB+meKI3pn0ceeAvuRv4dJsBXx
is5eejtoc4lTzNbbOaOMyTOB6TFjdIN0opRN8HLrLkU/JR6aLyeZfaMEEA9Qasfr
9u2Zacphepgmw9gqnVGWhhrliQP8FluE2lt+JluLDMgkbXQHnzjRrDK75c66OB3J
a/QJH/pAtM3xIs/cqmnoOz5Exz6v42QywYoRJ5xxG0pV4e/DWLTn+fByRcZaYYo4
2EaNChymEI8kgzKuuTByWcxzGi02zMgW5Af21QVl7sF6H1iQGQpkKIGAz0we64lK
UW+yDCaQrTU=
=LapY
-----END PGP SIGNATURE-----
