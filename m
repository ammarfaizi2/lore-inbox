Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262774AbTJJVuo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 17:50:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263081AbTJJVuo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 17:50:44 -0400
Received: from tolkor.sgi.com ([198.149.18.6]:12261 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id S262774AbTJJVuR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 17:50:17 -0400
Message-ID: <3F872984.7877D382@sgi.com>
Date: Fri, 10 Oct 2003 16:49:57 -0500
From: Patrick Gefre <pfg@sgi.com>
Organization: SGI
X-Mailer: Mozilla 4.8C-SGI [en] (X11; U; IRIX 6.5 IP32)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: davidm@napali.hpl.hp.com, jbarnes@sgi.com
Subject: [PATCH] Altix I/O code cleanup
Content-Type: multipart/mixed;
 boundary="------------984D6D37E3F420542C5524C6"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------984D6D37E3F420542C5524C6
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

This is my first patch for this - more to come ....



--------------984D6D37E3F420542C5524C6
Content-Type: text/plain; charset=us-ascii;
 name="patch0"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch0"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1272  -> 1.1273 
#	include/asm-ia64/sn/pci/pcibr_private.h	1.10    -> 1.11   
#	arch/ia64/sn/io/sn2/ml_iograph.c	1.5     -> 1.6    
#	arch/ia64/sn/io/sn2/xtalk.c	1.2     -> 1.3    
#	include/asm-ia64/sn/sgi.h	1.7     -> 1.8    
#	arch/ia64/sn/io/sn2/klconflib.c	1.3     -> 1.4    
#	include/asm-ia64/sn/arc/hinv.h	1.4     ->         (deleted)      
#	arch/ia64/sn/io/machvec/pci.c	1.11    -> 1.12   
#	arch/ia64/sn/io/machvec/pci_dma.c	1.16    -> 1.17   
#	include/asm-ia64/sn/klconfig.h	1.6     -> 1.7    
#	arch/ia64/sn/io/io.c	1.8     -> 1.9    
#	arch/ia64/sn/io/sn2/pcibr/pcibr_slot.c	1.9     -> 1.10   
#	arch/ia64/sn/io/platform_init/irix_io_init.c	1.2     -> 1.3    
#	arch/ia64/sn/io/sgi_if.c	1.6     -> 1.7    
#	arch/ia64/sn/io/sn2/shub_intr.c	1.4     -> 1.5    
#	include/asm-ia64/sn/ioerror_handling.h	1.5     -> 1.6    
#	arch/ia64/sn/io/sn2/shub.c	1.6     -> 1.7    
#	arch/ia64/sn/io/hwgfs/hcl.c	1.7     -> 1.8    
#	arch/ia64/sn/io/hwgfs/labelcl.c	1.1     -> 1.2    
#	arch/ia64/sn/io/sn2/geo_op.c	1.1     -> 1.2    
#	arch/ia64/sn/io/sn2/klgraph.c	1.3     -> 1.4    
#	arch/ia64/sn/io/drivers/ioconfig_bus.c	1.6     -> 1.7    
#	arch/ia64/sn/io/sn2/bte_error.c	1.3     -> 1.4    
#	arch/ia64/sn/io/machvec/pci_bus_cvlink.c	1.13    -> 1.14   
#	include/asm-ia64/sn/arc/types.h	1.5     ->         (deleted)      
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/10/10	pfg@attica.americas.sgi.com	1.1273
# Some general code clean up - nothing very interesting
# --------------------------------------------
#
diff -Nru a/arch/ia64/sn/io/drivers/ioconfig_bus.c b/arch/ia64/sn/io/drivers/ioconfig_bus.c
--- a/arch/ia64/sn/io/drivers/ioconfig_bus.c	Fri Oct 10 16:40:38 2003
+++ b/arch/ia64/sn/io/drivers/ioconfig_bus.c	Fri Oct 10 16:40:38 2003
@@ -19,7 +19,6 @@
 #include <asm/sn/sgi.h>
 #include <asm/io.h>
 #include <asm/sn/iograph.h>
-#include <asm/sn/invent.h>
 #include <asm/sn/hcl.h>
 #include <asm/sn/labelcl.h>
 #include <asm/sn/sn_sal.h>
diff -Nru a/arch/ia64/sn/io/hwgfs/hcl.c b/arch/ia64/sn/io/hwgfs/hcl.c
--- a/arch/ia64/sn/io/hwgfs/hcl.c	Fri Oct 10 16:40:38 2003
+++ b/arch/ia64/sn/io/hwgfs/hcl.c	Fri Oct 10 16:40:38 2003
@@ -28,11 +28,6 @@
 #include <asm/sn/labelcl.h>
 #include <asm/sn/simulator.h>
 
-#define HCL_NAME "SGI-HWGRAPH COMPATIBILITY DRIVER"
-#define HCL_TEMP_NAME "HCL_TEMP_NAME_USED_FOR_HWGRAPH_VERTEX_CREATE"
-#define HCL_TEMP_NAME_LEN 44 
-#define HCL_VERSION "1.0"
-
 #define vertex_hdl_t hwgfs_handle_t
 vertex_hdl_t hwgraph_root;
 vertex_hdl_t linux_busnum;
@@ -40,26 +35,6 @@
 extern void pci_bus_cvlink_init(void);
 
 /*
- * Debug flag definition.
- */
-#define OPTION_NONE             0x00
-#define HCL_DEBUG_NONE 0x00000
-#define HCL_DEBUG_ALL  0x0ffff
-#if defined(CONFIG_HCL_DEBUG)
-static unsigned int hcl_debug_init __initdata = HCL_DEBUG_NONE;
-#endif
-static unsigned int hcl_debug = HCL_DEBUG_NONE;
-#if defined(CONFIG_HCL_DEBUG) && !defined(MODULE)
-static unsigned int boot_options = OPTION_NONE;
-#endif
-
-invplace_t invplace_none = {
-	GRAPH_VERTEX_NONE,
-	GRAPH_VERTEX_PLACE_NONE,
-	NULL
-};
-
-/*
  * init_hcl() - Boot time initialization.
  *
  */
@@ -403,39 +378,6 @@
 	return(0);
 }
 
-#if 0
-/*
- * hwgraph_edge_add - This routines has changed from the original conext.
- * All it does now is to create a symbolic link from "from" to "to".
- */
-/* ARGSUSED */
-int
-hwgraph_edge_add(vertex_hdl_t from, vertex_hdl_t to, char *name)
-{
-
-	char *path, *link;
-	vertex_hdl_t handle = NULL;
-	int rv, i;
-
-	handle = hwgfs_find_handle(from, name, 0, 0, 0, 1);
-	if (handle) {
-		return(0);
-	}
-
-	path = kmalloc(1024, GFP_KERNEL);
-	memset(path, 0x0, 1024);
-	link = kmalloc(1024, GFP_KERNEL);
-	memset(path, 0x0, 1024);
-	i = hwgfs_generate_path (to, link, 1024);
-	rv = hwgfs_mk_symlink (from, (const char *)name, 
-			       DEVFS_FL_DEFAULT, link,
-			       &handle, NULL);
-	return(0);
-
-
-}
-#endif
-
 int
 hwgraph_edge_add(vertex_hdl_t from, vertex_hdl_t to, char *name)
 {
@@ -718,24 +660,6 @@
 		    	0,		/* minor */
 		    	0,		/* char | block */
 		    	1));		/* traverse symlinks */
-}
-
-/*
- * hwgraph_inventory_remove - Removes an inventory entry.
- *
- *	Remove an inventory item associated with a vertex.   It is the caller's
- *	responsibility to make sure that there are no races between removing
- *	inventory from a vertex and simultaneously removing that vertex.
-*/
-int
-hwgraph_inventory_remove(	vertex_hdl_t de,
-				int class,
-				int type,
-				major_t controller,
-				minor_t unit,
-				int state)
-{
-	return(0); /* Just a Stub for IRIX code. */
 }
 
 /*
diff -Nru a/arch/ia64/sn/io/hwgfs/labelcl.c b/arch/ia64/sn/io/hwgfs/labelcl.c
--- a/arch/ia64/sn/io/hwgfs/labelcl.c	Fri Oct 10 16:40:38 2003
+++ b/arch/ia64/sn/io/hwgfs/labelcl.c	Fri Oct 10 16:40:38 2003
@@ -16,7 +16,6 @@
 #include <linux/smp_lock.h>
 #include <asm/sn/sgi.h>
 #include <asm/sn/hwgfs.h>
-#include <asm/sn/invent.h>
 #include <asm/sn/hcl.h>
 #include <asm/sn/labelcl.h>
 
diff -Nru a/arch/ia64/sn/io/io.c b/arch/ia64/sn/io/io.c
--- a/arch/ia64/sn/io/io.c	Fri Oct 10 16:40:38 2003
+++ b/arch/ia64/sn/io/io.c	Fri Oct 10 16:40:38 2003
@@ -20,7 +20,6 @@
 #include <asm/sn/io.h>
 #include <asm/sn/sn_private.h>
 #include <asm/sn/addrs.h>
-#include <asm/sn/invent.h>
 #include <asm/sn/hcl.h>
 #include <asm/sn/hcl_util.h>
 #include <asm/sn/intr.h>
@@ -29,7 +28,6 @@
 #include <asm/sn/sn_cpuid.h>
 
 extern xtalk_provider_t hub_provider;
-extern void hub_intr_init(vertex_hdl_t hubv);
 
 static int force_fire_and_forget = 1;
 static int ignore_conveyor_override;
@@ -601,7 +599,6 @@
 hub_provider_startup(vertex_hdl_t hubv)
 {
 	hub_pio_init(hubv);
-	hub_intr_init(hubv);
 }
 
 /*
diff -Nru a/arch/ia64/sn/io/machvec/pci.c b/arch/ia64/sn/io/machvec/pci.c
--- a/arch/ia64/sn/io/machvec/pci.c	Fri Oct 10 16:40:38 2003
+++ b/arch/ia64/sn/io/machvec/pci.c	Fri Oct 10 16:40:38 2003
@@ -22,7 +22,6 @@
 #include <asm/sn/xtalk/xwidget.h>
 #include <asm/sn/sn_private.h>
 #include <asm/sn/addrs.h>
-#include <asm/sn/invent.h>
 #include <asm/sn/hcl.h>
 #include <asm/sn/hcl_util.h>
 #include <asm/sn/pci/pciio.h>
diff -Nru a/arch/ia64/sn/io/machvec/pci_bus_cvlink.c b/arch/ia64/sn/io/machvec/pci_bus_cvlink.c
--- a/arch/ia64/sn/io/machvec/pci_bus_cvlink.c	Fri Oct 10 16:40:38 2003
+++ b/arch/ia64/sn/io/machvec/pci_bus_cvlink.c	Fri Oct 10 16:40:38 2003
@@ -23,7 +23,6 @@
 #include <asm/sn/xtalk/xwidget.h>
 #include <asm/sn/sn_private.h>
 #include <asm/sn/addrs.h>
-#include <asm/sn/invent.h>
 #include <asm/sn/hcl.h>
 #include <asm/sn/hcl_util.h>
 #include <asm/sn/intr.h>
@@ -437,11 +436,11 @@
 #ifdef CONFIG_PROC_FS
 		extern void register_sn_procfs(void);
 #endif
-		extern void irix_io_init(void);
+		extern void sn_io_init(void);
 		extern void sn_init_cpei_timer(void);
 		
 		init_hcl();
-		irix_io_init();
+		sn_io_init();
 		
 		for (cnode = 0; cnode < numnodes; cnode++) {
 			extern void intr_init_vecblk(cnodeid_t);
diff -Nru a/arch/ia64/sn/io/machvec/pci_dma.c b/arch/ia64/sn/io/machvec/pci_dma.c
--- a/arch/ia64/sn/io/machvec/pci_dma.c	Fri Oct 10 16:40:38 2003
+++ b/arch/ia64/sn/io/machvec/pci_dma.c	Fri Oct 10 16:40:38 2003
@@ -29,7 +29,6 @@
 #include <asm/sn/types.h>
 #include <asm/sn/alenlist.h>
 #include <asm/sn/pci/pci_bus_cvlink.h>
-#include <asm/sn/nag.h>
 
 /*
  * For ATE allocations
diff -Nru a/arch/ia64/sn/io/platform_init/irix_io_init.c b/arch/ia64/sn/io/platform_init/irix_io_init.c
--- a/arch/ia64/sn/io/platform_init/irix_io_init.c	Fri Oct 10 16:40:38 2003
+++ b/arch/ia64/sn/io/platform_init/irix_io_init.c	Fri Oct 10 16:40:38 2003
@@ -27,13 +27,6 @@
 extern int pci_bus_to_hcl_cvlink(void);
 extern void mlreset(void);
 
-/* #define DEBUG_IO_INIT 1 */
-#ifdef DEBUG_IO_INIT
-#define DBG(x...) printk(x)
-#else
-#define DBG(x...)
-#endif /* DEBUG_IO_INIT */
-
 /*
  * This routine is responsible for the setup of all the IRIX hwgraph style
  * stuff that's been pulled into linux.  It's called by sn_pci_find_bios which
@@ -45,12 +38,12 @@
  */
 
 void
-irix_io_init(void)
+sn_io_init(void)
 {
 	cnodeid_t cnode;
 
 	/*
-	 * This is the Master CPU.  Emulate mlsetup and main.c in Irix.
+	 * This is the Master CPU.
 	 */
 	mlreset();
 
diff -Nru a/arch/ia64/sn/io/sgi_if.c b/arch/ia64/sn/io/sgi_if.c
--- a/arch/ia64/sn/io/sgi_if.c	Fri Oct 10 16:40:38 2003
+++ b/arch/ia64/sn/io/sgi_if.c	Fri Oct 10 16:40:38 2003
@@ -12,16 +12,14 @@
 #include <linux/mm.h>
 #include <linux/slab.h>
 #include <asm/sn/sgi.h>
-#include <asm/sn/invent.h>
 #include <asm/sn/hcl.h>
 #include <asm/sn/labelcl.h>
-#include <asm/sn/pci/bridge.h>
 #include <asm/sn/ioerror_handling.h>
 #include <asm/sn/pci/pciio.h>
 #include <asm/sn/slotnum.h>
 
 void *
-snia_kmem_zalloc(size_t size, int flag)
+snia_kmem_zalloc(size_t size)
 {
         void *ptr = kmalloc(size, GFP_KERNEL);
 	if ( ptr )
@@ -34,26 +32,6 @@
 {
         kfree(ptr);
 }
-
-/*
- * the alloc/free_node routines do a simple kmalloc for now ..
- */
-void *
-snia_kmem_alloc_node(register size_t size, register int flags, cnodeid_t node)
-{
-	/* someday will Allocate on node 'node' */
-	return(kmalloc(size, GFP_KERNEL));
-}
-
-void *
-snia_kmem_zalloc_node(register size_t size, register int flags, cnodeid_t node)
-{
-	void *ptr = kmalloc(size, GFP_KERNEL);
-	if ( ptr )
-		BZERO(ptr, size);
-        return(ptr);
-}
-
 
 /*
  * print_register() allows formatted printing of bit fields.  individual
diff -Nru a/arch/ia64/sn/io/sn2/bte_error.c b/arch/ia64/sn/io/sn2/bte_error.c
--- a/arch/ia64/sn/io/sn2/bte_error.c	Fri Oct 10 16:40:38 2003
+++ b/arch/ia64/sn/io/sn2/bte_error.c	Fri Oct 10 16:40:38 2003
@@ -39,7 +39,6 @@
 #include <asm/sn/sgi.h>
 #include <asm/sn/io.h>
 #include <asm/sn/iograph.h>
-#include <asm/sn/invent.h>
 #include <asm/sn/hcl.h>
 #include <asm/sn/labelcl.h>
 #include <asm/sn/sn_private.h>
diff -Nru a/arch/ia64/sn/io/sn2/geo_op.c b/arch/ia64/sn/io/sn2/geo_op.c
--- a/arch/ia64/sn/io/sn2/geo_op.c	Fri Oct 10 16:40:38 2003
+++ b/arch/ia64/sn/io/sn2/geo_op.c	Fri Oct 10 16:40:38 2003
@@ -29,7 +29,6 @@
 #include <asm/sn/types.h>
 #include <asm/sn/sgi.h>
 #include <asm/sn/iograph.h>
-#include <asm/sn/invent.h>
 #include <asm/sn/hcl.h>
 #include <asm/sn/labelcl.h>
 #include <asm/sn/io.h>
diff -Nru a/arch/ia64/sn/io/sn2/klconflib.c b/arch/ia64/sn/io/sn2/klconflib.c
--- a/arch/ia64/sn/io/sn2/klconflib.c	Fri Oct 10 16:40:38 2003
+++ b/arch/ia64/sn/io/sn2/klconflib.c	Fri Oct 10 16:40:38 2003
@@ -15,7 +15,6 @@
 #include <asm/sn/io.h>
 #include <asm/sn/sn_cpuid.h>
 #include <asm/sn/iograph.h>
-#include <asm/sn/invent.h>
 #include <asm/sn/hcl.h>
 #include <asm/sn/labelcl.h>
 #include <asm/sn/klconfig.h>
@@ -25,9 +24,6 @@
 #include <asm/sn/xtalk/xbow.h>
 
 
-#define LDEBUG 0
-#define NIC_UNKNOWN ((nic_t) -1)
-
 #undef DEBUG_KLGRAPH
 #ifdef DEBUG_KLGRAPH
 #define DBG(x...) printk(x)
@@ -186,33 +182,6 @@
 
 }
 
-/*
- * get_actual_nasid
- *
- *	Completely disabled brds have their klconfig on 
- *	some other nasid as they have no memory. But their
- *	actual nasid is hidden in the klconfig. Use this
- *	routine to get it. Works for normal boards too.
- */
-nasid_t
-get_actual_nasid(lboard_t *brd)
-{
-	klhub_t	*hub ;
-
-	if (!brd)
-		return INVALID_NASID ;
-
-	/* find out if we are a completely disabled brd. */
-
-        hub  = (klhub_t *)find_first_component(brd, KLSTRUCT_HUB);
-	if (!hub)
-                return INVALID_NASID ;
-	if (!(hub->hub_info.flags & KLINFO_ENABLE))	/* disabled node brd */
-		return hub->hub_info.physid ;
-	else
-		return brd->brd_nasid ;
-}
-
 int
 xbow_port_io_enabled(nasid_t nasid, int link)
 {
@@ -292,25 +261,6 @@
 	format_module_id(buffer, modnum, MODULE_FORMAT_BRIEF);
 	sprintf(path, EDGE_LBL_MODULE "/%s/" EDGE_LBL_SLAB "/%d/%s", buffer, geo_slab(brd->brd_geoid), board_name);
 }
-
-/*
- * Get the module number for a NASID.
- */
-moduleid_t
-get_module_id(nasid_t nasid)
-{
-	lboard_t *brd;
-
-	brd = find_lboard((lboard_t *)KL_CONFIG_INFO(nasid), KLTYPE_SNIA);
-
-	if (!brd)
-		return INVALID_MODULE;
-	else
-		return geo_module(brd->brd_geoid);
-}
-
-
-#define MHZ	1000000
 
 
 /* Get the canonical hardware graph name for the given pci component
diff -Nru a/arch/ia64/sn/io/sn2/klgraph.c b/arch/ia64/sn/io/sn2/klgraph.c
--- a/arch/ia64/sn/io/sn2/klgraph.c	Fri Oct 10 16:40:38 2003
+++ b/arch/ia64/sn/io/sn2/klgraph.c	Fri Oct 10 16:40:38 2003
@@ -28,13 +28,11 @@
 #include <asm/sn/xtalk/xbow.h>
 #include <asm/sn/hcl_util.h>
 
-// #define KLGRAPH_DEBUG 1
+/* #define KLGRAPH_DEBUG 1 */
 #ifdef KLGRAPH_DEBUG
 #define GRPRINTF(x)	printk x
-#define CE_GRPANIC	CE_PANIC
 #else
 #define GRPRINTF(x)
-#define CE_GRPANIC	CE_PANIC
 #endif
 
 #include <asm/sn/sn_private.h>
diff -Nru a/arch/ia64/sn/io/sn2/ml_iograph.c b/arch/ia64/sn/io/sn2/ml_iograph.c
--- a/arch/ia64/sn/io/sn2/ml_iograph.c	Fri Oct 10 16:40:38 2003
+++ b/arch/ia64/sn/io/sn2/ml_iograph.c	Fri Oct 10 16:40:38 2003
@@ -15,12 +15,10 @@
 #include <asm/sn/io.h>
 #include <asm/sn/sn_cpuid.h>
 #include <asm/sn/iograph.h>
-#include <asm/sn/invent.h>
 #include <asm/sn/hcl.h>
 #include <asm/sn/hcl_util.h>
 #include <asm/sn/labelcl.h>
 #include <asm/sn/xtalk/xbow.h>
-#include <asm/sn/pci/bridge.h>
 #include <asm/sn/klconfig.h>
 #include <asm/sn/sn_private.h>
 #include <asm/sn/pci/pcibr.h>
@@ -59,9 +57,9 @@
 {
 	xswitch_vol_t xvolinfo;
 	int rc;
-	extern void * snia_kmem_zalloc(size_t size, int flag);
+	extern void * snia_kmem_zalloc(size_t size);
 
-	xvolinfo = snia_kmem_zalloc(sizeof(struct xswitch_vol_s), GFP_KERNEL);
+	xvolinfo = snia_kmem_zalloc(sizeof(struct xswitch_vol_s));
 	mutex_init(&xvolinfo->xswitch_volunteer_mutex);
 	rc = hwgraph_info_add_LBL(xswitch, 
 			INFO_LBL_XSWITCH_VOL,
@@ -79,12 +77,11 @@
 {
 	xswitch_vol_t xvolinfo;
 	int rc;
-	extern void snia_kmem_free(void *ptr, size_t size);
 
 	rc = hwgraph_info_remove_LBL(xswitch, 
 				INFO_LBL_XSWITCH_VOL,
 				(arbitrary_info_t *)&xvolinfo);
-	snia_kmem_free(xvolinfo, sizeof(struct xswitch_vol_s));
+	kfree(xvolinfo);
 }
 /*
  * A Crosstalk master volunteers to manage xwidgets on the specified xswitch.
@@ -508,18 +505,11 @@
 			ASSERT_ALWAYS(to);
 			rc = hwgraph_edge_add(from, to,
 				EDGE_LBL_INTERCONNECT);
-			if (rc == -EEXIST)
-				goto link_done;
-			if (rc != GRAPH_SUCCESS) {
+			if ((rc != -EEXIST) && (rc != GRAPH_SUCCESS)) {
 				printk("%s: Unable to establish link"
 					" for xbmon.", pathname);
 			}
-link_done:
 		}
-
-#ifdef	SN0_USE_BTE
-		bte_bpush_war(cnode, (void *)board);
-#endif
 	}
 }
 
@@ -617,7 +607,6 @@
 	nodepda_t	*npdap;
 	struct semaphore *peer_sema = 0;
 	uint32_t	widget_partnum;
-	cpu_cookie_t	c = 0;
 
 	npdap = NODEPDA(cnodeid);
 
@@ -839,34 +828,6 @@
 
 static
 struct io_brick_map_s io_brick_tab[] = {
-
-/* Ibrick widget number to PCI bus number map */
- {      MODULE_IBRICK,                          /* Ibrick type    */ 
-    /*  PCI Bus #                                  Widget #       */
-    {   0, 0, 0, 0, 0, 0, 0, 0,                 /* 0x0 - 0x7      */
-        0,                                      /* 0x8            */
-        0,                                      /* 0x9            */
-        0, 0,                                   /* 0xa - 0xb      */
-        0,                                      /* 0xc            */
-        0,                                      /* 0xd            */
-        2,                                      /* 0xe            */
-        1                                       /* 0xf            */
-     }
- },
-
-/* Pbrick widget number to PCI bus number map */
- {      MODULE_PBRICK,                          /* Pbrick type    */ 
-    /*  PCI Bus #                                  Widget #       */
-    {   0, 0, 0, 0, 0, 0, 0, 0,                 /* 0x0 - 0x7      */
-        2,                                      /* 0x8            */
-        1,                                      /* 0x9            */
-        0, 0,                                   /* 0xa - 0xb      */
-        4,                                      /* 0xc            */
-        6,                                      /* 0xd            */
-        3,                                      /* 0xe            */
-        5                                       /* 0xf            */
-    }
- },
 
 /* PXbrick widget number to PCI bus number map */
  {      MODULE_PXBRICK,                         /* PXbrick type   */ 
diff -Nru a/arch/ia64/sn/io/sn2/pcibr/pcibr_slot.c b/arch/ia64/sn/io/sn2/pcibr/pcibr_slot.c
--- a/arch/ia64/sn/io/sn2/pcibr/pcibr_slot.c	Fri Oct 10 16:40:38 2003
+++ b/arch/ia64/sn/io/sn2/pcibr/pcibr_slot.c	Fri Oct 10 16:40:38 2003
@@ -319,9 +319,8 @@
     reg_p                        b_respp;
     pcibr_slot_info_resp_t       slotp;
     pcibr_slot_func_info_resp_t  funcp;
-    extern void snia_kmem_free(void *, int);
 
-    slotp = snia_kmem_zalloc(sizeof(*slotp), 0);
+    slotp = snia_kmem_zalloc(sizeof(*slotp));
     if (slotp == NULL) {
         return(ENOMEM);
     }
@@ -395,7 +394,7 @@
         return(EFAULT);
     }
 
-    snia_kmem_free(slotp, sizeof(*slotp));
+    kfree(slotp);
 
     return(0);
 }
diff -Nru a/arch/ia64/sn/io/sn2/shub.c b/arch/ia64/sn/io/sn2/shub.c
--- a/arch/ia64/sn/io/sn2/shub.c	Fri Oct 10 16:40:38 2003
+++ b/arch/ia64/sn/io/sn2/shub.c	Fri Oct 10 16:40:38 2003
@@ -203,7 +203,7 @@
         uint64_t        longarg;
 	int		nasid;
 
-        cnode = (cnodeid_t)file->f_dentry->d_fsdata;
+        cnode = (cnodeid_t)(long)file->f_dentry->d_fsdata;
 
         switch (cmd) {
 	case SNDRV_SHUB_CONFIGURE:
diff -Nru a/arch/ia64/sn/io/sn2/shub_intr.c b/arch/ia64/sn/io/sn2/shub_intr.c
--- a/arch/ia64/sn/io/sn2/shub_intr.c	Fri Oct 10 16:40:38 2003
+++ b/arch/ia64/sn/io/sn2/shub_intr.c	Fri Oct 10 16:40:38 2003
@@ -18,7 +18,6 @@
 #include <asm/sn/io.h>
 #include <asm/sn/sn_private.h>
 #include <asm/sn/addrs.h>
-#include <asm/sn/invent.h>
 #include <asm/sn/hcl.h>
 #include <asm/sn/hcl_util.h>
 #include <asm/sn/intr.h>
@@ -27,12 +26,6 @@
 #include <asm/sn/sn2/shub_mmr.h>
 #include <asm/sn/sn_cpuid.h>
 
-/* ARGSUSED */
-void
-hub_intr_init(vertex_hdl_t hubv)
-{
-}
-
 xwidgetnum_t
 hub_widget_id(nasid_t nasid)
 {
@@ -77,7 +70,7 @@
 		xtalk_addr = SH_II_INT0 | ((unsigned long)nasid << 36) | (1UL << 47);
 	}
 
-	intr_hdl = snia_kmem_alloc_node(sizeof(struct hub_intr_s), KM_NOSLEEP, cnode);
+	intr_hdl = kmalloc(sizeof(struct hub_intr_s), GFP_KERNEL);
 	ASSERT_ALWAYS(intr_hdl);
 
 	xtalk_info = &intr_hdl->i_xtalk_info;
diff -Nru a/arch/ia64/sn/io/sn2/xtalk.c b/arch/ia64/sn/io/sn2/xtalk.c
--- a/arch/ia64/sn/io/sn2/xtalk.c	Fri Oct 10 16:40:38 2003
+++ b/arch/ia64/sn/io/sn2/xtalk.c	Fri Oct 10 16:40:38 2003
@@ -912,11 +912,6 @@
     if (!(widget_info = xwidget_info_get(widget)))
 	return(1);
 
-    /* Remove the inventory information associated
-     * with the widget.
-     */
-    hwgraph_inventory_remove(widget, -1, -1, -1, -1, -1);
-    
     hwid = &(widget_info->w_hwid);
 
     /* Clean out the xwidget information */
diff -Nru a/include/asm-ia64/sn/arc/hinv.h b/include/asm-ia64/sn/arc/hinv.h
--- a/include/asm-ia64/sn/arc/hinv.h	Fri Oct 10 16:40:38 2003
+++ /dev/null	Wed Dec 31 16:00:00 1969
@@ -1,183 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2000-2003 Silicon Graphics, Inc. All rights reserved.
- */
-
-/* $Id$
- *
- * ARCS hardware/memory inventory/configuration and system ID definitions.
- */
-#ifndef _ASM_SN_ARC_HINV_H
-#define _ASM_SN_ARC_HINV_H
-
-#include <asm/sn/arc/types.h>
-
-/* configuration query defines */
-typedef enum configclass {
-	SystemClass,
-	ProcessorClass,
-	CacheClass,
-#ifndef	_NT_PROM
-	MemoryClass,
-	AdapterClass,
-	ControllerClass,
-	PeripheralClass
-#else	/* _NT_PROM */
-	AdapterClass,
-	ControllerClass,
-	PeripheralClass,
-	MemoryClass
-#endif	/* _NT_PROM */
-} CONFIGCLASS;
-
-typedef enum configtype {
-	ARC,
-	CPU,
-	FPU,
-	PrimaryICache,
-	PrimaryDCache,
-	SecondaryICache,
-	SecondaryDCache,
-	SecondaryCache,
-#ifndef	_NT_PROM
-	Memory,
-#endif
-	EISAAdapter,
-	TCAdapter,
-	SCSIAdapter,
-	DTIAdapter,
-	MultiFunctionAdapter,
-	DiskController,
-	TapeController,
-	CDROMController,
-	WORMController,
-	SerialController,
-	NetworkController,
-	DisplayController,
-	ParallelController,
-	PointerController,
-	KeyboardController,
-	AudioController,
-	OtherController,
-	DiskPeripheral,
-	FloppyDiskPeripheral,
-	TapePeripheral,
-	ModemPeripheral,
-	MonitorPeripheral,
-	PrinterPeripheral,
-	PointerPeripheral,
-	KeyboardPeripheral,
-	TerminalPeripheral,
-	LinePeripheral,
-	NetworkPeripheral,
-#ifdef	_NT_PROM
-	Memory,
-#endif
-	OtherPeripheral,
-
-	/* new stuff for IP30 */
-	/* added without moving anything */
-	/* except ANONYMOUS. */
-
-	XTalkAdapter,
-	PCIAdapter,
-	GIOAdapter,
-	TPUAdapter,
-	TernaryCache,
-	Anonymous
-} CONFIGTYPE;
-
-typedef enum {
-	Failed = 1,
-	ReadOnly = 2,
-	Removable = 4,
-	ConsoleIn = 8,
-	ConsoleOut = 16,
-	Input = 32,
-	Output = 64
-} IDENTIFIERFLAG;
-
-#ifndef NULL			/* for GetChild(NULL); */
-#define	NULL	0
-#endif
-
-union key_u {
-	struct {
-#ifdef	_MIPSEB
-		unsigned char  c_bsize;		/* block size in lines */
-		unsigned char  c_lsize;		/* line size in bytes/tag */
-		unsigned short c_size;		/* cache size in 4K pages */
-#else	/* _MIPSEL */
-		unsigned short c_size;		/* cache size in 4K pages */
-		unsigned char  c_lsize;		/* line size in bytes/tag */
-		unsigned char  c_bsize;		/* block size in lines */
-#endif	/* _MIPSEL */
-	} cache;
-	ULONG FullKey;
-};
-
-#if _MIPS_SIM == _ABI64
-#define SGI_ARCS_VERS	64			/* sgi 64-bit version */
-#define SGI_ARCS_REV	0			/* rev .00 */
-#else
-#define SGI_ARCS_VERS	1			/* first version */
-#define SGI_ARCS_REV	10			/* rev .10, 3/04/92 */
-#endif
-
-typedef struct component {
-	CONFIGCLASS	Class;
-	CONFIGTYPE	Type;
-	IDENTIFIERFLAG	Flags;
-	USHORT		Version;
-	USHORT		Revision;
-	ULONG 		Key;
-	ULONG		AffinityMask;
-	ULONG		ConfigurationDataSize;
-	ULONG		IdentifierLength;
-	char		*Identifier;
-} COMPONENT;
-
-/* internal structure that holds pathname parsing data */
-struct cfgdata {
-	char *name;			/* full name */
-	int minlen;			/* minimum length to match */
-	CONFIGTYPE type;		/* type of token */
-};
-
-/* System ID */
-typedef struct systemid {
-	CHAR VendorId[8];
-	CHAR ProductId[8];
-} SYSTEMID;
-
-/* memory query functions */
-typedef enum memorytype {
-	ExceptionBlock,
-	SPBPage,			/* ARCS == SystemParameterBlock */
-#ifndef	_NT_PROM
-	FreeContiguous,
-	FreeMemory,
-	BadMemory,
-	LoadedProgram,
-	FirmwareTemporary,
-	FirmwarePermanent
-#else	/* _NT_PROM */
-	FreeMemory,
-	BadMemory,
-	LoadedProgram,
-	FirmwareTemporary,
-	FirmwarePermanent,
-	FreeContiguous
-#endif	/* _NT_PROM */
-} MEMORYTYPE;
-
-typedef struct memorydescriptor {
-	MEMORYTYPE	Type;
-	LONG		BasePage;
-	LONG		PageCount;
-} MEMORYDESCRIPTOR;
-
-#endif /* _ASM_SN_ARC_HINV_H */
diff -Nru a/include/asm-ia64/sn/arc/types.h b/include/asm-ia64/sn/arc/types.h
--- a/include/asm-ia64/sn/arc/types.h	Fri Oct 10 16:40:38 2003
+++ /dev/null	Wed Dec 31 16:00:00 1969
@@ -1,41 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (c) 1999,2001-2003 Silicon Graphics, Inc.  All Rights Reserved.
- * Copyright 1999 Ralf Baechle (ralf@gnu.org)
- */
-#ifndef _ASM_SN_ARC_TYPES_H
-#define _ASM_SN_ARC_TYPES_H
-
-typedef char		CHAR;
-typedef short		SHORT;
-typedef long		LARGE_INTEGER __attribute__ ((__mode__ (__DI__)));
-typedef	long		LONG __attribute__ ((__mode__ (__DI__)));
-typedef unsigned char	UCHAR;
-typedef unsigned short	USHORT;
-typedef unsigned long	ULONG __attribute__ ((__mode__ (__DI__)));
-typedef void		VOID;
-
-/* The pointer types.  We're 64-bit and the firmware is also 64-bit, so
-   live is sane ...  */
-typedef CHAR		*_PCHAR;
-typedef SHORT		*_PSHORT;
-typedef LARGE_INTEGER	*_PLARGE_INTEGER;
-typedef	LONG		*_PLONG;
-typedef UCHAR		*_PUCHAR;
-typedef USHORT		*_PUSHORT;
-typedef ULONG		*_PULONG;
-typedef VOID		*_PVOID;
-
-typedef CHAR		*PCHAR;
-typedef SHORT		*PSHORT;
-typedef LARGE_INTEGER	*PLARGE_INTEGER;
-typedef	LONG		*PLONG;
-typedef UCHAR		*PUCHAR;
-typedef USHORT		*PUSHORT;
-typedef ULONG		*PULONG;
-typedef VOID		*PVOID;
-
-#endif /* _ASM_SN_ARC_TYPES_H */
diff -Nru a/include/asm-ia64/sn/ioerror_handling.h b/include/asm-ia64/sn/ioerror_handling.h
--- a/include/asm-ia64/sn/ioerror_handling.h	Fri Oct 10 16:40:38 2003
+++ b/include/asm-ia64/sn/ioerror_handling.h	Fri Oct 10 16:40:38 2003
@@ -255,7 +255,7 @@
 	 * one.								 
 	 */								 
 	if (v_error_skip_env_get(v, error_env) != GRAPH_SUCCESS) {	 
-		error_env = snia_kmem_zalloc(sizeof(label_t), KM_NOSLEEP);	 
+		error_env = snia_kmem_zalloc(sizeof(label_t));	 
 		/* Unable to allocate memory for jum buffer. This should 
 		 * be a very rare occurrence.				 
 		 */							 
diff -Nru a/include/asm-ia64/sn/klconfig.h b/include/asm-ia64/sn/klconfig.h
--- a/include/asm-ia64/sn/klconfig.h	Fri Oct 10 16:40:38 2003
+++ b/include/asm-ia64/sn/klconfig.h	Fri Oct 10 16:40:38 2003
@@ -41,7 +41,6 @@
 #include <asm/sn/sgi.h>
 #include <asm/sn/addrs.h>
 #include <asm/sn/vector.h>
-#include <asm/sn/arc/hinv.h>
 #include <asm/sn/xtalk/xbow.h>
 #include <asm/sn/xtalk/xtalk.h>
 #include <asm/sn/kldir.h>
@@ -514,11 +513,11 @@
 	unsigned char	widid;	          /* Widget id - if applicable */
 	nasid_t		nasid;            /* node number - from parent */
 	char		pad1;		  /* pad out structure. */
-	char		pad2;		  /* pad out structure. */
-	COMPONENT	*arcs_compt;      /* ptr to the arcs struct for ease*/
+	char		pad2;
+	void		*pad3;
         klconf_off_t	errinfo;          /* component specific errors */
-        unsigned short  pad3;             /* pci fields have moved over to */
-        unsigned short  pad4;             /* klbri_t */
+        unsigned short  pad4;
+        unsigned short  pad5;
 } klinfo_t ;
 
 #define KLCONFIG_INFO_ENABLED(_i)	((_i)->flags & KLINFO_ENABLE)
diff -Nru a/include/asm-ia64/sn/pci/pcibr_private.h b/include/asm-ia64/sn/pci/pcibr_private.h
--- a/include/asm-ia64/sn/pci/pcibr_private.h	Fri Oct 10 16:40:38 2003
+++ b/include/asm-ia64/sn/pci/pcibr_private.h	Fri Oct 10 16:40:38 2003
@@ -662,8 +662,8 @@
 /*
  * mem alloc/free macros
  */
-#define NEWAf(ptr,n,f)	(ptr = snia_kmem_zalloc((n)*sizeof (*(ptr)), (f&PCIIO_NOSLEEP)?KM_NOSLEEP:KM_SLEEP))
-#define NEWA(ptr,n)	(ptr = snia_kmem_zalloc((n)*sizeof (*(ptr)), KM_SLEEP))
+#define NEWAf(ptr,n,f)	(ptr = snia_kmem_zalloc((n)*sizeof (*(ptr))))
+#define NEWA(ptr,n)	(ptr = snia_kmem_zalloc((n)*sizeof (*(ptr))))
 #define DELA(ptr,n)	(kfree(ptr))
 
 #define NEWf(ptr,f)	NEWAf(ptr,1,f)
diff -Nru a/include/asm-ia64/sn/sgi.h b/include/asm-ia64/sn/sgi.h
--- a/include/asm-ia64/sn/sgi.h	Fri Oct 10 16:40:38 2003
+++ b/include/asm-ia64/sn/sgi.h	Fri Oct 10 16:40:38 2003
@@ -169,9 +169,7 @@
 #define splhi()  0
 #define splx(s)
 
-extern void * snia_kmem_alloc_node(register size_t, register int, cnodeid_t);
-extern void * snia_kmem_zalloc(size_t, int);
-extern void * snia_kmem_zalloc_node(register size_t, register int, cnodeid_t );
+extern void * snia_kmem_zalloc(size_t);
 extern int is_specified(char *);
 
 #endif /* _ASM_IA64_SN_SGI_H */

--------------984D6D37E3F420542C5524C6--

