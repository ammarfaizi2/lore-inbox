Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261567AbTCKTdd>; Tue, 11 Mar 2003 14:33:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261578AbTCKTdd>; Tue, 11 Mar 2003 14:33:33 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:38643 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261567AbTCKTda>; Tue, 11 Mar 2003 14:33:30 -0500
Subject: [RFC][PATCH] linux-2.5.64_monotonic-clock_A1
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Joel.Becker@oracle.com, "Martin J. Bligh" <mbligh@aracnet.com>,
       wim.coekaerts@oracle.com
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-WvEsTcXzTIz9LDn1w7z7"
Organization: 
Message-Id: <1047411561.16614.684.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 11 Mar 2003 11:39:22 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-WvEsTcXzTIz9LDn1w7z7
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

All,=20
	Here is the next rev of my monotonic-clock patch. This version uses
scaled math to avoid the costly 64 bit divide at interrupt time. Big
thanks to George Anzinger for the suggestion.

	This patch, written with the advice of Joel Becker, addresses a problem
with the hangcheck-timer. The basic problem is that the hangcheck-timer
code (Required for Oracle) needs a accurate hard clock which can be used
to detect OS stalls (due to udelay() or pci bus hangs) that would cause
system time to skew (its sort of a sanity check that insures the
system's notion of time is accurate). However, currently they are using
get_cycles() to fetch the cpu's TSC register, thus this does not work on
systems w/o a synced TSC. As suggested by Andi Kleen (see thread here:
http://www.uwsg.iu.edu/hypermail/linux/kernel/0302.0/1234.html ) I've
worked with Joel and others to implement the monotonic_clock()
interface.

This interface returns a unsigned long long representing the number of
nanoseconds that has passed since time_init().=20

Future plans to the interface include properly handling cpu_freq changes
and porting to the different arches.

Comments, suggestions and flames welcome.

thanks
-john



--=-WvEsTcXzTIz9LDn1w7z7
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA+bjtpMDAZ/OmgHwwRAuaqAJ9efLlv5/ptC24CHgRsMHG7OkpAMQCfYLfQ
hWzCuAdZcB2Y7hOOg4xV/qU=
=GdMZ
-----END PGP SIGNATURE-----

--=-WvEsTcXzTIz9LDn1w7z7--

