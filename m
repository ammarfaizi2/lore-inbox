Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265479AbUANBrr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 20:47:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265649AbUANBrq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 20:47:46 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:45031 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S265479AbUANBro
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 20:47:44 -0500
From: James Cleverdon <jamesclv@us.ibm.com>
Reply-To: jamesclv@us.ibm.com
Organization: IBM LTC
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] 2.6.1-mm2: Adjust MAX_MP_BUSSES for summit and generic subarches
Date: Tue, 13 Jan 2004 17:47:31 -0800
User-Agent: KMail/1.5
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, Chris McDermott <lcm@us.ibm.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_1+JBA/Ifqb0sfCr"
Message-Id: <200401131747.33107.jamesclv@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_1+JBA/Ifqb0sfCr
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

We're overflowing some of the bus arrays on 32-way x445s (the BIOS reserves 
lots of busses for PCI hot-plug), and probably would do the same on a 16-way 
x440 with dual PCI expansion boxes.  This should make enough room.


diff -pru 2.6.1-mm2/include/asm-i386/mach-generic/mach_mpspec.h 
q1mm2/include/asm-i386/mach-generic/mach_mpspec.h
--- 2.6.1-mm2/include/asm-i386/mach-generic/mach_mpspec.h	2004-01-08 
22:59:45.000000000 -0800
+++ q1mm2/include/asm-i386/mach-generic/mach_mpspec.h	2004-01-13 
17:08:23.823784680 -0800
@@ -8,6 +8,12 @@
 
 #define MAX_IRQ_SOURCES 256
 
-#define MAX_MP_BUSSES 32
+/* Summit or generic (i.e. installer) kernels need lots of bus entries. */
+#if defined(CONFIG_X86_SUMMIT) || defined(CONFIG_X86_GENERICARCH)
+/* Maximum 256 PCI busses, plus 1 ISA bus in each of 4 cabinets. */
+# define MAX_MP_BUSSES 260
+#else
+# define MAX_MP_BUSSES 32
+#endif
 
 #endif /* __ASM_MACH_MPSPEC_H */
diff -pru 2.6.1-mm2/include/asm-i386/mach-summit/mach_mpspec.h 
q1mm2/include/asm-i386/mach-summit/mach_mpspec.h
--- 2.6.1-mm2/include/asm-i386/mach-summit/mach_mpspec.h	2004-01-08 
22:59:26.000000000 -0800
+++ q1mm2/include/asm-i386/mach-summit/mach_mpspec.h	2004-01-13 
16:59:24.706742928 -0800
@@ -8,6 +8,7 @@
 
 #define MAX_IRQ_SOURCES 256
 
-#define MAX_MP_BUSSES 32
+/* Maximum 256 PCI busses, plus 1 ISA bus in each of 4 cabinets. */
+#define MAX_MP_BUSSES 260
 
 #endif /* __ASM_MACH_MPSPEC_H */

--Boundary-00=_1+JBA/Ifqb0sfCr
Content-Type: text/x-diff;
  charset="us-ascii";
  name="max_mp_busses_2004-01-13_2.6.1-mm2"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="max_mp_busses_2004-01-13_2.6.1-mm2"

diff -pru 2.6.1-mm2/include/asm-i386/mach-generic/mach_mpspec.h q1mm2/include/asm-i386/mach-generic/mach_mpspec.h
--- 2.6.1-mm2/include/asm-i386/mach-generic/mach_mpspec.h	2004-01-08 22:59:45.000000000 -0800
+++ q1mm2/include/asm-i386/mach-generic/mach_mpspec.h	2004-01-13 17:08:23.823784680 -0800
@@ -8,6 +8,12 @@
 
 #define MAX_IRQ_SOURCES 256
 
-#define MAX_MP_BUSSES 32
+/* Summit or generic (i.e. installer) kernels need lots of bus entries. */
+#if defined(CONFIG_X86_SUMMIT) || defined(CONFIG_X86_GENERICARCH)
+/* Maximum 256 PCI busses, plus 1 ISA bus in each of 4 cabinets. */
+# define MAX_MP_BUSSES 260
+#else
+# define MAX_MP_BUSSES 32
+#endif
 
 #endif /* __ASM_MACH_MPSPEC_H */
diff -pru 2.6.1-mm2/include/asm-i386/mach-summit/mach_mpspec.h q1mm2/include/asm-i386/mach-summit/mach_mpspec.h
--- 2.6.1-mm2/include/asm-i386/mach-summit/mach_mpspec.h	2004-01-08 22:59:26.000000000 -0800
+++ q1mm2/include/asm-i386/mach-summit/mach_mpspec.h	2004-01-13 16:59:24.706742928 -0800
@@ -8,6 +8,7 @@
 
 #define MAX_IRQ_SOURCES 256
 
-#define MAX_MP_BUSSES 32
+/* Maximum 256 PCI busses, plus 1 ISA bus in each of 4 cabinets. */
+#define MAX_MP_BUSSES 260
 
 #endif /* __ASM_MACH_MPSPEC_H */

--Boundary-00=_1+JBA/Ifqb0sfCr--

