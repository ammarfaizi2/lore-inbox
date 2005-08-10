Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932573AbVHJKdQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932573AbVHJKdQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 06:33:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932569AbVHJKcz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 06:32:55 -0400
Received: from relay.rost.ru ([80.254.111.11]:11669 "EHLO donpac.ru")
	by vger.kernel.org with ESMTP id S932543AbVHJKcy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 06:32:54 -0400
Subject: [PATCH 1/5] 2.6.13-rc5-mm1, remove old debugging code
In-Reply-To: <11236699661419@donpac.ru>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Wed, 10 Aug 2005 14:32:48 +0400
Message-Id: <11236699682765@donpac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Andrey Panin <pazke@donpac.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


DMI debugging code is unused for ages. This patch removes it.

Signed-off-by: Andrey Panin <pazke@donpac.ru>

 arch/i386/kernel/dmi_scan.c |   21 ---------------------
 1 files changed, 21 deletions(-)

diff -urdpNX /usr/share/dontdiff linux-2.6.13-rc5-mm1.vanilla/arch/i386/kernel/dmi_scan.c linux-2.6.13-rc5-mm1/arch/i386/kernel/dmi_scan.c
--- linux-2.6.13-rc5-mm1.vanilla/arch/i386/kernel/dmi_scan.c	2005-06-14 23:24:54.000000000 +0400
+++ linux-2.6.13-rc5-mm1/arch/i386/kernel/dmi_scan.c	2005-06-14 23:25:07.000000000 +0400
@@ -12,13 +12,6 @@ struct dmi_header {
 	u16 handle;
 };
 
-#undef DMI_DEBUG
-
-#ifdef DMI_DEBUG
-#define dmi_printk(x) printk x
-#else
-#define dmi_printk(x)
-#endif
 
 static char * __init dmi_string(struct dmi_header *dm, u8 s)
 {
@@ -117,29 +110,19 @@ static void __init dmi_decode(struct dmi
 	
 	switch(dm->type) {
 	case  0:
-		dmi_printk(("BIOS Vendor: %s\n", dmi_string(dm, data[4])));
 		dmi_save_ident(dm, DMI_BIOS_VENDOR, 4);
-		dmi_printk(("BIOS Version: %s\n", dmi_string(dm, data[5])));
 		dmi_save_ident(dm, DMI_BIOS_VERSION, 5);
-		dmi_printk(("BIOS Release: %s\n", dmi_string(dm, data[8])));
 		dmi_save_ident(dm, DMI_BIOS_DATE, 8);
 		break;
 	case 1:
-		dmi_printk(("System Vendor: %s\n", dmi_string(dm, data[4])));
 		dmi_save_ident(dm, DMI_SYS_VENDOR, 4);
-		dmi_printk(("Product Name: %s\n", dmi_string(dm, data[5])));
 		dmi_save_ident(dm, DMI_PRODUCT_NAME, 5);
-		dmi_printk(("Version: %s\n", dmi_string(dm, data[6])));
 		dmi_save_ident(dm, DMI_PRODUCT_VERSION, 6);
-		dmi_printk(("Serial Number: %s\n", dmi_string(dm, data[7])));
 		dmi_save_ident(dm, DMI_PRODUCT_SERIAL, 7);
 		break;
 	case 2:
-		dmi_printk(("Board Vendor: %s\n", dmi_string(dm, data[4])));
 		dmi_save_ident(dm, DMI_BOARD_VENDOR, 4);
-		dmi_printk(("Board Name: %s\n", dmi_string(dm, data[5])));
 		dmi_save_ident(dm, DMI_BOARD_NAME, 5);
-		dmi_printk(("Board Version: %s\n", dmi_string(dm, data[6])));
 		dmi_save_ident(dm, DMI_BOARD_VERSION, 6);
 		break;
 	}
@@ -177,10 +160,6 @@ void __init dmi_scan_machine(void)
 			else
 				printk(KERN_INFO "DMI present.\n");
 
-			dmi_printk((KERN_INFO "%d structures occupying %d bytes.\n",
-				num, len));
-			dmi_printk((KERN_INFO "DMI table at 0x%08X.\n", base));
-
 			if (dmi_table(base,len, num, dmi_decode) == 0)
 				return;
 		}

