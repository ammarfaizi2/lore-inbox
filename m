Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263024AbUGQWpa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263024AbUGQWpa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jul 2004 18:45:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262932AbUGQWpG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jul 2004 18:45:06 -0400
Received: from digitalimplant.org ([64.62.235.95]:61417 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S263024AbUGQWgU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jul 2004 18:36:20 -0400
Date: Sat, 17 Jul 2004 15:36:09 -0700 (PDT)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: linux-kernel@vger.kernel.org
cc: pavel@ucw.cz
Subject: [23/25] Merge pmdisk and swsusp
Message-ID: <Pine.LNX.4.50.0407171532360.22290-100000@monsoon.he.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ChangeSet 1.1865, 2004/07/17 13:52:19-07:00, mochel@digitalimplant.org

[swsusp] Remove unneeded suspend_pagedir_lock.


 kernel/power/swsusp.c |    6 ------
 1 files changed, 6 deletions(-)


diff -Nru a/kernel/power/swsusp.c b/kernel/power/swsusp.c
--- a/kernel/power/swsusp.c	2004-07-17 14:50:29 -07:00
+++ b/kernel/power/swsusp.c	2004-07-17 14:50:29 -07:00
@@ -81,9 +81,6 @@

 extern int is_head_of_free_region(struct page *);

-/* Locks */
-spinlock_t suspend_pagedir_lock __nosavedata = SPIN_LOCK_UNLOCKED;
-
 /* Variables to be preserved over suspend */
 int pagedir_order_check;
 int nr_copy_pages_check;
@@ -908,10 +905,7 @@

 static void suspend_finish(void)
 {
-	spin_lock_irq(&suspend_pagedir_lock);	/* Done to disable interrupts */
-
 	free_pages((unsigned long) pagedir_nosave, pagedir_order);
-	spin_unlock_irq(&suspend_pagedir_lock);

 #ifdef CONFIG_HIGHMEM
 	printk( "Restoring highmem\n" );
