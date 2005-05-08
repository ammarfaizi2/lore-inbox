Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262995AbVEHWia@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262995AbVEHWia (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 May 2005 18:38:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262996AbVEHWia
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 May 2005 18:38:30 -0400
Received: from mail.dif.dk ([193.138.115.101]:32224 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S262995AbVEHWh4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 May 2005 18:37:56 -0400
Date: Mon, 9 May 2005 00:41:44 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Marc Zyngier <maz@wild-wind.fr.eu.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Whitespace clenups for drivers/eisa/
Message-ID: <Pine.LNX.4.62.0505090035560.2440@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove spaces between function names and opening parenthesis.
Those space are not in line with Documentation/CodingStyle and they really 
get on my nerves as well when reading the code, so I desided to get rid of 
them. :)
A blank line also met its maker and some stuff got moved to a single line 
instead of two.

Please consider applying.


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
---

 drivers/eisa/eisa-bus.c     |  205 +++++++++++++++++++++-----------------------
 drivers/eisa/pci_eisa.c     |   18 +--
 drivers/eisa/virtual_root.c |   16 +--
 3 files changed, 118 insertions(+), 121 deletions(-)

diff -upr linux-2.6.12-rc3-mm3-orig/drivers/eisa/eisa-bus.c linux-2.6.12-rc3-mm3/drivers/eisa/eisa-bus.c
--- linux-2.6.12-rc3-mm3-orig/drivers/eisa/eisa-bus.c	2005-03-02 08:37:52.000000000 +0100
+++ linux-2.6.12-rc3-mm3/drivers/eisa/eisa-bus.c	2005-05-09 00:31:52.000000000 +0200
@@ -39,10 +39,10 @@ static int enable_dev_count;
 static int disable_dev[EISA_MAX_FORCED_DEV];
 static int disable_dev_count;
 
-static int is_forced_dev (int *forced_tab,
-			  int forced_count,
-			  struct eisa_root_device *root,
-			  struct eisa_device *edev)
+static int is_forced_dev(int *forced_tab,
+			 int forced_count,
+			 struct eisa_root_device *root,
+			 struct eisa_device *edev)
 {
 	int i, x;
 
@@ -55,21 +55,21 @@ static int is_forced_dev (int *forced_ta
 	return 0;
 }
 
-static void __init eisa_name_device (struct eisa_device *edev)
+static void __init eisa_name_device(struct eisa_device *edev)
 {
 #ifdef CONFIG_EISA_NAMES
 	int i;
 	for (i = 0; i < EISA_INFOS; i++) {
 		if (!strcmp (edev->id.sig, eisa_table[i].id.sig)) {
-			strlcpy (edev->pretty_name,
-				 eisa_table[i].name,
-				 DEVICE_NAME_SIZE);
+			strlcpy(edev->pretty_name,
+				eisa_table[i].name,
+				DEVICE_NAME_SIZE);
 			return;
 		}
 	}
 
 	/* No name was found */
-	sprintf (edev->pretty_name, "EISA device %.7s", edev->id.sig);
+	sprintf(edev->pretty_name, "EISA device %.7s", edev->id.sig);
 #endif
 }
 
@@ -106,22 +106,21 @@ static char __init *decode_eisa_sig(unsi
         return sig_str;
 }
 
-static int eisa_bus_match (struct device *dev, struct device_driver *drv)
+static int eisa_bus_match(struct device *dev, struct device_driver *drv)
 {
-	struct eisa_device *edev = to_eisa_device (dev);
-	struct eisa_driver *edrv = to_eisa_driver (drv);
+	struct eisa_device *edev = to_eisa_device(dev);
+	struct eisa_driver *edrv = to_eisa_driver(drv);
 	const struct eisa_device_id *eids = edrv->id_table;
 
 	if (!eids)
 		return 0;
 
-	while (strlen (eids->sig)) {
-		if (!strcmp (eids->sig, edev->id.sig) &&
+	while (strlen(eids->sig)) {
+		if (!strcmp(eids->sig, edev->id.sig) &&
 		    edev->state & EISA_CONFIG_ENABLED) {
 			edev->id.driver_data = eids->driver_data;
 			return 1;
 		}
-
 		eids++;
 	}
 
@@ -133,62 +132,62 @@ struct bus_type eisa_bus_type = {
 	.match = eisa_bus_match,
 };
 
-int eisa_driver_register (struct eisa_driver *edrv)
+int eisa_driver_register(struct eisa_driver *edrv)
 {
 	int r;
 	
 	edrv->driver.bus = &eisa_bus_type;
-	if ((r = driver_register (&edrv->driver)) < 0)
+	if ((r = driver_register(&edrv->driver)) < 0)
 		return r;
 
 	return 0;
 }
 
-void eisa_driver_unregister (struct eisa_driver *edrv)
+void eisa_driver_unregister(struct eisa_driver *edrv)
 {
-	driver_unregister (&edrv->driver);
+	driver_unregister(&edrv->driver);
 }
 
-static ssize_t eisa_show_sig (struct device *dev, char *buf)
+static ssize_t eisa_show_sig(struct device *dev, char *buf)
 {
-        struct eisa_device *edev = to_eisa_device (dev);
-        return sprintf (buf,"%s\n", edev->id.sig);
+        struct eisa_device *edev = to_eisa_device(dev);
+        return sprintf(buf,"%s\n", edev->id.sig);
 }
 
 static DEVICE_ATTR(signature, S_IRUGO, eisa_show_sig, NULL);
 
-static ssize_t eisa_show_state (struct device *dev, char *buf)
+static ssize_t eisa_show_state(struct device *dev, char *buf)
 {
         struct eisa_device *edev = to_eisa_device (dev);
-        return sprintf (buf,"%d\n", edev->state & EISA_CONFIG_ENABLED);
+        return sprintf(buf,"%d\n", edev->state & EISA_CONFIG_ENABLED);
 }
 
 static DEVICE_ATTR(enabled, S_IRUGO, eisa_show_state, NULL);
 
-static int __init eisa_init_device (struct eisa_root_device *root,
-				    struct eisa_device *edev,
-				    int slot)
+static int __init eisa_init_device(struct eisa_root_device *root,
+				   struct eisa_device *edev,
+				   int slot)
 {
 	char *sig;
         unsigned long sig_addr;
 	int i;
 
-	sig_addr = SLOT_ADDRESS (root, slot) + EISA_VENDOR_ID_OFFSET;
+	sig_addr = SLOT_ADDRESS(root, slot) + EISA_VENDOR_ID_OFFSET;
 
-	if (!(sig = decode_eisa_sig (sig_addr)))
+	if (!(sig = decode_eisa_sig(sig_addr)))
 		return -1;	/* No EISA device here */
 	
-	memcpy (edev->id.sig, sig, EISA_SIG_LEN);
+	memcpy(edev->id.sig, sig, EISA_SIG_LEN);
 	edev->slot = slot;
-	edev->state = inb (SLOT_ADDRESS (root, slot) + EISA_CONFIG_OFFSET) & EISA_CONFIG_ENABLED;
-	edev->base_addr = SLOT_ADDRESS (root, slot);
+	edev->state = inb(SLOT_ADDRESS(root, slot) + EISA_CONFIG_OFFSET) & EISA_CONFIG_ENABLED;
+	edev->base_addr = SLOT_ADDRESS(root, slot);
 	edev->dma_mask = root->dma_mask; /* Default DMA mask */
-	eisa_name_device (edev);
+	eisa_name_device(edev);
 	edev->dev.parent = root->dev;
 	edev->dev.bus = &eisa_bus_type;
 	edev->dev.dma_mask = &edev->dma_mask;
 	edev->dev.coherent_dma_mask = edev->dma_mask;
-	sprintf (edev->dev.bus_id, "%02X:%02X", root->bus_nr, slot);
+	sprintf(edev->dev.bus_id, "%02X:%02X", root->bus_nr, slot);
 
 	for (i = 0; i < EISA_MAX_RESOURCES; i++) {
 #ifdef CONFIG_EISA_NAMES
@@ -198,29 +197,29 @@ static int __init eisa_init_device (stru
 #endif
 	}
 
-	if (is_forced_dev (enable_dev, enable_dev_count, root, edev))
+	if (is_forced_dev(enable_dev, enable_dev_count, root, edev))
 		edev->state = EISA_CONFIG_ENABLED | EISA_CONFIG_FORCED;
 	
-	if (is_forced_dev (disable_dev, disable_dev_count, root, edev))
+	if (is_forced_dev(disable_dev, disable_dev_count, root, edev))
 		edev->state = EISA_CONFIG_FORCED;
 
 	return 0;
 }
 
-static int __init eisa_register_device (struct eisa_device *edev)
+static int __init eisa_register_device(struct eisa_device *edev)
 {
-	if (device_register (&edev->dev))
+	if (device_register(&edev->dev))
 		return -1;
 
-	device_create_file (&edev->dev, &dev_attr_signature);
-	device_create_file (&edev->dev, &dev_attr_enabled);
+	device_create_file(&edev->dev, &dev_attr_signature);
+	device_create_file(&edev->dev, &dev_attr_enabled);
 
 	return 0;
 }
 
-static int __init eisa_request_resources (struct eisa_root_device *root,
-					  struct eisa_device *edev,
-					  int slot)
+static int __init eisa_request_resources(struct eisa_root_device *root,
+					 struct eisa_device *edev,
+					 int slot)
 {
 	int i;
 
@@ -238,137 +237,135 @@ static int __init eisa_request_resources
 		
 		if (slot) {
 			edev->res[i].name  = NULL;
-			edev->res[i].start = SLOT_ADDRESS (root, slot) + (i * 0x400);
+			edev->res[i].start = SLOT_ADDRESS(root, slot) + (i * 0x400);
 			edev->res[i].end   = edev->res[i].start + 0xff;
 			edev->res[i].flags = IORESOURCE_IO;
 		} else {
 			edev->res[i].name  = NULL;
-			edev->res[i].start = SLOT_ADDRESS (root, slot) + EISA_VENDOR_ID_OFFSET;
+			edev->res[i].start = SLOT_ADDRESS(root, slot) + EISA_VENDOR_ID_OFFSET;
 			edev->res[i].end   = edev->res[i].start + 3;
 			edev->res[i].flags = IORESOURCE_BUSY;
 		}
 
-		if (request_resource (root->res, &edev->res[i]))
+		if (request_resource(root->res, &edev->res[i]))
 			goto failed;
 	}
 
 	return 0;
 	
- failed:
+failed:
 	while (--i >= 0)
-		release_resource (&edev->res[i]);
+		release_resource(&edev->res[i]);
 
 	return -1;
 }
 
-static void __init eisa_release_resources (struct eisa_device *edev)
+static void __init eisa_release_resources(struct eisa_device *edev)
 {
 	int i;
 
 	for (i = 0; i < EISA_MAX_RESOURCES; i++)
 		if (edev->res[i].start || edev->res[i].end)
-			release_resource (&edev->res[i]);
+			release_resource(&edev->res[i]);
 }
 
-static int __init eisa_probe (struct eisa_root_device *root)
+static int __init eisa_probe(struct eisa_root_device *root)
 {
         int i, c;
 	struct eisa_device *edev;
 
-        printk (KERN_INFO "EISA: Probing bus %d at %s\n",
-		root->bus_nr, root->dev->bus_id);
+        printk(KERN_INFO "EISA: Probing bus %d at %s\n",
+	       root->bus_nr, root->dev->bus_id);
 
 	/* First try to get hold of slot 0. If there is no device
 	 * here, simply fail, unless root->force_probe is set. */
 	
-	if (!(edev = kmalloc (sizeof (*edev), GFP_KERNEL))) {
-		printk (KERN_ERR "EISA: Couldn't allocate mainboard slot\n");
+	if (!(edev = kmalloc(sizeof(*edev), GFP_KERNEL))) {
+		printk(KERN_ERR "EISA: Couldn't allocate mainboard slot\n");
 		return -ENOMEM;
 	}
 		
-	memset (edev, 0, sizeof (*edev));
+	memset(edev, 0, sizeof (*edev));
 
-	if (eisa_request_resources (root, edev, 0)) {
-		printk (KERN_WARNING \
-			"EISA: Cannot allocate resource for mainboard\n");
-		kfree (edev);
+	if (eisa_request_resources(root, edev, 0)) {
+		printk(KERN_WARNING \
+		       "EISA: Cannot allocate resource for mainboard\n");
+		kfree(edev);
 		if (!root->force_probe)
 			return -EBUSY;
 		goto force_probe;
 	}
 
-	if (eisa_init_device (root, edev, 0)) {
-		eisa_release_resources (edev);
-		kfree (edev);
+	if (eisa_init_device(root, edev, 0)) {
+		eisa_release_resources(edev);
+		kfree(edev);
 		if (!root->force_probe)
 			return -ENODEV;
 		goto force_probe;
 	}
 
-	printk (KERN_INFO "EISA: Mainboard %s detected.\n", edev->id.sig);
+	printk(KERN_INFO "EISA: Mainboard %s detected.\n", edev->id.sig);
 
-	if (eisa_register_device (edev)) {
-		printk (KERN_ERR "EISA: Failed to register %s\n",
-			edev->id.sig);
-		eisa_release_resources (edev);
-		kfree (edev);
+	if (eisa_register_device(edev)) {
+		printk(KERN_ERR "EISA: Failed to register %s\n", edev->id.sig);
+		eisa_release_resources(edev);
+		kfree(edev);
 	}
 	
  force_probe:
 	
         for (c = 0, i = 1; i <= root->slots; i++) {
-		if (!(edev = kmalloc (sizeof (*edev), GFP_KERNEL))) {
-			printk (KERN_ERR "EISA: Out of memory for slot %d\n",
-				i);
+		if (!(edev = kmalloc(sizeof(*edev), GFP_KERNEL))) {
+			printk(KERN_ERR "EISA: Out of memory for slot %d\n", i);
 			continue;
 		}
 		
-		memset (edev, 0, sizeof (*edev));
+		memset(edev, 0, sizeof(*edev));
 
-		if (eisa_request_resources (root, edev, i)) {
-			printk (KERN_WARNING \
-				"Cannot allocate resource for EISA slot %d\n",
-				i);
-			kfree (edev);
+		if (eisa_request_resources(root, edev, i)) {
+			printk(KERN_WARNING \
+			       "Cannot allocate resource for EISA slot %d\n",
+			       i);
+			kfree(edev);
 			continue;
 		}
 
-                if (eisa_init_device (root, edev, i)) {
-			eisa_release_resources (edev);
-			kfree (edev);
+                if (eisa_init_device(root, edev, i)) {
+			eisa_release_resources(edev);
+			kfree(edev);
 			continue;
 		}
 		
-		printk (KERN_INFO "EISA: slot %d : %s detected",
-			i, edev->id.sig);
+		printk(KERN_INFO "EISA: slot %d : %s detected",	i,
+		       edev->id.sig);
 			
 		switch (edev->state) {
 		case EISA_CONFIG_ENABLED | EISA_CONFIG_FORCED:
-			printk (" (forced enabled)");
+			printk(" (forced enabled)");
 			break;
 
 		case EISA_CONFIG_FORCED:
-			printk (" (forced disabled)");
+			printk(" (forced disabled)");
 			break;
 
 		case 0:
-			printk (" (disabled)");
+			printk(" (disabled)");
 			break;
 		}
 			
-		printk (".\n");
+		printk(".\n");
 
 		c++;
 
 		if (eisa_register_device (edev)) {
-			printk (KERN_ERR "EISA: Failed to register %s\n",
-				edev->id.sig);
-			eisa_release_resources (edev);
-			kfree (edev);
+			printk(KERN_ERR "EISA: Failed to register %s\n",
+			       edev->id.sig);
+			eisa_release_resources(edev);
+			kfree(edev);
 		}
         }
 
-        printk (KERN_INFO "EISA: Detected %d card%s.\n", c, c == 1 ? "" : "s");
+        printk(KERN_INFO "EISA: Detected %d card%s.\n", c, c == 1 ? "" : "s");
 
 	return 0;
 }
@@ -382,7 +379,7 @@ static struct resource eisa_root_res = {
 
 static int eisa_bus_count;
 
-int __init eisa_root_register (struct eisa_root_device *root)
+int __init eisa_root_register(struct eisa_root_device *root)
 {
 	int err;
 
@@ -396,35 +393,35 @@ int __init eisa_root_register (struct ei
 	root->eisa_root_res.end   = root->res->end;
 	root->eisa_root_res.flags = IORESOURCE_BUSY;
 
-	if ((err = request_resource (&eisa_root_res, &root->eisa_root_res)))
+	if ((err = request_resource(&eisa_root_res, &root->eisa_root_res)))
 		return err;
 	
 	root->bus_nr = eisa_bus_count++;
 
-	if ((err = eisa_probe (root)))
-		release_resource (&root->eisa_root_res);
+	if ((err = eisa_probe(root)))
+		release_resource(&root->eisa_root_res);
 
 	return err;
 }
 
-static int __init eisa_init (void)
+static int __init eisa_init(void)
 {
 	int r;
 	
-	if ((r = bus_register (&eisa_bus_type)))
+	if ((r = bus_register(&eisa_bus_type)))
 		return r;
 
-	printk (KERN_INFO "EISA bus registered\n");
+	printk(KERN_INFO "EISA bus registered\n");
 	return 0;
 }
 
 module_param_array(enable_dev, int, &enable_dev_count, 0444);
 module_param_array(disable_dev, int, &disable_dev_count, 0444);
 
-postcore_initcall (eisa_init);
+postcore_initcall(eisa_init);
 
 int EISA_bus;		/* for legacy drivers */
-EXPORT_SYMBOL (EISA_bus);
-EXPORT_SYMBOL (eisa_bus_type);
-EXPORT_SYMBOL (eisa_driver_register);
-EXPORT_SYMBOL (eisa_driver_unregister);
+EXPORT_SYMBOL(EISA_bus);
+EXPORT_SYMBOL(eisa_bus_type);
+EXPORT_SYMBOL(eisa_driver_register);
+EXPORT_SYMBOL(eisa_driver_unregister);
diff -upr linux-2.6.12-rc3-mm3-orig/drivers/eisa/pci_eisa.c linux-2.6.12-rc3-mm3/drivers/eisa/pci_eisa.c
--- linux-2.6.12-rc3-mm3-orig/drivers/eisa/pci_eisa.c	2005-04-30 18:24:55.000000000 +0200
+++ linux-2.6.12-rc3-mm3/drivers/eisa/pci_eisa.c	2005-05-09 00:32:50.000000000 +0200
@@ -19,14 +19,14 @@
 /* There is only *one* pci_eisa device per machine, right ? */
 static struct eisa_root_device pci_eisa_root;
 
-static int __devinit pci_eisa_init (struct pci_dev *pdev,
-				    const struct pci_device_id *ent)
+static int __devinit pci_eisa_init(struct pci_dev *pdev,
+				   const struct pci_device_id *ent)
 {
 	int rc;
 
-	if ((rc = pci_enable_device (pdev))) {
-		printk (KERN_ERR "pci_eisa : Could not enable device %s\n",
-			pci_name(pdev));
+	if ((rc = pci_enable_device(pdev))) {
+		printk(KERN_ERR "pci_eisa : Could not enable device %s\n",
+		       pci_name(pdev));
 		return rc;
 	}
 
@@ -37,8 +37,8 @@ static int __devinit pci_eisa_init (stru
 	pci_eisa_root.slots	       = EISA_MAX_SLOTS;
 	pci_eisa_root.dma_mask         = pdev->dma_mask;
 
-	if (eisa_root_register (&pci_eisa_root)) {
-		printk (KERN_ERR "pci_eisa : Could not register EISA root\n");
+	if (eisa_root_register(&pci_eisa_root)) {
+		printk(KERN_ERR "pci_eisa : Could not register EISA root\n");
 		return -1;
 	}
 
@@ -57,9 +57,9 @@ static struct pci_driver pci_eisa_driver
 	.probe		= pci_eisa_init,
 };
 
-static int __init pci_eisa_init_module (void)
+static int __init pci_eisa_init_module(void)
 {
-	return pci_register_driver (&pci_eisa_driver);
+	return pci_register_driver(&pci_eisa_driver);
 }
 
 device_initcall(pci_eisa_init_module);
diff -upr linux-2.6.12-rc3-mm3-orig/drivers/eisa/virtual_root.c linux-2.6.12-rc3-mm3/drivers/eisa/virtual_root.c
--- linux-2.6.12-rc3-mm3-orig/drivers/eisa/virtual_root.c	2005-03-02 08:38:17.000000000 +0100
+++ linux-2.6.12-rc3-mm3/drivers/eisa/virtual_root.c	2005-05-09 00:33:50.000000000 +0200
@@ -22,7 +22,7 @@
 #endif
 
 static int force_probe = EISA_FORCE_PROBE_DEFAULT;
-static void virtual_eisa_release (struct device *);
+static void virtual_eisa_release(struct device *);
 
 /* The default EISA device parent (virtual root device).
  * Now use a platform device, since that's the obvious choice. */
@@ -43,16 +43,16 @@ static struct eisa_root_device eisa_bus_
 	.dma_mask      = 0xffffffff,
 };
 
-static void virtual_eisa_release (struct device *dev)
+static void virtual_eisa_release(struct device *dev)
 {
 	/* nothing really to do here */
 }
 
-static int virtual_eisa_root_init (void)
+static int virtual_eisa_root_init(void)
 {
 	int r;
 	
-        if ((r = platform_device_register (&eisa_root_dev))) {
+        if ((r = platform_device_register(&eisa_root_dev))) {
                 return r;
         }
 
@@ -60,16 +60,16 @@ static int virtual_eisa_root_init (void)
 	
 	eisa_root_dev.dev.driver_data = &eisa_bus_root;
 
-	if (eisa_root_register (&eisa_bus_root)) {
+	if (eisa_root_register(&eisa_bus_root)) {
 		/* A real bridge may have been registered before
 		 * us. So quietly unregister. */
-		platform_device_unregister (&eisa_root_dev);
+		platform_device_unregister(&eisa_root_dev);
 		return -1;
 	}
 
 	return 0;
 }
 
-module_param (force_probe, int, 0444);
+module_param(force_probe, int, 0444);
 
-device_initcall (virtual_eisa_root_init);
+device_initcall(virtual_eisa_root_init);



