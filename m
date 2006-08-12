Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422696AbWHLVDE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422696AbWHLVDE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 17:03:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422698AbWHLVCj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 17:02:39 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:17043 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1422701AbWHLVCX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 17:02:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=Lu3ugNMJ+bNVR4PCb9Z3V+AgetFxEhsHC0xclUs52q1bh5Qk7/H1rhio8yjQ6QP7Whdf15B+rGd0MEhPSAQ5fi3VzwgnO83ZtfRjrGWLYPN8ZaSL/nORQLwaf0dGlSJ74grRFs8ru+HqRliRZKbO94Wd0gePV3C2taeW00pwQrI=
Message-ID: <44DE4201.4020703@gmail.com>
Date: Sat, 12 Aug 2006 23:02:57 +0200
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
CC: Andrew Morton <akpm@osdl.org>,
       James Bottomley <James.Bottomley@steeleye.com>,
       linux-scsi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
       ipslinux@adaptec.com
Subject: Re: [RFC] [PATCH 6/9] drivers/scsi/ips.h Removal of old scsi code
References: <44DE3E5E.3020605@gmail.com>
In-Reply-To: <44DE3E5E.3020605@gmail.com>
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>

diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/scsi/ips.h linux-work/drivers/scsi/ips.h
--- linux-work-clean/drivers/scsi/ips.h	2006-03-20 06:53:29.000000000 +0100
+++ linux-work/drivers/scsi/ips.h	2006-08-12 22:02:54.000000000 +0200
@@ -57,9 +57,7 @@
    /*
     * Some handy macros
     */
-   #if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,20) || defined CONFIG_HIGHIO
-      #define IPS_HIGHIO
-   #endif
+    #define IPS_HIGHIO

    #define IPS_HA(x)                   ((ips_ha_t *) x->hostdata)
    #define IPS_COMMAND_ID(ha, scb)     (int) (scb - ha->scbs)
@@ -83,11 +81,6 @@
     #define IPS_SGLIST_SIZE(ha)       (IPS_USE_ENH_SGLIST(ha) ? \
                                          sizeof(IPS_ENH_SG_LIST) : sizeof(IPS_STD_SG_LIST))

-   #if LINUX_VERSION_CODE < KERNEL_VERSION(2,4,4)
-      #define pci_set_dma_mask(dev,mask) ( mask > 0xffffffff ? 1:0 )
-      #define scsi_set_pci_device(sh,dev) (0)
-   #endif
-
    #ifndef IRQ_NONE
       typedef void irqreturn_t;
       #define IRQ_NONE
@@ -95,18 +88,6 @@
       #define IRQ_RETVAL(x)
    #endif

-   #if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-      #define IPS_REGISTER_HOSTS(SHT)      scsi_register_module(MODULE_SCSI_HA,SHT)
-      #define IPS_UNREGISTER_HOSTS(SHT)    scsi_unregister_module(MODULE_SCSI_HA,SHT)
-      #define IPS_ADD_HOST(shost,device)
-      #define IPS_REMOVE_HOST(shost)
-      #define IPS_SCSI_SET_DEVICE(sh,ha)   scsi_set_pci_device(sh, (ha)->pcidev)
-      #define IPS_PRINTK(level, pcidev, format, arg...)                 \
-            printk(level "%s %s:" format , "ips" ,     \
-            (pcidev)->slot_name , ## arg)
-      #define scsi_host_alloc(sh,size)         scsi_register(sh,size)
-      #define scsi_host_put(sh)             scsi_unregister(sh)
-   #else
       #define IPS_REGISTER_HOSTS(SHT)      (!ips_detect(SHT))
       #define IPS_UNREGISTER_HOSTS(SHT)
       #define IPS_ADD_HOST(shost,device)   do { scsi_add_host(shost,device); scsi_scan_host(shost); } while (0)
@@ -114,7 +95,6 @@
       #define IPS_SCSI_SET_DEVICE(sh,ha)   do { } while (0)
       #define IPS_PRINTK(level, pcidev, format, arg...)                 \
             dev_printk(level , &((pcidev)->dev) , format , ## arg)
-   #endif

    #ifndef MDELAY
       #define MDELAY mdelay
@@ -448,16 +428,10 @@
    /*
     * Scsi_Host Template
     */
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-   static int ips_proc24_info(char *, char **, off_t, int, int, int);
-   static void ips_select_queue_depth(struct Scsi_Host *, struct scsi_device *);
-   static int ips_biosparam(Disk *disk, kdev_t dev, int geom[]);
-#else
    static int ips_proc_info(struct Scsi_Host *, char *, char **, off_t, int, int);
    static int ips_biosparam(struct scsi_device *sdev, struct block_device *bdev,
 		sector_t capacity, int geom[]);
    static int ips_slave_configure(struct scsi_device *SDptr);
-#endif

 /*
  * Raid Command Formats

