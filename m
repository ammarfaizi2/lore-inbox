Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261724AbUGQUuN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbUGQUuN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jul 2004 16:50:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261763AbUGQUuN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jul 2004 16:50:13 -0400
Received: from wblv-254-37.telkomadsl.co.za ([165.165.254.37]:53462 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S261724AbUGQUuB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jul 2004 16:50:01 -0400
Subject: Re: 2.6.8-rc1-np1
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
In-Reply-To: <40F8F0A6.8020003@yahoo.com.au>
References: <40F8B7C5.9030201@yahoo.com.au>
	 <1090053943.1828.4.camel@teapot.felipe-alfaro.com>
	 <40F8F0A6.8020003@yahoo.com.au>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-8tKptaP9WoRArDBbiMPO"
Message-Id: <1090097552.9380.10.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 17 Jul 2004 22:52:32 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-8tKptaP9WoRArDBbiMPO
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2004-07-17 at 11:25, Nick Piggin wrote:
> Felipe Alfaro Solana wrote:
> > On Sat, 2004-07-17 at 15:23 +1000, Nick Piggin wrote:
> >=20
> >=20
> >>Scheduler behaviour is generally pretty good now so I've increased the
> >>timeslice size to see how far I can push it. Some workloads really dema=
nd
> >>small timeslices though, so I've added /proc/sys/kernel/base_timeslice.
> >>If you have any problems with the default, please report it to me, and
> >>check if lowering this value helps.
> >=20
> >=20
> > On my 700Mhz Pentium III Mobile laptop, I feel that 256ms is too high
> > for the system to keep interactive when a CPU hog is running. For
>=20
> Yeah, it is probably a bit too large here too. A burst of activity
> from X can cause xmms to skip slightly. Probably 128 or 64 would
> be a decent default.
>=20

Feels fine here on 3GHz P4 (HT system on i875 with dual channel
memory, striped raid ST38013AS HDD's).  xmms haven't skipped yet
(X reniced to -10) and desktop switching is quick.  First time
typing might be a bit sluggish in gnome-terminal, but second/third
char is fine, and vim seems to load fast enough.  All this is
with a 'make -j24' for kernel (yeah, not really that realistic,
but thought I should give it a go) and make -j4 for xorg-x11 going.
A few load values is:

load average: 26.72, 15.99, 7.35
load average: 27.93, 19.48, 9.52
load average: 28.02, 19.64, 9.63
load average: 26.01, 19.36, 9.59


base_timeslice is 256 btw ...

> > example, running "while true; do a=3D2; done" makes the system pretty
> > sluggish with the default timeslice. This is noticeable while dragging
> > windows around (the movement is jerky and doesn't feel smooth).
> > Decreasing the timeslie to 50ms, or even better, 25ms, makes the system
> > behave much much better, although it will decrease throughput
> > considerably, I guess.
> >=20
>=20

Cannot say I can really feel this test.  That with 'make -j4' for
X have load:

load average: 2.74, 4.45, 5.98

where the last is still high from the make -j24.

> It usually isn't too bad for desktops, but is more important on
> systems with more CPUs and bigger caches.
>=20
> On this dual P3 with 256K L2 cache, a make -j8 vmlinux uses
> 162.16user 15.43system, ~150ctxsw/s with base_timeslice =3D 10000
> 163.88user 16.16system, ~300ctxsw/s with base_timeslice =3D 32
> 192.65user 17.27system, ~1300ctxsw/s with base_timeslice =3D 1
>=20
> So you come to the point of diminishing returns very quickly, and
> 32 or even 16 or 8 are probably fine values for a desktop system
> and worth the small cost for CPU intensive tasks.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
--=20
Martin Schlemmer

--=-8tKptaP9WoRArDBbiMPO
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA+ZGPqburzKaJYLYRAoh/AKCTkHNWoTbEPsM/afmY/C6+7EtbvwCdE1f6
BxiPBwdyCK6ekiSkmhXq7do=
=AVn/
-----END PGP SIGNATURE-----

--=-8tKptaP9WoRArDBbiMPO--

