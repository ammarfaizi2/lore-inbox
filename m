Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269065AbUIQWj4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269065AbUIQWj4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 18:39:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269102AbUIQWet
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 18:34:49 -0400
Received: from S010600105aa6e9d5.gv.shawcable.net ([24.68.24.66]:34957 "EHLO
	spitfire.gotdns.org") by vger.kernel.org with ESMTP id S269085AbUIQW3y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 18:29:54 -0400
From: Ryan Cumming <ryan@spitfire.gotdns.org>
To: Andrea Arcangeli <andrea@novell.com>
Subject: Re: [RFC, 2.6] a simple FIFO implementation
Date: Fri, 17 Sep 2004 15:29:50 -0700
User-Agent: KMail/1.7
Cc: Stelian Pop <stelian@popies.net>, Hugh Dickins <hugh@veritas.com>,
       James R Bruce <bruce@andrew.cmu.edu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
References: <20040917154834.GA3180@crusoe.alcove-fr> <200409171454.02531.ryan@spitfire.gotdns.org> <20040917220039.GD15426@dualathlon.random>
In-Reply-To: <20040917220039.GD15426@dualathlon.random>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart6860739.3kPtf6XZUT";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200409171529.52864.ryan@spitfire.gotdns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart6860739.3kPtf6XZUT
Content-Type: multipart/mixed;
  boundary="Boundary-01=_eV2SBLMckLpypPz"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_eV2SBLMckLpypPz
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Er, sorry, the last patch was had an off-by-one error (it would round 4 up =
to=20
8).

=2DRyan

--Boundary-01=_eV2SBLMckLpypPz
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="roundup-pow-two.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="roundup-pow-two.diff"

=2D-- include/linux/kernel.h	2004-09-16 06:38:19.000000000 -0700
+++ include/linux/kernel.h	2004-09-17 15:12:20.598844004 -0700
@@ -12,6 +12,7 @@
 #include <linux/stddef.h>
 #include <linux/types.h>
 #include <linux/compiler.h>
+#include <linux/bitops.h>
 #include <asm/byteorder.h>
 #include <asm/bug.h>
=20
@@ -111,6 +112,10 @@
 	return r;
 }
=20
+static inline unsigned long __attribute_pure__ roundup_pow_of_two(int x)
+{
+	return (1UL << fls(x - 1));
+}
=20
 extern int printk_ratelimit(void);
 extern int __printk_ratelimit(int ratelimit_jiffies, int ratelimit_burst);

--Boundary-01=_eV2SBLMckLpypPz--

--nextPart6860739.3kPtf6XZUT
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBS2VgW4yVCW5p+qYRAhqDAKDBvY+hr/6vq2RJJ5KsaXTjY+oj0gCgqTYH
GLFh23PAsHTfiOoreHpKXtY=
=QomO
-----END PGP SIGNATURE-----

--nextPart6860739.3kPtf6XZUT--
