Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264368AbTFECFx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 22:05:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264424AbTFECEs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 22:04:48 -0400
Received: from granite.he.net ([216.218.226.66]:58886 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S264368AbTFECCD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 22:02:03 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10547787472263@kroah.com>
Subject: Re: [PATCH] PCI and PCI Hotplug changes and fixes for 2.5.70
In-Reply-To: <10547787473026@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 4 Jun 2003 19:05:47 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1254.4.8, 2003/06/03 22:48:45-07:00, greg@kroah.com

[PATCH] PCI: Remove a lot of PCI core only functions from include/linux/pci.h


 drivers/pci/bus.c                      |    1 
 drivers/pci/hotplug/acpiphp_glue.c     |    1 
 drivers/pci/hotplug/acpiphp_pci.c      |    1 
 drivers/pci/hotplug/cpci_hotplug_pci.c |    1 
 drivers/pci/hotplug/cpqphp_pci.c       |    1 
 drivers/pci/hotplug/ibmphp_core.c      |    1 
 drivers/pci/pci.h                      |   44 ++++++++++++++++++++++++++++
 drivers/pci/setup-res.c                |    2 -
 include/linux/pci.h                    |   51 ---------------------------------
 9 files changed, 50 insertions(+), 53 deletions(-)


diff -Nru a/drivers/pci/bus.c b/drivers/pci/bus.c
--- a/drivers/pci/bus.c	Wed Jun  4 18:11:51 2003
+++ b/drivers/pci/bus.c	Wed Jun  4 18:11:51 2003
@@ -129,6 +129,5 @@
 	}
 }
 
-EXPORT_SYMBOL(pci_bus_alloc_resource);
 EXPORT_SYMBOL(pci_bus_add_devices);
 EXPORT_SYMBOL(pci_enable_bridges);
diff -Nru a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
--- a/drivers/pci/hotplug/acpiphp_glue.c	Wed Jun  4 18:11:51 2003
+++ b/drivers/pci/hotplug/acpiphp_glue.c	Wed Jun  4 18:11:51 2003
@@ -34,6 +34,7 @@
 #include <linux/init.h>
 #include <asm/semaphore.h>
 
+#include "../pci.h"
 #include "pci_hotplug.h"
 #include "acpiphp.h"
 
diff -Nru a/drivers/pci/hotplug/acpiphp_pci.c b/drivers/pci/hotplug/acpiphp_pci.c
--- a/drivers/pci/hotplug/acpiphp_pci.c	Wed Jun  4 18:11:51 2003
+++ b/drivers/pci/hotplug/acpiphp_pci.c	Wed Jun  4 18:11:51 2003
@@ -35,6 +35,7 @@
 #include <linux/pci.h>
 #include <linux/init.h>
 #include <linux/acpi.h>
+#include "../pci.h"
 #include "pci_hotplug.h"
 #include "acpiphp.h"
 
diff -Nru a/drivers/pci/hotplug/cpci_hotplug_pci.c b/drivers/pci/hotplug/cpci_hotplug_pci.c
--- a/drivers/pci/hotplug/cpci_hotplug_pci.c	Wed Jun  4 18:11:51 2003
+++ b/drivers/pci/hotplug/cpci_hotplug_pci.c	Wed Jun  4 18:11:51 2003
@@ -28,6 +28,7 @@
 #include <linux/kernel.h>
 #include <linux/pci.h>
 #include <linux/proc_fs.h>
+#include "../pci.h"
 #include "pci_hotplug.h"
 #include "cpci_hotplug.h"
 
diff -Nru a/drivers/pci/hotplug/cpqphp_pci.c b/drivers/pci/hotplug/cpqphp_pci.c
--- a/drivers/pci/hotplug/cpqphp_pci.c	Wed Jun  4 18:11:51 2003
+++ b/drivers/pci/hotplug/cpqphp_pci.c	Wed Jun  4 18:11:51 2003
@@ -34,6 +34,7 @@
 #include <linux/workqueue.h>
 #include <linux/proc_fs.h>
 #include <linux/pci.h>
+#include "../pci.h"
 #include "cpqphp.h"
 #include "cpqphp_nvram.h"
 #include "../../../arch/i386/pci/pci.h"	/* horrible hack showing how processor dependent we are... */
diff -Nru a/drivers/pci/hotplug/ibmphp_core.c b/drivers/pci/hotplug/ibmphp_core.c
--- a/drivers/pci/hotplug/ibmphp_core.c	Wed Jun  4 18:11:51 2003
+++ b/drivers/pci/hotplug/ibmphp_core.c	Wed Jun  4 18:11:51 2003
@@ -35,6 +35,7 @@
 #include <linux/delay.h>
 #include <linux/wait.h>
 #include <linux/smp_lock.h>
+#include "../pci.h"
 #include "../../../arch/i386/pci/pci.h"	/* for struct irq_routing_table */
 #include "ibmphp.h"
 
diff -Nru a/drivers/pci/pci.h b/drivers/pci/pci.h
--- a/drivers/pci/pci.h	Wed Jun  4 18:11:51 2003
+++ b/drivers/pci/pci.h	Wed Jun  4 18:11:51 2003
@@ -3,3 +3,47 @@
 extern int pci_hotplug (struct device *dev, char **envp, int num_envp,
 			 char *buffer, int buffer_size);
 extern void pci_create_sysfs_dev_files(struct pci_dev *pdev);
+extern int pci_bus_alloc_resource(struct pci_bus *bus, struct resource *res,
+				  unsigned long size, unsigned long align,
+				  unsigned long min, unsigned int type_mask,
+				  void (*alignf)(void *, struct resource *,
+					  	 unsigned long, unsigned long),
+				  void *alignf_data);
+extern int pci_proc_attach_device(struct pci_dev *dev);
+extern int pci_proc_detach_device(struct pci_dev *dev);
+extern int pci_proc_attach_bus(struct pci_bus *bus);
+extern int pci_proc_detach_bus(struct pci_bus *bus);
+
+/* Functions for PCI Hotplug drivers to use */
+extern struct pci_bus * pci_add_new_bus(struct pci_bus *parent, struct pci_dev *dev, int busnr);
+extern unsigned int pci_do_scan_bus(struct pci_bus *bus);
+extern void pci_remove_bus_device(struct pci_dev *dev);
+extern int pci_remove_device_safe(struct pci_dev *dev);
+
+struct pci_dev_wrapped {
+	struct pci_dev	*dev;
+	void		*data;
+};
+
+struct pci_bus_wrapped {
+	struct pci_bus	*bus;
+	void		*data;
+};
+
+struct pci_visit {
+	int (* pre_visit_pci_bus)	(struct pci_bus_wrapped *,
+					 struct pci_dev_wrapped *);
+	int (* post_visit_pci_bus)	(struct pci_bus_wrapped *,
+					 struct pci_dev_wrapped *);
+
+	int (* pre_visit_pci_dev)	(struct pci_dev_wrapped *,
+					 struct pci_bus_wrapped *);
+	int (* visit_pci_dev)		(struct pci_dev_wrapped *,
+					 struct pci_bus_wrapped *);
+	int (* post_visit_pci_dev)	(struct pci_dev_wrapped *,
+					 struct pci_bus_wrapped *);
+};
+
+extern int pci_visit_dev(struct pci_visit *fn,
+			 struct pci_dev_wrapped *wrapped_dev,
+			 struct pci_bus_wrapped *wrapped_parent);
diff -Nru a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
--- a/drivers/pci/setup-res.c	Wed Jun  4 18:11:51 2003
+++ b/drivers/pci/setup-res.c	Wed Jun  4 18:11:51 2003
@@ -23,7 +23,7 @@
 #include <linux/ioport.h>
 #include <linux/cache.h>
 #include <linux/slab.h>
-
+#include "pci.h"
 
 #define DEBUG_CONFIG 0
 #if DEBUG_CONFIG
diff -Nru a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	Wed Jun  4 18:11:51 2003
+++ b/include/linux/pci.h	Wed Jun  4 18:11:51 2003
@@ -548,10 +548,6 @@
 }
 int pci_scan_slot(struct pci_bus *bus, int devfn);
 void pci_bus_add_devices(struct pci_bus *bus);
-int pci_proc_attach_device(struct pci_dev *dev);
-int pci_proc_detach_device(struct pci_dev *dev);
-int pci_proc_attach_bus(struct pci_bus *bus);
-int pci_proc_detach_bus(struct pci_bus *bus);
 void pci_name_device(struct pci_dev *dev);
 char *pci_class_name(u32 class);
 void pci_read_bridge_bases(struct pci_bus *child);
@@ -640,24 +636,14 @@
 void pci_release_region(struct pci_dev *, int);
 
 /* drivers/pci/bus.c */
-
-int pci_bus_alloc_resource(struct pci_bus *bus, struct resource *res,
-			   unsigned long size, unsigned long align,
-			   unsigned long min, unsigned int type_mask,
-			   void (*alignf)(void *, struct resource *,
-					  unsigned long, unsigned long),
-			   void *alignf_data);
 void pci_enable_bridges(struct pci_bus *bus);
 
 /* New-style probing supporting hot-pluggable devices */
 int pci_register_driver(struct pci_driver *);
 void pci_unregister_driver(struct pci_driver *);
-void pci_remove_bus_device(struct pci_dev *);
 void pci_remove_behind_bridge(struct pci_dev *);
 struct pci_driver *pci_dev_driver(const struct pci_dev *);
 const struct pci_device_id *pci_match_device(const struct pci_device_id *ids, const struct pci_dev *dev);
-unsigned int pci_do_scan_bus(struct pci_bus *bus);
-struct pci_bus * pci_add_new_bus(struct pci_bus *parent, struct pci_dev *dev, int busnr);
 int pci_scan_bridge(struct pci_bus *bus, struct pci_dev * dev, int max, int pass);
 
 /* kmem_cache style wrapper around pci_alloc_consistent() */
@@ -672,42 +658,6 @@
 extern struct pci_dev *isa_bridge;
 #endif
 
-/* Some worker functions that PCI Hotplug drivers find useful */
-struct pci_dev_wrapped {
-	struct pci_dev	*dev;
-	void		*data;
-};
-
-struct pci_bus_wrapped {
-	struct pci_bus	*bus;
-	void		*data;
-};
-
-struct pci_visit {
-	int (* pre_visit_pci_bus)	(struct pci_bus_wrapped *,
-					 struct pci_dev_wrapped *);
-	int (* post_visit_pci_bus)	(struct pci_bus_wrapped *,
-					 struct pci_dev_wrapped *);
-
-	int (* pre_visit_pci_dev)	(struct pci_dev_wrapped *,
-					 struct pci_bus_wrapped *);
-	int (* visit_pci_dev)		(struct pci_dev_wrapped *,
-					 struct pci_bus_wrapped *);
-	int (* post_visit_pci_dev)	(struct pci_dev_wrapped *,
-					 struct pci_bus_wrapped *);
-};
-
-extern int pci_visit_dev(struct pci_visit *fn,
-			 struct pci_dev_wrapped *wrapped_dev,
-			 struct pci_bus_wrapped *wrapped_parent);
-extern int pci_remove_device_safe(struct pci_dev *dev);
-
-static inline void
-pci_dynids_set_use_driver_data(struct pci_driver *pdrv, int val)
-{
-	pdrv->dynids.use_driver_data = val;
-}
-
 #endif /* CONFIG_PCI */
 
 /* Include architecture-dependent settings and functions */
@@ -756,7 +706,6 @@
 static inline int scsi_to_pci_dma_dir(unsigned char scsi_dir) { return scsi_dir; }
 static inline int pci_find_capability (struct pci_dev *dev, int cap) {return 0; }
 static inline const struct pci_device_id *pci_match_device(const struct pci_device_id *ids, const struct pci_dev *dev) { return NULL; }
-static inline void pci_dynids_set_use_driver_data(struct pci_driver *pdrv, int val) { }
 
 /* Power management related routines */
 static inline int pci_save_state(struct pci_dev *dev, u32 *buffer) { return 0; }

