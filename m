Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317693AbSHGPvt>; Wed, 7 Aug 2002 11:51:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317829AbSHGPvt>; Wed, 7 Aug 2002 11:51:49 -0400
Received: from ppp-217-133-222-186.dialup.tiscali.it ([217.133.222.186]:10965
	"EHLO home.ldb.ods.org") by vger.kernel.org with ESMTP
	id <S317693AbSHGPvs>; Wed, 7 Aug 2002 11:51:48 -0400
Subject: [PATCH] [2.5 i386] Fix AP GDT descs to have limit = size - 1
From: Luca Barbieri <ldb@ldb.ods.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Ingo Molnar <mingo@elte.hu>,
       Linux-Kernel ML <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-c85U+XIrCMDIbJxZ6x8Z"
X-Mailer: Ximian Evolution 1.0.5 
Date: 07 Aug 2002 17:54:31 +0200
Message-Id: <1028735671.11775.5.camel@ldb>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-c85U+XIrCMDIbJxZ6x8Z
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This is the right thing (also done by head.s).

diff --exclude-from=/home/ldb/src/linux-exclude -urNd a/arch/i386/kernel/cpu/common.c b/arch/i386/kernel/cpu/common.c
--- a/arch/i386/kernel/cpu/common.c	2002-08-06 10:26:11.000000000 +0200
+++ b/arch/i386/kernel/cpu/common.c	2002-08-07 17:47:05.000000000 +0200
@@ -451,7 +451,7 @@
 	 */
 	if (cpu) {
 		memcpy(cpu_gdt_table[cpu], cpu_gdt_table[0], GDT_SIZE);
-		cpu_gdt_descr[cpu].size = GDT_SIZE;
+		cpu_gdt_descr[cpu].size = GDT_SIZE - 1;
 		cpu_gdt_descr[cpu].address = (unsigned long)cpu_gdt_table[cpu];
 	}
 

--=-c85U+XIrCMDIbJxZ6x8Z
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9UUK3djkty3ft5+cRAsHwAJ43vxWJjlrW6bdqZWsDlzYrwUA7ZwCdHmPI
LX6pAGT84iZjQMmE64Jbrqo=
=BPqS
-----END PGP SIGNATURE-----

--=-c85U+XIrCMDIbJxZ6x8Z--
