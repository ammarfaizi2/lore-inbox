Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266048AbUIMFZT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266048AbUIMFZT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 01:25:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266069AbUIMFZT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 01:25:19 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:32925 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S266048AbUIMFZL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 01:25:11 -0400
Date: Mon, 13 Sep 2004 14:27:05 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: [PATCH] add missing pci_disable_device for e1000
To: greg@kroah.com, akpm@osdl.org, linux-kernel@vger.kernel.org
Message-id: <41452FA9.1080100@jp.fujitsu.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: ja
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; ja-JP; rv:1.4)
 Gecko/20030624 Netscape/7.1 (ax)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds pci_disable_device() into e1000_remove().

If your driver decides to stop using the device, it should call
pci_disable_device() to deallocate any IRQ resources, disable PCI
bus-mastering, etc.

Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>

---

 linux-2.6.9-rc1-kanesige/drivers/net/e1000/e1000_main.c |    2 ++
 1 files changed, 2 insertions(+)

diff -puN drivers/net/e1000/e1000_main.c~add_missing_pci_disable_device_e1000 drivers/net/e1000/e1000_main.c
--- linux-2.6.9-rc1/drivers/net/e1000/e1000_main.c~add_missing_pci_disable_device_e1000	2004-09-13 12:41:28.108862428 +0900
+++ linux-2.6.9-rc1-kanesige/drivers/net/e1000/e1000_main.c	2004-09-13 12:41:28.111792131 +0900
@@ -639,6 +639,8 @@ e1000_remove(struct pci_dev *pdev)
 	pci_release_regions(pdev);
 
 	free_netdev(netdev);
+
+	pci_disable_device(pdev);
 }
 
 /**

_

