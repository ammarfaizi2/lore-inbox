Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266749AbUHOOsv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266749AbUHOOsv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 10:48:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266743AbUHOOsR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 10:48:17 -0400
Received: from mx1.redhat.com ([66.187.233.31]:13785 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266727AbUHOOrV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 10:47:21 -0400
Date: Sun, 15 Aug 2004 10:46:24 -0400
From: Alan Cox <alan@redhat.com>
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: PATCH: quieten some IDE diagnostics we will be using much more
Message-ID: <20040815144624.GA8168@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.8-rc3/drivers/ide/ide-probe.c linux-2.6.8-rc3/drivers/ide/ide-probe.c
--- linux.vanilla-2.6.8-rc3/drivers/ide/ide-probe.c	2004-08-09 15:51:00.000000000 +0100
+++ linux-2.6.8-rc3/drivers/ide/ide-probe.c	2004-08-14 21:03:03.000000000 +0100
@@ -635,12 +680,11 @@
 	device_register(&hwif->gendev);
 }
 
-#ifdef CONFIG_PPC
 static int wait_hwif_ready(ide_hwif_t *hwif)
 {
 	int rc;
 
-	printk(KERN_INFO "Probing IDE interface %s...\n", hwif->name);
+	printk(KERN_DEBUG "Probing IDE interface %s...\n", hwif->name);
 
 	/* Let HW settle down a bit from whatever init state we
 	 * come from */
@@ -671,7 +715,6 @@
 	
 	return rc;
 }
-#endif
 
 /*
  * This routine only knows how to look for drive units 0 and 1
@@ -717,7 +760,6 @@
 
 	local_irq_set(flags);
 
-#ifdef CONFIG_PPC
 	/* This is needed on some PPCs and a bunch of BIOS-less embedded
 	 * platforms. Typical cases are:
 	 * 
@@ -738,8 +780,7 @@
 	 *  BenH.
 	 */
 	if (wait_hwif_ready(hwif))
-		printk(KERN_WARNING "%s: Wait for ready failed before probe !\n", hwif->name);
-#endif /* CONFIG_PPC */
+		printk(KERN_DEBUG "%s: Wait for ready failed before probe !\n", hwif->name);
 
 	/*
 	 * Second drive should only exist if first drive was found,
