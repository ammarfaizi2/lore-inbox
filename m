Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262563AbTDVHRJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 03:17:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262972AbTDVHRJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 03:17:09 -0400
Received: from mail.actcom.co.il ([192.114.47.13]:47780 "EHLO
	smtp1.actcom.net.il") by vger.kernel.org with ESMTP id S262563AbTDVHRH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 03:17:07 -0400
Date: Tue, 22 Apr 2003 10:29:04 +0300
From: Muli Ben-Yehuda <mulix@mulix.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Fix irq event debug print-out, and add stack dump which can
Message-ID: <20030422072904.GA7434@actcom.co.il>
References: <200304220713.h3M7DdRZ018542@hera.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qxx1br4bt0+wmkIi"
Content-Disposition: inline
In-Reply-To: <200304220713.h3M7DdRZ018542@hera.kernel.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 22, 2003 at 06:05:40AM +0000, Linux Kernel Mailing List wrote:

>  			printk(retval
>  				? "irq event %d: bogus retval mask %x\n"
>  				: "irq %d: nobody cared!\n",
>  				irq,=20
>  				retval);

Uhm, the first printk string takes two parameters, and the second one=20
only one parameter... how about this cosmetic patch? Better some
superflous information than printk params mismatch. Not tested,
obvious.=20

diff -u -r1.31 irq.c
--- arch/i386/kernel/irq.c	21 Apr 2003 20:10:51 -0000	1.31
+++ arch/i386/kernel/irq.c	22 Apr 2003 06:31:10 -0000
@@ -225,7 +225,7 @@
 			count--;
 			printk(retval
 				? "irq event %d: bogus retval mask %x\n"
-				: "irq %d: nobody cared!\n",
+				: "irq %d: nobody cared! (retval %x)\n",
 				irq,=20
 				retval);
 		}

--=20
Muli Ben-Yehuda
http://www.mulix.org


--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+pO8/KRs727/VN8sRAkKXAKCEbrSMcBvxwHNMsGV61ParVuMh6ACfYPYB
zeUnUofzK/NwerWNv0jW9rE=
=5Fnc
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--
