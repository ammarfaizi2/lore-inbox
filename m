Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267310AbTCERG1>; Wed, 5 Mar 2003 12:06:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267322AbTCERG1>; Wed, 5 Mar 2003 12:06:27 -0500
Received: from franka.aracnet.com ([216.99.193.44]:48013 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267310AbTCERGV>; Wed, 5 Mar 2003 12:06:21 -0500
Date: Wed, 05 Mar 2003 09:16:48 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] 3/6 Convert physnode_map to u8 
Message-ID: <155480000.1046884607@[10.10.2.4]>
In-Reply-To: <155040000.1046884524@[10.10.2.4]>
References: <154390000.1046884457@[10.10.2.4]>
 <155040000.1046884524@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From Andy Whitcroft

Convert physnode_map from an int to a u8 to save cachelines.

diff -urpN -X /home/fletch/.diff.exclude
013-numa_x86_pc/arch/i386/kernel/numaq.c
014-physnode_map_u8/arch/i386/kernel/numaq.c
--- 013-numa_x86_pc/arch/i386/kernel/numaq.c	Wed Mar  5 07:41:52 2003
+++ 014-physnode_map_u8/arch/i386/kernel/numaq.c	Wed Mar  5 07:41:55 2003
@@ -64,8 +64,6 @@ static void __init smp_dump_qct(void)
 	}
 }
 
-extern int physnode_map[];
-
 /*
  * for each node mark the regions
  *        TOPOFMEM = hi_shrd_mem_start + hi_shrd_mem_size
diff -urpN -X /home/fletch/.diff.exclude
013-numa_x86_pc/arch/i386/mm/discontig.c
014-physnode_map_u8/arch/i386/mm/discontig.c
--- 013-numa_x86_pc/arch/i386/mm/discontig.c	Wed Mar  5 07:41:54 2003
+++ 014-physnode_map_u8/arch/i386/mm/discontig.c	Wed Mar  5 07:41:55 2003
@@ -57,7 +57,7 @@ bootmem_data_t node0_bdata;
  *     physnode_map[4-7] = 1;
  *     physnode_map[8- ] = -1;
  */
-int physnode_map[MAX_ELEMENTS] = { [0 ... (MAX_ELEMENTS - 1)] = -1};
+u8 physnode_map[MAX_ELEMENTS] = { [0 ... (MAX_ELEMENTS - 1)] = -1};
 
 unsigned long node_start_pfn[MAX_NUMNODES];
 unsigned long node_end_pfn[MAX_NUMNODES];
diff -urpN -X /home/fletch/.diff.exclude
013-numa_x86_pc/include/asm-i386/mmzone.h
014-physnode_map_u8/include/asm-i386/mmzone.h
--- 013-numa_x86_pc/include/asm-i386/mmzone.h	Wed Mar  5 07:41:54 2003
+++ 014-physnode_map_u8/include/asm-i386/mmzone.h	Wed Mar  5 07:41:55 2003
@@ -107,7 +107,7 @@ extern struct pglist_data *node_data[];
 #define MAX_ELEMENTS 256
 #define PAGES_PER_ELEMENT (MAX_NR_PAGES/MAX_ELEMENTS)
 
-extern int physnode_map[];
+extern u8 physnode_map[];
 
 static inline int pfn_to_nid(unsigned long pfn)
 {
diff -urpN -X /home/fletch/.diff.exclude
013-numa_x86_pc/include/asm-i386/numaq.h
014-physnode_map_u8/include/asm-i386/numaq.h
--- 013-numa_x86_pc/include/asm-i386/numaq.h	Wed Mar  5 07:41:52 2003
+++ 014-physnode_map_u8/include/asm-i386/numaq.h	Wed Mar  5 07:41:55 2003
@@ -28,8 +28,6 @@
 
 #ifdef CONFIG_X86_NUMAQ
 
-extern int physnode_map[];
-
 #define MAX_NUMNODES		8
 extern void get_memcfg_numaq(void);
 #define get_memcfg_numa() get_memcfg_numaq()
diff -urpN -X /home/fletch/.diff.exclude
013-numa_x86_pc/include/asm-i386/srat.h
014-physnode_map_u8/include/asm-i386/srat.h
--- 013-numa_x86_pc/include/asm-i386/srat.h	Wed Mar  5 07:41:52 2003
+++ 014-physnode_map_u8/include/asm-i386/srat.h	Wed Mar  5 07:41:55 2003
@@ -27,7 +27,6 @@
 #ifndef _ASM_SRAT_H_
 #define _ASM_SRAT_H_
 
-extern int physnode_map[];
 #define MAX_NUMNODES		8
 extern void get_memcfg_from_srat(void);
 extern unsigned long *get_zholes_size(int);

