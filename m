Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265325AbTLRVND (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 16:13:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265334AbTLRVND
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 16:13:03 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:35724 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S265325AbTLRVMy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 16:12:54 -0500
Date: Thu, 18 Dec 2003 13:12:13 -0800
To: Len Brown <len.brown@intel.com>
Cc: ACPI Developers <acpi-devel@lists.sourceforge.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [ACPI] [BKPATCH] ACPI update for 2.6
Message-ID: <20031218211213.GA845@sgi.com>
Mail-Followup-To: Len Brown <len.brown@intel.com>,
	ACPI Developers <acpi-devel@lists.sourceforge.net>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1071742310.2496.217.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="r5Pyd7+fXNt84Ff3"
Content-Disposition: inline
In-Reply-To: <1071742310.2496.217.camel@dhcppc4>
User-Agent: Mutt/1.5.4i
From: jbarnes@sgi.com (Jesse Barnes)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 18, 2003 at 05:11:50AM -0500, Len Brown wrote:
> Hi Andrew/Linus, please do a 
> 
> 	bk pull http://linux-acpi.bkbits.net/linux-acpi-release-2.6.0

Len, could you please include these two patches in your next update if
you think they're ok?  They make the boot a lot quieter on big NUMA
boxes...

Thanks,
Jesse

--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="acpi-numa-quiet.patch"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1487  -> 1.1488 
#	 drivers/acpi/numa.c	1.5     -> 1.6    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/11/24	jbarnes@tomahawk.engr.sgi.com	1.1488
# make acpi NUMA printks quieter
# --------------------------------------------
#
diff -Nru a/drivers/acpi/numa.c b/drivers/acpi/numa.c
--- a/drivers/acpi/numa.c	Mon Nov 24 12:41:26 2003
+++ b/drivers/acpi/numa.c	Mon Nov 24 12:41:26 2003
@@ -31,6 +31,13 @@
 #include <linux/acpi.h>
 #include <acpi/acpi_bus.h>
 
+#undef ACPI_NUMA_DEBUG
+#ifdef ACPI_NUMA_DEBUG
+#define Dprintk(x...) printk(x)
+#else
+#define Dprintk(x...)
+#endif
+
 extern int __init acpi_table_parse_madt_family (enum acpi_table_id id, unsigned long madt_size, int entry_id, acpi_madt_entry_handler handler);
 
 void __init
@@ -46,7 +53,7 @@
 	{
 		struct acpi_table_processor_affinity *p =
 			(struct acpi_table_processor_affinity*) header;
-		printk(KERN_INFO PREFIX "SRAT Processor (id[0x%02x] eid[0x%02x]) in proximity domain %d %s\n",
+		Dprintk(KERN_INFO PREFIX "SRAT Processor (id[0x%02x] eid[0x%02x]) in proximity domain %d %s\n",
 		       p->apic_id, p->lsapic_eid, p->proximity_domain,
 		       p->flags.enabled?"enabled":"disabled");
 	}
@@ -56,7 +63,7 @@
 	{
 		struct acpi_table_memory_affinity *p =
 			(struct acpi_table_memory_affinity*) header;
-		printk(KERN_INFO PREFIX "SRAT Memory (0x%08x%08x length 0x%08x%08x type 0x%x) in proximity domain %d %s%s\n",
+		Dprintk(KERN_INFO PREFIX "SRAT Memory (0x%08x%08x length 0x%08x%08x type 0x%x) in proximity domain %d %s%s\n",
 		       p->base_addr_hi, p->base_addr_lo, p->length_hi, p->length_lo,
 		       p->memory_type, p->proximity_domain,
 		       p->flags.enabled ? "enabled" : "disabled",

--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="acpi-tables-quiet.patch"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1488  -> 1.1489 
#	drivers/acpi/tables.c	1.16    -> 1.17   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/11/24	jbarnes@tomahawk.engr.sgi.com	1.1489
# make acpi table parsing quieter
# --------------------------------------------
#
diff -Nru a/drivers/acpi/tables.c b/drivers/acpi/tables.c
--- a/drivers/acpi/tables.c	Mon Nov 24 12:41:41 2003
+++ b/drivers/acpi/tables.c	Mon Nov 24 12:41:41 2003
@@ -35,6 +35,13 @@
 #include <linux/acpi.h>
 #include <linux/bootmem.h>
 
+#undef ACPI_TABLES_DEBUG
+#ifdef ACPI_TABLES_DEBUG
+#define Dprintk(x...) printk(x)
+#else
+#define Dprintk(x...)
+#endif
+
 #define PREFIX			"ACPI: "
 
 #define ACPI_MAX_TABLES		256
@@ -118,7 +125,7 @@
 	{
 		struct acpi_table_lapic *p =
 			(struct acpi_table_lapic*) header;
-		printk(KERN_INFO PREFIX "LAPIC (acpi_id[0x%02x] lapic_id[0x%02x] %s)\n",
+		Dprintk(KERN_INFO PREFIX "LAPIC (acpi_id[0x%02x] lapic_id[0x%02x] %s)\n",
 			p->acpi_id, p->id, p->flags.enabled?"enabled":"disabled");
 	}
 		break;
@@ -127,7 +134,7 @@
 	{
 		struct acpi_table_ioapic *p =
 			(struct acpi_table_ioapic*) header;
-		printk(KERN_INFO PREFIX "IOAPIC (id[0x%02x] address[0x%08x] global_irq_base[0x%x])\n",
+		Dprintk(KERN_INFO PREFIX "IOAPIC (id[0x%02x] address[0x%08x] global_irq_base[0x%x])\n",
 			p->id, p->address, p->global_irq_base);
 	}
 		break;
@@ -136,7 +143,7 @@
 	{
 		struct acpi_table_int_src_ovr *p =
 			(struct acpi_table_int_src_ovr*) header;
-		printk(KERN_INFO PREFIX "INT_SRC_OVR (bus[%d] irq[0x%x] global_irq[0x%x] polarity[0x%x] trigger[0x%x])\n",
+		Dprintk(KERN_INFO PREFIX "INT_SRC_OVR (bus[%d] irq[0x%x] global_irq[0x%x] polarity[0x%x] trigger[0x%x])\n",
 			p->bus, p->bus_irq, p->global_irq, p->flags.polarity, p->flags.trigger);
 	}
 		break;
@@ -145,7 +152,7 @@
 	{
 		struct acpi_table_nmi_src *p =
 			(struct acpi_table_nmi_src*) header;
-		printk(KERN_INFO PREFIX "NMI_SRC (polarity[0x%x] trigger[0x%x] global_irq[0x%x])\n",
+		Dprintk(KERN_INFO PREFIX "NMI_SRC (polarity[0x%x] trigger[0x%x] global_irq[0x%x])\n",
 			p->flags.polarity, p->flags.trigger, p->global_irq);
 	}
 		break;
@@ -154,7 +161,7 @@
 	{
 		struct acpi_table_lapic_nmi *p =
 			(struct acpi_table_lapic_nmi*) header;
-		printk(KERN_INFO PREFIX "LAPIC_NMI (acpi_id[0x%02x] polarity[0x%x] trigger[0x%x] lint[0x%x])\n",
+		Dprintk(KERN_INFO PREFIX "LAPIC_NMI (acpi_id[0x%02x] polarity[0x%x] trigger[0x%x] lint[0x%x])\n",
 			p->acpi_id, p->flags.polarity, p->flags.trigger, p->lint);
 	}
 		break;
@@ -163,7 +170,7 @@
 	{
 		struct acpi_table_lapic_addr_ovr *p =
 			(struct acpi_table_lapic_addr_ovr*) header;
-		printk(KERN_INFO PREFIX "LAPIC_ADDR_OVR (address[%p])\n",
+		Dprintk(KERN_INFO PREFIX "LAPIC_ADDR_OVR (address[%p])\n",
 			(void *) (unsigned long) p->address);
 	}
 		break;
@@ -172,7 +179,7 @@
 	{
 		struct acpi_table_iosapic *p =
 			(struct acpi_table_iosapic*) header;
-		printk(KERN_INFO PREFIX "IOSAPIC (id[0x%x] global_irq_base[0x%x] address[%p])\n",
+		Dprintk(KERN_INFO PREFIX "IOSAPIC (id[0x%x] global_irq_base[0x%x] address[%p])\n",
 			p->id, p->global_irq_base, (void *) (unsigned long) p->address);
 	}
 		break;
@@ -181,7 +188,7 @@
 	{
 		struct acpi_table_lsapic *p =
 			(struct acpi_table_lsapic*) header;
-		printk(KERN_INFO PREFIX "LSAPIC (acpi_id[0x%02x] lsapic_id[0x%02x] lsapic_eid[0x%02x] %s)\n",
+		Dprintk(KERN_INFO PREFIX "LSAPIC (acpi_id[0x%02x] lsapic_id[0x%02x] lsapic_eid[0x%02x] %s)\n",
 			p->acpi_id, p->id, p->eid, p->flags.enabled?"enabled":"disabled");
 	}
 		break;
@@ -190,7 +197,7 @@
 	{
 		struct acpi_table_plat_int_src *p =
 			(struct acpi_table_plat_int_src*) header;
-		printk(KERN_INFO PREFIX "PLAT_INT_SRC (polarity[0x%x] trigger[0x%x] type[0x%x] id[0x%04x] eid[0x%x] iosapic_vector[0x%x] global_irq[0x%x]\n",
+		Dprintk(KERN_INFO PREFIX "PLAT_INT_SRC (polarity[0x%x] trigger[0x%x] type[0x%x] id[0x%04x] eid[0x%x] iosapic_vector[0x%x] global_irq[0x%x]\n",
 			p->flags.polarity, p->flags.trigger, p->type, p->id, p->eid, p->iosapic_vector, p->global_irq);
 	}
 		break;

--r5Pyd7+fXNt84Ff3--
