Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268460AbTCFWZI>; Thu, 6 Mar 2003 17:25:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268463AbTCFWZI>; Thu, 6 Mar 2003 17:25:08 -0500
Received: from mailout10.sul.t-online.com ([194.25.134.21]:9125 "EHLO
	mailout10.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S268460AbTCFWZF>; Thu, 6 Mar 2003 17:25:05 -0500
Date: Thu, 6 Mar 2003 23:35:18 +0100
From: Martin Waitz <tali@admingilde.org>
To: Robert Love <rml@tech9.net>
Cc: Linus Torvalds <torvalds@transmeta.com>, Andrew Morton <akpm@digeo.com>,
       mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: [patch] "HT scheduler", sched-2.5.63-B3
Message-ID: <20030306223518.GB1326@admingilde.org>
Mail-Followup-To: Robert Love <rml@tech9.net>,
	Linus Torvalds <torvalds@transmeta.com>,
	Andrew Morton <akpm@digeo.com>, mingo@elte.hu,
	linux-kernel@vger.kernel.org
References: <20030228202555.4391bf87.akpm@digeo.com> <Pine.LNX.4.44.0303051910380.1429-100000@home.transmeta.com> <20030306220307.GA1326@admingilde.org> <1046988457.715.37.camel@phantasy.awol.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gatW/ieO32f1wygP"
Content-Disposition: inline
In-Reply-To: <1046988457.715.37.camel@phantasy.awol.org>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--gatW/ieO32f1wygP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 06, 2003 at 05:07:37PM -0500, Robert Love wrote:
> On Thu, 2003-03-06 at 17:03, Martin Waitz wrote:
>=20
> > RE: the patch, i think using sleep_avg is a wrong metric from the
> > beginning.
> Eh?  It is as close to a heuristic of interactivity as I can think of.

processes tend to max out at one extreme or the other

processes that get stalled by a huge overall load of the machine
are forced to sleep, too; yet they are not interactive.

priority should be based on things the processes did, not on what
they haven't done.

> > in addition, timeslices should be shortest for high priority processes
> > (depending on dynamic prio, not static)
>=20
> No, they should be longer.  In some cases they should be nearly
> infinitely long (which is sort of what we do with the reinsertion into
> the active array for highly interactive tasks).  We want interactive
> tasks to always be able to run.

but for interactive tasks, latency is all-important
if the task can't provide a result in a short timeslice it already
failed to provide low latency and should not be considered interactive
any more.

when the dynamic prio of the currently running process is high,
then only interactive processes should run.
but these processes should be rescheduled fast, to
provide low-latency equally to all interactive processes

when the dynamic prio of the currently running process is low
then no interactive process runs and the scheduler can resort
to a more batch-job mode: increase timeslices to reduce
scheduling overhead.

> You may think they need shorter timeslice because they are I/O-bound.=20
> Keep in mind they need not _use_ all their timeslice in one go, and
> having a large timeslice ensures they have timeslice available when they
> wake up and need to run.
but the time slice should not be large enough to stall other
processes, which is extremely important for interactivity

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

--gatW/ieO32f1wygP
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+Z80mj/Eaxd/oD7IRAupfAJ97/REV2g5+V+8u53uQdZbIdz8y5ACfYzgE
HbxY43RzFbyhJfXhA/yXj0A=
=L/O4
-----END PGP SIGNATURE-----

--gatW/ieO32f1wygP--
