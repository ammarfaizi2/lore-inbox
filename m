Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267184AbTAFW2n>; Mon, 6 Jan 2003 17:28:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267192AbTAFW2n>; Mon, 6 Jan 2003 17:28:43 -0500
Received: from [195.39.17.254] ([195.39.17.254]:7172 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S267184AbTAFW2m>;
	Mon, 6 Jan 2003 17:28:42 -0500
Date: Mon, 6 Jan 2003 23:35:51 +0100
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>, torvalds@transmeta.com
Subject: Fix s4 in 2.5.54
Message-ID: <20030106223550.GA2510@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Andrew's drain_local_pages support enables swsusp to work again,
please apply, 
							Pavel

--- clean/kernel/suspend.c	2002-12-18 22:21:13.000000000 +0100
+++ linux-swsusp/kernel/suspend.c	2002-12-23 18:58:51.000000000 +0100
@@ -680,6 +680,8 @@
 	struct sysinfo i;
 	unsigned int nr_needed_pages = 0;
 
+	drain_local_pages();
+
 	pagedir_nosave = NULL;
 	printk( "/critical section: Counting pages to copy" );
 	nr_copy_pages = count_and_copy_data_pages(NULL);
@@ -714,6 +716,7 @@
 	nr_copy_pages_check = nr_copy_pages;
 	pagedir_order_check = pagedir_order;
 
+	drain_local_pages();	/* During allocating of suspend pagedir, new cold pages may appear. Kill them */
 	if (nr_copy_pages != count_and_copy_data_pages(pagedir_nosave))	/* copy */
 		BUG();
 

-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
