Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268346AbUIMSCK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268346AbUIMSCK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 14:02:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268274AbUIMSCJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 14:02:09 -0400
Received: from magic.adaptec.com ([216.52.22.17]:1947 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S268139AbUIMSCA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 14:02:00 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: 2.4.28-pre3: broken ips update
Date: Mon, 13 Sep 2004 14:01:46 -0400
Message-ID: <A121ABA5B472B74EB59076B8E3C8F0197965F4@rtpe2k01.adaptec.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.4.28-pre3: broken ips update
Thread-Index: AcSZoYkJAHWFE6hTSSaV9HAiuIySrwAER1xgAAGDYgA=
From: "Hammer, Jack" <Jack_Hammer@adaptec.com>
To: <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>
Cc: "Marcelo Tosatti" <marcelo.tosatti@cyclades.com>,
       "Arjan van de Ven" <arjanv@redhat.com>, "Adrian Bunk" <bunk@fs.tum.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch replaces the patch I submitted ( and then rescinded ) earlier
today. It fixes the compilation problem in 2.4.28 and includes the
changes recommended by Arjan on my earlier proposal for this.

Jack 




--- linux.orig/drivers/scsi/ips.h	Mon Sep 13 12:51:04 2004
+++ linux/drivers/scsi/ips.h	Mon Sep 13 12:55:15 2004
@@ -95,15 +95,14 @@
       #define scsi_set_pci_device(sh,dev) (0)
    #endif
 
-   #if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-   
-      #ifndef irqreturn_t
-         typedef void irqreturn_t;
-      #endif 
-      
+   #ifndef IRQ_NONE
+      typedef void irqreturn_t;
       #define IRQ_NONE
       #define IRQ_HANDLED
       #define IRQ_RETVAL(x)
+   #endif
+   
+   #if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
       #define IPS_REGISTER_HOSTS(SHT)
scsi_register_module(MODULE_SCSI_HA,SHT)
       #define IPS_UNREGISTER_HOSTS(SHT)
scsi_unregister_module(MODULE_SCSI_HA,SHT)
       #define IPS_ADD_HOST(shost,device) 



