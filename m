Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263379AbUCXN5p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 08:57:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263703AbUCXN5p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 08:57:45 -0500
Received: from ns.suse.de ([195.135.220.2]:54495 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263379AbUCXN5j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 08:57:39 -0500
Date: Wed, 24 Mar 2004 14:57:37 +0100
From: Marcus Meissner <meissner@suse.de>
To: linux-kernel@vger.kernel.org
Subject: PATCH: siginfo -> si_band is long
Message-ID: <20040324135737.GB9355@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/NkBOFFp2J2Af1nK"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--/NkBOFFp2J2Af1nK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

After discussion on the glibc list the result was that=20
si_band is "long int" according to POSIX:

	http://www.opengroup.org/onlinepubs/007904975/basedefs/signal.h.html

Ulrich Drepper refused a patch to fix glibc due to this reason:
	http://sources.redhat.com/ml/libc-alpha/2004-03/msg00254.html

so here is the patch to fix it in the kernel.

ppc64 and s390x were broken before and are fixed by this patch too.

Please apply.

Ciao, Marcus

--- linux-2.6.4/include/asm-generic/siginfo.h.xx	2004-03-24 14:44:23.000000=
000 +0100
+++ linux-2.6.4/include/asm-generic/siginfo.h	2004-03-24 14:44:36.000000000=
 +0100
@@ -27,7 +27,7 @@
 #endif
=20
 #ifndef __ARCH_SI_BAND_T
-#define __ARCH_SI_BAND_T int
+#define __ARCH_SI_BAND_T long int
 #endif
=20
 #ifndef HAVE_ARCH_SIGINFO_T
--- linux-2.6.4/include/asm-x86_64/siginfo.h.xx	2004-03-24 14:45:26.0000000=
00 +0100
+++ linux-2.6.4/include/asm-x86_64/siginfo.h	2004-03-24 14:45:34.000000000 =
+0100
@@ -3,8 +3,6 @@
=20
 #define __ARCH_SI_PREAMBLE_SIZE	(4 * sizeof(int))
=20
-#define __ARCH_SI_BAND_T long
-
 #define SIGEV_PAD_SIZE ((SIGEV_MAX_SIZE/sizeof(int)) - 4)
=20
 #include <asm-generic/siginfo.h>

Ciao, Marcus

--/NkBOFFp2J2Af1nK
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQFAYZPR6nvzlwF1Yj4RArBhAKCJZvd69oTHWQ/p38E73+RwuNGwvQCeKscV
1MnhXBby1Xhef/EVS7eZvNI=
=9Nxb
-----END PGP SIGNATURE-----

--/NkBOFFp2J2Af1nK--
