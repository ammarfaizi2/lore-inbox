Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315162AbSHBOy7>; Fri, 2 Aug 2002 10:54:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315168AbSHBOy7>; Fri, 2 Aug 2002 10:54:59 -0400
Received: from sccrmhc01.attbi.com ([204.127.202.61]:14756 "EHLO
	sccrmhc01.attbi.com") by vger.kernel.org with ESMTP
	id <S315162AbSHBOy6>; Fri, 2 Aug 2002 10:54:58 -0400
Message-ID: <3D4A9E0E.A3B24096@attbi.com>
Date: Fri, 02 Aug 2002 10:58:22 -0400
From: Albert Cranford <ac9410@attbi.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] 2.5.30 ARCH=i386 create dmi_scan.h and move decl from dmi_scan.c
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,
Alan suggested that sensors group use a dmi scanner to
manage allow/blacklist products.  In order to do this
we need to use arch/i386/kernel/dmi_scan.c components.

Could you apply the following patch to facilitate this?
Its been tested in linux-2.5.30 with no negative impact on
kernel and may be useful for others.

Thanks,
Albert
--- linux/arch/i386/kernel/dmi_scan.c.orig     2002-07-31 23:10:21.000000000 -0400
+++ linux/arch/i386/kernel/dmi_scan.c  2002-07-31 23:13:52.000000000 -0400
@@ -9,6 +9,7 @@
 #include <linux/pm.h>
 #include <asm/keyboard.h>
 #include <asm/system.h>
+#include <asm/dmi_scan.h>
 #include <linux/bootmem.h>
 
 unsigned long dmi_broken;
@@ -127,22 +128,7 @@
        return -1;
 }
 
-
-enum
-{
-       DMI_BIOS_VENDOR,
-       DMI_BIOS_VERSION,
-       DMI_BIOS_DATE,
-       DMI_SYS_VENDOR,
-       DMI_PRODUCT_NAME,
-       DMI_PRODUCT_VERSION,
-       DMI_BOARD_VENDOR,
-       DMI_BOARD_NAME,
-       DMI_BOARD_VERSION,
-       DMI_STRING_MAX
-};
-
-static char *dmi_ident[DMI_STRING_MAX];
+char *dmi_ident[DMI_STRING_MAX];
 
 /*
  *     Save a DMI string
--- /dev/null   1994-07-17 19:46:18.000000000 -0400
+++ linux/include/asm-i386/dmi_scan.h  2002-07-31 23:12:49.000000000 -0400
@@ -0,0 +1,19 @@
+#ifndef __i386_DMI_SCAN_H
+#define __i386_DMI_SCAN_H
+enum
+{
+       DMI_BIOS_VENDOR,
+       DMI_BIOS_VERSION,
+       DMI_BIOS_DATE,
+       DMI_SYS_VENDOR,
+       DMI_PRODUCT_NAME,
+       DMI_PRODUCT_VERSION,
+       DMI_BOARD_VENDOR,
+       DMI_BOARD_NAME,
+       DMI_BOARD_VERSION,
+       DMI_STRING_MAX
+};
+
+extern char *dmi_ident[DMI_STRING_MAX];
+
+#endif

-- 
Albert Cranford Deerfield Beach FL USA
ac9410@bellsouth.net
