Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318872AbSHMFs0>; Tue, 13 Aug 2002 01:48:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318902AbSHMFra>; Tue, 13 Aug 2002 01:47:30 -0400
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:17309 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP
	id <S318938AbSHMFqY>; Tue, 13 Aug 2002 01:46:24 -0400
Message-ID: <3D589E11.6093B119@attbi.com>
Date: Tue, 13 Aug 2002 01:50:09 -0400
From: Albert Cranford <ac9410@attbi.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.20-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [PATCH]2.4.20 ARCH=i386 create dmi_scan.h and move decl from dmi_scan.c
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Marcelo,
Could you apply the following patch against 2.4.20-pre2.
Alan C. thought this would be OK to support i2c/sensors.
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

On Fri, 2002-08-02 at 15:58, Albert Cranford wrote:
> Hello Linus,
> Alan suggested that sensors group use a dmi scanner to
> manage allow/blacklist products.  In order to do this
> we need to use arch/i386/kernel/dmi_scan.c components.
> 
> Could you apply the following patch to facilitate this?
> Its been tested in linux-2.5.30 with no negative impact on
> kernel and may be useful for others.


Ok by me
