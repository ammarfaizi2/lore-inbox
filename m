Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262246AbTEFBRv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 21:17:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262247AbTEFBRv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 21:17:51 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:64143 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262246AbTEFBRn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 21:17:43 -0400
Message-ID: <3EB70EEC.9040004@us.ibm.com>
Date: Mon, 05 May 2003 18:25:00 -0700
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>, Dave Hansen <haveblue@us.ibm.com>,
       Bill Hartner <bhartner@us.ibm.com>,
       Andrew Theurer <habanero@us.ibm.com>, Andrew Morton <akpm@zip.com.au>,
       Robert Love <rml@tech9.net>
CC: linux-kernel@vger.kernel.org
Subject: [patch] Re: Bug 619 - sched_best_cpu does not pick best cpu (1/2)
Content-Type: multipart/mixed;
 boundary="------------000102020206070302070504"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000102020206070302070504
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This patch is in regard to bugme.osdl.org bug 619, link here:

http://bugme.osdl.org/show_bug.cgi?id=619

This is the first of two patches to fix this bug.  This patch changes 
the nine files that #include <asm/topology.h> to #include 
<linux/topology.h>.  It also creates include/linux/topology.h, but 
solely as a shell.  The next patch fills it in.

[mcd@arrakis src]$ diffstat ~/patches/add_linux_topo.patch
  drivers/base/cpu.c        |    3 +--
  drivers/base/memblk.c     |    3 +--
  drivers/base/node.c       |    3 +--
  include/asm-i386/cpu.h    |    2 +-
  include/asm-i386/memblk.h |    2 +-
  include/asm-i386/node.h   |    3 +--
  include/linux/mmzone.h    |    2 +-
  include/linux/topology.h  |   32 ++++++++++++++++++++++++++++++++
  mm/page_alloc.c           |    3 +--
  mm/vmscan.c               |    2 +-
  10 files changed, 41 insertions(+), 14 deletions(-)

-Matt

--------------000102020206070302070504
Content-Type: text/plain;
 name="add_linux_topo.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="add_linux_topo.patch"

diff -Nur --exclude-from=/home/mcd/.dontdiff linux-2.5.69-vanilla/drivers/base/cpu.c linux-2.5.69-add_linux_topo/drivers/base/cpu.c
--- linux-2.5.69-vanilla/drivers/base/cpu.c	Sun May  4 16:53:09 2003
+++ linux-2.5.69-add_linux_topo/drivers/base/cpu.c	Mon May  5 17:17:39 2003
@@ -6,8 +6,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/cpu.h>
-
-#include <asm/topology.h>
+#include <linux/topology.h>
 
 
 struct class cpu_class = {
diff -Nur --exclude-from=/home/mcd/.dontdiff linux-2.5.69-vanilla/drivers/base/memblk.c linux-2.5.69-add_linux_topo/drivers/base/memblk.c
--- linux-2.5.69-vanilla/drivers/base/memblk.c	Sun May  4 16:53:57 2003
+++ linux-2.5.69-add_linux_topo/drivers/base/memblk.c	Mon May  5 17:17:39 2003
@@ -7,8 +7,7 @@
 #include <linux/init.h>
 #include <linux/memblk.h>
 #include <linux/node.h>
-
-#include <asm/topology.h>
+#include <linux/topology.h>
 
 
 static struct class memblk_class = {
diff -Nur --exclude-from=/home/mcd/.dontdiff linux-2.5.69-vanilla/drivers/base/node.c linux-2.5.69-add_linux_topo/drivers/base/node.c
--- linux-2.5.69-vanilla/drivers/base/node.c	Sun May  4 16:53:02 2003
+++ linux-2.5.69-add_linux_topo/drivers/base/node.c	Mon May  5 17:17:39 2003
@@ -7,8 +7,7 @@
 #include <linux/init.h>
 #include <linux/mm.h>
 #include <linux/node.h>
-
-#include <asm/topology.h>
+#include <linux/topology.h>
 
 
 static struct class node_class = {
diff -Nur --exclude-from=/home/mcd/.dontdiff linux-2.5.69-vanilla/include/asm-i386/cpu.h linux-2.5.69-add_linux_topo/include/asm-i386/cpu.h
--- linux-2.5.69-vanilla/include/asm-i386/cpu.h	Sun May  4 16:53:35 2003
+++ linux-2.5.69-add_linux_topo/include/asm-i386/cpu.h	Mon May  5 17:17:39 2003
@@ -3,8 +3,8 @@
 
 #include <linux/device.h>
 #include <linux/cpu.h>
+#include <linux/topology.h>
 
-#include <asm/topology.h>
 #include <asm/node.h>
 
 struct i386_cpu {
diff -Nur --exclude-from=/home/mcd/.dontdiff linux-2.5.69-vanilla/include/asm-i386/memblk.h linux-2.5.69-add_linux_topo/include/asm-i386/memblk.h
--- linux-2.5.69-vanilla/include/asm-i386/memblk.h	Sun May  4 16:53:31 2003
+++ linux-2.5.69-add_linux_topo/include/asm-i386/memblk.h	Mon May  5 17:17:39 2003
@@ -4,8 +4,8 @@
 #include <linux/device.h>
 #include <linux/mmzone.h>
 #include <linux/memblk.h>
+#include <linux/topology.h>
 
-#include <asm/topology.h>
 #include <asm/node.h>
 
 struct i386_memblk {
diff -Nur --exclude-from=/home/mcd/.dontdiff linux-2.5.69-vanilla/include/asm-i386/node.h linux-2.5.69-add_linux_topo/include/asm-i386/node.h
--- linux-2.5.69-vanilla/include/asm-i386/node.h	Sun May  4 16:53:08 2003
+++ linux-2.5.69-add_linux_topo/include/asm-i386/node.h	Mon May  5 17:17:39 2003
@@ -4,8 +4,7 @@
 #include <linux/device.h>
 #include <linux/mmzone.h>
 #include <linux/node.h>
-
-#include <asm/topology.h>
+#include <linux/topology.h>
 
 struct i386_node {
 	struct node node;
diff -Nur --exclude-from=/home/mcd/.dontdiff linux-2.5.69-vanilla/include/linux/mmzone.h linux-2.5.69-add_linux_topo/include/linux/mmzone.h
--- linux-2.5.69-vanilla/include/linux/mmzone.h	Sun May  4 16:53:31 2003
+++ linux-2.5.69-add_linux_topo/include/linux/mmzone.h	Mon May  5 17:17:39 2003
@@ -255,7 +255,7 @@
 #define MAX_NR_MEMBLKS	1
 #endif /* CONFIG_NUMA */
 
-#include <asm/topology.h>
+#include <linux/topology.h>
 /* Returns the number of the current Node. */
 #define numa_node_id()		(cpu_to_node(smp_processor_id()))
 
diff -Nur --exclude-from=/home/mcd/.dontdiff linux-2.5.69-vanilla/include/linux/topology.h linux-2.5.69-add_linux_topo/include/linux/topology.h
--- linux-2.5.69-vanilla/include/linux/topology.h	Wed Dec 31 16:00:00 1969
+++ linux-2.5.69-add_linux_topo/include/linux/topology.h	Mon May  5 17:43:35 2003
@@ -0,0 +1,32 @@
+/*
+ * include/linux/topology.h
+ *
+ * Written by: Matthew Dobson, IBM Corporation
+ *
+ * Copyright (C) 2002, IBM Corp.
+ *
+ * All rights reserved.          
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
+ * NON INFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ * Send feedback to <colpatch@us.ibm.com>
+ */
+#ifndef _LINUX_TOPOLOGY_H
+#define _LINUX_TOPOLOGY_H
+
+#include <asm/topology.h>
+
+#endif /* _LINUX_TOPOLOGY_H */
diff -Nur --exclude-from=/home/mcd/.dontdiff linux-2.5.69-vanilla/mm/page_alloc.c linux-2.5.69-add_linux_topo/mm/page_alloc.c
--- linux-2.5.69-vanilla/mm/page_alloc.c	Sun May  4 16:53:01 2003
+++ linux-2.5.69-add_linux_topo/mm/page_alloc.c	Mon May  5 17:17:39 2003
@@ -28,8 +28,7 @@
 #include <linux/blkdev.h>
 #include <linux/slab.h>
 #include <linux/notifier.h>
-
-#include <asm/topology.h>
+#include <linux/topology.h>
 
 DECLARE_BITMAP(node_online_map, MAX_NUMNODES);
 DECLARE_BITMAP(memblk_online_map, MAX_NR_MEMBLKS);
diff -Nur --exclude-from=/home/mcd/.dontdiff linux-2.5.69-vanilla/mm/vmscan.c linux-2.5.69-add_linux_topo/mm/vmscan.c
--- linux-2.5.69-vanilla/mm/vmscan.c	Sun May  4 16:53:02 2003
+++ linux-2.5.69-add_linux_topo/mm/vmscan.c	Mon May  5 17:17:39 2003
@@ -28,10 +28,10 @@
 #include <linux/pagevec.h>
 #include <linux/backing-dev.h>
 #include <linux/rmap-locking.h>
+#include <linux/topology.h>
 
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
-#include <asm/topology.h>
 #include <asm/div64.h>
 
 #include <linux/swapops.h>

--------------000102020206070302070504--

