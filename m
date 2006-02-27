Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750956AbWB0E5E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750956AbWB0E5E (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 23:57:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751209AbWB0E5E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 23:57:04 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:48077 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1750956AbWB0E5B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 23:57:01 -0500
Message-ID: <44028623.20809@jp.fujitsu.com>
Date: Mon, 27 Feb 2006 13:54:59 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, Andrew Morton <akpm@osdl.org>,
       Greg KH <greg@kroah.com>
CC: Kenji Kaneshige <kaneshige.kenji@soft.fujitsu.com>,
       Andi Kleen <ak@suse.de>, Jeff Garzik <jgarzik@pobox.com>,
       benh@kernel.crashing.org
Subject: [PATCH 4/4] PCI legacy I/O port free driver (take 3) - Make Emulex
 lpfc driver legacy I/O port free
References: <44028502.4000108@soft.fujitsu.com>
In-Reply-To: <44028502.4000108@soft.fujitsu.com>
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes Emulex lpfc driver legacy I/O port free.

Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>

---
 drivers/scsi/lpfc/lpfc_init.c |    3 +++
 1 files changed, 3 insertions(+)

Index: linux-2.6.16-rc4/drivers/scsi/lpfc/lpfc_init.c
===================================================================
--- linux-2.6.16-rc4.orig/drivers/scsi/lpfc/lpfc_init.c	2006-02-27 13:28:34.000000000 +0900
+++ linux-2.6.16-rc4/drivers/scsi/lpfc/lpfc_init.c	2006-02-27 13:29:47.000000000 +0900
@@ -1368,6 +1368,9 @@
 	int i;
 	uint16_t iotag;
 
+	/* Don't need to use I/O port regions */
+	pdev->no_ioport = 1;
+
 	if (pci_enable_device(pdev))
 		goto out;
 	if (pci_request_regions(pdev, LPFC_DRIVER_NAME))

