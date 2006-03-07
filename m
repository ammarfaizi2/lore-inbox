Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751516AbWCGGBT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751516AbWCGGBT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 01:01:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751630AbWCGGBT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 01:01:19 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:39613 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751516AbWCGGBS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 01:01:18 -0500
Message-ID: <440D2151.5040501@jp.fujitsu.com>
Date: Tue, 07 Mar 2006 14:59:45 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
Cc: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: [PATCH 4/4] PCI legacy I/O port free driver (take5) - Make Emulex
 lpfc driver legacy I/O port free
References: <440D1FEC.1070701@jp.fujitsu.com>
In-Reply-To: <440D1FEC.1070701@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes Emulex lpfc driver legacy I/O port free.

Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>

---
 drivers/scsi/lpfc/lpfc_init.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

Index: linux-2.6.16-rc5-mm2/drivers/scsi/lpfc/lpfc_init.c
===================================================================
--- linux-2.6.16-rc5-mm2.orig/drivers/scsi/lpfc/lpfc_init.c	2006-03-07 14:06:48.000000000 +0900
+++ linux-2.6.16-rc5-mm2/drivers/scsi/lpfc/lpfc_init.c	2006-03-07 14:07:22.000000000 +0900
@@ -1391,8 +1391,9 @@
 	int error = -ENODEV, retval;
 	int i;
 	uint16_t iotag;
+	int bars = pci_select_bars(pdev, IORESOURCE_MEM);
 
-	if (pci_enable_device(pdev))
+	if (pci_enable_device_bars(pdev, bars))
 		goto out;
 	if (pci_request_regions(pdev, LPFC_DRIVER_NAME))
 		goto out_disable_device;

