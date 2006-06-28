Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932772AbWF1Ksl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932772AbWF1Ksl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 06:48:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932764AbWF1Ksl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 06:48:41 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:33227 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S932772AbWF1Ksk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 06:48:40 -0400
From: Nigel Cunningham <ncunningham@linuxmail.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Linux-pm mailing list" <linux-pm@lists.osdl.org>,
       suspend2-devel@lists.suspend2.net
Subject: x86_64 restore_image declaration needs asmlinkage?
Date: Wed, 28 Jun 2006 20:48:34 +1000
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1420535.EvX7lUtGpV";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200606282048.38746.ncunningham@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1420535.EvX7lUtGpV
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

I received a report of problems with CONFIG_REGPARM and suspending, that le=
d=20
me to recheck asm calls and declarations. Not being a guru on these things,=
 I=20
want to ask advice from those who know more.

Along the way I noticed that current git has:

extern asmlinkage int swsusp_arch_suspend(void);
extern asmlinkage int swsusp_arch_resume(void);

This is right for x86, but for x86_64, we actually call a C routine in=20
arch/x86_64/kernel/suspend.c, which calls restore_image in=20
arch/x86_64/kernel/suspend_asm.S. Restore image is declared in suspend.c as=
=20

extern int restore_image(void);

should it be:

extern asmlinkage int restore_image(void);

Having swsusp_arch_resume declared as asmlinkage doesn't matter, does it?

Regards,

Nigel
=2D-=20
Nigel, Michelle and Alisdair Cunningham
5 Mitchell Street
Cobden 3266
Victoria, Australia

--nextPart1420535.EvX7lUtGpV
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEol6GN0y+n1M3mo0RAheSAKCzlOA4dWc0hw1vQR+Gsq9I1u2tzQCgo3dK
9abTdhPjYny1S4EbYXjHTag=
=xGWS
-----END PGP SIGNATURE-----

--nextPart1420535.EvX7lUtGpV--
