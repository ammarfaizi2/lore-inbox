Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161078AbWF0PFy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161078AbWF0PFy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 11:05:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161080AbWF0PFy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 11:05:54 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:29148 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1161078AbWF0PFy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 11:05:54 -0400
Subject: PATCH: further small stallion fix.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 27 Jun 2006 16:22:05 +0100
Message-Id: <1151421725.32186.22.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alan Cox <alan@redhat.com>

Works better on SMP if...

--- linux-2.6.17/drivers/char/stallion.c~	2006-06-27 15:40:12.890919856 +0100
+++ linux-2.6.17/drivers/char/stallion.c	2006-06-27 15:41:29.857219200 +0100
@@ -3029,6 +3029,9 @@
 	int i;
 	printk(KERN_INFO "%s: version %s\n", stl_drvtitle, stl_drvversion);
 
+	spin_lock_init(&stallion_lock);
+	spin_lock_init(&brd_lock);
+	
 	stl_initbrds();
 
 	stl_serial = alloc_tty_driver(STL_MAXBRDS * STL_MAXPORTS);

