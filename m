Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262740AbVAQJZr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262740AbVAQJZr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 04:25:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262742AbVAQJZq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 04:25:46 -0500
Received: from canuck.infradead.org ([205.233.218.70]:50956 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S262740AbVAQJZk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 04:25:40 -0500
Subject: via82cxxx resume failure.
From: David Woodhouse <dwmw2@infradead.org>
To: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Mon, 17 Jan 2005 09:25:30 +0000
Message-Id: <1105953931.26551.314.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On resume from sleep, via_set_speed() doesn't reinstate the correct DMA
mode, because it thinks the drive is already configured correctly. This
one-line hack is sufficient to make it refrain from dying a horrible
death immediately after resume, but presumably has other problems...

===== drivers/ide/pci/via82cxxx.c 1.24 vs edited =====
--- 1.24/drivers/ide/pci/via82cxxx.c	Mon Aug  9 18:00:46 2004
+++ edited/drivers/ide/pci/via82cxxx.c	Tue Oct 26 22:48:59 2004
@@ -328,7 +328,7 @@
 	struct ide_timing t, p;
 	unsigned int T, UT;
 
-	if (speed != XFER_PIO_SLOW && speed != drive->current_speed)
+	//	if (speed != XFER_PIO_SLOW && speed != drive->current_speed)
 		if (ide_config_drive_speed(drive, speed))
 			printk(KERN_WARNING "ide%d: Drive %d didn't "
 				"accept speed setting. Oh, well.\n",


-- 
dwmw2

