Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263813AbTDIVLm (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 17:11:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263821AbTDIVLm (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 17:11:42 -0400
Received: from palrel10.hp.com ([156.153.255.245]:10444 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S263813AbTDIVLk (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 17:11:40 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16020.36679.706202.639063@napali.hpl.hp.com>
Date: Wed, 9 Apr 2003 14:23:19 -0700
To: davej@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: a couple of AGP cleanups
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A couple of small AGP fixes.  The include of <linux/vmalloc.h> is
needed since agp/generic.c calls vmalloc() in agp_create_memory().
The other patches affect ia64 only.

Thanks,

	--david

diff -Nru a/drivers/char/agp/generic.c b/drivers/char/agp/generic.c
--- a/drivers/char/agp/generic.c	Wed Apr  9 13:28:53 2003
+++ b/drivers/char/agp/generic.c	Wed Apr  9 13:28:53 2003
@@ -34,6 +34,7 @@
 #include <linux/miscdevice.h>
 #include <linux/pm.h>
 #include <linux/agp_backend.h>
+#include <linux/vmalloc.h>
 #include "agp.h"
 
 __u32 *agp_gatt_table; 
diff -Nru a/drivers/char/agp/hp-agp.c b/drivers/char/agp/hp-agp.c
--- a/drivers/char/agp/hp-agp.c	Wed Apr  9 13:28:53 2003
+++ b/drivers/char/agp/hp-agp.c	Wed Apr  9 13:28:53 2003
@@ -369,7 +369,7 @@
 }
 
 static struct agp_driver hp_agp_driver = {
-	.owner = THIS_MODULE;
+	.owner = THIS_MODULE,
 };
 
 static int __init agp_hp_probe (struct pci_dev *dev, const struct pci_device_id *ent)
@@ -394,7 +394,7 @@
 	{ }
 };
 
-MODULE_DEVICE_TABLE(pci, agp_pci_table);
+MODULE_DEVICE_TABLE(pci, agp_hp_pci_table);
 
 static struct __initdata pci_driver agp_hp_pci_driver = {
 	.name		= "agpgart-hp",
diff -Nru a/drivers/char/agp/i460-agp.c b/drivers/char/agp/i460-agp.c
--- a/drivers/char/agp/i460-agp.c	Wed Apr  9 13:28:53 2003
+++ b/drivers/char/agp/i460-agp.c	Wed Apr  9 13:28:53 2003
@@ -560,7 +560,7 @@
 }
 
 static struct agp_driver i460_agp_driver = {
-	.owner = THIS_MODULE;
+	.owner = THIS_MODULE,
 };
 
 static int __init agp_intel_i460_probe (struct pci_dev *dev, const struct pci_device_id *ent)
diff -Nru a/drivers/char/drm/drm_bufs.h b/drivers/char/drm/drm_bufs.h
--- a/drivers/char/drm/drm_bufs.h	Wed Apr  9 13:28:52 2003
+++ b/drivers/char/drm/drm_bufs.h	Wed Apr  9 13:28:52 2003
@@ -106,7 +106,7 @@
 	switch ( map->type ) {
 	case _DRM_REGISTERS:
 	case _DRM_FRAME_BUFFER:
-#if !defined(__sparc__) && !defined(__alpha__)
+#if !defined(__sparc__) && !defined(__alpha__) && !defined(__ia64__)
 		if ( map->offset + map->size < map->offset ||
 		     map->offset < virt_to_phys(high_memory) ) {
 			DRM(free)( map, sizeof(*map), DRM_MEM_MAPS );
