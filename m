Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267070AbTBWLZL>; Sun, 23 Feb 2003 06:25:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268061AbTBWLZL>; Sun, 23 Feb 2003 06:25:11 -0500
Received: from holomorphy.com ([66.224.33.161]:16812 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267070AbTBWLZL>;
	Sun, 23 Feb 2003 06:25:11 -0500
Date: Sun, 23 Feb 2003 03:34:24 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: greg@kroah.com
Cc: linux-kernel@vger.kernel.org
Subject: make pci_scan_device() static
Message-ID: <20030223113424.GG27135@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	greg@kroah.com, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make pci_scan_device() static, as it's not called outside probe.c

$ grep -nr pci_scan_device .
./drivers/pci/probe.c:430:struct pci_dev * __devinit pci_scan_device(struct pci_dev *temp)
./drivers/pci/probe.c:484:              dev = pci_scan_device(temp);

===== drivers/pci/probe.c 1.29 vs edited =====
--- 1.29/drivers/pci/probe.c	Tue Feb 18 03:14:13 2003
+++ edited/drivers/pci/probe.c	Sun Feb 23 03:30:48 2003
@@ -427,7 +427,7 @@
  * Read the config data for a PCI device, sanity-check it
  * and fill in the dev structure...
  */
-struct pci_dev * __devinit pci_scan_device(struct pci_dev *temp)
+static struct pci_dev * __devinit pci_scan_device(struct pci_dev *temp)
 {
 	struct pci_dev *dev;
 	u32 l;
