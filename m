Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269810AbUICVVL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269810AbUICVVL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 17:21:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269798AbUICVTP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 17:19:15 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:44212 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S269277AbUICVQI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 17:16:08 -0400
Date: Fri, 3 Sep 2004 22:15:47 +0100
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: hpt366 ptr use before NULL check.
Message-ID: <20040903211546.GY26419@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Another picked up with the coverity checker.

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6.8/drivers/ide/pci/hpt366.c~	2004-09-03 22:13:46.870500672 +0100
+++ linux-2.6.8/drivers/ide/pci/hpt366.c	2004-09-03 22:14:53.095432952 +0100
@@ -773,13 +773,17 @@
 static int hpt3xx_tristate (ide_drive_t * drive, int state)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
-	struct pci_dev *dev	= hwif->pci_dev;
-	u8 reg59h = 0, reset	= (hwif->channel) ? 0x80 : 0x40;
-	u8 regXXh = 0, state_reg= (hwif->channel) ? 0x57 : 0x53;
+	struct pci_dev *dev;
+	u8 reg59h = 0, reset;
+	u8 regXXh = 0, state_reg;
 
 	if (!hwif)
 		return -EINVAL;
 
+	dev = hwif->pci_dev;
+	reset = (hwif->channel) ? 0x80 : 0x40;
+	state_reg = (hwif->channel) ? 0x57 : 0x53;
+
 //	hwif->bus_state = state;
 
 	pci_read_config_byte(dev, 0x59, &reg59h);
