Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263993AbUDVMZe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263993AbUDVMZe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 08:25:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263994AbUDVMZe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 08:25:34 -0400
Received: from mx1.redhat.com ([66.187.233.31]:57292 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263993AbUDVMZc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 08:25:32 -0400
Date: Thu, 22 Apr 2004 14:25:00 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390 (9/9): no timer interrupts in idle.
Message-ID: <20040422122459.GE27339@devserv.devel.redhat.com>
References: <OF694C3C12.232234B8-ONC1256E7E.00423882-C1256E7E.004344A0@de.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HWvPVVuAAfuRc6SZ"
Content-Disposition: inline
In-Reply-To: <OF694C3C12.232234B8-ONC1256E7E.00423882-C1256E7E.004344A0@de.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--HWvPVVuAAfuRc6SZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 22, 2004 at 02:14:44PM +0200, Martin Schwidefsky wrote:
> > What I'm proposing as alternative is using the one shot mode of the
> timers
> > on most machines to do teh following:
> > when the timer irq hits, you do the business you need to do. And then you
> > check all existing timers and the scheduler when the next "virtual tick"
> is where
> > you're going to do real work. You then set the one-shot counter to that
> > amount. This means that in add_timer/mod_timer you will need to check if
> the
> > just added timer is before the current one-shot runs out, and if so,
> adjust
> > it. Perhaps in the scheduler too.
> 
> You can't do that with the current timer code. A HZ timer interrupt is used
> for several things: 1) increase jiffies_64, 2) update the xtime, 3) calculate
> the load every 5 seconds, 4) check cpu time limits and send SIGXCPU,
> 5) do interval timer stuff, 6) run local timer queue and 7) add time slice to
> current process. With your one-shot timer you won't do the correct updates
> to the jiffies and the xtime.

xtime is easy, that's interpolated anyway afaics. Jiffies would either just
jump some, which code needs to deal with anyway given that preempt can do
the same, or would become an approximated thing as well based on the other
time keeping sources in the system.

calculating the load can be a real timer for sure (which would cause an irq
at that time), cpu limits we can do at the end of timeslice (and set the
timeslice such that the limits won't be exceeded).

--HWvPVVuAAfuRc6SZ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAh7mbxULwo51rQBIRAmtYAJ9du4v5CG35TzKsiShFiFxEuR4kqwCfWhUD
k9QkWMJFxgfBMOYDUJBvsTk=
=xG0u
-----END PGP SIGNATURE-----

--HWvPVVuAAfuRc6SZ--
