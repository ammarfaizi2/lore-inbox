Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316430AbSEZVkQ>; Sun, 26 May 2002 17:40:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316441AbSEZVkP>; Sun, 26 May 2002 17:40:15 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:21519 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id <S316430AbSEZVkN>;
	Sun, 26 May 2002 17:40:13 -0400
Date: Sun, 26 May 2002 23:40:13 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: [PATCH-2.5] SRM cleanup for generic Alpha kernels
Message-ID: <20020526214013.GJ4148@lug-owl.de>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KjX7LgAomYr70Ka9"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux mail 2.4.18 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--KjX7LgAomYr70Ka9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus!

Please apply this patch to current 2.5.x kernels.

	- alpha_using_srm is #define'd for machine specific kernels, but
	  is a real integer variable for generic Alpha kernels. Export
	  it...
=09
	- The callback_* functions are _always_ there (they might be NOP
	  functions owith generic kernels on non-SRM machines).

	- srm_env can now be compiled on generic alpha kernels. An
	  explicit check for SRM capability was always there:-)

Please apply!

MfG, JBG


--- linux-2.5.18-srm/arch/alpha/kernel/alpha_ksyms.c.orig	Sun May 26 23:16:=
40 2002
+++ linux-2.5.18-srm/arch/alpha/kernel/alpha_ksyms.c	Sun May 26 23:19:36 20=
02
@@ -58,11 +58,12 @@
 EXPORT_SYMBOL(probe_irq_mask);
 EXPORT_SYMBOL(screen_info);
 EXPORT_SYMBOL(perf_irq);
-#ifdef CONFIG_ALPHA_SRM
 EXPORT_SYMBOL(callback_getenv);
 EXPORT_SYMBOL(callback_setenv);
 EXPORT_SYMBOL(callback_save_env);
-#endif /* CONFIG_ALPHA_SRM */
+#ifdef CONFIG_ALPHA_GENERIC
+EXPORT_SYMBOL(alpha_using_srm);
+#endif /* CONFIG_ALPHA_GENERIC */
=20
 /* platform dependent support */
 EXPORT_SYMBOL(_inb);
--- linux-2.5.18-srm/arch/alpha/config.in.orig	Sun May 26 02:05:53 2002
+++ linux-2.5.18-srm/arch/alpha/config.in	Sun May 26 02:07:37 2002
@@ -259,7 +259,7 @@
 	"ELF		CONFIG_KCORE_ELF	\
 	 A.OUT		CONFIG_KCORE_AOUT" ELF
 fi
-if [ "$CONFIG_PROC_FS" !=3D "n" -a "$CONFIG_ALPHA_SRM" =3D "y" ]; then
+if [ "$CONFIG_PROC_FS" !=3D "n" ]; then
    tristate 'SRM environment through procfs' CONFIG_SRM_ENV
 fi
 =20

--=20
Jan-Benedict Glaw   .   jbglaw@lug-owl.de   .   +49-172-7608481
	 -- New APT-Proxy written in shell script --
	   http://lug-owl.de/~jbglaw/software/ap2/

--KjX7LgAomYr70Ka9
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE88VY7Hb1edYOZ4bsRAsSVAJ9AbpT2YhG9P8ozRJl+OYUubLAFngCbBdTl
PPxw5L4NBt0/tFDm0rj36bA=
=vFG5
-----END PGP SIGNATURE-----

--KjX7LgAomYr70Ka9--
