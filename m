Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129402AbRAYVuC>; Thu, 25 Jan 2001 16:50:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130935AbRAYVtw>; Thu, 25 Jan 2001 16:49:52 -0500
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:58971
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S130803AbRAYVtq>; Thu, 25 Jan 2001 16:49:46 -0500
Date: Thu, 25 Jan 2001 22:49:39 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] eliminate #ifdef in parport_pc.c by adding empty entry in pci.h (241p10)
Message-ID: <20010125224939.G603@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

The following two patches removes an #ifdef CONFIG_PCI in 
drivers/parport/parport_pc.c by adding a nop definition of
pci_match_device to include/linux/pci.h. It incidentially
also removes a compiler warning when CONFIG_PCI is not
set.

Applies against ac11 and 241p10 (the latter with a bit of
fuzz in the parport_pc.c case).

Please comment.


--- linux-ac11-clean/include/linux/pci.h	Thu Jan  4 23:51:32 2001
+++ linux-ac11/include/linux/pci.h	Thu Jan 25 22:03:51 2001
@@ -596,6 +596,7 @@
 static inline void pci_unregister_driver(struct pci_driver *drv) { }
 static inline int scsi_to_pci_dma_dir(unsigned char scsi_dir) { return scsi_dir; }
 static inline int pci_find_capability (struct pci_dev *dev, int cap) {return 0; }
+const struct pci_device_id *pci_match_device(const struct pci_device_id *ids, const struct pci_dev *dev) { return NULL; }
 
 #else
 

--- linux-ac11-clean/drivers/parport/parport_pc.c	Thu Jan 25 20:49:12 2001
+++ linux-ac11/drivers/parport/parport_pc.c	Thu Jan 25 22:02:49 2001
@@ -2552,7 +2552,6 @@
 
 static int __init parport_pc_init_superio (void)
 {
-#ifdef CONFIG_PCI
 	const struct pci_device_id *id;
 	struct pci_dev *pdev;
 
@@ -2563,7 +2562,6 @@
 
 		return parport_pc_superio_info[id->driver_data].probe (pdev);
 	}
-#endif /* CONFIG_PCI */
 
 	return 0; /* zero devices found */
 }


-- 
Regards,
        Rasmus(rasmus@jaquet.dk)

We're going to turn this team around 360 degrees.
-Jason Kidd, upon his drafting to the Dallas Mavericks
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
