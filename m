Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318397AbSHAAKq>; Wed, 31 Jul 2002 20:10:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318558AbSHAAKq>; Wed, 31 Jul 2002 20:10:46 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:43442 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S318397AbSHAAKp>; Wed, 31 Jul 2002 20:10:45 -0400
Message-ID: <3D487CEF.5000107@us.ibm.com>
Date: Wed, 31 Jul 2002 17:12:31 -0700
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [patch] MAX_NR_NODES name change
Content-Type: multipart/mixed;
 boundary="------------010103050908060101040706"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010103050908060101040706
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This patch changes MAX_NR_NODES to be NR_NODES, so as to be more consistent 
with the naming of NR_CPUS.  It is easier to change this one as it only appears 
in 3 places and NR_CPUS appears all over the place.

Cheers!

-Matt

--------------010103050908060101040706
Content-Type: text/plain;
 name="max_nr_node-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="max_nr_node-fix.patch"

diff -Nur linux-2.5.29-vanilla/include/linux/mmzone.h linux-2.5.29-patched/include/linux/mmzone.h
--- linux-2.5.29-vanilla/include/linux/mmzone.h	Fri Jul 26 19:58:25 2002
+++ linux-2.5.29-patched/include/linux/mmzone.h	Wed Jul 31 17:09:20 2002
@@ -167,14 +167,14 @@
 
 #define NODE_DATA(nid)		(&contig_page_data)
 #define NODE_MEM_MAP(nid)	mem_map
-#define MAX_NR_NODES		1
+#define NR_NODES		1
 
 #else /* !CONFIG_DISCONTIGMEM */
 
 #include <asm/mmzone.h>
 
 /* page->zone is currently 8 bits ... */
-#define MAX_NR_NODES		(255 / MAX_NR_ZONES)
+#define NR_NODES		(255 / MAX_NR_ZONES)
 
 #endif /* !CONFIG_DISCONTIGMEM */
 
diff -Nur linux-2.5.29-vanilla/mm/page_alloc.c linux-2.5.29-patched/mm/page_alloc.c
--- linux-2.5.29-vanilla/mm/page_alloc.c	Fri Jul 26 19:58:27 2002
+++ linux-2.5.29-patched/mm/page_alloc.c	Wed Jul 31 17:09:00 2002
@@ -34,7 +34,7 @@
  * Used by page_zone() to look up the address of the struct zone whose
  * id is encoded in the upper bits of page->flags
  */
-zone_t *zone_table[MAX_NR_ZONES*MAX_NR_NODES];
+zone_t *zone_table[MAX_NR_ZONES*NR_NODES];
 EXPORT_SYMBOL(zone_table);
 
 static char *zone_names[MAX_NR_ZONES] = { "DMA", "Normal", "HighMem" };

--------------010103050908060101040706--

