Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316786AbSG1OTf>; Sun, 28 Jul 2002 10:19:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316797AbSG1OTf>; Sun, 28 Jul 2002 10:19:35 -0400
Received: from mail.actcom.co.il ([192.114.47.13]:16875 "EHLO
	lmail.actcom.co.il") by vger.kernel.org with ESMTP
	id <S316786AbSG1OTd>; Sun, 28 Jul 2002 10:19:33 -0400
Date: Sun, 28 Jul 2002 17:17:50 +0300
From: Muli Ben-Yehuda <mulix@actcom.co.il>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] add num_possible_cpus() to fix 2.5.29 apm.c compilation
Message-ID: <20020728141750.GB9573@alhambra.actcom.co.il>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IrhDeMKUP4DT/M7F"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--IrhDeMKUP4DT/M7F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This patch fixes the apm.c breakage in 2.5.29 by providing definitions
for num_possible_cpus() for UP and SMP. There were several patches
posted to fix it, but I think this is what the author intended. Rusty?

Patch against latest bitkeeper, compiles fine on UP and SMP. Don't
have an SMP machine to test it own.=20

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.477   -> 1.478 =20
#	include/asm-i386/smp.h	1.11    -> 1.12  =20
#	arch/i386/kernel/apm.c	1.34    -> 1.35  =20
#	 include/linux/smp.h	1.12    -> 1.13  =20
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/07/28	mulix@alhambra.merseine.nu	1.478
# fix compilation failure in apm.c due to missing num_possible_cpus()
# --------------------------------------------
#
diff -Nru a/arch/i386/kernel/apm.c b/arch/i386/kernel/apm.c
--- a/arch/i386/kernel/apm.c	Sun Jul 28 17:07:57 2002
+++ b/arch/i386/kernel/apm.c	Sun Jul 28 17:07:57 2002
@@ -214,6 +214,7 @@
 #include <linux/sched.h>
 #include <linux/pm.h>
 #include <linux/kernel.h>
+#include <linux/smp.h>
 #include <linux/smp_lock.h>
=20
 #include <asm/system.h>
diff -Nru a/include/asm-i386/smp.h b/include/asm-i386/smp.h
--- a/include/asm-i386/smp.h	Sun Jul 28 17:07:57 2002
+++ b/include/asm-i386/smp.h	Sun Jul 28 17:07:57 2002
@@ -93,6 +93,11 @@
 	return hweight32(cpu_online_map);
 }
=20
+extern inline unsigned int num_possible_cpus(void)
+{
+	return hweight32(phys_cpu_present_map);
+}
+
 extern inline int any_online_cpu(unsigned int mask)
 {
 	if (mask & cpu_online_map)
diff -Nru a/include/linux/smp.h b/include/linux/smp.h
--- a/include/linux/smp.h	Sun Jul 28 17:07:57 2002
+++ b/include/linux/smp.h	Sun Jul 28 17:07:57 2002
@@ -96,6 +96,7 @@
 #define cpu_online_map				1
 #define cpu_online(cpu)				({ cpu; 1; })
 #define num_online_cpus()			1
+#define num_possible_cpus()                     1
 #define __per_cpu_data
 #define per_cpu(var, cpu)			var
 #define this_cpu(var)				var

--=20
http://vipe.technion.ac.il/~mulix/
http://syscalltrack.sf.net/

--IrhDeMKUP4DT/M7F
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9Q/0OKRs727/VN8sRAq6MAKCgPa9aIZU98LLfw0rWPVHJzVcIHwCgkc48
/RGiNYxtiYrCdVwhzLxV0eM=
=PNKM
-----END PGP SIGNATURE-----

--IrhDeMKUP4DT/M7F--
