Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262483AbVFIWVo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262483AbVFIWVo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 18:21:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262489AbVFIWVo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 18:21:44 -0400
Received: from mail.kroah.org ([69.55.234.183]:59849 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262483AbVFIWVl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 18:21:41 -0400
Date: Thu, 9 Jun 2005 15:21:33 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Cc: nsankar@broadcom.com
Subject: [PATCH] PCI: MSI functionality broken on Serverworks GC chipset
Message-ID: <20050609222133.GB12580@kroah.com>
References: <20050609222033.GA12580@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050609222033.GA12580@kroah.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] PCI: MSI functionality broken on Serverworks GC chipset

MSI functionality is broken on the GC_LE x86 chipset that Serverworks
developed and that is being used in various platforms today. Broadcom is
going to push out to the kernel MSI enabled Gigabit drivers (in the very
near future), and we would like to make sure that MSI does not get
enabled on any platforms using the GC_LE chipset (device id 0x17).
Following the AMD 8131 example, I am including a patch to disable MSI
functionality when a GCNB_LE is detected. Please let me know if there
are any issues with this. This is a permanent fix for this chipset, as
the hardware will not be updated.

Signed-off-by: Narendra Sankar <nsankar@broadcom.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 1e06276704c101bd1ae7b62879faaffcd7496a3e
tree 0b983e8000ed7f57d189f68097a6e78ad5c33488
parent 76854ceac3ef3408ab9a50a2521147fb14779f58
author Narendra Sankar <nsankar@broadcom.com> Fri, 06 May 2005 14:12:05 -0700
committer Greg Kroah-Hartman <gregkh@suse.de> Thu, 09 Jun 2005 17:04:30 -0700

 drivers/pci/quirks.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -456,6 +456,12 @@ static void __init quirk_amd_8131_ioapic
 } 
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_8131_APIC,         quirk_amd_8131_ioapic ); 
 
+static void __init quirk_svw_msi(struct pci_dev *dev)
+{
+	pci_msi_quirk = 1;
+	printk(KERN_WARNING "PCI: MSI quirk detected. pci_msi_quirk set.\n");
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_GCNB_LE, quirk_svw_msi );
 #endif /* CONFIG_X86_IO_APIC */
 
 
