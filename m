Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261694AbTDMTPP (for <rfc822;willy@w.ods.org>); Sun, 13 Apr 2003 15:15:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261695AbTDMTPP (for <rfc822;linux-kernel-outgoing>);
	Sun, 13 Apr 2003 15:15:15 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:19425 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S261694AbTDMTPN (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 13 Apr 2003 15:15:13 -0400
Date: Sun, 13 Apr 2003 15:23:54 -0400
From: Ben Collins <bcollins@debian.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Adrian Bunk <bunk@fs.tum.de>, linux-kernel@vger.kernel.org
Subject: [PATCH] Fix nodemgr.c compile (was Re: 2.5.67-mm2: ieee1394/nodemgr.c doesn't compile)
Message-ID: <20030413192354.GD16706@phunnypharm.org>
References: <20030412180852.77b6c5e8.akpm@digeo.com> <20030413125744.GN9640@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030413125744.GN9640@fs.tum.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The following compile error #ifdef CONFIG_IEEE1394_VERBOSEDEBUG seems to 
> come from Linus' tree:

Thanks, here's a patch.

Index: nodemgr.c
===================================================================
--- linux/drivers/ieee1394/nodemgr.c	(revision 862)
+++ linux/drivers/ieee1394/nodemgr.c	(working copy)
@@ -1010,34 +1010,7 @@
 		kfree(ud);
 }
 
-static void dump_directories (struct node_entry *ne)
-{
-#ifdef CONFIG_IEEE1394_VERBOSEDEBUG
-	struct list_head *l;
 
-	HPSB_DEBUG("vendor_id=0x%06x [%s], capabilities=0x%06x",
-		   ne->vendor_id, ne->vendor_name ?: "Unknown",
-		   ne->capabilities);
-	list_for_each (l, &ne->unit_directories) {
-		struct unit_directory *ud = list_entry (l, struct unit_directory, node_list);
-		HPSB_DEBUG("unit directory:");
-		if (ud->flags & UNIT_DIRECTORY_VENDOR_ID)
-			HPSB_DEBUG("  vendor_id=0x%06x [%s]",
-				   ud->vendor_id,
-				   ud->vendor_name ?: "Unknown");
-		if (ud->flags & UNIT_DIRECTORY_MODEL_ID)
-			HPSB_DEBUG("  model_id=0x%06x [%s]",
-				   ud->model_id,
-				   ud->model_name ?: "Unknown");
-		if (ud->flags & UNIT_DIRECTORY_SPECIFIER_ID)
-			HPSB_DEBUG("  sw_specifier_id=0x%06x ", ud->specifier_id);
-		if (ud->flags & UNIT_DIRECTORY_VERSION)
-			HPSB_DEBUG("  sw_version=0x%06x ", ud->version);
-	}
-#endif
-	return;
-}
-
 static void nodemgr_process_root_directory(struct host_info *hi, struct node_entry *ne)
 {
 	octlet_t address;
@@ -1104,8 +1077,6 @@
 			break;
 		}
 	}
-
-	dump_directories(ne);
 }
 
 #ifdef CONFIG_HOTPLUG
