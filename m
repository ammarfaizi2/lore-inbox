Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271459AbRHPEl0>; Thu, 16 Aug 2001 00:41:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271461AbRHPElK>; Thu, 16 Aug 2001 00:41:10 -0400
Received: from trained-monkey.org ([209.217.122.11]:34296 "EHLO
	savage.trained-monkey.org") by vger.kernel.org with ESMTP
	id <S271459AbRHPEk6>; Thu, 16 Aug 2001 00:40:58 -0400
Date: Thu, 16 Aug 2001 00:39:03 -0400
Message-Id: <200108160439.f7G4d3b19502@savage.trained-monkey.org>
From: <jes@trained-monkey.org>
To: bcollins@debian.net
CC: torvalds@transmeta.com, alan@redhat.com, linux-kernel@vger.kernel.org
Subject: [patch] 64 bit locking in ieee1394/nodemgr.c
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

The drivers/ieee1394/nodemgr.c driver tries to save cpu_flags in a 32
bit type which is kinda bad.

Here is a patch.

Jes

--- drivers/ieee1394/nodemgr.c~	Wed Aug  8 00:08:04 2001
+++ drivers/ieee1394/nodemgr.c	Thu Aug 16 00:37:15 2001
@@ -208,7 +208,7 @@
         nodeid_t nodeid = LOCAL_BUS;
 	quadlet_t buffer[5], quad;
 	octlet_t base = CSR_REGISTER_BASE + CSR_CONFIG_ROM;
-	int flags;
+	unsigned long flags;
 
 	/* We need to detect when the ConfigROM's generation has changed,
 	 * so we only update the node's info when it needs to be.  */
@@ -389,7 +389,7 @@
 static void nodemgr_add_host(struct hpsb_host *host)
 {
 	struct host_info *hi = kmalloc (sizeof (struct host_info), GFP_KERNEL);
-	int flags;
+	unsigned long flags;
 
 	if (!hi) {
 		HPSB_ERR ("Out of memory in Node Manager");
@@ -416,7 +416,7 @@
 {
 	struct list_head *lh;
 	struct host_info *hi = NULL;
-	int flags;
+	unsigned long flags;
 
 	spin_lock_irqsave (&host_info_lock, flags);
 	lh = host_info_list.next;
@@ -451,7 +451,7 @@
 	struct list_head *lh;
 	struct host_info *hi = NULL;
 	struct node_entry *ne;
-	int flags;
+	unsigned long flags;
 
 	/* First remove all node entries for this host */
 	write_lock_irqsave(&node_lock, flags);
