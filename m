Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265968AbSKBNbo>; Sat, 2 Nov 2002 08:31:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265969AbSKBNbo>; Sat, 2 Nov 2002 08:31:44 -0500
Received: from h-64-105-136-52.SNVACAID.covad.net ([64.105.136.52]:25054 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S265968AbSKBNbn>; Sat, 2 Nov 2002 08:31:43 -0500
Date: Sat, 2 Nov 2002 05:38:06 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
To: mj@ucw.cz
Cc: linux-kernel@vger.kernel.org
Subject: Patch/resubmit: 2.5.45 - eliminate pci_dev.driver_data
Message-ID: <20021102053806.A6302@adam.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="4Ckj6UjgE2iN1+kY"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Martin,

	The following patch eliminates pci_dev.driver_data, in favor
of the field provided for this purpose in the generic struct device
(pci_dev.dev.driver_data).  This shinks pci_dev by four bytes and
eliminates a line from pci.h.

	What gives this patch importance to me is that I am about to
submit a patch for the generic driver layer to do simple
pre-allocation of device.driver_data for drivers that request it
(current code will be unaffected).  This will enable elimination of of
some memory allocation/deallocation pairs and associated error legs in
many drivers.

        I submitted this patch to you during 2.5.44 and mentioned that
there were a few driver files that still directly referenced
pci_dev.driver_data and that I had submitted patches to fix them to
use pci_[gs]et_drvdata.  Those patches got into 2.5.45, so integrating
this patch at this point should not break any drivers.

	I have been running this change in 2.5.44 and 2.5.45 without
problems.

	Also, I would appreciate it if you would acknowledge this
email.  Thanks in advance.

-- 
Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."

--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="pci.diff"

--- linux-2.5.45/include/linux/pci.h	2002-10-30 16:42:55.000000000 -0800
+++ linux/include/linux/pci.h	2002-10-27 01:06:04.000000000 -0800
@@ -344,7 +344,6 @@
 	u8		rom_base_reg;	/* which config register controls the ROM */
 
 	struct pci_driver *driver;	/* which driver has allocated this device */
-	void		*driver_data;	/* data private to the driver */
 	u64		dma_mask;	/* Mask of the bits of bus address this
 					   device implements.  Normally this is
 					   0xffffffff.  You only need to change
@@ -758,12 +757,12 @@
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

--4Ckj6UjgE2iN1+kY--
