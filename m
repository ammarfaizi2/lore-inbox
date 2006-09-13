Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751189AbWIMUwP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751189AbWIMUwP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 16:52:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751190AbWIMUwP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 16:52:15 -0400
Received: from mx1.redhat.com ([66.187.233.31]:48779 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751189AbWIMUwO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 16:52:14 -0400
Date: Wed, 13 Sep 2006 17:52:03 -0300
From: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH -mm] 8250: remove not needed NMI watchdog tickle in serial8250_console_write()
Message-ID: <20060913205203.GC4787@cathedrallabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When touch_nmi_watchdog() was added to inside the wait loop in
wait_for_xmitr()[1], where the long delays come from, a unneeded
touch_nmi_watchdog() call was left in the beginning of
serial8250_console_write() (introduced in
78512ece148992a5c00c63fbf4404f3cde635016) and this patch reverts it.

[1] http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc6/2.6.18-rc6-mm2/broken-out/tickle-nmi-watchdog-on-serial-output.patch
    http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc6/2.6.18-rc6-mm2/broken-out/tickle-nmi-watchdog-on-serial-output-fix.patch
[2] http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=78512ece148992a5c00c63fbf4404f3cde635016;hp=0ad775dbba12de3b7d25f586efe81ad995ca75a7

Signed-off-by: Aristeu S. Rozanski F. <aris@cathedrallabs.org>

--- mm.orig/drivers/serial/8250.c	2006-09-13 17:26:53.000000000 -0300
+++ mm/drivers/serial/8250.c	2006-09-13 17:27:14.000000000 -0300
@@ -2263,8 +2263,6 @@
 	unsigned int ier;
 	int locked = 1;
 
-	touch_nmi_watchdog();
-
 	local_irq_save(flags);
 	if (up->port.sysrq) {
 		/* serial8250_handle_port() already took the lock */
