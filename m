Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265686AbUBBQIN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 11:08:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265689AbUBBQIN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 11:08:13 -0500
Received: from witte.sonytel.be ([80.88.33.193]:54961 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S265686AbUBBQIF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 11:08:05 -0500
Date: Mon, 2 Feb 2004 17:07:52 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       support@moxa.com.tw
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: [PATCH] Moxa serial compile fixes
Message-ID: <Pine.GSO.4.58.0402021706530.19699@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Compile fixes for the Moxa serial drivers:
  - Add missing #include <linux/init.h>
  - Kill warning if CONFIG_PCI is not set

--- linux-2.6.2-rc3/drivers/char/moxa.c	2003-10-09 10:02:39.000000000 +0200
+++ linux-m68k-2.6.2-rc3/drivers/char/moxa.c	2004-01-10 04:25:26.000000000 +0100
@@ -49,6 +49,7 @@
 #include <linux/tty_driver.h>
 #include <linux/delay.h>
 #include <linux/pci.h>
+#include <linux/init.h>

 #include <asm/system.h>
 #include <asm/io.h>
@@ -292,7 +293,7 @@

 static int __init moxa_init(void)
 {
-	int i, n, numBoards;
+	int i, numBoards;
 	struct moxa_str *ch;

 	printk(KERN_INFO "MOXA Intellio family driver version %s\n", MOXA_VERSION);
@@ -410,7 +411,7 @@
 #ifdef CONFIG_PCI
 	{
 		struct pci_dev *p = NULL;
-		n = (sizeof(moxa_pcibrds) / sizeof(moxa_pcibrds[0])) - 1;
+		int n = (sizeof(moxa_pcibrds) / sizeof(moxa_pcibrds[0])) - 1;
 		i = 0;
 		while (i < n) {
 			while ((p = pci_find_device(moxa_pcibrds[i].vendor, moxa_pcibrds[i].device, p))!=NULL)
--- linux-2.6.2-rc3/drivers/char/mxser.c	2003-10-09 10:02:40.000000000 +0200
+++ linux-m68k-2.6.2-rc3/drivers/char/mxser.c	2004-01-10 04:26:02.000000000 +0100
@@ -56,6 +56,7 @@
 #include <linux/mm.h>
 #include <linux/smp_lock.h>
 #include <linux/pci.h>
+#include <linux/init.h>

 #include <asm/system.h>
 #include <asm/io.h>
@@ -496,7 +497,6 @@
 static int __init mxser_module_init(void)
 {
 	int i, m, retval, b;
-	int n, index;
 	struct mxser_hwconf hwconf;

 	mxvar_sdriver = alloc_tty_driver(MXSER_PORTS + 1);
@@ -600,9 +600,8 @@
 #ifdef CONFIG_PCI
 	{
 		struct pci_dev *pdev = NULL;
-
-		n = (sizeof(mxser_pcibrds) / sizeof(mxser_pcibrds[0])) - 1;
-		index = 0;
+		int n = (sizeof(mxser_pcibrds) / sizeof(mxser_pcibrds[0])) - 1;
+		int index = 0;
 		for (b = 0; b < n; b++) {
 			while ((pdev = pci_find_device(mxser_pcibrds[b].vendor, mxser_pcibrds[b].device, pdev)))
 			{

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
