Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751357AbWIYVIi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751357AbWIYVIi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 17:08:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751005AbWIYVIi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 17:08:38 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:7035 "EHLO
	dwalker1.mvista.com") by vger.kernel.org with ESMTP
	id S1751346AbWIYVIf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 17:08:35 -0400
Message-Id: <20060925210710.931336000@mvista.com>
User-Agent: quilt/0.45-1
Date: Mon, 25 Sep 2006 14:07:10 -0700
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
From: dwalker@mvista.com
Subject: [PATCH -mm] console: console_drivers not initialized
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was doing -rt stuff on a PPC PowerBook G4. It would always reboot
itself when it hit console_init() .

I noticed that the console code seems to want console_drivers = NULL,
but it never actually sets it that way. Once I added this, the reboot 
issue was gone..

Signed-Off-By: Daniel Walker <dwalker@mvista.com>

Index: linux-2.6.18/kernel/printk.c
===================================================================
--- linux-2.6.18.orig/kernel/printk.c
+++ linux-2.6.18/kernel/printk.c
@@ -68,7 +68,7 @@ EXPORT_SYMBOL(oops_in_progress);
  */
 static DECLARE_MUTEX(console_sem);
 static DECLARE_MUTEX(secondary_console_sem);
-struct console *console_drivers;
+struct console *console_drivers = NULL;
 /*
  * This is used for debugging the mess that is the VT code by
  * keeping track if we have the console semaphore held. It's
--
