Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261856AbTIPMq3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 08:46:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261864AbTIPMq1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 08:46:27 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:10229 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261856AbTIPMqK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 08:46:10 -0400
Message-ID: <3F670566.5040905@us.ibm.com>
Date: Tue, 16 Sep 2003 05:43:18 -0700
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jesse Barnes <jbarnes@sgi.com>
CC: "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk, wli@holomorphy.com
Subject: Re: [PATCH] Clean up MAX_NR_NODES/NUMNODES/etc. [1/5]
References: <20030910153601.36219ed8.akpm@osdl.org> <41000000.1063237600@flay> <20030911000303.GA20329@sgi.com> <3F6659DF.1090508@us.ibm.com> <3F665A80.2020808@us.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------080607070200090101030203"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080607070200090101030203
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Here's a version rediffed against test5-mm2.  The other patches, except 
for a little fuzz on 5/5, apply fine to either test5 or -mm2.

Cheers!

-Matt

--------------080607070200090101030203
Content-Type: text/plain;
 name="01-max_numnodes2nodes_shift-mm2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="01-max_numnodes2nodes_shift-mm2.patch"

diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.0-test5-mm2/include/asm-alpha/numnodes.h linux-2.6.0-test5-01/include/asm-alpha/numnodes.h
--- linux-2.6.0-test5-mm2/include/asm-alpha/numnodes.h	Mon Sep  8 12:49:53 2003
+++ linux-2.6.0-test5-01/include/asm-alpha/numnodes.h	Tue Sep 16 05:19:42 2003
@@ -1,6 +1,7 @@
 #ifndef _ASM_MAX_NUMNODES_H
 #define _ASM_MAX_NUMNODES_H
 
-#define MAX_NUMNODES		128 /* Marvel */
+/* Max 128 Nodes - Marvel */
+#define NODES_SHIFT	7
 
 #endif /* _ASM_MAX_NUMNODES_H */
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.0-test5-mm2/include/asm-i386/numaq.h linux-2.6.0-test5-01/include/asm-i386/numaq.h
--- linux-2.6.0-test5-mm2/include/asm-i386/numaq.h	Tue Sep 16 05:18:10 2003
+++ linux-2.6.0-test5-01/include/asm-i386/numaq.h	Tue Sep 16 05:20:47 2003
@@ -28,7 +28,6 @@
 
 #ifdef CONFIG_X86_NUMAQ
 
-#define MAX_NUMNODES		16
 extern int get_memcfg_numaq(void);
 
 /*
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.0-test5-mm2/include/asm-i386/numnodes.h linux-2.6.0-test5-01/include/asm-i386/numnodes.h
--- linux-2.6.0-test5-mm2/include/asm-i386/numnodes.h	Tue Sep 16 05:18:10 2003
+++ linux-2.6.0-test5-01/include/asm-i386/numnodes.h	Tue Sep 16 05:22:21 2003
@@ -4,11 +4,15 @@
 #include <linux/config.h>
 
 #ifdef CONFIG_X86_NUMAQ
-#include <asm/numaq.h>
+
+/* Max 16 Nodes */
+#define NODES_SHIFT	4
+
 #elif CONFIG_ACPI_SRAT
-#include <asm/srat.h>
-#else
-#define MAX_NUMNODES	1
+
+/* Max 8 Nodes */
+#define NODES_SHIFT	3
+
 #endif /* CONFIG_X86_NUMAQ */
 
 #endif /* _ASM_MAX_NUMNODES_H */
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.0-test5-mm2/include/asm-i386/srat.h linux-2.6.0-test5-01/include/asm-i386/srat.h
--- linux-2.6.0-test5-mm2/include/asm-i386/srat.h	Tue Sep 16 05:18:11 2003
+++ linux-2.6.0-test5-01/include/asm-i386/srat.h	Tue Sep 16 05:22:59 2003
@@ -31,7 +31,6 @@
 #error CONFIG_ACPI_SRAT not defined, and srat.h header has been included
 #endif
 
-#define MAX_NUMNODES		8
 extern int get_memcfg_from_srat(void);
 extern unsigned long *get_zholes_size(int);
 
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.0-test5-mm2/include/asm-ppc64/numnodes.h linux-2.6.0-test5-01/include/asm-ppc64/numnodes.h
--- linux-2.6.0-test5-mm2/include/asm-ppc64/numnodes.h	Mon Sep  8 12:50:22 2003
+++ linux-2.6.0-test5-01/include/asm-ppc64/numnodes.h	Tue Sep 16 05:19:42 2003
@@ -1,6 +1,7 @@
 #ifndef _ASM_MAX_NUMNODES_H
 #define _ASM_MAX_NUMNODES_H
 
-#define MAX_NUMNODES 16
+/* Max 16 Nodes */
+#define NODES_SHIFT	4
 
 #endif /* _ASM_MAX_NUMNODES_H */
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.0-test5-mm2/include/asm-x86_64/mmzone.h linux-2.6.0-test5-01/include/asm-x86_64/mmzone.h
--- linux-2.6.0-test5-mm2/include/asm-x86_64/mmzone.h	Mon Sep  8 12:50:22 2003
+++ linux-2.6.0-test5-01/include/asm-x86_64/mmzone.h	Tue Sep 16 05:19:42 2003
@@ -10,7 +10,6 @@
 
 #define VIRTUAL_BUG_ON(x) 
 
-#include <asm/numnodes.h>
 #include <asm/smp.h>
 
 #define MAXNODE 8 
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.0-test5-mm2/include/asm-x86_64/numnodes.h linux-2.6.0-test5-01/include/asm-x86_64/numnodes.h
--- linux-2.6.0-test5-mm2/include/asm-x86_64/numnodes.h	Mon Sep  8 12:50:03 2003
+++ linux-2.6.0-test5-01/include/asm-x86_64/numnodes.h	Tue Sep 16 05:19:42 2003
@@ -3,10 +3,7 @@
 
 #include <linux/config.h>
 
-#ifdef CONFIG_DISCONTIGMEM
-#define MAX_NUMNODES 8	/* APIC limit currently */
-#else
-#define MAX_NUMNODES 1
-#endif
+/* Max 8 Nodes - APIC limit currently */
+#define NODES_SHIFT	3
 
 #endif
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.0-test5-mm2/include/linux/mmzone.h linux-2.6.0-test5-01/include/linux/mmzone.h
--- linux-2.6.0-test5-mm2/include/linux/mmzone.h	Mon Sep  8 12:50:07 2003
+++ linux-2.6.0-test5-01/include/linux/mmzone.h	Tue Sep 16 05:19:42 2003
@@ -14,9 +14,10 @@
 #ifdef CONFIG_DISCONTIGMEM
 #include <asm/numnodes.h>
 #endif
-#ifndef MAX_NUMNODES
-#define MAX_NUMNODES 1
+#ifndef NODES_SHIFT
+#define NODES_SHIFT	0
 #endif
+#define MAX_NUMNODES	(1 << NODES_SHIFT)
 
 /* Free memory management - zoned buddy allocator.  */
 #ifndef CONFIG_FORCE_MAX_ZONEORDER
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.0-test5-mm2/mm/slab.c linux-2.6.0-test5-01/mm/slab.c
--- linux-2.6.0-test5-mm2/mm/slab.c	Tue Sep 16 05:18:13 2003
+++ linux-2.6.0-test5-01/mm/slab.c	Tue Sep 16 05:19:42 2003
@@ -250,7 +250,7 @@ struct kmem_cache_s {
 	unsigned int		limit;
 /* 2) touched by every alloc & free from the backend */
 	struct kmem_list3	lists;
-	/* NUMA: kmem_3list_t	*nodelists[NR_NODES] */
+	/* NUMA: kmem_3list_t	*nodelists[MAX_NUMNODES] */
 	unsigned int		objsize;
 	unsigned int	 	flags;	/* constant flags */
 	unsigned int		num;	/* # of objs per slab */

--------------080607070200090101030203--

