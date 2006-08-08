Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030225AbWHHTXy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030225AbWHHTXy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 15:23:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030231AbWHHTXx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 15:23:53 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:16819 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1030229AbWHHTXw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 15:23:52 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Tue, 8 Aug 2006 21:22:54 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH 2/4] ieee1394: safer definition of empty macros
To: linux-kernel@vger.kernel.org
cc: Ben Collins <bcollins@ubuntu.com>, Andrew Morton <akpm@osdl.org>,
       linux1394-devel@lists.sourceforge.net
In-Reply-To: <tkrat.57bb8cb1b7c97d1e@s5r6.in-berlin.de>
Message-ID: <tkrat.a4ed36860ca1de89@s5r6.in-berlin.de>
References: <tkrat.57bb8cb1b7c97d1e@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A deactivated macro, defined as "#define foo(bar)", will result in
silent corruption if somebody forgets a semicolon after a call to foo.
Replace it by "#define foo(bar) do {} while (0)" which will reveal any
respective syntax errors.

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---
 drivers/ieee1394/dv1394.c         |    4 ++--
 drivers/ieee1394/ieee1394_core.c  |    2 +-
 drivers/ieee1394/ieee1394_types.h |    2 +-
 drivers/ieee1394/ohci1394.c       |    8 ++++----
 drivers/ieee1394/raw1394.c        |    2 +-
 drivers/ieee1394/sbp2.c           |   18 +++++++++---------
 drivers/ieee1394/video1394.c      |    2 +-
 7 files changed, 19 insertions(+), 19 deletions(-)

Index: linux/drivers/ieee1394/dv1394.c
===================================================================
--- linux.orig/drivers/ieee1394/dv1394.c	2006-07-29 20:11:13.000000000 +0200
+++ linux/drivers/ieee1394/dv1394.c	2006-08-01 20:36:25.000000000 +0200
@@ -137,13 +137,13 @@
 #if DV1394_DEBUG_LEVEL >= 2
 #define irq_printk( args... ) printk( args )
 #else
-#define irq_printk( args... )
+#define irq_printk( args... ) do {} while (0)
 #endif
 
 #if DV1394_DEBUG_LEVEL >= 1
 #define debug_printk( args... ) printk( args)
 #else
-#define debug_printk( args... )
+#define debug_printk( args... ) do {} while (0)
 #endif
 
 /* issue a dummy PCI read to force the preceding write
Index: linux/drivers/ieee1394/ieee1394_core.c
===================================================================
--- linux.orig/drivers/ieee1394/ieee1394_core.c	2006-07-29 20:11:13.000000000 +0200
+++ linux/drivers/ieee1394/ieee1394_core.c	2006-08-01 20:37:04.000000000 +0200
@@ -85,7 +85,7 @@ static void dump_packet(const char *text
 	printk("\n");
 }
 #else
-#define dump_packet(a,b,c,d)
+#define dump_packet(a,b,c,d) do {} while (0)
 #endif
 
 static void abort_requests(struct hpsb_host *host);
Index: linux/drivers/ieee1394/ieee1394_types.h
===================================================================
--- linux.orig/drivers/ieee1394/ieee1394_types.h	2006-07-29 20:11:13.000000000 +0200
+++ linux/drivers/ieee1394/ieee1394_types.h	2006-08-01 20:37:55.000000000 +0200
@@ -41,7 +41,7 @@ typedef u16 arm_length_t;
 #define HPSB_VERBOSE(fmt, args...)	HPSB_PRINT(KERN_DEBUG, fmt , ## args)
 #define HPSB_DEBUG_TLABELS
 #else
-#define HPSB_VERBOSE(fmt, args...)
+#define HPSB_VERBOSE(fmt, args...)	do {} while (0)
 #endif
 
 #ifdef __BIG_ENDIAN
Index: linux/drivers/ieee1394/ohci1394.c
===================================================================
--- linux.orig/drivers/ieee1394/ohci1394.c	2006-07-29 20:11:13.000000000 +0200
+++ linux/drivers/ieee1394/ohci1394.c	2006-08-01 20:53:27.000000000 +0200
@@ -136,7 +136,7 @@
 #define DBGMSG(fmt, args...) \
 printk(KERN_INFO "%s: fw-host%d: " fmt "\n" , OHCI1394_DRIVER_NAME, ohci->host->id , ## args)
 #else
-#define DBGMSG(fmt, args...)
+#define DBGMSG(fmt, args...) do {} while (0)
 #endif
 
 #ifdef CONFIG_IEEE1394_OHCI_DMA_DEBUG
@@ -148,8 +148,8 @@ printk(KERN_INFO "%s: fw-host%d: " fmt "
 		--global_outstanding_dmas, ## args)
 static int global_outstanding_dmas = 0;
 #else
-#define OHCI_DMA_ALLOC(fmt, args...)
-#define OHCI_DMA_FREE(fmt, args...)
+#define OHCI_DMA_ALLOC(fmt, args...) do {} while (0)
+#define OHCI_DMA_FREE(fmt, args...) do {} while (0)
 #endif
 
 /* print general (card independent) information */
@@ -210,7 +210,7 @@ static inline void packet_swab(quadlet_t
 }
 #else
 /* Don't waste cycles on same sex byte swaps */
-#define packet_swab(w,x)
+#define packet_swab(w,x) do {} while (0)
 #endif /* !LITTLE_ENDIAN */
 
 /***********************************
Index: linux/drivers/ieee1394/raw1394.c
===================================================================
--- linux.orig/drivers/ieee1394/raw1394.c	2006-07-29 20:11:13.000000000 +0200
+++ linux/drivers/ieee1394/raw1394.c	2006-08-01 20:39:34.000000000 +0200
@@ -67,7 +67,7 @@
 #define DBGMSG(fmt, args...) \
 printk(KERN_INFO "raw1394:" fmt "\n" , ## args)
 #else
-#define DBGMSG(fmt, args...)
+#define DBGMSG(fmt, args...) do {} while (0)
 #endif
 
 static LIST_HEAD(host_info_list);
Index: linux/drivers/ieee1394/sbp2.c
===================================================================
--- linux.orig/drivers/ieee1394/sbp2.c	2006-07-29 20:11:13.000000000 +0200
+++ linux/drivers/ieee1394/sbp2.c	2006-08-01 20:54:17.000000000 +0200
@@ -203,9 +203,9 @@ static u32 global_outstanding_command_or
 #define outstanding_orb_incr global_outstanding_command_orbs++
 #define outstanding_orb_decr global_outstanding_command_orbs--
 #else
-#define SBP2_ORB_DEBUG(fmt, args...)
-#define outstanding_orb_incr
-#define outstanding_orb_decr
+#define SBP2_ORB_DEBUG(fmt, args...)	do {} while (0)
+#define outstanding_orb_incr		do {} while (0)
+#define outstanding_orb_decr		do {} while (0)
 #endif
 
 #ifdef CONFIG_IEEE1394_SBP2_DEBUG_DMA
@@ -217,8 +217,8 @@ static u32 global_outstanding_command_or
 		 --global_outstanding_dmas, ## args)
 static u32 global_outstanding_dmas = 0;
 #else
-#define SBP2_DMA_ALLOC(fmt, args...)
-#define SBP2_DMA_FREE(fmt, args...)
+#define SBP2_DMA_ALLOC(fmt, args...)	do {} while (0)
+#define SBP2_DMA_FREE(fmt, args...)	do {} while (0)
 #endif
 
 #if CONFIG_IEEE1394_SBP2_DEBUG >= 2
@@ -232,7 +232,7 @@ static u32 global_outstanding_dmas = 0;
 #define SBP2_NOTICE(fmt, args...)	HPSB_NOTICE("sbp2: "fmt, ## args)
 #define SBP2_WARN(fmt, args...)		HPSB_WARN("sbp2: "fmt, ## args)
 #else
-#define SBP2_DEBUG(fmt, args...)
+#define SBP2_DEBUG(fmt, args...)	do {} while (0)
 #define SBP2_INFO(fmt, args...)		HPSB_INFO("sbp2: "fmt, ## args)
 #define SBP2_NOTICE(fmt, args...)       HPSB_NOTICE("sbp2: "fmt, ## args)
 #define SBP2_WARN(fmt, args...)         HPSB_WARN("sbp2: "fmt, ## args)
@@ -375,8 +375,8 @@ static inline void sbp2util_cpu_to_be32_
 }
 #else /* BIG_ENDIAN */
 /* Why waste the cpu cycles? */
-#define sbp2util_be32_to_cpu_buffer(x,y)
-#define sbp2util_cpu_to_be32_buffer(x,y)
+#define sbp2util_be32_to_cpu_buffer(x,y) do {} while (0)
+#define sbp2util_cpu_to_be32_buffer(x,y) do {} while (0)
 #endif
 
 #ifdef CONFIG_IEEE1394_SBP2_PACKET_DUMP
@@ -412,7 +412,7 @@ static void sbp2util_packet_dump(void *b
 	return;
 }
 #else
-#define sbp2util_packet_dump(w,x,y,z)
+#define sbp2util_packet_dump(w,x,y,z) do {} while (0)
 #endif
 
 static DECLARE_WAIT_QUEUE_HEAD(access_wq);
Index: linux/drivers/ieee1394/video1394.c
===================================================================
--- linux.orig/drivers/ieee1394/video1394.c	2006-07-29 20:11:13.000000000 +0200
+++ linux/drivers/ieee1394/video1394.c	2006-08-01 20:42:56.000000000 +0200
@@ -129,7 +129,7 @@ struct file_ctx {
 #define DBGMSG(card, fmt, args...) \
 printk(KERN_INFO "video1394_%d: " fmt "\n" , card , ## args)
 #else
-#define DBGMSG(card, fmt, args...)
+#define DBGMSG(card, fmt, args...) do {} while (0)
 #endif
 
 /* print general (card independent) information */


