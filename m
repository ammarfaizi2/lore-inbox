Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268354AbUHKX55@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268354AbUHKX55 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 19:57:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268423AbUHKX5b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 19:57:31 -0400
Received: from omx1-ext.SGI.COM ([192.48.179.11]:48107 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S268387AbUHKXgZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 19:36:25 -0400
From: Pat Gefre <pfg@sgi.com>
Message-Id: <200408112335.i7BNZCJC163712@fsgi900.americas.sgi.com>
Subject: Re: Altix I/O code reorganization - 18 of 21
To: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       hch@infradead.org
Date: Wed, 11 Aug 2004 18:35:12 -0500 (CDT)
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/08/11 17:50:50-05:00 pfg@sgi.com 
#   code clean up
#   changes needed for new I/O code
# 
# include/asm-ia64/sn/types.h
#   2004/08/11 17:50:33-05:00 pfg@sgi.com +2 -0
#    
# 
# include/asm-ia64/sn/sndrv.h
#   2004/08/11 17:50:33-05:00 pfg@sgi.com +1 -0
#    
# 
# include/asm-ia64/sn/sn_sal.h
#   2004/08/11 17:50:33-05:00 pfg@sgi.com +25 -38
#    
# 
# include/asm-ia64/sn/sn_cpuid.h
#   2004/08/11 17:50:33-05:00 pfg@sgi.com +8 -0
#    
# 
# include/asm-ia64/sn/sgi.h
#   2004/08/11 17:50:32-05:00 pfg@sgi.com +6 -17
#    
# 
# include/asm-ia64/sn/router.h
#   2004/08/11 17:50:32-05:00 pfg@sgi.com +3 -4
#    
# 
# include/asm-ia64/sn/pda.h
#   2004/08/11 17:50:32-05:00 pfg@sgi.com +2 -1
#    
# 
# include/asm-ia64/sn/nodepda.h
#   2004/08/11 17:50:32-05:00 pfg@sgi.com +1 -59
#    
# 
# include/asm-ia64/sn/module.h
#   2004/08/11 17:50:31-05:00 pfg@sgi.com +11 -44
#    
# 
# include/asm-ia64/sn/ksys/l1.h
#   2004/08/11 17:50:31-05:00 pfg@sgi.com +4 -0
#    
# 
# include/asm-ia64/sn/klconfig.h
#   2004/08/11 17:50:31-05:00 pfg@sgi.com +8 -26
#    
# 
# include/asm-ia64/sn/iograph.h
#   2004/08/11 17:50:30-05:00 pfg@sgi.com +8 -18
#    
# 
# include/asm-ia64/sn/io.h
#   2004/08/11 17:50:30-05:00 pfg@sgi.com +2 -0
#    
# 
# include/asm-ia64/sn/intr.h
#   2004/08/11 17:50:30-05:00 pfg@sgi.com +0 -2
#    
# 
# include/asm-ia64/sn/hcl.h
#   2004/08/11 17:50:30-05:00 pfg@sgi.com +1 -51
#    
# 
# include/asm-ia64/sn/geo.h
#   2004/08/11 17:50:29-05:00 pfg@sgi.com +12 -19
#    
# 
# include/asm-ia64/sn/arch.h
#   2004/08/11 17:50:29-05:00 pfg@sgi.com +5 -0
#    
# 
# include/asm-ia64/sn/addrs.h
#   2004/08/11 17:50:29-05:00 pfg@sgi.com +22 -1
#    
# 
diff -Nru a/include/asm-ia64/sn/addrs.h b/include/asm-ia64/sn/addrs.h
--- a/include/asm-ia64/sn/addrs.h	2004-08-11 17:51:32 -05:00
+++ b/include/asm-ia64/sn/addrs.h	2004-08-11 17:51:32 -05:00
@@ -28,6 +28,7 @@
 #define NODE_CAC_BASE(_n)	(CAC_BASE  + NODE_OFFSET(_n))
 #define NODE_HSPEC_BASE(_n)	(HSPEC_BASE + NODE_OFFSET(_n))
 #define NODE_IO_BASE(_n)	(IO_BASE    + NODE_OFFSET(_n))
+#define TIO_IO_BASE(_n)		(TIO_BASE    + NODE_OFFSET(_n))
 #define NODE_MSPEC_BASE(_n)	(MSPEC_BASE + NODE_OFFSET(_n))
 #define NODE_UNCAC_BASE(_n)	(UNCAC_BASE + NODE_OFFSET(_n))
 
@@ -41,6 +42,9 @@
 #define RAW_NODE_SWIN_BASE(nasid, widget)				\
 	(NODE_IO_BASE(nasid) + ((uint64_t) (widget) << SWIN_SIZE_BITS))
 
+#define RAW_TIO_SWIN_BASE(nasid, widget)				\
+	(NODE_IO_BASE(nasid) + ((uint64_t) (widget) << TIO_SWIN_SIZE_BITS))
+
 #define WIDGETID_GET(addr)	((unsigned char)((addr >> SWIN_SIZE_BITS) & 0xff))
 
 /*
@@ -54,6 +58,11 @@
 #define	SWIN_SIZEMASK		(SWIN_SIZE - 1)
 #define	SWIN_WIDGET_MASK	0xF
 
+#define TIO_SWIN_SIZE_BITS	28
+#define TIO_SWIN_SIZE		(1UL << 28)
+#define TIO_SWIN_SIZEMASK	(SWIN_SIZE - 1)
+#define TIO_SWIN_WIDGET_MASK	0x3
+
 /*
  * Convert smallwindow address to xtalk address.
  *
@@ -62,6 +71,10 @@
  */
 #define	SWIN_WIDGETADDR(addr)	((addr) & SWIN_SIZEMASK)
 #define	SWIN_WIDGETNUM(addr)	(((addr)  >> SWIN_SIZE_BITS) & SWIN_WIDGET_MASK)
+
+#define TIO_SWIN_WIDGETADDR(addr)	((addr) & TIO_SWIN_SIZEMASK)
+#define TIO_SWIN_WIDGETNUM(addr)	(((addr)  >> TIO_SWIN_SIZE_BITS) & TIO_SWIN_WIDGET_MASK)
+
 /*
  * Verify if addr belongs to small window address on node with "nasid"
  *
@@ -126,12 +139,20 @@
  *	Otherwise, the recommended approach is to use *_HUB_L() and *_HUB_S().
  *	They're always safe.
  */
+/*
+ * LOCAL_HUB_ADDR doesn't need to be changed for TIO, since, by definition,
+ * there are no "local" TIOs.
+ */
 #define LOCAL_HUB_ADDR(_x)							\
 	(((_x) & BWIN_TOP) ? (HUBREG_CAST (LOCAL_MMR_ADDR(_x)))		\
 	: (HUBREG_CAST (IALIAS_BASE + (_x))))
 #define REMOTE_HUB_ADDR(_n, _x)						\
+	((_n & 1) ?							\
+	/* TIO: */							\
+	(HUBREG_CAST (GLOBAL_MMR_ADDR(_n, _x)))				\
+	: /* SHUB: */							\
 	(((_x) & BWIN_TOP) ? (HUBREG_CAST (GLOBAL_MMR_ADDR(_n, _x)))	\
-	: (HUBREG_CAST (NODE_SWIN_BASE(_n, 1) + 0x800000 + (_x))))
+	: (HUBREG_CAST (NODE_SWIN_BASE(_n, 1) + 0x800000 + (_x)))))
 
 #ifndef __ASSEMBLY__
 
diff -Nru a/include/asm-ia64/sn/arch.h b/include/asm-ia64/sn/arch.h
--- a/include/asm-ia64/sn/arch.h	2004-08-11 17:51:32 -05:00
+++ b/include/asm-ia64/sn/arch.h	2004-08-11 17:51:32 -05:00
@@ -14,11 +14,16 @@
 #include <asm/types.h>
 #include <asm/sn/types.h>
 #include <asm/sn/sn_cpuid.h>
+#include <asm/sn/sn2/arch.h>
 
 typedef u64	shubreg_t;
 typedef u64	hubreg_t;
 typedef u64	mmr_t;
 typedef u64	nic_t;
+
+#define NASID_TO_COMPACT_NODEID(nasid)  (nasid_to_cnodeid(nasid))
+#define COMPACT_TO_NASID_NODEID(cnode)  (cnodeid_to_nasid(cnode))
+
 
 #define INVALID_NASID		((nasid_t)-1)
 #define INVALID_CNODEID		((cnodeid_t)-1)
diff -Nru a/include/asm-ia64/sn/geo.h b/include/asm-ia64/sn/geo.h
--- a/include/asm-ia64/sn/geo.h	2004-08-11 17:51:32 -05:00
+++ b/include/asm-ia64/sn/geo.h	2004-08-11 17:51:32 -05:00
@@ -3,7 +3,7 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
- * Copyright (C) 1992 - 1997, 2000-2003 Silicon Graphics, Inc. All rights reserved.
+ * Copyright (C) 1992 - 1997, 2000-2004 Silicon Graphics, Inc. All rights reserved.
  */
 
 #ifndef _ASM_IA64_SN_GEO_H
@@ -24,22 +24,15 @@
 #define GEO_FORMAT_HWGRAPH	1
 #define GEO_FORMAT_BRIEF	2
 
-/* (the parameter for hwcfg_format_geoid_compt() is defined in the
- * platform-specific geo.h file) */
-
-/* Routines for manipulating geoid_t values */
-
-extern moduleid_t geo_module(geoid_t g);
-extern slabid_t geo_slab(geoid_t g);
-extern geo_type_t geo_type(geoid_t g);
-extern int geo_valid(geoid_t g);
-extern int geo_cmp(geoid_t g0, geoid_t g1);
-extern geoid_t geo_new(geo_type_t type, ...);
-
-extern geoid_t hwcfg_parse_geoid(char *buffer);
-extern void hwcfg_format_geoid(char *buffer, geoid_t m, int fmt);
-extern void hwcfg_format_geoid_compt(char *buffer, geoid_t m, int compt);
-extern geoid_t hwcfg_geo_get_self(geo_type_t type);
-extern geoid_t hwcfg_geo_get_by_nasid(geo_type_t type, nasid_t nasid);
-
+static inline moduleid_t geo_module(geoid_t g)
+{
+        return (g.any.type == GEO_TYPE_INVALID) ?
+                INVALID_MODULE : g.any.module;
+}
+
+static inline slabid_t geo_slab(geoid_t g)
+{
+        return (g.any.type == GEO_TYPE_INVALID) ?
+                INVALID_SLAB : g.any.slab;
+}
 #endif /* _ASM_IA64_SN_GEO_H */
diff -Nru a/include/asm-ia64/sn/hcl.h b/include/asm-ia64/sn/hcl.h
--- a/include/asm-ia64/sn/hcl.h	2004-08-11 17:51:32 -05:00
+++ b/include/asm-ia64/sn/hcl.h	2004-08-11 17:51:32 -05:00
@@ -14,7 +14,7 @@
 extern vertex_hdl_t hwgraph_root;
 extern vertex_hdl_t linux_busnum;
 
-void hwgraph_debug(char *, const char *, int, vertex_hdl_t, vertex_hdl_t, char *, ...);
+void hwgraph_debug(char *, const char *, int, hwgfs_handle_t, hwgfs_handle_t, char *, ...);
 
 #if 1
 #define HWGRAPH_DEBUG(args...) hwgraph_debug(args)
@@ -53,55 +53,5 @@
 #define HWGRAPH_EDGELBL_HW 	"hw"
 #define HWGRAPH_EDGELBL_DOT 	"."
 #define HWGRAPH_EDGELBL_DOTDOT 	".."
-
-#include <asm/sn/labelcl.h>
-#define hwgraph_fastinfo_set(a,b) labelcl_info_replace_IDX(a, HWGRAPH_FASTINFO, b, NULL)
-#define hwgraph_connectpt_set labelcl_info_connectpt_set
-#define hwgraph_generate_path hwgfs_generate_path
-#define hwgraph_path_to_vertex(a) hwgfs_find_handle(NULL, a, 0, 0, 0, 1)
-#define hwgraph_vertex_unref(a)
-
-/*
- * External declarations of EXPORTED SYMBOLS in hcl.c
- */
-extern vertex_hdl_t hwgraph_register(vertex_hdl_t, const char *,
-	unsigned int, unsigned int, unsigned int, unsigned int,
-	umode_t, uid_t, gid_t, struct file_operations *, void *);
-
-extern int hwgraph_mk_symlink(vertex_hdl_t, const char *, unsigned int,
-	unsigned int, const char *, unsigned int, vertex_hdl_t *, void *);
-
-extern int hwgraph_vertex_destroy(vertex_hdl_t);
-
-extern int hwgraph_edge_add(vertex_hdl_t, vertex_hdl_t, char *);
-extern int hwgraph_edge_get(vertex_hdl_t, char *, vertex_hdl_t *);
-
-extern arbitrary_info_t hwgraph_fastinfo_get(vertex_hdl_t);
-extern vertex_hdl_t hwgraph_mk_dir(vertex_hdl_t, const char *, unsigned int, void *);
-
-extern int hwgraph_connectpt_set(vertex_hdl_t, vertex_hdl_t);
-extern vertex_hdl_t hwgraph_connectpt_get(vertex_hdl_t);
-extern int hwgraph_edge_get_next(vertex_hdl_t, char *, vertex_hdl_t *, unsigned int *);
-
-extern graph_error_t hwgraph_traverse(vertex_hdl_t, char *, vertex_hdl_t *);
-
-extern int hwgraph_vertex_get_next(vertex_hdl_t *, vertex_hdl_t *);
-extern int hwgraph_path_add(vertex_hdl_t, char *, vertex_hdl_t *);
-extern vertex_hdl_t hwgraph_path_to_dev(char *);
-extern vertex_hdl_t hwgraph_block_device_get(vertex_hdl_t);
-extern vertex_hdl_t hwgraph_char_device_get(vertex_hdl_t);
-extern graph_error_t hwgraph_char_device_add(vertex_hdl_t, char *, char *, vertex_hdl_t *);
-extern int hwgraph_path_add(vertex_hdl_t, char *, vertex_hdl_t *);
-extern int hwgraph_info_add_LBL(vertex_hdl_t, char *, arbitrary_info_t);
-extern int hwgraph_info_get_LBL(vertex_hdl_t, char *, arbitrary_info_t *);
-extern int hwgraph_info_replace_LBL(vertex_hdl_t, char *, arbitrary_info_t,
-				    arbitrary_info_t *);
-extern int hwgraph_info_get_exported_LBL(vertex_hdl_t, char *, int *, arbitrary_info_t *);
-extern int hwgraph_info_get_next_LBL(vertex_hdl_t, char *, arbitrary_info_t *,
-                                labelcl_info_place_t *);
-extern int hwgraph_info_export_LBL(vertex_hdl_t, char *, int);
-extern int hwgraph_info_unexport_LBL(vertex_hdl_t, char *);
-extern int hwgraph_info_remove_LBL(vertex_hdl_t, char *, arbitrary_info_t *);
-extern char *vertex_to_name(vertex_hdl_t, char *, unsigned int);
 
 #endif /* _ASM_IA64_SN_HCL_H */
diff -Nru a/include/asm-ia64/sn/intr.h b/include/asm-ia64/sn/intr.h
--- a/include/asm-ia64/sn/intr.h	2004-08-11 17:51:32 -05:00
+++ b/include/asm-ia64/sn/intr.h	2004-08-11 17:51:32 -05:00
@@ -8,11 +8,9 @@
 #ifndef _ASM_IA64_SN_INTR_H
 #define _ASM_IA64_SN_INTR_H
 
-#include <asm/sn/types.h>
 #include <asm/sn/sn2/intr.h>
 
 extern void sn_send_IPI_phys(long, int, int);
-extern void intr_init_vecblk(cnodeid_t node);
 
 #define CPU_VECTOR_TO_IRQ(cpuid,vector) (vector)
 #define SN_CPU_FROM_IRQ(irq)	(0)
diff -Nru a/include/asm-ia64/sn/io.h b/include/asm-ia64/sn/io.h
--- a/include/asm-ia64/sn/io.h	2004-08-11 17:51:32 -05:00
+++ b/include/asm-ia64/sn/io.h	2004-08-11 17:51:32 -05:00
@@ -11,6 +11,8 @@
 
 #include <asm/sn/addrs.h>
 
+extern int numionodes;
+
 /* Because we only have PCI I/O ports.  */
 #define IIO_ITTE_BASE	0x400160	/* base of translation table entries */
 #define IIO_ITTE(bigwin)	(IIO_ITTE_BASE + 8*(bigwin))
diff -Nru a/include/asm-ia64/sn/iograph.h b/include/asm-ia64/sn/iograph.h
--- a/include/asm-ia64/sn/iograph.h	2004-08-11 17:51:32 -05:00
+++ b/include/asm-ia64/sn/iograph.h	2004-08-11 17:51:32 -05:00
@@ -8,8 +8,6 @@
 #ifndef _ASM_IA64_SN_IOGRAPH_H
 #define _ASM_IA64_SN_IOGRAPH_H
 
-#include <asm/sn/xtalk/xbow.h>	/* For get MAX_PORT_NUM */
-
 /*
  * During initialization, platform-dependent kernel code establishes some
  * basic elements of the hardware graph.  This file contains edge and
@@ -34,6 +32,7 @@
 #define EDGE_LBL_DISABLED		"disabled"
 #define EDGE_LBL_DISK			"disk"
 #define EDGE_LBL_HUB			"hub"		/* For SN0 */
+#define EDGE_LBL_ICE			"ice"		/* For TIO */
 #define EDGE_LBL_HW			"hw"
 #define EDGE_LBL_INTERCONNECT		"link"
 #define EDGE_LBL_IO			"io"
@@ -73,6 +72,8 @@
 #define	EDGE_LBL_XIO			"xio"
 #define EDGE_LBL_XSWITCH		".xswitch"
 #define EDGE_LBL_XTALK			"xtalk"
+#define EDGE_LBL_CORETALK		"coretalk"
+#define EDGE_LBL_CORELET		"corelet"
 #define EDGE_LBL_XWIDGET		"xwidget"
 #define EDGE_LBL_ELSC			"elsc"
 #define EDGE_LBL_L1			"L1"
@@ -83,9 +84,14 @@
 #define	EDGE_LBL_XPLINK_KERNEL		"kernel"	/* XP kernel devs */
 #define	EDGE_LBL_XPLINK_ADMIN		"admin"	   	/* Partition admin */
 #define EDGE_LBL_IOBRICK		"iobrick"
+#define EDGE_LBL_PEBRICK		"PEbrick"
 #define EDGE_LBL_PXBRICK		"PXbrick"
+#define EDGE_LBL_PABRICK		"PAbrick"
 #define EDGE_LBL_OPUSBRICK		"onboardio"
+#define EDGE_LBL_SABRICK		"SAbrick"	/* TIO BringUp Brick */
+#define EDGE_LBL_GABRICK		"GAbrick"
 #define EDGE_LBL_IXBRICK		"IXbrick"
+#define EDGE_LBL_IABRICK		"IAbrick"
 #define EDGE_LBL_CGBRICK		"CGbrick"
 #define EDGE_LBL_CPUBUS			"cpubus"	/* CPU Interfaces (SysAd) */
 
@@ -117,21 +123,5 @@
 #define INFO_LBL_XSWITCH_VOL		"_xswitch_volunteer"
 #define INFO_LBL_XFUNCS			"_xtalk_ops"	/* ops vector for gio providers */
 #define INFO_LBL_XWIDGET		"_xwidget"
-
-
-#ifdef __KERNEL__
-void init_all_devices(void);
-#endif /* __KERNEL__ */
-
-int io_brick_map_widget(int, int);
-
-/*
- * Map a brick's widget number to a meaningful int
- */
-
-struct io_brick_map_s {
-    int                 ibm_type;                  /* brick type */
-    int                 ibm_map_wid[MAX_PORT_NUM]; /* wid to int map */
-};
 
 #endif /* _ASM_IA64_SN_IOGRAPH_H */
diff -Nru a/include/asm-ia64/sn/klconfig.h b/include/asm-ia64/sn/klconfig.h
--- a/include/asm-ia64/sn/klconfig.h	2004-08-11 17:51:32 -05:00
+++ b/include/asm-ia64/sn/klconfig.h	2004-08-11 17:51:32 -05:00
@@ -29,16 +29,12 @@
 
 #include <linux/types.h>
 #include <asm/sn/types.h>
-#include <asm/sn/slotnum.h>
 #include <asm/sn/router.h>
 #include <asm/sn/sgi.h>
 #include <asm/sn/addrs.h>
 #include <asm/sn/vector.h>
-#include <asm/sn/xtalk/xbow.h>
-#include <asm/sn/xtalk/xtalk.h>
 #include <asm/sn/kldir.h>
 #include <asm/sn/sn_fru.h>
-#include <asm/sn/sn2/shub_md.h>
 #include <asm/sn/geo.h>
 
 #define KLCFGINFO_MAGIC	0xbeedbabe
@@ -66,8 +62,6 @@
 #define DUPLICATE_BOARD 	0x04    /* Boards like midplanes/routers which
                                    	   are discovered twice. Use one of them */
 #define VISITED_BOARD		0x08	/* Used for compact hub numbering. */
-#define LOCAL_MASTER_IO6	0x10    /* master io6 for that node */
-#define KLTYPE_IOBRICK_XBOW	(KLCLASS_MIDPLANE | 0x2)
 
 /* klinfo->flags fields */
 
@@ -124,7 +118,6 @@
 	confidence_t	ch_sn0net_belief; /* confidence that sn0net is bad */
 } kl_config_hdr_t;
 
-
 #define KL_CONFIG_HDR(_nasid) 	((kl_config_hdr_t *)(KLCONFIG_ADDR(_nasid)))
 
 #define NODE_OFFSET_TO_LBOARD(nasid,off)        (lboard_t*)(NODE_CAC_BASE(nasid) + (off))
@@ -286,17 +279,24 @@
 
 #define KLTYPE_WEIRDCPU (KLCLASS_CPU | 0x0)
 #define KLTYPE_SNIA	(KLCLASS_CPU | 0x1)
+#define KLTYPE_TIO	(KLCLASS_CPU | 0x2)
 
 #define KLTYPE_ROUTER     (KLCLASS_ROUTER | 0x1)
 #define KLTYPE_META_ROUTER (KLCLASS_ROUTER | 0x3)
 #define KLTYPE_REPEATER_ROUTER (KLCLASS_ROUTER | 0x4)
 
+#define KLTYPE_IOBRICK_XBOW	(KLCLASS_MIDPLANE | 0x2)
+
 #define KLTYPE_IOBRICK		(KLCLASS_IOBRICK | 0x0)
 #define KLTYPE_NBRICK		(KLCLASS_IOBRICK | 0x4)
 #define KLTYPE_PXBRICK		(KLCLASS_IOBRICK | 0x6)
 #define KLTYPE_IXBRICK		(KLCLASS_IOBRICK | 0x7)
 #define KLTYPE_CGBRICK		(KLCLASS_IOBRICK | 0x8)
 #define KLTYPE_OPUSBRICK	(KLCLASS_IOBRICK | 0x9)
+#define KLTYPE_SABRICK          (KLCLASS_IOBRICK | 0xa)
+#define KLTYPE_IABRICK		(KLCLASS_IOBRICK | 0xb)
+#define KLTYPE_PABRICK          (KLCLASS_IOBRICK | 0xc)
+#define KLTYPE_GABRICK		(KLCLASS_IOBRICK | 0xd)
 
 
 /* The value of type should be more than 8 so that hinv prints
@@ -346,6 +346,7 @@
 	klconf_off_t	brd_next_same;    /* Next BOARD with same nasid */
 } lboard_t;
 
+
 /*
  *	Make sure we pass back the calias space address for local boards.
  *	klconfig board traversal and error structure extraction defines.
@@ -676,27 +677,8 @@
 extern lboard_t *find_lboard_nasid(lboard_t *start, nasid_t, unsigned char type);
 extern klinfo_t *find_component(lboard_t *brd, klinfo_t *kli, unsigned char type);
 extern klinfo_t *find_first_component(lboard_t *brd, unsigned char type);
-extern klcpu_t *nasid_slice_to_cpuinfo(nasid_t, int);
-
-
-extern lboard_t *find_gfxpipe(int pipenum);
 extern lboard_t *find_lboard_class_any(lboard_t *start, unsigned char brd_class);
 extern lboard_t *find_lboard_class_nasid(lboard_t *start, nasid_t, unsigned char brd_class);
-extern lboard_t *find_nic_lboard(lboard_t *, nic_t);
-extern lboard_t *find_nic_type_lboard(nasid_t, unsigned char, nic_t);
-extern lboard_t *find_lboard_modslot(lboard_t *start, geoid_t geoid);
-extern int	config_find_nic_router(nasid_t, nic_t, lboard_t **, klrou_t**);
-extern int	config_find_nic_hub(nasid_t, nic_t, lboard_t **, klhub_t**);
-extern int	config_find_xbow(nasid_t, lboard_t **, klxbow_t**);
-extern int 	update_klcfg_cpuinfo(nasid_t, int);
 extern void 	board_to_path(lboard_t *brd, char *path);
-extern void 	nic_name_convert(char *old_name, char *new_name);
-extern int 	module_brds(nasid_t nasid, lboard_t **module_brds, int n);
-extern lboard_t *brd_from_key(uint64_t key);
-extern void 	device_component_canonical_name_get(lboard_t *,klinfo_t *,
-						    char *);
-extern int	board_serial_number_get(lboard_t *,char *);
-extern nasid_t	get_actual_nasid(lboard_t *brd) ;
-extern net_vec_t klcfg_discover_route(lboard_t *, lboard_t *, int);
 
 #endif /* _ASM_IA64_SN_KLCONFIG_H */
diff -Nru a/include/asm-ia64/sn/ksys/l1.h b/include/asm-ia64/sn/ksys/l1.h
--- a/include/asm-ia64/sn/ksys/l1.h	2004-08-11 17:51:32 -05:00
+++ b/include/asm-ia64/sn/ksys/l1.h	2004-08-11 17:51:32 -05:00
@@ -95,6 +95,7 @@
 #define L1_BRICKTYPE_TWISTER    0x36            /* 6 */ /* IP53 & ROUTER */
 #define L1_BRICKTYPE_IX         0x3d            /* = */
 #define L1_BRICKTYPE_IP34       0x61            /* a */
+#define L1_BRICKTYPE_GA		0x62            /* b */
 #define L1_BRICKTYPE_C          0x63            /* c */
 #define L1_BRICKTYPE_I          0x69            /* i */
 #define L1_BRICKTYPE_N          0x6e            /* n */
@@ -104,6 +105,9 @@
 #define L1_BRICKTYPE_CHI_CG     0x76            /* v */
 #define L1_BRICKTYPE_X          0x78            /* x */
 #define L1_BRICKTYPE_X2         0x79            /* y */
+#define L1_BRICKTYPE_SA		0x5e            /* ^ */ /* TIO bringup brick */
+#define L1_BRICKTYPE_PA		0x6a            /* j */
+#define L1_BRICKTYPE_IA		0x6b            /* k */
 
 /* EEPROM codes (for the "read EEPROM" request) */
 /* c brick */
diff -Nru a/include/asm-ia64/sn/module.h b/include/asm-ia64/sn/module.h
--- a/include/asm-ia64/sn/module.h	2004-08-11 17:51:32 -05:00
+++ b/include/asm-ia64/sn/module.h	2004-08-11 17:51:32 -05:00
@@ -8,9 +8,6 @@
 #ifndef _ASM_IA64_SN_MODULE_H
 #define _ASM_IA64_SN_MODULE_H
 
-#include <asm/sn/klconfig.h>
-#include <asm/sn/ksys/elsc.h>
-
 #define MODULE_MAX			128
 #define MODULE_MAX_NODES		2
 #define MODULE_HIST_CNT			16
@@ -18,7 +15,6 @@
 
 /* Well-known module IDs */
 #define MODULE_UNKNOWN		(-2) /* initial value of klconfig brd_module */
-/* #define INVALID_MODULE	(-1) ** generic invalid moduleid_t (arch.h) */
 #define MODULE_NOT_SET		0    /* module ID not set in sys ctlrs. */
 
 /* parameter for format_module_id() */
@@ -135,6 +131,10 @@
 #define MODULE_IXBRICK          10
 #define MODULE_CGBRICK		11
 #define MODULE_OPUSBRICK        12
+#define MODULE_SABRICK		13	/* TIO BringUp Brick */
+#define MODULE_IABRICK		14
+#define MODULE_PABRICK		15
+#define MODULE_GABRICK		16
 
 /*
  * Moduleid_t comparison macros
@@ -144,51 +144,18 @@
                                  ((_m2)&(MODULE_RACK_MASK|MODULE_BPOS_MASK)))
 #define MODULE_MATCH(_m1, _m2)  (MODULE_CMP((_m1),(_m2)) == 0)
 
-typedef struct module_s module_t;
+struct slab_info{
+	struct hubdev_info	hubdev;
+};
 
-struct module_s {
+struct brick{
     moduleid_t		id;		/* Module ID of this module        */
-
-    spinlock_t		lock;		/* Lock for this structure	   */
-
-    /* List of nodes in this module */
-    cnodeid_t		nodes[MAX_SLABS + 1];
-    geoid_t		geoid[MAX_SLABS + 1];
-
-    /* Fields for Module System Controller */
-    int			mesgpend;	/* Message pending                 */
-    int			shutdown;	/* Shutdown in progress            */
-    time_t		intrhist[MODULE_HIST_CNT];
-    int			histptr;
-
-    int			hbt_active;	/* MSC heartbeat monitor active    */
-    uint64_t		hbt_last;	/* RTC when last heartbeat sent    */
-
-    /* Module serial number info */
-    union {
-	char		snum_str[MAX_SERIAL_NUM_SIZE];	 /* used by CONFIG_SGI_IP27    */
-	uint64_t	snum_int;			 /* used by speedo */
-    } snum;
-    int			snum_valid;
-
-    int			disable_alert;
-    int			count_down;
-
-    /* System serial number info (used by SN1) */
-    char		sys_snum[MAX_SERIAL_NUM_SIZE];
-    int			sys_snum_valid;
+    struct slab_info	slab_info[MAX_SLABS + 1];
 };
 
-/* module.c */
-extern module_t	       *sn_modules[MODULE_MAX];	/* Indexed by cmoduleid_t   */
+extern struct brick	**bricks;	/* Indexed by cmoduleid_t   */
 extern int		nummodules;
-
-extern module_t	       *module_lookup(moduleid_t id);
+extern struct brick    *module_lookup(moduleid_t id);
 extern void		format_module_id(char *buffer, moduleid_t m, int fmt);
-extern int		parse_module_id(char *buffer);
-
-#ifdef	__cplusplus
-}
-#endif
 
 #endif /* _ASM_IA64_SN_MODULE_H */
diff -Nru a/include/asm-ia64/sn/nodepda.h b/include/asm-ia64/sn/nodepda.h
--- a/include/asm-ia64/sn/nodepda.h	2004-08-11 17:51:32 -05:00
+++ b/include/asm-ia64/sn/nodepda.h	2004-08-11 17:51:32 -05:00
@@ -3,7 +3,7 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
- * Copyright (C) 1992 - 1997, 2000-2003 Silicon Graphics, Inc. All rights reserved.
+ * Copyright (C) 1992 - 1997, 2000-2004 Silicon Graphics, Inc. All rights reserved.
  */
 #ifndef _ASM_IA64_SN_NODEPDA_H
 #define _ASM_IA64_SN_NODEPDA_H
@@ -14,7 +14,6 @@
 #include <asm/sn/intr.h>
 #include <asm/sn/router.h>
 #include <asm/sn/pda.h>
-#include <asm/sn/module.h>
 #include <asm/sn/bte.h>
 #include <asm/sn/sn2/arch.h>
 
@@ -32,32 +31,8 @@
  * This structure provides a convenient way of keeping together 
  * all per-node data structures. 
  */
-
-
-
 struct nodepda_s {
-	vertex_hdl_t 	xbow_vhdl;
-	nasid_t		xbow_peer;	/* NASID of our peer hub on xbow */
-	struct semaphore xbow_sema;	/* Sema for xbow synchronization */
-	slotid_t	slotdesc;
-	geoid_t		geoid;
-	module_t	*module;	/* Pointer to containing module */
-	xwidgetnum_t 	basew_id;
-	vertex_hdl_t 	basew_xc;
-	int		hubticks;
-	int		num_routers;	/* XXX not setup! Total routers in the system */
-
-	
-	char		*hwg_node_name;	/* hwgraph node name */
-	vertex_hdl_t	node_vertex;	/* Hwgraph vertex for this node */
-
 	void 		*pdinfo;	/* Platform-dependent per-node info */
-
-
-	nodepda_router_info_t	*npda_rip_first;
-	nodepda_router_info_t	**npda_rip_last;
-
-
 	spinlock_t		bist_lock;
 
 	/*
@@ -76,17 +51,6 @@
 
 typedef struct nodepda_s nodepda_t;
 
-struct irqpda_s {
-	int num_irq_used;
-	char irq_flags[NR_IRQS];
-	struct pci_dev *device_dev[NR_IRQS];
-	char share_count[NR_IRQS];
-	struct pci_dev *curr;
-};
-
-typedef struct irqpda_s irqpda_t;
-
-
 /*
  * Access Functions for node PDA.
  * Since there is one nodepda for each node, we need a convenient mechanism
@@ -104,32 +68,10 @@
 #define	nodepda		pda->p_nodepda		/* Ptr to this node's PDA */
 #define	NODEPDA(cnode)		(nodepda->pernode_pdaindr[cnode])
 
-
-/*
- * Macros to access data structures inside nodepda 
- */
-#define NODE_MODULEID(cnode)    geo_module((NODEPDA(cnode)->geoid))
-#define NODE_SLOTID(cnode)	(NODEPDA(cnode)->slotdesc)
-
-
-/*
- * Quickly convert a compact node ID into a hwgraph vertex
- */
-#define cnodeid_to_vertex(cnodeid) (NODEPDA(cnodeid)->node_vertex)
-
-
 /*
  * Check if given a compact node id the corresponding node has all the
  * cpus disabled. 
  */
 #define is_headless_node(cnode)		(nr_cpus_node(cnode) == 0)
-
-/*
- * Check if given a node vertex handle the corresponding node has all the
- * cpus disabled. 
- */
-#define is_headless_node_vertex(_nodevhdl) \
-			is_headless_node(nodevertex_to_cnodeid(_nodevhdl))
-
 
 #endif /* _ASM_IA64_SN_NODEPDA_H */
diff -Nru a/include/asm-ia64/sn/pda.h b/include/asm-ia64/sn/pda.h
--- a/include/asm-ia64/sn/pda.h	2004-08-11 17:51:32 -05:00
+++ b/include/asm-ia64/sn/pda.h	2004-08-11 17:51:32 -05:00
@@ -49,13 +49,14 @@
 	volatile unsigned long *pio_shub_war_cam_addr;
 	volatile unsigned long *mem_write_status_addr;
 
+	struct bteinfo_s *cpu_bte_if[BTES_PER_NODE];	/* cpu interface order */
+
 	unsigned long	sn_soft_irr[4];
 	unsigned long	sn_in_service_ivecs[4];
 	short		cnodeid_to_nasid_table[MAX_NUMNODES];
 	int		sn_lb_int_war_ticks;
 	int		sn_last_irq;
 	int		sn_first_irq;
-	int		sn_num_irqs;			/* number of irqs targeted for this cpu */
 } pda_t;
 
 
diff -Nru a/include/asm-ia64/sn/router.h b/include/asm-ia64/sn/router.h
--- a/include/asm-ia64/sn/router.h	2004-08-11 17:51:32 -05:00
+++ b/include/asm-ia64/sn/router.h	2004-08-11 17:51:32 -05:00
@@ -18,7 +18,6 @@
 #ifndef __ASSEMBLY__
 
 #include <asm/sn/vector.h>
-#include <asm/sn/slotnum.h>
 #include <asm/sn/arch.h>
 #include <asm/sn/sgi.h>
 
@@ -411,7 +410,7 @@
 typedef struct router_map_ent_s {
 	uint64_t	nic;
 	moduleid_t	module;
-	slotid_t	slot;
+	char		slot;
 } router_map_ent_t;
 
 struct rr_status_error_fmt {
@@ -485,7 +484,7 @@
 	int64_t	ri_timestamp;	/* Time of last sample		    */
 	router_port_info_t ri_port[MAX_ROUTER_PORTS]; /* per port info      */
 	moduleid_t	ri_module;	/* Which module are we in?	    */
-	slotid_t	ri_slotnum;	/* Which slot are we in?	    */
+	char		ri_slotnum;	/* Which slot are we in?	    */
 	router_reg_t	ri_glbl_parms[GLBL_PARMS_REGS];
 					/* Global parms0&1 register contents*/
 	vertex_hdl_t	ri_vertex;	/* hardware graph vertex            */
@@ -530,7 +529,7 @@
 	short		router_port;	/* port thru which we entered       */
 	short		router_portmask;
 	moduleid_t	router_module;	/* module in which router is there  */
-	slotid_t	router_slot;	/* router slot			    */
+	char		router_slot;	/* router slot			    */
 	unsigned char	router_type;	/* kind of router 		    */
 	net_vec_t	router_vector;	/* vector from the guardian node    */
 
diff -Nru a/include/asm-ia64/sn/sgi.h b/include/asm-ia64/sn/sgi.h
--- a/include/asm-ia64/sn/sgi.h	2004-08-11 17:51:32 -05:00
+++ b/include/asm-ia64/sn/sgi.h	2004-08-11 17:51:32 -05:00
@@ -6,15 +6,19 @@
  * Copyright (C) 2000-2003 Silicon Graphics, Inc. All rights reserved.
  */
 
+/*
+ * This file is a bit of a dumping ground. A lot of things that don't really
+ * have a home, but which make life easier, end up here.
+ */
 
 #ifndef _ASM_IA64_SN_SGI_H
 #define _ASM_IA64_SN_SGI_H
 
 #include <linux/config.h>
-
 #include <asm/sn/types.h>
+#include <linux/mm.h>
+#include <linux/fs.h>
 #include <asm/sn/hwgfs.h>
-
 typedef hwgfs_handle_t vertex_hdl_t;
 
 /* Nice general name length that lots of people like to use */
@@ -41,21 +45,6 @@
 #define CPU_NONE		(-1)
 #define GRAPH_VERTEX_NONE ((vertex_hdl_t)-1)
 
-/*
- * Defines for individual WARs. Each is a bitmask of applicable
- * part revision numbers. (1 << 1) == rev A, (1 << 2) == rev B,
- * (3 << 1) == (rev A or rev B), etc
- */
-#define PV854697 (~0)     /* PIC: write 64bit regs as 64bits. permanent */
-#define PV854827 (~0UL)   /* PIC: fake widget 0xf presence bit. permanent */
-#define PV855271 (1 << 1) /* PIC: use virt chan iff 64-bit device. */
-#define PV878674 (~0)     /* PIC: Dont allow 64bit PIOs.  permanent */
-#define PV855272 (1 << 1) /* PIC: runaway interrupt WAR */
-#define PV856155 (1 << 1) /* PIC: arbitration WAR */
-#define PV856864 (1 << 1) /* PIC: lower timeout to free TNUMs quicker */
-#define PV856866 (1 << 1) /* PIC: avoid rrb's 0/1/8/9. */
-#define PV862253 (1 << 1) /* PIC: don't enable write req RAM parity checking */
-#define PV867308 (3 << 1) /* PIC: make LLP error interrupts FATAL for PIC */
 
 /*
  * No code is complete without an Assertion macro
diff -Nru a/include/asm-ia64/sn/sn_cpuid.h b/include/asm-ia64/sn/sn_cpuid.h
--- a/include/asm-ia64/sn/sn_cpuid.h	2004-08-11 17:51:32 -05:00
+++ b/include/asm-ia64/sn/sn_cpuid.h	2004-08-11 17:51:32 -05:00
@@ -84,6 +84,7 @@
  */
 
 #ifndef CONFIG_SMP
+#define cpu_logical_id(cpu)				0
 #define cpu_physical_id(cpuid)			((ia64_getreg(_IA64_REG_CR_LID) >> 16) & 0xffff)
 #endif
 
@@ -93,6 +94,7 @@
  */
 #define cpu_physical_id_to_nasid(cpi)		((cpi) &0xfff)
 #define cpu_physical_id_to_slice(cpi)		((cpi>>12) & 3)
+#define cpu_physical_id_to_coherence_id(cpi)	(((cpi) & 0x600) >> 9)
 #define get_nasid()				((ia64_getreg(_IA64_REG_CR_LID) >> 16) & 0xfff)
 #define get_slice()				((ia64_getreg(_IA64_REG_CR_LID) >> 28) & 0xf)
 #define get_node_number(addr)			(((unsigned long)(addr)>>38) & 0x7ff)
@@ -171,6 +173,12 @@
  
 
 #define smp_physical_node_id()			(cpuid_to_nasid(smp_processor_id()))
+
+/*
+ * cpuid_to_coherence_id - convert a cpuid to the coherence domain id it
+ * resides on
+ */
+#define cpuid_to_coherence_id(cpuid)    cpu_physical_id_to_coherence_id(cpu_physical_id(cpuid))
 
 
 #endif /* _ASM_IA64_SN_SN_CPUID_H */
diff -Nru a/include/asm-ia64/sn/sn_sal.h b/include/asm-ia64/sn/sn_sal.h
--- a/include/asm-ia64/sn/sn_sal.h	2004-08-11 17:51:32 -05:00
+++ b/include/asm-ia64/sn/sn_sal.h	2004-08-11 17:51:32 -05:00
@@ -8,7 +8,7 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
- * Copyright (c) 2000-2003 Silicon Graphics, Inc.  All rights reserved.
+ * Copyright (c) 2000-2004 Silicon Graphics, Inc.  All rights reserved.
  */
 
 
@@ -17,8 +17,6 @@
 #include <asm/sn/sn_cpuid.h>
 #include <asm/sn/arch.h>
 #include <asm/sn/nodepda.h>
-#include <asm/sn/klconfig.h>
-        
 
 // SGI Specific Calls
 #define  SN_SAL_POD_MODE                           0x02000001
@@ -33,7 +31,6 @@
 #define  SN_SAL_NO_FAULT_ZONE_VIRTUAL		   0x02000010
 #define  SN_SAL_NO_FAULT_ZONE_PHYSICAL		   0x02000011
 #define  SN_SAL_PRINT_ERROR			   0x02000012
-#define  SN_SAL_SET_ERROR_HANDLING_FEATURES	   0x0200001a	// reentrant
 #define  SN_SAL_CONSOLE_PUTC                       0x02000021
 #define  SN_SAL_CONSOLE_GETC                       0x02000022
 #define  SN_SAL_CONSOLE_PUTS                       0x02000023
@@ -59,7 +56,13 @@
 #define  SN_SAL_MEMPROTECT                         0x0200003e
 #define  SN_SAL_SYSCTL_FRU_CAPTURE		   0x0200003f
 
+#define	 SN_SAL_SYSCTL_IOBRICK_SLAB_GET		   0x02000041	// reentrant
 #define  SN_SAL_SYSCTL_IOBRICK_PCI_OP		   0x02000042	// reentrant
+#define	 SN_SAL_START_IO			   0x02000045	// reentrant ??
+#define	 SN_SAL_GET_IO_MAPS			   0x02000046	// reentrant ??
+
+#define SN_SAL_PCIIO				   0x02000049	// reentrant ??
+#define SN_SAL_XTALK				   0x0200004a
 
 /*
  * Service-specific constants
@@ -93,19 +96,6 @@
 #define SALRET_INVALID_ARG	-2
 #define SALRET_ERROR		-3
 
-/*
- * SN_SAL_SET_ERROR_HANDLING_FEATURES bit settings
- */
-enum 
-{
-	/* if "rz always" is set, have the mca slaves call os_init_slave */
-	SN_SAL_EHF_MCA_SLV_TO_OS_INIT_SLV=0,
-	/* do not rz on tlb checks, even if "rz always" is set */
-	SN_SAL_EHF_NO_RZ_TLBC,
-	/* do not rz on PIO reads to I/O space, even if "rz always" is set */
-	SN_SAL_EHF_NO_RZ_IO_READ,
-};
-
 
 /**
  * sn_sal_rev_major - get the major SGI SAL revision number
@@ -141,8 +131,8 @@
  * Specify the minimum PROM revsion required for this kernel.
  * Note that they're stored in hex format...
  */
-#define SN_SAL_MIN_MAJOR	0x3  /* SN2 kernels need at least PROM 3.40 */
-#define SN_SAL_MIN_MINOR	0x40
+#define SN_SAL_MIN_MAJOR	0x1  /* SN2 kernels need at least PROM 1.0 */
+#define SN_SAL_MIN_MINOR	0x0
 
 u64 ia64_sn_probe_io_slot(long paddr, long size, void *data_ptr);
 
@@ -302,7 +292,7 @@
 	ret_stuff.v0 = 0;
 	ret_stuff.v1 = 0;
 	ret_stuff.v2 = 0;
-	SAL_CALL_REENTRANT(ret_stuff, SN_SAL_PRINT_ERROR, (uint64_t)hook, (uint64_t)rec, 0, 0, 0, 0, 0);
+	SAL_CALL_NOLOCK(ret_stuff, SN_SAL_PRINT_ERROR, (uint64_t)hook, (uint64_t)rec, 0, 0, 0, 0, 0);
 
 	return ret_stuff.status;
 }
@@ -623,12 +613,12 @@
 	unsigned long irq_flags;
 
 	cnodeid = nasid_to_cnodeid(get_node_number(paddr));
-	spin_lock(&NODEPDA(cnodeid)->bist_lock);
+	// spin_lock(&NODEPDA(cnodeid)->bist_lock);
 	local_irq_save(irq_flags);
 	SAL_CALL_NOLOCK(ret_stuff, SN_SAL_MEMPROTECT, paddr, len, nasid_array,
 		 perms, 0, 0, 0);
 	local_irq_restore(irq_flags);
-	spin_unlock(&NODEPDA(cnodeid)->bist_lock);
+	// spin_unlock(&NODEPDA(cnodeid)->bist_lock);
 	return ret_stuff.status;
 }
 #define SN_MEMPROT_ACCESS_CLASS_0		0x14a080
@@ -672,7 +662,7 @@
  */
 static inline u64
 ia64_sn_sysctl_iobrick_pci_op(nasid_t n, u64 connection_type, 
-			      u64 bus, slotid_t slot, 
+			      u64 bus, char slot, 
 			      u64 action)
 {
 	struct ia64_sal_retval rv = {0, 0, 0, 0};
@@ -684,24 +674,21 @@
 	return 0;
 }
 
-/*
- * Tell the prom how the OS wants to handle specific error features.
- * It takes an array of 7 u64.
- */
 static inline u64
-ia64_sn_set_error_handling_features(const u64 *feature_bits)
+ia64_sn_get_map_ptr(u64 *ptr)
 {
-	struct ia64_sal_retval rv = {0, 0, 0, 0};
+	struct ia64_sal_retval ret_stuff;
+
+	ret_stuff.status = 0;
+	ret_stuff.v0 = 0;
+	ret_stuff.v1 = 0;
+	ret_stuff.v2 = 0;
+	SAL_CALL_NOLOCK(ret_stuff, SN_SAL_GET_IO_MAPS, 0, 0, 0, 0, 0, 0, 0);
 
-	SAL_CALL_REENTRANT(rv, SN_SAL_SET_ERROR_HANDLING_FEATURES,
-			feature_bits[0],
-			feature_bits[1],
-			feature_bits[2],
-			feature_bits[3],
-			feature_bits[4],
-			feature_bits[5],
-			feature_bits[6]);
-	return rv.status;
+	/* ptr is in 'v0' */
+	*ptr = ret_stuff.v0;
+
+	return ret_stuff.status;
 }
 
 #endif /* _ASM_IA64_SN_SN_SAL_H */
diff -Nru a/include/asm-ia64/sn/sndrv.h b/include/asm-ia64/sn/sndrv.h
--- a/include/asm-ia64/sn/sndrv.h	2004-08-11 17:51:32 -05:00
+++ b/include/asm-ia64/sn/sndrv.h	2004-08-11 17:51:32 -05:00
@@ -46,6 +46,7 @@
 #define SNDRV_SHUB_GETMMR64_IO         47
 #define SNDRV_SHUB_PUTMMR64            48
 #define SNDRV_SHUB_PUTMMR64_IO         49
+#define SNDRV_SHUB_GET_IOCTL_VERSION    50
 
 /* Devices */
 #define SNDRV_UKNOWN_DEVICE		-1
diff -Nru a/include/asm-ia64/sn/types.h b/include/asm-ia64/sn/types.h
--- a/include/asm-ia64/sn/types.h	2004-08-11 17:51:32 -05:00
+++ b/include/asm-ia64/sn/types.h	2004-08-11 17:51:32 -05:00
@@ -15,9 +15,11 @@
 typedef unsigned int    moduleid_t;     /* user-visible module number type */
 typedef unsigned int    cmoduleid_t;    /* kernel compact module id type */
 typedef signed char     slabid_t;
+typedef unsigned char	clusterid_t;	/* Clusterid of the cell */
 
 typedef unsigned long iopaddr_t;
 typedef unsigned long paddr_t;
+typedef unsigned long pfn_t;
 typedef short cnodeid_t;
 
 #endif /* _ASM_IA64_SN_TYPES_H */
