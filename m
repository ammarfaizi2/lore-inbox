Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261167AbVA0UeO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261167AbVA0UeO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 15:34:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261172AbVA0UeO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 15:34:14 -0500
Received: from soundwarez.org ([217.160.171.123]:10718 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S261167AbVA0UeK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 15:34:10 -0500
Date: Thu, 27 Jan 2005 21:34:10 +0100
From: Kay Sievers <kay.sievers@vrfy.org>
To: linux-kernel@vger.kernel.org
Cc: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] sysfs: export the vfs release call of binary attribute
Message-ID: <20050127203410.GA5022@vrfy.org>
References: <20050127201923.GA4968@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050127201923.GA4968@vrfy.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2005 at 09:19:23PM +0100, Kay Sievers wrote:
> Initialize the allocated bin_attribute structure, otherwise unused fields
> are pointing to random places.

Sorry, wrong place for the inititalization.

Signed-off-by: Kay Sievers <kay.sievers@vrfy.org>

===== drivers/pci/pci-sysfs.c 1.16 vs edited =====
--- 1.16/drivers/pci/pci-sysfs.c	2005-01-06 21:30:29 +01:00
+++ edited/drivers/pci/pci-sysfs.c	2005-01-27 21:31:09 +01:00
@@ -436,6 +436,7 @@ int pci_create_sysfs_dev_files (struct p
 		
 		rom_attr = kmalloc(sizeof(*rom_attr), GFP_ATOMIC);
 		if (rom_attr) {
+			memset(rom_attr, 0x00, sizeof(*rom_attr));
 			pdev->rom_attr = rom_attr;
 			rom_attr->size = pci_resource_len(pdev, PCI_ROM_RESOURCE);
 			rom_attr->attr.name = "rom";

