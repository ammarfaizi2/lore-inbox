Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751123AbVKJAff@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751123AbVKJAff (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 19:35:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751124AbVKJAff
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 19:35:35 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:22022 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1751123AbVKJAfe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 19:35:34 -0500
Date: Wed, 9 Nov 2005 16:34:19 -0800
Message-Id: <200511100034.jAA0YJFg027720@zach-dev.vmware.com>
Subject: [PATCH 2/10] Pnp segments in segment h
From: Zachary Amsden <zach@vmware.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>, Zachary Amsden <zach@vmware.com>
X-OriginalArrivalTime: 10 Nov 2005 00:34:20.0087 (UTC) FILETIME=[7D569470:01C5E58E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Move PnP BIOS segment definitions into segment.h; the segments are reserved
here, so they might as well be defined here as well.

Note I didn't do this for APM BIOS, as Macintosh and other systems use those
values to emulate APM in some scary way I don't want to understand.

Signed-off-by: Zachary Amsden <zach@vmware.com>
Index: linux-2.6.14-zach-work/include/asm-i386/segment.h
===================================================================
--- linux-2.6.14-zach-work.orig/include/asm-i386/segment.h	2005-11-04 12:13:31.000000000 -0800
+++ linux-2.6.14-zach-work/include/asm-i386/segment.h	2005-11-05 00:28:13.000000000 -0800
@@ -91,6 +91,20 @@
 #define GDT_ENTRY_BOOT_DS		(GDT_ENTRY_BOOT_CS + 1)
 #define __BOOT_DS	(GDT_ENTRY_BOOT_DS * 8)
 
+/* The PnP BIOS entries in the GDT */
+#define GDT_ENTRY_PNPBIOS_CS32		(GDT_ENTRY_PNPBIOS_BASE + 0)
+#define GDT_ENTRY_PNPBIOS_CS16		(GDT_ENTRY_PNPBIOS_BASE + 1)
+#define GDT_ENTRY_PNPBIOS_DS		(GDT_ENTRY_PNPBIOS_BASE + 2)
+#define GDT_ENTRY_PNPBIOS_TS1		(GDT_ENTRY_PNPBIOS_BASE + 3)
+#define GDT_ENTRY_PNPBIOS_TS2		(GDT_ENTRY_PNPBIOS_BASE + 4)
+
+/* The PnP BIOS selectors */
+#define PNP_CS32   (GDT_ENTRY_PNPBIOS_CS32 * 8)	/* segment for calling fn */
+#define PNP_CS16   (GDT_ENTRY_PNPBIOS_CS16 * 8)	/* code segment for BIOS */
+#define PNP_DS     (GDT_ENTRY_PNPBIOS_DS * 8)	/* data segment for BIOS */
+#define PNP_TS1    (GDT_ENTRY_PNPBIOS_TS1 * 8)	/* transfer data segment */
+#define PNP_TS2    (GDT_ENTRY_PNPBIOS_TS2 * 8)	/* another data segment */
+
 /*
  * The interrupt descriptor table has room for 256 idt's,
  * the global descriptor table is dependent on the number
Index: linux-2.6.14-zach-work/drivers/pnp/pnpbios/bioscalls.c
===================================================================
--- linux-2.6.14-zach-work.orig/drivers/pnp/pnpbios/bioscalls.c	2005-11-04 12:13:31.000000000 -0800
+++ linux-2.6.14-zach-work/drivers/pnp/pnpbios/bioscalls.c	2005-11-05 00:28:13.000000000 -0800
@@ -31,15 +31,6 @@ static struct {
 } pnp_bios_callpoint;
 
 
-/* The PnP BIOS entries in the GDT */
-#define PNP_GDT    (GDT_ENTRY_PNPBIOS_BASE * 8)
-
-#define PNP_CS32   (PNP_GDT+0x00)	/* segment for calling fn */
-#define PNP_CS16   (PNP_GDT+0x08)	/* code segment for BIOS */
-#define PNP_DS     (PNP_GDT+0x10)	/* data segment for BIOS */
-#define PNP_TS1    (PNP_GDT+0x18)	/* transfer data segment */
-#define PNP_TS2    (PNP_GDT+0x20)	/* another data segment */
-
 /*
  * These are some opcodes for a "static asmlinkage"
  * As this code is *not* executed inside the linux kernel segment, but in a
