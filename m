Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262506AbVAPN6t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262506AbVAPN6t (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 08:58:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262507AbVAPN5r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 08:57:47 -0500
Received: from out006pub.verizon.net ([206.46.170.106]:46989 "EHLO
	out006.verizon.net") by vger.kernel.org with ESMTP id S262508AbVAPNw7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 08:52:59 -0500
From: James Nelson <james4765@cwazy.co.uk>
To: linux-kernel@vger.kernel.org, kernel-janitors@lists.osdl.org
Cc: akpm@osdl.org, James Nelson <james4765@cwazy.co.uk>
Message-Id: <20050116135256.30109.54745.20646@localhost.localdomain>
In-Reply-To: <20050116135223.30109.26479.55757@localhost.localdomain>
References: <20050116135223.30109.26479.55757@localhost.localdomain>
Subject: [PATCH 5/13] generic_serial: remove cli()/sti() in drivers/char/generic_serial.c
X-Authentication-Info: Submitted using SMTP AUTH at out006.verizon.net from [209.158.220.243] at Sun, 16 Jan 2005 07:52:56 -0600
Date: Sun, 16 Jan 2005 07:52:58 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: James Nelson <james4765@gmail.com>

diff -urN --exclude='*~' linux-2.6.11-rc1-mm1-original/drivers/char/generic_serial.c linux-2.6.11-rc1-mm1/drivers/char/generic_serial.c
--- linux-2.6.11-rc1-mm1-original/drivers/char/generic_serial.c	2005-01-16 07:19:12.000000000 -0500
+++ linux-2.6.11-rc1-mm1/drivers/char/generic_serial.c	2005-01-16 07:32:19.299556404 -0500
@@ -53,8 +53,8 @@
 #define RELEASEIT up (&port->port_write_sem);
 #else
 #define DECL      unsigned long flags;
-#define LOCKIT    save_flags (flags);cli ()
-#define RELEASEIT restore_flags (flags)
+#define LOCKIT    local_irq_save (flags)
+#define RELEASEIT local_irq_restore (flags)
 #endif
 
 #define RS_EVENT_WRITE_WAKEUP	1
@@ -211,7 +211,7 @@
 
 	local_save_flags(flags);
 	while (1) {
-		cli();
+		local_irq_disable();
 		c = count;
 
 		/* This is safe because we "OWN" the "head". Noone else can 
