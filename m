Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271125AbTHQWad (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 18:30:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271129AbTHQWac
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 18:30:32 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:56635 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP id S271125AbTHQWab
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 18:30:31 -0400
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: Russell King <rmk@arm.linux.org.uk>, Christoph Hellwig <hch@infradead.org>,
       Patrick Mochel <mochel@osdl.org>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] don't call device_shutdown on halt.
References: <m1he4kzpiy.fsf@frodo.biederman.org>
	<20030814085442.A21232@infradead.org>
	<20030814090605.A25516@flint.arm.linux.org.uk>
	<m17k5gz1aq.fsf@frodo.biederman.org>
	<20030814170721.B332@flint.arm.linux.org.uk>
	<m1wudgxiab.fsf@frodo.biederman.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 17 Aug 2003 16:26:36 -0600
In-Reply-To: <m1wudgxiab.fsf@frodo.biederman.org>
Message-ID: <m1fzjzyl7n.fsf_-_@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For a halt quiescing devices is overkill, historically wrong, and
error prone when the system is halted.  The only drivers that should
care are drivers for devices that do the wrong thing when power is
removed.

diff -uNr linux-2.6.0-test3/kernel/sys.c linux-2.6.0-test3-no_device_shutdown/kernel/sys.c
--- linux-2.6.0-test3/kernel/sys.c	Tue Jul 29 14:48:17 2003
+++ linux-2.6.0-test3-no_device_shutdown/kernel/sys.c	Sun Aug 17 22:04:18 2003
@@ -423,7 +423,6 @@
 	case LINUX_REBOOT_CMD_HALT:
 		notifier_call_chain(&reboot_notifier_list, SYS_HALT, NULL);
 		system_running = 0;
-		device_shutdown();
 		printk(KERN_EMERG "System halted.\n");
 		machine_halt();
 		unlock_kernel();
@@ -433,7 +432,6 @@
 	case LINUX_REBOOT_CMD_POWER_OFF:
 		notifier_call_chain(&reboot_notifier_list, SYS_POWER_OFF, NULL);
 		system_running = 0;
-		device_shutdown();
 		printk(KERN_EMERG "Power down.\n");
 		machine_power_off();
 		unlock_kernel();

