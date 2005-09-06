Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751134AbVIFXoa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134AbVIFXoa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 19:44:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751138AbVIFXoa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 19:44:30 -0400
Received: from serv01.siteground.net ([70.85.91.68]:54955 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S1751134AbVIFXo3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 19:44:29 -0400
Date: Tue, 6 Sep 2005 16:44:29 -0700
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>,
       Alok Kataria <alokk@calsoftinc.com>
Subject: [patch 4/4] ide: Break ide_lock -- remove ide_lock  from piix driver
Message-ID: <20050906234429.GE3642@localhost.localdomain>
References: <20050906233322.GA3642@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050906233322.GA3642@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch to convert piix driver to use per-driver/hwgroup lock and kill
ide_lock.  In the case of piix, hwgroup->lock should be sufficient.

Signed-off-by: Ravikiran Thirumalai <kiran@scalex86.org>

Index: linux-2.6.13/drivers/ide/pci/piix.c
===================================================================
--- linux-2.6.13.orig/drivers/ide/pci/piix.c	2005-09-06 12:00:25.000000000 -0700
+++ linux-2.6.13/drivers/ide/pci/piix.c	2005-09-06 13:22:49.000000000 -0700
@@ -231,7 +231,6 @@
 
 	pio = ide_get_best_pio_mode(drive, pio, 5, NULL);
 	spin_lock_irqsave(&hwgroup->lock, flags);
-	spin_lock(&ide_lock);
 	pci_read_config_word(dev, master_port, &master_data);
 	if (is_slave) {
 		master_data = master_data | 0x4000;
@@ -251,7 +250,6 @@
 	pci_write_config_word(dev, master_port, master_data);
 	if (is_slave)
 		pci_write_config_byte(dev, slave_port, slave_data);
-	spin_unlock(&ide_lock);
 	spin_unlock_irqrestore(&hwgroup->lock, flags);
 }
 
