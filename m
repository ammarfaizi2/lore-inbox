Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932211AbWISF5p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932211AbWISF5p (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 01:57:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932190AbWISF5p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 01:57:45 -0400
Received: from outbound0.mx.meer.net ([209.157.153.23]:2824 "EHLO
	outbound0.sv.meer.net") by vger.kernel.org with ESMTP
	id S932242AbWISF5o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 01:57:44 -0400
Subject: Re: [patch 6/8] debugfs entries for configuration
From: Don Mullis <dwm@meer.net>
To: Akinobu Mita <mita@miraclelinux.com>
Cc: linux-kernel@vger.kernel.org, ak@suse.de, akpm@osdl.org
In-Reply-To: <20060914102032.633059366@localhost.localdomain>
References: <20060914102012.251231177@localhost.localdomain>
	 <20060914102032.633059366@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 18 Sep 2006 22:52:39 -0700
Message-Id: <1158645159.2419.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Factor out process-filter functionality, move later in series to
process-filter-specific patch.


Signed-off-by: Don Mullis <dwm@meer.net>

---
 lib/fault-inject-debugfs.c |   11 -----------
 1 file changed, 11 deletions(-)

Index: linux-2.6.17/lib/fault-inject-debugfs.c
===================================================================
--- linux-2.6.17.orig/lib/fault-inject-debugfs.c
+++ linux-2.6.17/lib/fault-inject-debugfs.c
@@ -8,7 +8,6 @@ struct fault_attr_entries {
 	struct dentry *interval_file;
 	struct dentry *times_file;
 	struct dentry *space_file;
-	struct dentry *process_filter_file;
 };
 
 static void debugfs_ul_set(void *data, u64 val)
@@ -67,10 +66,6 @@ static void cleanup_fault_attr_entries(s
 			debugfs_remove(entries->space_file);
 			entries->space_file = NULL;
 		}
-		if (entries->process_filter_file) {
-			debugfs_remove(entries->process_filter_file);
-			entries->process_filter_file = NULL;
-		}
 		debugfs_remove(entries->dir);
 		entries->dir = NULL;
 	}
@@ -110,12 +105,6 @@ static int init_fault_attr_entries(struc
 		goto fail;
 	entries->space_file = file;
 
-	file = debugfs_create_bool("process-filter", mode, dir,
-				   &attr->process_filter);
-	if (!file)
-		goto fail;
-	entries->process_filter_file = file;
-
 	return 0;
 fail:
 	cleanup_fault_attr_entries(entries);


