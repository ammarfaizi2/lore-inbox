Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262121AbUCETq2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 14:46:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262691AbUCETq2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 14:46:28 -0500
Received: from mail2.efi.com ([192.68.228.89]:22802 "EHLO
	fcexgw02.efi.internal") by vger.kernel.org with ESMTP
	id S262121AbUCETq0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 14:46:26 -0500
Subject: [PATCH 2.6.3] swsusp.c - Serial Console
From: Frederic Roussel <frederic.roussel@efi.com>
To: pavel@suse.cz, linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1078515963.4686.193.camel@frasc.efi.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 05 Mar 2004 11:46:03 -0800
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 Mar 2004 19:46:03.0885 (UTC) FILETIME=[7E5D19D0:01C402EA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

That's a very simple patch to allow swsusp on systems with serial
console only.

Please apply.

Thanks

--- linux-2.6.3/kernel/power/swsusp.c	2004-03-05 11:22:05.000000000
-0800
+++ linux/kernel/power/swsusp.c	2004-03-05 11:22:30.000000000 -0800
@@ -610,9 +610,11 @@
 	spin_unlock_irq(&suspend_pagedir_lock);
 	device_resume();
 
+#ifdef SUSPEND_CONSOLE
 	acquire_console_sem();
 	update_screen(fg_console);	/* Hmm, is this the problem? */
 	release_console_sem();
+#endif
 
 	PRINTK( "Fixing swap signatures... " );
 	mark_swapfiles(((swp_entry_t) {0}), MARK_SWAP_RESUME);


-- 
Frederic.R.Roussel         -o)                                    (o-
                           /\\  Join the penguin force  (o_  (o_  //\
                          _\_v   The Linux G3N3R47!0N   (/)_ (/)_ v_/_


