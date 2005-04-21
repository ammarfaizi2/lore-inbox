Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261287AbVDULRd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261287AbVDULRd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 07:17:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261298AbVDULRc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 07:17:32 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:19077 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261287AbVDULRO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 07:17:14 -0400
Date: Thu, 21 Apr 2005 13:13:46 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: [patch] properly stop devices before poweroff
Message-ID: <20050421111346.GA21421@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Without this patch, Linux provokes emergency disk shutdowns and
similar nastiness. It was in SuSE kernels for some time, IIRC.

Signed-off-by: Pavel Machek <pavel@suse.cz>

--- clean/kernel/sys.c	2005-03-19 00:32:32.000000000 +0100
+++ linux/kernel/sys.c	2005-03-22 12:20:53.000000000 +0100
@@ -404,6 +404,7 @@
 	case LINUX_REBOOT_CMD_HALT:
 		notifier_call_chain(&reboot_notifier_list, SYS_HALT, NULL);
 		system_state = SYSTEM_HALT;
+		device_suspend(PMSG_SUSPEND);
 		device_shutdown();
 		printk(KERN_EMERG "System halted.\n");
 		machine_halt();
@@ -414,6 +415,7 @@
 	case LINUX_REBOOT_CMD_POWER_OFF:
 		notifier_call_chain(&reboot_notifier_list, SYS_POWER_OFF, NULL);
 		system_state = SYSTEM_POWER_OFF;
+		device_suspend(PMSG_SUSPEND);
 		device_shutdown();
 		printk(KERN_EMERG "Power down.\n");
 		machine_power_off();
@@ -430,6 +432,7 @@
 
 		notifier_call_chain(&reboot_notifier_list, SYS_RESTART, buffer);
 		system_state = SYSTEM_RESTART;
+		device_suspend(PMSG_FREEZE);
 		device_shutdown();
 		printk(KERN_EMERG "Restarting system with command '%s'.\n", buffer);
 		machine_restart(buffer);

-- 
Boycott Kodak -- for their patent abuse against Java.
