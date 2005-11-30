Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750898AbVK3EXc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750898AbVK3EXc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 23:23:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750903AbVK3EXb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 23:23:31 -0500
Received: from mx1.redhat.com ([66.187.233.31]:11458 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750898AbVK3EXb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 23:23:31 -0500
Date: Tue, 29 Nov 2005 23:23:30 -0500
From: Dave Jones <davej@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: printk levels for spinlock debug.
Message-ID: <20051130042330.GA22019@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Dave Jones <davej@redhat.com>

--- vanilla/lib/spinlock_debug.c~	2005-11-29 23:21:14.000000000 -0500
+++ vanilla/lib/spinlock_debug.c	2005-11-29 23:21:49.000000000 -0500
@@ -19,9 +19,9 @@ static void spin_bug(spinlock_t *lock, c
 	if (xchg(&print_once, 0)) {
 		if (lock->owner && lock->owner != SPINLOCK_OWNER_INIT)
 			owner = lock->owner;
-		printk("BUG: spinlock %s on CPU#%d, %s/%d\n",
+		printk(KERN_EMERG "BUG: spinlock %s on CPU#%d, %s/%d\n",
 			msg, smp_processor_id(), current->comm, current->pid);
-		printk(" lock: %p, .magic: %08x, .owner: %s/%d, .owner_cpu: %d\n",
+		printk(KERN_EMERG " lock: %p, .magic: %08x, .owner: %s/%d, .owner_cpu: %d\n",
 			lock, lock->magic,
 			owner ? owner->comm : "<none>",
 			owner ? owner->pid : -1,
@@ -77,7 +77,7 @@ static void __spin_lock_debug(spinlock_t
 		/* lockup suspected: */
 		if (print_once) {
 			print_once = 0;
-			printk("BUG: spinlock lockup on CPU#%d, %s/%d, %p\n",
+			printk(KERN_EMERG "BUG: spinlock lockup on CPU#%d, %s/%d, %p\n",
 				smp_processor_id(), current->comm, current->pid,
 					lock);
 			dump_stack();
@@ -119,7 +119,7 @@ static void rwlock_bug(rwlock_t *lock, c
 	static long print_once = 1;
 
 	if (xchg(&print_once, 0)) {
-		printk("BUG: rwlock %s on CPU#%d, %s/%d, %p\n", msg,
+		printk(KERN_EMERG "BUG: rwlock %s on CPU#%d, %s/%d, %p\n", msg,
 			smp_processor_id(), current->comm, current->pid, lock);
 		dump_stack();
 #ifdef CONFIG_SMP
@@ -147,7 +147,7 @@ static void __read_lock_debug(rwlock_t *
 		/* lockup suspected: */
 		if (print_once) {
 			print_once = 0;
-			printk("BUG: read-lock lockup on CPU#%d, %s/%d, %p\n",
+			printk(KERN_EMERG "BUG: read-lock lockup on CPU#%d, %s/%d, %p\n",
 				smp_processor_id(), current->comm, current->pid,
 					lock);
 			dump_stack();
@@ -219,7 +219,7 @@ static void __write_lock_debug(rwlock_t 
 		/* lockup suspected: */
 		if (print_once) {
 			print_once = 0;
-			printk("BUG: write-lock lockup on CPU#%d, %s/%d, %p\n",
+			printk(KERN_EMERG "BUG: write-lock lockup on CPU#%d, %s/%d, %p\n",
 				smp_processor_id(), current->comm, current->pid,
 					lock);
 			dump_stack();
