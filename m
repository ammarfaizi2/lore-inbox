Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263864AbTCUTzb>; Fri, 21 Mar 2003 14:55:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263937AbTCUTyO>; Fri, 21 Mar 2003 14:54:14 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:63364
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263864AbTCUTdx>; Fri, 21 Mar 2003 14:33:53 -0500
Date: Fri, 21 Mar 2003 20:49:09 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303212049.h2LKn9lO026521@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: fix /proc for amd ide
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/ide/pci/amd74xx.c linux-2.5.65-ac2/drivers/ide/pci/amd74xx.c
--- linux-2.5.65/drivers/ide/pci/amd74xx.c	2003-03-18 16:46:48.000000000 +0000
+++ linux-2.5.65-ac2/drivers/ide/pci/amd74xx.c	2003-03-06 23:38:01.000000000 +0000
@@ -98,6 +99,7 @@
 	unsigned int v, u, i;
 	unsigned short c, w;
 	unsigned char t;
+	int len;
 	char *p = buffer;
 
 	amd_print("----------AMD BusMastering IDE Configuration----------------");
@@ -167,7 +169,11 @@
 	amd_print_drive("Cycle Time:    ", "%8dns", cycle[i]);
 	amd_print_drive("Transfer Rate: ", "%4d.%dMB/s", speed[i] / 1000, speed[i] / 100 % 10);
 
-	return p - buffer;	/* hoping it is less than 4K... */
+	/* hoping p - buffer is less than 4K... */
+	len = (p - buffer) - offset;
+	*addr = buffer + offset;
+	
+	return len > count ? count : len;
 }
 
 #endif
