Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263663AbVBCSFa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263663AbVBCSFa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 13:05:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263661AbVBCR5u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 12:57:50 -0500
Received: from mail.kroah.org ([69.55.234.183]:52647 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263620AbVBCRky convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 12:40:54 -0500
Cc: kay.sievers@vrfy.org
Subject: [PATCH] PCI: memset rom attribute before using it
In-Reply-To: <11074524211780@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 3 Feb 2005 09:40:21 -0800
Message-Id: <11074524213464@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2043, 2005/02/03 00:40:37-08:00, kay.sievers@vrfy.org

[PATCH] PCI: memset rom attribute before using it

Initialize the allocated bin_attribute structure, otherwise unused fields
are pointing to random places.

Signed-off-by: Kay Sievers <kay.sievers@vrfy.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/pci/pci-sysfs.c |    1 +
 1 files changed, 1 insertion(+)


diff -Nru a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
--- a/drivers/pci/pci-sysfs.c	2005-02-03 09:28:46 -08:00
+++ b/drivers/pci/pci-sysfs.c	2005-02-03 09:28:46 -08:00
@@ -436,6 +436,7 @@
 		
 		rom_attr = kmalloc(sizeof(*rom_attr), GFP_ATOMIC);
 		if (rom_attr) {
+			memset(rom_attr, 0x00, sizeof(*rom_attr));
 			pdev->rom_attr = rom_attr;
 			rom_attr->size = pci_resource_len(pdev, PCI_ROM_RESOURCE);
 			rom_attr->attr.name = "rom";

