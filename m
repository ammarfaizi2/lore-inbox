Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261560AbVGDHWN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261560AbVGDHWN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 03:22:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261601AbVGDHWM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 03:22:12 -0400
Received: from cantor2.suse.de ([195.135.220.15]:32747 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261560AbVGDHSN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 03:18:13 -0400
Message-ID: <42C8D83A.70705@suse.de>
Date: Mon, 04 Jul 2005 08:33:30 +0200
From: Stefan Seyfried <seife@suse.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041207 Thunderbird/1.0 Mnenhy/0.7.2.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] call device_shutdown with interrupts enabled
References: <20050703214929.GA9214@elf.ucw.cz>
In-Reply-To: <20050703214929.GA9214@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Do not call device_shutdown with interrupts disabled. It is wrong and
> produces ugly warnings.

Hm. How about (possible whitespace damage):

--- linux/kernel/power/disk.c~	2005-07-04 08:26:47.000000000 +0200
+++ linux/kernel/power/disk.c	2005-07-04 08:27:45.000000000 +0200
@@ -53,19 +53,17 @@ static void power_down(suspend_disk_meth
 	unsigned long flags;
 	int error = 0;

+	device_shutdown();
 	local_irq_save(flags);
 	switch(mode) {
 	case PM_DISK_PLATFORM:
- 		device_shutdown();
 		error = pm_ops->enter(PM_SUSPEND_DISK);
 		break;
 	case PM_DISK_SHUTDOWN:
 		printk("Powering off system\n");
-		device_shutdown();
 		machine_power_off();
 		break;
 	case PM_DISK_REBOOT:
-		device_shutdown();
 		machine_restart(NULL);
 		break;
 	}


-- 
Stefan Seyfried                  \ "I didn't want to write for pay. I
QA / R&D Team Mobile Devices      \ wanted to be paid for what I write."
SUSE LINUX Products GmbH, Nürnberg \                    -- Leonard Cohen

