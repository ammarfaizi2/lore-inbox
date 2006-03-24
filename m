Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423151AbWCXFnW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423151AbWCXFnW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 00:43:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423152AbWCXFnW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 00:43:22 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:54170 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1423151AbWCXFnV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 00:43:21 -0500
Message-ID: <44238546.6080401@jp.fujitsu.com>
Date: Fri, 24 Mar 2006 14:36:06 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: [PATCH 2.6.16-mm1 4/4] PCI legacy I/O port free driver (take 6) -
 Make Emulex lpfc driver legacy I/O port free
References: <442382F1.2050300@jp.fujitsu.com>
In-Reply-To: <442382F1.2050300@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes Emulex lpfc driver legacy I/O port free.

Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>

---
 drivers/scsi/lpfc/lpfc_init.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

Index: linux-2.6.16-mm1/drivers/scsi/lpfc/lpfc_init.c
===================================================================
--- linux-2.6.16-mm1.orig/drivers/scsi/lpfc/lpfc_init.c	2006-03-23 20:04:05.000000000 +0900
+++ linux-2.6.16-mm1/drivers/scsi/lpfc/lpfc_init.c	2006-03-23 20:04:14.000000000 +0900
@@ -1434,8 +1434,9 @@
 	int error = -ENODEV, retval;
 	int i;
 	uint16_t iotag;
+	int bars = pci_select_bars(pdev, IORESOURCE_MEM);
 
-	if (pci_enable_device(pdev))
+	if (pci_enable_device_bars(pdev, bars))
 		goto out;
 	if (pci_request_regions(pdev, LPFC_DRIVER_NAME))
 		goto out_disable_device;

