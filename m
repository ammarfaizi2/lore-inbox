Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266425AbSLOLAG>; Sun, 15 Dec 2002 06:00:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266356AbSLOLAG>; Sun, 15 Dec 2002 06:00:06 -0500
Received: from gateway.cinet.co.jp ([210.166.75.129]:58941 "EHLO
	precia.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S266425AbSLOLAF>; Sun, 15 Dec 2002 06:00:05 -0500
Message-ID: <3DFC621A.60AA112@cinet.co.jp>
Date: Sun, 15 Dec 2002 20:06:02 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
X-Mailer: Mozilla 4.8C-ja  [ja/Vine] (X11; U; Linux 2.5.50-ac1-pc98smp i686)
X-Accept-Language: ja
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCHSET] PC-9800 addtional for 2.5.50-ac1 (4/21)
References: <3DFC50E9.656B96D0@cinet.co.jp>
Content-Type: multipart/mixed;
 boundary="------------7010667DDB438A47C58E2560"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------7010667DDB438A47C58E2560
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit

NEC PC-9800 subarchitecture support patch for 2.5.50-ac1 (4/21)
This is updates for mach-pc9800/setup.c.
"APM bios version bug fix" moved here from apm.c.

diffstat:
 arch/i386/mach-pc9800/setup.c |    6 ++++++
 1 files changed, 6 insertions(+)

Regards,
Osamu Tomita
--------------7010667DDB438A47C58E2560
Content-Type: text/plain; charset=iso-2022-jp;
 name="mach-pc9800-setup_c-update.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mach-pc9800-setup_c-update.patch"

diff -Nru linux-2.5.50-ac1/arch/i386/mach-pc9800/setup.c linux98-2.5.50-ac1/arch/i386/mach-pc9800/setup.c
--- linux-2.5.50-ac1/arch/i386/mach-pc9800/setup.c	2002-12-11 13:09:57.000000000 +0900
+++ linux98-2.5.50-ac1/arch/i386/mach-pc9800/setup.c	2002-12-12 22:15:25.000000000 +0900
@@ -8,6 +8,7 @@
 #include <linux/init.h>
 #include <linux/irq.h>
 #include <linux/interrupt.h>
+#include <linux/apm_bios.h>
 #include <asm/setup.h>
 #include <asm/arch_hooks.h>
 
@@ -69,6 +70,11 @@
 	SYS_DESC_TABLE.length = 0;
 	MCA_bus = 0;
 	pc98 = 1;
+#ifdef CONFIG_PC9800
+	/* In PC-9800, APM BIOS version is written in BCD...?? */
+	APM_BIOS_INFO.version = (APM_BIOS_INFO.version & 0xff00)
+				| ((APM_BIOS_INFO.version & 0x00f0) >> 4);
+#endif
 }
 
 /**

--------------7010667DDB438A47C58E2560--

