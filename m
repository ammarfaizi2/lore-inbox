Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261410AbTC0WD4>; Thu, 27 Mar 2003 17:03:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261424AbTC0WDz>; Thu, 27 Mar 2003 17:03:55 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:52197 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S261410AbTC0WCt>; Thu, 27 Mar 2003 17:02:49 -0500
Date: Thu, 27 Mar 2003 23:13:56 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: ipslinux@adaptec.com, Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: [2.4 patch] fix ips.c .text.exit error
Message-ID: <20030327221356.GD24744@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In 2.4.21-pre6 the __devinit function ips_insert_device in 
drivers/scsi/ips.c calls the __devexit function ips_remove_device 
resulting in a .text.exit compile error if !CONFIG_HOTPLUG.

The patch below removes the __devexit from ips_remove_device.

I've tested the compilation with 2.4.21-pre6.

Please apply
Adrian


--- linux-2.4.21-pre6-full-nohotplug/drivers/scsi/ips.c.old	2003-03-27 22:25:49.000000000 +0100
+++ linux-2.4.21-pre6-full-nohotplug/drivers/scsi/ips.c	2003-03-27 22:28:51.000000000 +0100
@@ -246,9 +246,6 @@
     #define IPS_SG_ADDRESS(sg)       ((sg)->address)
     #define IPS_LOCK_SAVE(lock,flags) spin_lock_irqsave(&io_request_lock,flags)
     #define IPS_UNLOCK_RESTORE(lock,flags) spin_unlock_irqrestore(&io_request_lock,flags)
-    #ifndef __devexit_p
-        #define __devexit_p(x) x
-    #endif
 #else
     #define IPS_SG_ADDRESS(sg)      (page_address((sg)->page) ? \
                                      page_address((sg)->page)+(sg)->offset : 0)
@@ -338,48 +335,48 @@
    static char ips_hot_plug_name[] = "ips";
    
    static int __devinit  ips_insert_device(struct pci_dev *pci_dev, const struct pci_device_id *ent);
-   static void __devexit ips_remove_device(struct pci_dev *pci_dev);
+   static void ips_remove_device(struct pci_dev *pci_dev);
    
    struct pci_driver ips_pci_driver = {
        name:		ips_hot_plug_name,
        id_table:	ips_pci_table,
        probe:		ips_insert_device,
-       remove:		__devexit_p(ips_remove_device),
+       remove:		ips_remove_device,
    }; 
            
    struct pci_driver ips_pci_driver_anaconda = {
        name:		ips_hot_plug_name,
        id_table:	ips_pci_table_anaconda,
        probe:		ips_insert_device,
-       remove:		__devexit_p(ips_remove_device),
+       remove:		ips_remove_device,
    }; 
 
    struct pci_driver ips_pci_driver_5i = {
        name:		ips_hot_plug_name,
        id_table:	ips_pci_table_5i,
        probe:		ips_insert_device,
-       remove:		__devexit_p(ips_remove_device),
+       remove:		ips_remove_device,
    };
            
    struct pci_driver ips_pci_driver_6i = {
        name:		ips_hot_plug_name,
        id_table:	ips_pci_table_6i,
        probe:		ips_insert_device,
-       remove:		__devexit_p(ips_remove_device),
+       remove:		ips_remove_device,
    };
 
    struct pci_driver ips_pci_driver_i960 = {
        name:		ips_hot_plug_name,
        id_table:	ips_pci_table_i960,
        probe:		ips_insert_device,
-       remove:		__devexit_p(ips_remove_device),
+       remove:		ips_remove_device,
    };
 
    struct pci_driver ips_pci_driver_adaptec = {
        name:		ips_hot_plug_name,
        id_table:	ips_pci_table_adaptec,
        probe:		ips_insert_device,
-       remove:		__devexit_p(ips_remove_device),
+       remove:		ips_remove_device,
    };
 
 #endif
@@ -7346,7 +7343,7 @@
 /*   Routine Description:                                                    */
 /*     Remove one Adapter ( Hot Plugging )                                   */
 /*---------------------------------------------------------------------------*/
-static void __devexit ips_remove_device(struct pci_dev *pci_dev)
+static void ips_remove_device(struct pci_dev *pci_dev)
 {
    int    i;
    struct Scsi_Host *sh;
