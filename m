Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262534AbTJTLSq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 07:18:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262538AbTJTLSq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 07:18:46 -0400
Received: from rumms.uni-mannheim.de ([134.155.50.52]:26038 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id S262534AbTJTLSo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 07:18:44 -0400
From: Thomas Schlichter <schlicht@uni-mannheim.de>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.0-test8-mm1
Date: Mon, 20 Oct 2003 13:18:31 +0200
User-Agent: KMail/1.5.9
Cc: Andrew Morton <akpm@osdl.org>
References: <20031020020558.16d2a776.akpm@osdl.org>
In-Reply-To: <20031020020558.16d2a776.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-03=_MS8k/uFGG0fUsUe";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200310201318.36486.schlicht@uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-03=_MS8k/uFGG0fUsUe
Content-Type: multipart/mixed;
  boundary="Boundary-01=_HS8k/ft28SoHPCB"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_HS8k/ft28SoHPCB
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 20 October 2003 11:05, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test8=
/2
>.6.0-test8-mm1
  ~~ snip ~~
> +fix-sqrt.patch
>
>  Fix int_sqrt().

I really like this one... ;-)

The problem ist that oom_kill.c assumes that int_sqrt() never returns 0. So=
 we=20
could get a division by zero there :-(

The attached patch fixes that...

Regards
   Thomas

--Boundary-01=_HS8k/ft28SoHPCB
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="fix-oom_kill.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
	filename="fix-oom_kill.diff"

=2D-- linux-2.6.0-test8-mm1/mm/oom_kill.c.orig	Mon Oct 20 12:49:58 2003
+++ linux-2.6.0-test8-mm1/mm/oom_kill.c	Mon Oct 20 12:52:55 2003
@@ -63,8 +63,8 @@
 	cpu_time =3D (p->utime + p->stime) >> (SHIFT_HZ + 3);
 	run_time =3D (get_jiffies_64() - p->start_time) >> (SHIFT_HZ + 10);
=20
=2D	points /=3D int_sqrt(cpu_time);
=2D	points /=3D int_sqrt(int_sqrt(run_time));
+	points /=3D cpu_time ? int_sqrt(cpu_time) : 1;
+	points /=3D run_time ? int_sqrt(int_sqrt(run_time)) : 1;
=20
 	/*
 	 * Niced processes are most likely less important, so double

--Boundary-01=_HS8k/ft28SoHPCB--

--Boundary-03=_MS8k/uFGG0fUsUe
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA/k8SMYAiN+WRIZzQRAruNAKCC7acIAM9FmVuZnipvR5kfLJRFuQCgjLft
KTm1aDdcO+9AO7kZM33F/Lc=
=Vj24
-----END PGP SIGNATURE-----

--Boundary-03=_MS8k/uFGG0fUsUe--
