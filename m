Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265470AbSKFBig>; Tue, 5 Nov 2002 20:38:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265309AbSKFBhG>; Tue, 5 Nov 2002 20:37:06 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:15376 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S265363AbSKFBfC>;
	Tue, 5 Nov 2002 20:35:02 -0500
Date: Tue, 5 Nov 2002 17:37:41 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Subject: Re: [BK PATCH] PCI hotplug changes for 2.5.46
Message-ID: <20021106013741.GS18627@kroah.com>
References: <20021106013615.GQ18627@kroah.com> <20021106013708.GR18627@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021106013708.GR18627@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.875.1.2, 2002/11/02 22:36:38-08:00, scottm@somanetworks.com

[PATCH] 2.5.45 CompactPCI driver patch 1/4

This is a patch 1 of 4 of my CompactPCI hotplug core and
drivers, consisting of the required core PCI changes.

The various arch file changes are to change pcibios_fixup_pbus_ranges to
from __init to __devinit, so that pci_setup_bridge can be safely exported
from drivers/pci/setup-bus.c.


diff -Nru a/arch/alpha/kernel/pci.c b/arch/alpha/kernel/pci.c
--- a/arch/alpha/kernel/pci.c	Tue Nov  5 17:26:27 2002
+++ b/arch/alpha/kernel/pci.c	Tue Nov  5 17:26:27 2002
@@ -326,7 +326,7 @@
 	return PCI_SLOT(dev->devfn);
 }
 
-void __init
+void __devinit
 pcibios_fixup_pbus_ranges(struct pci_bus * bus,
 			  struct pbus_set_ranges_data * ranges)
 {
diff -Nru a/arch/i386/pci/common.c b/arch/i386/pci/common.c
--- a/arch/i386/pci/common.c	Tue Nov  5 17:26:27 2002
+++ b/arch/i386/pci/common.c	Tue Nov  5 17:26:27 2002
@@ -90,6 +90,11 @@
 	}
 }
 
+void __devinit
+pcibios_fixup_pbus_ranges (struct pci_bus *bus, struct pbus_set_ranges_data *ranges)
+{
+}
+
 /*
  *  Called after each bus is probed, but before its children
  *  are examined.
diff -Nru a/arch/mips/ddb5074/pci.c b/arch/mips/ddb5074/pci.c
--- a/arch/mips/ddb5074/pci.c	Tue Nov  5 17:26:27 2002
+++ b/arch/mips/ddb5074/pci.c	Tue Nov  5 17:26:27 2002
@@ -297,8 +297,8 @@
 	pci_write_config_byte(dev, PCI_INTERRUPT_LINE, irq);
 }
 
-void __init pcibios_fixup_pbus_ranges(struct pci_bus *bus,
-				      struct pbus_set_ranges_data *ranges)
+void __devinit pcibios_fixup_pbus_ranges(struct pci_bus *bus,
+					 struct pbus_set_ranges_data *ranges)
 {
 }
 
diff -Nru a/arch/mips/ddb5476/pci.c b/arch/mips/ddb5476/pci.c
--- a/arch/mips/ddb5476/pci.c	Tue Nov  5 17:26:27 2002
+++ b/arch/mips/ddb5476/pci.c	Tue Nov  5 17:26:27 2002
@@ -341,8 +341,8 @@
 	pci_write_config_byte(dev, PCI_INTERRUPT_LINE, irq);
 }
 
-void __init pcibios_fixup_pbus_ranges(struct pci_bus *bus,
-				      struct pbus_set_ranges_data *ranges)
+void __devinit pcibios_fixup_pbus_ranges(struct pci_bus *bus,
+					 struct pbus_set_ranges_data *ranges)
 {
 	/*
 	 * our caller figure out range by going through the dev structures.  
diff -Nru a/arch/mips64/sgi-ip27/ip27-pci.c b/arch/mips64/sgi-ip27/ip27-pci.c
--- a/arch/mips64/sgi-ip27/ip27-pci.c	Tue Nov  5 17:26:27 2002
+++ b/arch/mips64/sgi-ip27/ip27-pci.c	Tue Nov  5 17:26:27 2002
@@ -234,7 +234,7 @@
 	pci_fixup_irqs(pci_swizzle, pci_map_irq);
 }
 
-void __init
+void __devinit
 pcibios_fixup_pbus_ranges(struct pci_bus * bus,
                           struct pbus_set_ranges_data * ranges)
 {
diff -Nru a/arch/mips64/sgi-ip32/ip32-pci.c b/arch/mips64/sgi-ip32/ip32-pci.c
--- a/arch/mips64/sgi-ip32/ip32-pci.c	Tue Nov  5 17:26:27 2002
+++ b/arch/mips64/sgi-ip32/ip32-pci.c	Tue Nov  5 17:26:27 2002
@@ -349,8 +349,8 @@
 }
 
 /* XXX anybody know what this is supposed to do? */
-void __init pcibios_fixup_pbus_ranges(struct pci_bus * bus,
-				      struct pbus_set_ranges_data * ranges)
+void __devinit pcibios_fixup_pbus_ranges(struct pci_bus * bus,
+					 struct pbus_set_ranges_data * ranges)
 {
 }
 
diff -Nru a/arch/parisc/kernel/pci.c b/arch/parisc/kernel/pci.c
--- a/arch/parisc/kernel/pci.c	Tue Nov  5 17:26:27 2002
+++ b/arch/parisc/kernel/pci.c	Tue Nov  5 17:26:27 2002
@@ -345,7 +345,7 @@
 /*
 ** called by drivers/pci/setup-res.c:pci_setup_bridge().
 */
-void pcibios_fixup_pbus_ranges(
+void __devinit pcibios_fixup_pbus_ranges(
 	struct pci_bus *bus,
 	struct pbus_set_ranges_data *ranges
 	)
diff -Nru a/arch/ppc/kernel/pci.c b/arch/ppc/kernel/pci.c
--- a/arch/ppc/kernel/pci.c	Tue Nov  5 17:26:27 2002
+++ b/arch/ppc/kernel/pci.c	Tue Nov  5 17:26:27 2002
@@ -1107,7 +1107,7 @@
 	return PCI_SLOT(dev->devfn);
 }
 
-void __init
+void __devinit
 pcibios_fixup_pbus_ranges(struct pci_bus * bus, struct pbus_set_ranges_data * ranges)
 {
 }
diff -Nru a/arch/ppc64/kernel/pci.c b/arch/ppc64/kernel/pci.c
--- a/arch/ppc64/kernel/pci.c	Tue Nov  5 17:26:27 2002
+++ b/arch/ppc64/kernel/pci.c	Tue Nov  5 17:26:27 2002
@@ -121,8 +121,8 @@
 }
 
 
-void pcibios_fixup_pbus_ranges(struct pci_bus *pbus,
-				struct pbus_set_ranges_data *pranges)
+void __devinit pcibios_fixup_pbus_ranges(struct pci_bus *pbus,
+					 struct pbus_set_ranges_data *pranges)
 {
 }
 
diff -Nru a/arch/sh/kernel/pci-dc.c b/arch/sh/kernel/pci-dc.c
--- a/arch/sh/kernel/pci-dc.c	Tue Nov  5 17:26:27 2002
+++ b/arch/sh/kernel/pci-dc.c	Tue Nov  5 17:26:27 2002
@@ -113,7 +113,7 @@
 }
 
 
-void __init pcibios_fixup_pbus_ranges(struct pci_bus *bus, struct pbus_set_ranges_data *ranges)
+void __devinit pcibios_fixup_pbus_ranges(struct pci_bus *bus, struct pbus_set_ranges_data *ranges)
 {
 }                                                                                
 
diff -Nru a/arch/sh/kernel/pci-sh7751.c b/arch/sh/kernel/pci-sh7751.c
--- a/arch/sh/kernel/pci-sh7751.c	Tue Nov  5 17:26:27 2002
+++ b/arch/sh/kernel/pci-sh7751.c	Tue Nov  5 17:26:27 2002
@@ -250,8 +250,8 @@
 	{ 0 }
 };
 
-void __init pcibios_fixup_pbus_ranges(struct pci_bus *b,
-		struct pbus_set_ranges_data *range)
+void __devinit pcibios_fixup_pbus_ranges(struct pci_bus *b,
+					 struct pbus_set_ranges_data *range)
 {
 	/* No fixups needed */
 }
diff -Nru a/arch/sh/kernel/pci_st40.c b/arch/sh/kernel/pci_st40.c
--- a/arch/sh/kernel/pci_st40.c	Tue Nov  5 17:26:27 2002
+++ b/arch/sh/kernel/pci_st40.c	Tue Nov  5 17:26:27 2002
@@ -380,7 +380,7 @@
 }
 
 
-void __init
+void __devinit
 pcibios_fixup_pbus_ranges(struct pci_bus *bus,
 			  struct pbus_set_ranges_data *ranges)
 {
diff -Nru a/arch/sparc64/kernel/pci.c b/arch/sparc64/kernel/pci.c
--- a/arch/sparc64/kernel/pci.c	Tue Nov  5 17:26:27 2002
+++ b/arch/sparc64/kernel/pci.c	Tue Nov  5 17:26:27 2002
@@ -479,8 +479,8 @@
 {
 }
 
-void pcibios_fixup_pbus_ranges(struct pci_bus *pbus,
-			       struct pbus_set_ranges_data *pranges)
+void __devinit pcibios_fixup_pbus_ranges(struct pci_bus *pbus,
+					 struct pbus_set_ranges_data *pranges)
 {
 }
 
diff -Nru a/drivers/pci/pci.c b/drivers/pci/pci.c
--- a/drivers/pci/pci.c	Tue Nov  5 17:26:27 2002
+++ b/drivers/pci/pci.c	Tue Nov  5 17:26:27 2002
@@ -25,6 +25,49 @@
 #endif
 
 /**
+ * pci_bus_max_busnr - returns maximum PCI bus number of given bus' children
+ * @bus: pointer to PCI bus structure to search
+ *
+ * Given a PCI bus, returns the highest PCI bus number present in the set
+ * including the given PCI bus and its list of child PCI buses.
+ */
+unsigned char __devinit
+pci_bus_max_busnr(struct pci_bus* bus)
+{
+	struct list_head *tmp;
+	unsigned char max, n;
+
+	max = bus->number;
+	list_for_each(tmp, &bus->children) {
+		n = pci_bus_max_busnr(pci_bus_b(tmp));
+		if(n > max)
+			max = n;
+	}
+	return max;
+}
+
+/**
+ * pci_max_busnr - returns maximum PCI bus number
+ *
+ * Returns the highest PCI bus number present in the system global list of
+ * PCI buses.
+ */
+unsigned char __devinit
+pci_max_busnr(void)
+{
+	struct pci_bus* bus;
+	unsigned char max, n;
+
+	max = 0;
+	pci_for_each_bus(bus) {
+		n = pci_bus_max_busnr(bus);
+		if(n > max)
+			max = n;
+	}
+	return max;
+}
+
+/**
  * pci_find_capability - query for devices' capabilities 
  * @dev: PCI device to query
  * @cap: capability code
@@ -79,6 +122,49 @@
 	return 0;
 }
 
+/**
+ * pci_bus_find_capability - query for devices' capabilities 
+ * @dev: PCI device to query
+ * @cap: capability code
+ *
+ * Like pci_find_capability() but works for pci devices that do not have a
+ * pci_dev structure set up yet. 
+ * Returns the address of the requested capability structure within the
+ * device's PCI configuration space or 0 in case the device does not
+ * support it.
+ */
+int pci_bus_find_capability(struct pci_bus *bus, unsigned int devfn, int cap)
+{
+	u16 status;
+	u8 pos, id;
+	int ttl = 48;
+	struct pci_dev *dev = bus->self;
+
+	pci_bus_read_config_word(bus, devfn, PCI_STATUS, &status);
+	if (!(status & PCI_STATUS_CAP_LIST))
+		return 0;
+	switch (dev->hdr_type) {
+	case PCI_HEADER_TYPE_NORMAL:
+	case PCI_HEADER_TYPE_BRIDGE:
+		pci_bus_read_config_byte(bus, devfn, PCI_CAPABILITY_LIST, &pos);
+		break;
+	case PCI_HEADER_TYPE_CARDBUS:
+		pci_bus_read_config_byte(bus, devfn, PCI_CB_CAPABILITY_LIST, &pos);
+		break;
+	default:
+		return 0;
+	}
+	while (ttl-- && pos >= 0x40) {
+		pos &= ~3;
+		pci_bus_read_config_byte(bus, devfn, pos + PCI_CAP_LIST_ID, &id);
+		if (id == 0xff)
+			break;
+		if (id == cap)
+			return pos;
+		pci_bus_read_config_byte(bus, devfn, pos + PCI_CAP_LIST_NEXT, &pos);
+	}
+	return 0;
+}
 
 /**
  * pci_find_parent_resource - return resource region of parent bus of given region
@@ -644,7 +730,10 @@
 
 EXPORT_SYMBOL(pci_enable_device);
 EXPORT_SYMBOL(pci_disable_device);
+EXPORT_SYMBOL(pci_max_busnr);
+EXPORT_SYMBOL(pci_bus_max_busnr);
 EXPORT_SYMBOL(pci_find_capability);
+EXPORT_SYMBOL(pci_bus_find_capability);
 EXPORT_SYMBOL(pci_release_regions);
 EXPORT_SYMBOL(pci_request_regions);
 EXPORT_SYMBOL(pci_release_region);
@@ -656,6 +745,8 @@
 EXPORT_SYMBOL(pci_dac_set_dma_mask);
 EXPORT_SYMBOL(pci_assign_resource);
 EXPORT_SYMBOL(pci_find_parent_resource);
+EXPORT_SYMBOL(pbus_size_bridges);
+EXPORT_SYMBOL(pbus_assign_resources);
 
 EXPORT_SYMBOL(pci_set_power_state);
 EXPORT_SYMBOL(pci_save_state);
diff -Nru a/drivers/pci/probe.c b/drivers/pci/probe.c
--- a/drivers/pci/probe.c	Tue Nov  5 17:26:27 2002
+++ b/drivers/pci/probe.c	Tue Nov  5 17:26:27 2002
@@ -254,7 +254,7 @@
  * them, we proceed to assigning numbers to the remaining buses in
  * order to avoid overlaps between old and new bus numbers.
  */
-static int __devinit pci_scan_bridge(struct pci_bus *bus, struct pci_dev * dev, int max, int pass)
+int __devinit pci_scan_bridge(struct pci_bus *bus, struct pci_dev * dev, int max, int pass)
 {
 	unsigned int buses;
 	unsigned short cr;
@@ -595,4 +595,5 @@
 EXPORT_SYMBOL(pci_do_scan_bus);
 EXPORT_SYMBOL(pci_scan_slot);
 EXPORT_SYMBOL(pci_scan_bus);
+EXPORT_SYMBOL(pci_scan_bridge);
 #endif
diff -Nru a/drivers/pci/search.c b/drivers/pci/search.c
--- a/drivers/pci/search.c	Tue Nov  5 17:26:27 2002
+++ b/drivers/pci/search.c	Tue Nov  5 17:26:27 2002
@@ -1,6 +1,45 @@
 #include <linux/pci.h>
 #include <linux/module.h>
 
+static struct pci_bus *
+pci_do_find_bus(struct pci_bus* bus, unsigned char busnr)
+{
+	struct pci_bus* child;
+	struct list_head *tmp;
+
+	if(bus->number == busnr)
+		return bus;
+
+	list_for_each(tmp, &bus->children) {
+		child = pci_do_find_bus(pci_bus_b(tmp), busnr);
+		if(child)
+			return child;
+	}
+	return NULL;
+}
+
+/**
+ * pci_find_bus - locate PCI bus from a given bus number
+ * @busnr: number of desired PCI bus
+ *
+ * Given a PCI bus number, the desired PCI bus is located in system
+ * global list of PCI buses.  If the bus is found, a pointer to its
+ * data structure is returned.  If no bus is found, %NULL is returned.
+ */
+struct pci_bus *
+pci_find_bus(unsigned char busnr)
+{
+	struct pci_bus* bus;
+	struct pci_bus* tmp_bus;
+
+	pci_for_each_bus(bus) {
+		tmp_bus = pci_do_find_bus(bus, busnr);
+		if(tmp_bus)
+			return tmp_bus;
+	}
+	return NULL;
+}
+
 /**
  * pci_find_slot - locate PCI device from a given PCI slot
  * @bus: number of PCI bus on which desired PCI device resides
@@ -104,6 +143,7 @@
 	return NULL;
 }
 
+EXPORT_SYMBOL(pci_find_bus);
 EXPORT_SYMBOL(pci_find_class);
 EXPORT_SYMBOL(pci_find_device);
 EXPORT_SYMBOL(pci_find_slot);
diff -Nru a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
--- a/drivers/pci/setup-bus.c	Tue Nov  5 17:26:27 2002
+++ b/drivers/pci/setup-bus.c	Tue Nov  5 17:26:27 2002
@@ -35,7 +35,7 @@
 
 #define ROUND_UP(x, a)		(((x) + (a) - 1) & ~((a) - 1))
 
-static int __init
+static int __devinit
 pbus_assign_resources_sorted(struct pci_bus *bus)
 {
 	struct list_head *ln;
@@ -85,7 +85,7 @@
    requires that if there is no I/O ports or memory behind the
    bridge, corresponding range must be turned off by writing base
    value greater than limit to the bridge's base/limit registers.  */
-static void __init
+static void __devinit
 pci_setup_bridge(struct pci_bus *bus)
 {
 	struct pbus_set_ranges_data ranges;
@@ -168,7 +168,7 @@
 /* Check whether the bridge supports optional I/O and
    prefetchable memory ranges. If not, the respective
    base/limit registers must be read-only and read as 0. */
-static void __init
+static void __devinit
 pci_bridge_check_ranges(struct pci_bus *bus)
 {
 	u16 io;
@@ -210,7 +210,7 @@
    since these windows have 4K granularity and the IO ranges
    of non-bridge PCI devices are limited to 256 bytes.
    We must be careful with the ISA aliasing though. */
-static void __init
+static void __devinit
 pbus_size_io(struct pci_bus *bus)
 {
 	struct list_head *ln;
@@ -259,7 +259,7 @@
 
 /* Calculate the size of the bus and minimal alignment which
    guarantees that all child resources fit in this size. */
-static void __init
+static void __devinit
 pbus_size_mem(struct pci_bus *bus, unsigned long mask, unsigned long type)
 {
 	struct list_head *ln;
@@ -331,7 +331,7 @@
 	b_res->end = size + min_align - 1;
 }
 
-void __init
+void __devinit
 pbus_size_bridges(struct pci_bus *bus)
 {
 	struct list_head *ln;
@@ -358,7 +358,7 @@
 	pbus_size_mem(bus, mask, type);
 }
 
-void __init
+void __devinit
 pbus_assign_resources(struct pci_bus *bus)
 {
 	struct list_head *ln;
diff -Nru a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	Tue Nov  5 17:26:27 2002
+++ b/include/linux/pci.h	Tue Nov  5 17:26:27 2002
@@ -557,8 +557,12 @@
 				 unsigned int ss_vendor, unsigned int ss_device,
 				 const struct pci_dev *from);
 struct pci_dev *pci_find_class (unsigned int class, const struct pci_dev *from);
+struct pci_bus *pci_find_bus(unsigned char busnr);
 struct pci_dev *pci_find_slot (unsigned int bus, unsigned int devfn);
+unsigned char pci_bus_max_busnr(struct pci_bus* bus);
+unsigned char pci_max_busnr(void);
 int pci_find_capability (struct pci_dev *dev, int cap);
+int pci_bus_find_capability (struct pci_bus *bus, unsigned int devfn, int cap);
 
 int pci_bus_read_config_byte (struct pci_bus *bus, unsigned int devfn, int where, u8 *val);
 int pci_bus_read_config_word (struct pci_bus *bus, unsigned int devfn, int where, u16 *val);
@@ -613,6 +617,8 @@
 
 /* Helper functions for low-level code (drivers/pci/setup-[bus,res].c) */
 
+void pbus_assign_resources(struct pci_bus *bus);
+void pbus_size_bridges(struct pci_bus *bus);
 int pci_claim_resource(struct pci_dev *, int);
 void pci_assign_unassigned_resources(void);
 void pdev_enable_device(struct pci_dev *);
@@ -634,6 +640,7 @@
 const struct pci_device_id *pci_match_device(const struct pci_device_id *ids, const struct pci_dev *dev);
 unsigned int pci_do_scan_bus(struct pci_bus *bus);
 struct pci_bus * pci_add_new_bus(struct pci_bus *parent, struct pci_dev *dev, int busnr);
+int pci_scan_bridge(struct pci_bus *bus, struct pci_dev * dev, int max, int pass);
 
 /* kmem_cache style wrapper around pci_alloc_consistent() */
 struct pci_pool *pci_pool_create (const char *name, struct pci_dev *dev,
