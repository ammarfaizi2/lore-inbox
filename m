Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263984AbTLLICD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 03:02:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264501AbTLLICD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 03:02:03 -0500
Received: from relais.videotron.ca ([24.201.245.36]:8679 "EHLO
	VL-MO-MR001.ip.videotron.ca") by vger.kernel.org with ESMTP
	id S263984AbTLLICA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 03:02:00 -0500
Date: Fri, 12 Dec 2003 03:00:53 -0500
From: Jean-Marc Valin <Jean-Marc.Valin@USherbrooke.ca>
Subject: Re: Increasing HZ (patch for HZ > 1000)
In-reply-to: <1288980000.1071126438@[10.10.2.4]>
To: "Martin J. Bligh" <mbligh@aracnet.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Message-id: <1071216053.4187.22.camel@idefix.homelinux.org>
Organization: =?ISO-8859-1?Q?Universit=C3=A9_de?= Sherbrooke
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7)
Content-type: multipart/signed; boundary="=-zazrsprF/SYYzwm/S42S";
 protocol="application/pgp-signature"; micalg=pgp-sha1
References: <1071122742.5149.12.camel@idefix.homelinux.org>
 <1288980000.1071126438@[10.10.2.4]>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-zazrsprF/SYYzwm/S42S
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Just one more thing about the patch I sent. I think it addresses
something unclean in the bogomips computation. For example, in
arch/i386/kernel/cpu/proc.c, you have:

seq_printf(m, "\nbogomips\t: %lu.%02lu\n\n",
           c->loops_per_jiffy/(500000/HZ),
           (c->loops_per_jiffy/(5000/HZ)) % 100);

It's clear that for any case where 5000/HZ is not an integer, the
bogomips decimals will be wrong and if 500000/HZ isn't an integer, the
bogomips integer part will be wrong.

For example on a 2 GHz processor with a 4000 bogomips value and HZ=3D1200,
the code above will produce 3996.66 instead of 4000. Of course, as soon
as HZ goes above 5000, you have a divide by zero right at compile time.

	Jean-Marc

--=20
Jean-Marc Valin, M.Sc.A., ing. jr.
LABORIUS (http://www.gel.usherb.ca/laborius)
Universit=E9 de Sherbrooke, Qu=E9bec, Canada

--=-zazrsprF/SYYzwm/S42S
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Ceci est une partie de message
	=?ISO-8859-1?Q?num=E9riquement?= =?ISO-8859-1?Q?_sign=E9e=2E?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/2XW1dXwABdFiRMQRAleKAJ9Oje44B6baKcbi+bowaCD48mnheACfZKhh
UJJKdFJqVYPLQZKm/rH4OzQ=
=5lcF
-----END PGP SIGNATURE-----

--=-zazrsprF/SYYzwm/S42S--

