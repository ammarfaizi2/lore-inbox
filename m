Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262047AbUB2NES (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 08:04:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262048AbUB2NES
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 08:04:18 -0500
Received: from gprs154-126.eurotel.cz ([160.218.154.126]:6528 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262047AbUB2NEQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 08:04:16 -0500
Date: Sun, 29 Feb 2004 14:04:05 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: swsusp: fix error handling in "not enough swap space"
Message-ID: <20040229130405.GA453@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Without this, if there's not enough swapspace, suspend fails, but
leaves devices suspended, leading to dead machine. Please apply,

							Pavel

--- tmp/linux/kernel/power/swsusp.c	2004-02-29 13:42:02.000000000 +0100
+++ linux/kernel/power/swsusp.c	2004-02-29 00:34:31.000000000 +0100
@@ -683,7 +683,11 @@
 
 	free_pages((unsigned long) pagedir_nosave, pagedir_order);
 	spin_unlock_irq(&suspend_pagedir_lock);
+
+	device_resume();
+	PRINTK( "Fixing swap signatures... " );
 	mark_swapfiles(((swp_entry_t) {0}), MARK_SWAP_RESUME);
+	PRINTK( "ok\n" );	
 }
 
 /*

 
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
