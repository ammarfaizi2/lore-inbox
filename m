Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264681AbSLIIyg>; Mon, 9 Dec 2002 03:54:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264699AbSLIIyg>; Mon, 9 Dec 2002 03:54:36 -0500
Received: from TYO201.gate.nec.co.jp ([210.143.35.51]:6383 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S264681AbSLIIyf>; Mon, 9 Dec 2002 03:54:35 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] [v850]  Add some v850 elf constants
Cc: linux-kernel@vger.kernel.org
Reply-To: Miles Bader <miles@gnu.org>
Message-Id: <20021209090211.5060E3704@mcspd15.ucom.lsi.nec.co.jp>
Date: Mon,  9 Dec 2002 18:02:11 +0900 (JST)
From: miles@lsi.nec.co.jp (Miles Bader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These are used for the new in-kernel module loader (actually not all the
relocation types are used right now, but are included for completeness).

Only the EM_CYGNUS_V850 macro, which is in a global namespace, is added
to <linux/elf.h>; the relocation types, which are private to the v850,
are added to <asm-v850/elf.h>.  [Perhaps some other archs can do a
similar split, to reduce the bloat in <linux/elf.h>]

diff -ruN -X../cludes -xm68knommu -xasm-m68knommu -xmm ../orig/linux-2.5.50/include/linux/elf.h include/linux/elf.h
--- ../orig/linux-2.5.50/include/linux/elf.h	2002-11-25 10:30:09.000000000 +0900
+++ include/linux/elf.h	2002-11-28 14:38:23.000000000 +0900
@@ -90,6 +92,9 @@
  */
 #define EM_ALPHA	0x9026
 
+/* Bogus old v850 magic number, used by old tools.  */
+#define EM_CYGNUS_V850	0x9080
+
 /*
  * This is the old interim value for S/390 architecture
  */
diff -ruN -X../cludes -xm68knommu -xasm-m68knommu -xmm ../orig/linux-2.5.50/include/asm-v850/elf.h include/asm-v850/elf.h
--- ../orig/linux-2.5.50/include/asm-v850/elf.h	2002-11-28 10:25:08.000000000 +0900
+++ include/asm-v850/elf.h	2002-11-28 14:39:36.000000000 +0900
@@ -22,6 +22,31 @@
 #define elf_check_arch(x)  \
   ((x)->e_machine == EM_V850 || (x)->e_machine == EM_CYGNUS_V850)
 
+
+/* v850 relocation types.  */
+#define R_V850_NONE		0
+#define R_V850_9_PCREL		1
+#define R_V850_22_PCREL		2
+#define R_V850_HI16_S		3
+#define R_V850_HI16		4
+#define R_V850_LO16		5
+#define R_V850_32		6
+#define R_V850_16		7
+#define R_V850_8		8
+#define R_V850_SDA_16_16_OFFSET	9	/* For ld.b, st.b, set1, clr1,
+					   not1, tst1, movea, movhi */
+#define R_V850_SDA_15_16_OFFSET	10	/* For ld.w, ld.h, ld.hu, st.w, st.h */
+#define R_V850_ZDA_16_16_OFFSET	11	/* For ld.b, st.b, set1, clr1,
+					   not1, tst1, movea, movhi */
+#define R_V850_ZDA_15_16_OFFSET	12	/* For ld.w, ld.h, ld.hu, st.w, st.h */
+#define R_V850_TDA_6_8_OFFSET	13	/* For sst.w, sld.w */
+#define R_V850_TDA_7_8_OFFSET	14	/* For sst.h, sld.h */
+#define R_V850_TDA_7_7_OFFSET	15	/* For sst.b, sld.b */
+#define R_V850_TDA_16_16_OFFSET	16	/* For set1, clr1, not1, tst1,
+					   movea, movhi */
+#define R_V850_NUM		17
+
+
 /*
  * These are used to set parameters in the core dumps.
  */
