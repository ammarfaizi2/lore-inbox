Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263709AbTCUSUp>; Fri, 21 Mar 2003 13:20:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263713AbTCUSTv>; Fri, 21 Mar 2003 13:19:51 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:46723
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263709AbTCUSTQ>; Fri, 21 Mar 2003 13:19:16 -0500
Date: Fri, 21 Mar 2003 19:34:30 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303211934.h2LJYU1A025817@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: fix proc handling in serverworks and sc1200 ide
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/ide/pci/sc1200.c linux-2.5.65-ac2/drivers/ide/pci/sc1200.c
--- linux-2.5.65/drivers/ide/pci/sc1200.c	2003-03-03 19:20:09.000000000 +0000
+++ linux-2.5.65-ac2/drivers/ide/pci/sc1200.c	2003-03-06 23:36:26.000000000 +0000
@@ -87,6 +87,7 @@
 {
 	char *p = buffer;
 	unsigned long bibma = pci_resource_start(bmide_dev, 4);
+	int len;
 	u8  c0 = 0, c1 = 0;
 
 	/*
@@ -111,7 +112,10 @@
 	p += sprintf(p, "DMA\n");
 	p += sprintf(p, "PIO\n");
 
-	return p-buffer;
+	len = (p - buffer) - offset;
+	*addr = buffer + offset;
+	
+	return len > count ? count : len;
 }
 #endif /* DISPLAY_SC1200_TIMINGS && CONFIG_PROC_FS */
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/ide/pci/serverworks.c linux-2.5.65-ac2/drivers/ide/pci/serverworks.c
--- linux-2.5.65/drivers/ide/pci/serverworks.c	2003-03-03 19:20:09.000000000 +0000
+++ linux-2.5.65-ac2/drivers/ide/pci/serverworks.c	2003-03-06 23:36:07.000000000 +0000
@@ -57,7 +57,7 @@
 static int svwks_get_info (char *buffer, char **addr, off_t offset, int count)
 {
 	char *p = buffer;
-	int i;
+	int i, len;
 
 	p += sprintf(p, "\n                             "
 			"ServerWorks OSB4/CSB5/CSB6\n");
@@ -195,7 +195,11 @@
 	}
 	p += sprintf(p, "\n");
 
-	return p-buffer;	 /* => must be less than 4k! */
+	/* p - buffer must be less than 4k! */
+	len = (p - buffer) - offset;
+	*addr = buffer + offset;
+	
+	return len > count ? count : len;
 }
 #endif  /* defined(DISPLAY_SVWKS_TIMINGS) && defined(CONFIG_PROC_FS) */
 
