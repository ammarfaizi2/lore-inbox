Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265437AbSLBHT6>; Mon, 2 Dec 2002 02:19:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265513AbSLBHTd>; Mon, 2 Dec 2002 02:19:33 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:45574 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S265543AbSLBHSR>;
	Mon, 2 Dec 2002 02:18:17 -0500
Date: Mon, 2 Dec 2002 00:26:08 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Subject: Re: [PATCH] PCI Hotplug changes for 2.5.50
Message-ID: <20021202082608.GD12121@kroah.com>
References: <20021202082443.GA12121@kroah.com> <20021202082525.GB12121@kroah.com> <20021202082543.GC12121@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021202082543.GC12121@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.924.3.2, 2002/11/30 01:18:05-08:00, adam@yggdrasil.com

[PATCH] Patch/resubmit(2.5.50): Eliminate pci_dev.driver_data

	To review, this patch deletes pci_dev.driver_data, using the
existing pci_dev.device.driver_data field instead, thereby shrinking
struct pci_dev by four bytes on 32-bit machines.  The few device
drivers that attempted to directly reference pci_dev.driver_data were
fixed in a patch of mine that Jeff Garzik got into 2.5.45.  Also,
making this change should help with memory allocation improvements in
the future, although that's a separate issue.


diff -Nru a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	Sun Dec  1 23:26:24 2002
+++ b/include/linux/pci.h	Sun Dec  1 23:26:24 2002
@@ -344,7 +344,6 @@
 	u8		rom_base_reg;	/* which config register controls the ROM */
 
 	struct pci_driver *driver;	/* which driver has allocated this device */
-	void		*driver_data;	/* data private to the driver */
 	u64		dma_mask;	/* Mask of the bits of bus address this
 					   device implements.  Normally this is
 					   0xffffffff.  You only need to change
@@ -753,12 +752,12 @@
  */
 static inline void *pci_get_drvdata (struct pci_dev *pdev)
 {
-	return pdev->driver_data;
+	return pdev->dev.driver_data;
 }
 
 static inline void pci_set_drvdata (struct pci_dev *pdev, void *data)
 {
-	pdev->driver_data = data;
+	pdev->dev.driver_data = data;
 }
 
 /*
