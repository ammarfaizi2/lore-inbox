Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275110AbRJOR7g>; Mon, 15 Oct 2001 13:59:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275739AbRJOR70>; Mon, 15 Oct 2001 13:59:26 -0400
Received: from postfix1-2.free.fr ([213.228.0.130]:9740 "HELO
	postfix1-2.free.fr") by vger.kernel.org with SMTP
	id <S275110AbRJOR7I>; Mon, 15 Oct 2001 13:59:08 -0400
Date: Mon, 15 Oct 2001 19:59:34 +0200
From: christophe barbe <christophe.barbe.ml@online.fr>
To: linux-kernel@vger.kernel.org
Cc: gibbs@plutotech.com
Subject: [PATCH] export pci_table in aic7xxx for Hotplug
Message-ID: <20011015195934.C2665@turing>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="AWniW0JNca5xppdA"
Content-Transfer-Encoding: 8bit
X-Mailer: Balsa 1.2.pre3
X-Operating-System: debian SID Gnu/Linux 2.4.12 on i586
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--AWniW0JNca5xppdA
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

Attached to this mail is a patch (against 2.4.12) that export the PCI table
for the hotplug code (via modules.pcimaps).

I use it succesfully with my Adaptec APA1480A cardbus and the hotplug code.

Christophe Barbé


-- 
Christophe Barbé <christophe.barbe@online.fr>
GnuPG FingerPrint: E0F6 FADF 2A5C F072 6AF8  F67A 8F45 2F1E D72C B41E

--AWniW0JNca5xppdA
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="aic7xxx-k2412-bis.patch"

--- linux/drivers/scsi/aic7xxx/aic7xxx_linux_pci.c	Mon Sep 24 20:30:34 2001
+++ linux/drivers/scsi/aic7xxx/aic7xxx_linux_pci.c	Fri Oct 12 19:34:05 2001
@@ -33,6 +33,9 @@
 
 #include "aic7xxx_osm.h"
 
+#define __NO_VERSION__
+#include <linux/module.h>
+
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,4,0)
 struct pci_device_id
 {
@@ -56,6 +59,8 @@
 	},
 	{ 0 }
 };
+
+MODULE_DEVICE_TABLE(pci, ahc_linux_pci_id_table);
 
 struct pci_driver aic7xxx_pci_driver = {
 	name:		"aic7xxx",

--AWniW0JNca5xppdA--
