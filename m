Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267001AbRGIKIm>; Mon, 9 Jul 2001 06:08:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267002AbRGIKIW>; Mon, 9 Jul 2001 06:08:22 -0400
Received: from smtp.alcove.fr ([212.155.209.139]:30993 "EHLO smtp.alcove.fr")
	by vger.kernel.org with ESMTP id <S267001AbRGIKIP>;
	Mon, 9 Jul 2001 06:08:15 -0400
Date: Mon, 9 Jul 2001 12:08:14 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 2.4.6-ac2] dmi_scan.c cleanups.
Message-ID: <20010709120814.D4850@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch cleans up the printk code in dmi_scan.c (the previous
code gave compile warnings on enabling the printk).

Stelian.

diff -uNr --exclude-from=dontdiff linux-2.4.6-ac2.orig/arch/i386/kernel/dmi_scan.c linux-2.4.6-ac2/arch/i386/kernel/dmi_scan.c
--- linux-2.4.6-ac2.orig/arch/i386/kernel/dmi_scan.c	Mon Jul  9 10:25:52 2001
+++ linux-2.4.6-ac2/arch/i386/kernel/dmi_scan.c	Mon Jul  9 11:03:29 2001
@@ -14,8 +14,8 @@
 	u16	handle;
 };
 
-#define dmi_printk(x)
-//#define dmi_printk(x) printk(x)
+#define dmi_printk while(0) printk
+//#define dmi_printk printk
 
 static char * __init dmi_string(struct dmi_header *dm, u8 s)
 {
@@ -78,13 +78,13 @@
 			u16 len=buf[7]<<8|buf[6];
 			u32 base=buf[11]<<24|buf[10]<<16|buf[9]<<8|buf[8];
 
-			dmi_printk((KERN_INFO "DMI %d.%d present.\n",
-				buf[14]>>4, buf[14]&0x0F));
-			dmi_printk((KERN_INFO "%d structures occupying %d bytes.\n",
+			dmi_printk(KERN_INFO "DMI %d.%d present.\n",
+				buf[14]>>4, buf[14]&0x0F);
+			dmi_printk(KERN_INFO "%d structures occupying %d bytes.\n",
 				buf[13]<<8|buf[12],
-				buf[7]<<8|buf[6]));
-			dmi_printk((KERN_INFO "DMI table at 0x%08X.\n",
-				buf[11]<<24|buf[10]<<16|buf[9]<<8|buf[8]));
+				buf[7]<<8|buf[6]);
+			dmi_printk(KERN_INFO "DMI table at 0x%08X.\n",
+				buf[11]<<24|buf[10]<<16|buf[9]<<8|buf[8]);
 			if(dmi_table(base,len, num, decode)==0)
 				return 0;
 		}
@@ -355,13 +355,13 @@
 			p=dmi_string(dm,data[4]);
 			if(*p)
 			{
-				dmi_printk(("BIOS Vendor: %s\n", p));
+				dmi_printk("BIOS Vendor: %s\n", p);
 				dmi_save_ident(dm, DMI_BIOS_VENDOR, 4);
-				dmi_printk(("BIOS Version: %s\n", 
-					dmi_string(dm, data[5])));
+				dmi_printk("BIOS Version: %s\n", 
+					dmi_string(dm, data[5]));
 				dmi_save_ident(dm, DMI_BIOS_VERSION, 5);
-				dmi_printk(("BIOS Release: %s\n",
-					dmi_string(dm, data[8])));
+				dmi_printk("BIOS Release: %s\n",
+					dmi_string(dm, data[8]));
 				dmi_save_ident(dm, DMI_BIOS_DATE, 8);
 			}
 			break;
@@ -370,36 +370,36 @@
 			p=dmi_string(dm,data[4]);
 			if(*p)
 			{
-				dmi_printk(("System Vendor: %s.\n",p));
+				dmi_printk("System Vendor: %s.\n",p);
 				dmi_save_ident(dm, DMI_SYS_VENDOR, 4);
-				dmi_printk(("Product Name: %s.\n",
-					dmi_string(dm, data[5])));
+				dmi_printk("Product Name: %s.\n",
+					dmi_string(dm, data[5]));
 				dmi_save_ident(dm, DMI_PRODUCT_NAME, 5);
-				dmi_printk(("Version %s.\n",
-					dmi_string(dm, data[6])));
+				dmi_printk("Version %s.\n",
+					dmi_string(dm, data[6]));
 				dmi_save_ident(dm, DMI_PRODUCT_VERSION, 6);
-				dmi_printk(("Serial Number %s.\n",
-					dmi_string(dm, data[7])));
+				dmi_printk("Serial Number %s.\n",
+					dmi_string(dm, data[7]));
 			}
 			break;
 		case 2:
 			p=dmi_string(dm,data[4]);
 			if(*p)
 			{
-				dmi_printk(("Board Vendor: %s.\n",p));
+				dmi_printk("Board Vendor: %s.\n",p);
 				dmi_save_ident(dm, DMI_BOARD_VENDOR, 4);
-				dmi_printk(("Board Name: %s.\n",
-					dmi_string(dm, data[5])));
+				dmi_printk("Board Name: %s.\n",
+					dmi_string(dm, data[5]));
 				dmi_save_ident(dm, DMI_BOARD_NAME, 5);
-				dmi_printk(("Board Version: %s.\n",
-					dmi_string(dm, data[6])));
+				dmi_printk("Board Version: %s.\n",
+					dmi_string(dm, data[6]));
 				dmi_save_ident(dm, DMI_BOARD_VERSION, 6);
 			}
 			break;
 		case 3:
 			p=dmi_string(dm,data[8]);
 			if(*p && *p!=' ')
-				dmi_printk(("Asset Tag: %s.\n", p));
+				dmi_printk("Asset Tag: %s.\n", p);
 			break;
 	}
 }
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
|---------------- Free Software Engineer -----------------|
| Alcôve - http://www.alcove.com - Tel: +33 1 49 22 68 00 |
|------------- Alcôve, liberating software ---------------|
