Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261228AbTCFXRa>; Thu, 6 Mar 2003 18:17:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261224AbTCFXRa>; Thu, 6 Mar 2003 18:17:30 -0500
Received: from mailout06.sul.t-online.com ([194.25.134.19]:55486 "EHLO
	mailout06.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261208AbTCFXR1>; Thu, 6 Mar 2003 18:17:27 -0500
Date: Fri, 7 Mar 2003 00:27:31 +0100
From: Martin Waitz <tali@admingilde.org>
To: Robert Love <rml@tech9.net>
Cc: Linus Torvalds <torvalds@transmeta.com>, Andrew Morton <akpm@digeo.com>,
       mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: [patch] "HT scheduler", sched-2.5.63-B3
Message-ID: <20030306232730.GC1326@admingilde.org>
Mail-Followup-To: Robert Love <rml@tech9.net>,
	Linus Torvalds <torvalds@transmeta.com>,
	Andrew Morton <akpm@digeo.com>, mingo@elte.hu,
	linux-kernel@vger.kernel.org
References: <20030228202555.4391bf87.akpm@digeo.com> <Pine.LNX.4.44.0303051910380.1429-100000@home.transmeta.com> <20030306220307.GA1326@admingilde.org> <1046988457.715.37.camel@phantasy.awol.org> <20030306223518.GB1326@admingilde.org> <1046991366.715.52.camel@phantasy.awol.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Y5rl02BVI9TCfPar"
Content-Disposition: inline
In-Reply-To: <1046991366.715.52.camel@phantasy.awol.org>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Y5rl02BVI9TCfPar
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hi :)

On Thu, Mar 06, 2003 at 05:56:06PM -0500, Robert Love wrote:
> On Thu, 2003-03-06 at 17:35, Martin Waitz wrote:
>=20
> > processes tend to max out at one extreme or the other
> >=20
> > processes that get stalled by a huge overall load of the machine
> > are forced to sleep, too; yet they are not interactive.
>=20
> Not running !=3D Sleeping

schedule() does prev->sleep_timestamp =3D jiffies; just before
deactivating prev.
so i guess inactivity is counted towards sleep_avg, too

> A process may have a 100ms timeslice, but only run for 1ms at a time
> (100x before recalculating its quanta).
but it _can_ use the 100ms at a time if it is cpu-bound
what's so bad about recalculating the quantum?

> This is the intention of giving large timeslices to interactive tasks:
> not that they need all 100ms at _once_ but they may need some of it
> soon, and when they need it they really NEED it, so make sure they
> have enough timeslice such that there is plenty available when they
> wake up (since the latency is important, as you said).
but most of the time, not _one_ process is waken up, but several at once

if it happens that the first who gets to run is cpu-bound,
then all other interactive processes have to wait a long time, even
if they would only need 1ms to finish their work.

scheduling overhead was successfully brought down to a minimum
thanks to the great work of a lot of people.
i think we should use that work to improve latency by reducing
the available timeslice for interactive processes.

if the process is still considered interactive after the time slice had run
out, nothing is lost; it simply gets another one.

but the kernel should get the chance to frequently reschedule
when interactivity is needed.

> Once a process stalls other processes (i.e. by running a long time i.e.
> by being a CPU hog) then it loses its interactive bonus.
but it takes too long. 100ms is noticeable

> I suggest you read the code.
i've read it ;)

--=20
CU,		  / Friedrich-Alexander University Erlangen, Germany
Martin Waitz	//  [Tali on IRCnet]  [tali.home.pages.de] _________
______________/// - - - - - - - - - - - - - - - - - - - - ///
dies ist eine manuell generierte mail, sie beinhaltet    //
tippfehler und ist auch ohne grossbuchstaben gueltig.   /
			    -
Wer bereit ist, grundlegende Freiheiten aufzugeben, um sich=20
kurzfristige Sicherheit zu verschaffen, der hat weder Freiheit=20
noch Sicherheit verdient.            Benjamin Franklin (1706 - 1790)

--Y5rl02BVI9TCfPar
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+Z9lij/Eaxd/oD7IRAsE0AJwKuqgRhUYU3DMYkpu/1u515hqaiwCfaue3
lBmo0Jw5xYQx89XnOQh8PYU=
=biIq
-----END PGP SIGNATURE-----

--Y5rl02BVI9TCfPar--
