Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751269AbWGDKep@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751269AbWGDKep (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 06:34:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751272AbWGDKeo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 06:34:44 -0400
Received: from ns2.suse.de ([195.135.220.15]:56463 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751269AbWGDKeo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 06:34:44 -0400
From: Andi Kleen <ak@suse.de>
To: akpm@osdl.org, linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Minor cleanup to lockdep.c
Date: Tue, 4 Jul 2006 12:34:30 +0200
User-Agent: KMail/1.9.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607041234.30350.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


- Use printk formatting for indentation
- Don't leave NTFS in the default event filter

Signed-off-by: Andi Kleen <ak@suse.de>

Index: linux-2.6.17-git22-work/kernel/lockdep.c
===================================================================
--- linux-2.6.17-git22-work.orig/kernel/lockdep.c
+++ linux-2.6.17-git22-work/kernel/lockdep.c
@@ -169,22 +169,17 @@ EXPORT_SYMBOL(lockdep_internal);
  */
 static int class_filter(struct lock_class *class)
 {
+#if 0
+	/* Example */	
 	if (class->name_version == 1 &&
-			!strcmp(class->name, "&rl->lock"))
+			!strcmp(class->name, "lockname"))
 		return 1;
 	if (class->name_version == 1 &&
-			!strcmp(class->name, "&ni->mrec_lock"))
+			!strcmp(class->name, "&struct->lockfield"))
 		return 1;
-	if (class->name_version == 1 &&
-			!strcmp(class->name, "mft_ni_runlist_lock"))
-		return 1;
-	if (class->name_version == 1 &&
-			!strcmp(class->name, "mft_ni_mrec_lock"))
-		return 1;
-	if (class->name_version == 1 &&
-			!strcmp(class->name, "&vol->lcnbmp_lock"))
-		return 1;
-	return 0;
+#endif
+	/* Allow everything else. 0 would be filter everything else */
+	return 1;	
 }
 #endif
 
@@ -408,23 +403,12 @@ static void lockdep_print_held_locks(str
 		print_lock(curr->held_locks + i);
 	}
 }
-/*
- * Helper to print a nice hierarchy of lock dependencies:
- */
-static void print_spaces(int nr)
-{
-	int i;
-
-	for (i = 0; i < nr; i++)
-		printk("  ");
-}
 
 static void print_lock_class_header(struct lock_class *class, int depth)
 {
 	int bit;
 
-	print_spaces(depth);
-	printk("->");
+	printk("%*s->", depth, "");
 	print_lock_name(class);
 	printk(" ops: %lu", class->ops);
 	printk(" {\n");
@@ -433,17 +417,14 @@ static void print_lock_class_header(stru
 		if (class->usage_mask & (1 << bit)) {
 			int len = depth;
 
-			print_spaces(depth);
-			len += printk("   %s", usage_str[bit]);
+			len += printk("%*s   %s", depth, "", usage_str[bit]);
 			len += printk(" at:\n");
 			print_stack_trace(class->usage_traces + bit, len);
 		}
 	}
-	print_spaces(depth);
-	printk(" }\n");
+	printk("%*s }\n", depth, "");
 
-	print_spaces(depth);
-	printk(" ... key      at: ");
+	printk("%*s ... key      at: ",depth,"");
 	print_ip_sym((unsigned long)class->key);
 }
 
@@ -463,8 +444,7 @@ static void print_lock_dependencies(stru
 		DEBUG_LOCKS_WARN_ON(!entry->class);
 		print_lock_dependencies(entry->class, depth + 1);
 
-		print_spaces(depth);
-		printk(" ... acquired at:\n");
+		printk("%*s ... acquired at:\n",depth,"");
 		print_stack_trace(&entry->trace, 2);
 		printk("\n");
 	}
