Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266034AbUIMFZE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266034AbUIMFZE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 01:25:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266048AbUIMFZE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 01:25:04 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:24738 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S266034AbUIMFZA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 01:25:00 -0400
Date: Mon, 13 Sep 2004 14:26:53 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: [PATCH] add missing pci_disable_device for PCI-based USB HCD
To: greg@kroah.com, akpm@osdl.org, linux-kernel@vger.kernel.org
Message-id: <41452F9D.7030301@jp.fujitsu.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: ja
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; ja-JP; rv:1.4)
 Gecko/20030624 Netscape/7.1 (ax)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds pci_disable_device() into usb_hcd_pci_remove().

If the driver decides to stop using the device, it should call
pci_disable_device() to deallocate any IRQ resources, disable PCI
bus-mastering, etc.

Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>

---

 linux-2.6.9-rc1-kanesige/drivers/usb/core/hcd-pci.c |    2 ++
 1 files changed, 2 insertions(+)

diff -puN drivers/usb/core/hcd-pci.c~add_missing_pci_disable_device_usb_hcd drivers/usb/core/hcd-pci.c
--- linux-2.6.9-rc1/drivers/usb/core/hcd-pci.c~add_missing_pci_disable_device_usb_hcd	2004-09-13 12:41:26.061976310 +0900
+++ linux-2.6.9-rc1-kanesige/drivers/usb/core/hcd-pci.c	2004-09-13 12:41:26.063929446 +0900
@@ -260,6 +260,8 @@ void usb_hcd_pci_remove (struct pci_dev 
 	}
 
 	usb_deregister_bus (&hcd->self);
+
+	pci_disable_device(dev);
 }
 EXPORT_SYMBOL (usb_hcd_pci_remove);
 

_


