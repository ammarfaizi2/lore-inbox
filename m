Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261186AbVALNXL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261186AbVALNXL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 08:23:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261180AbVALNXH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 08:23:07 -0500
Received: from gprs214-158.eurotel.cz ([160.218.214.158]:2029 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261186AbVALNV2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 08:21:28 -0500
Date: Wed, 12 Jan 2005 14:21:12 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: make suspend work with ioapic
Message-ID: <20050112132112.GA1562@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

IRQ balancing daemon needs try_to_freeze(). Please apply,
								Pavel

--- clean/arch/i386/kernel/io_apic.c	2004-12-25 13:34:57.000000000 +0100
+++ linux/arch/i386/kernel/io_apic.c	2004-12-25 15:51:05.000000000 +0100
@@ -573,6 +573,7 @@
 	for ( ; ; ) {
 		set_current_state(TASK_INTERRUPTIBLE);
 		time_remaining = schedule_timeout(time_remaining);
+		try_to_freeze(PF_FREEZE);
 		if (time_after(jiffies,
 				prev_balance_time+balanced_irq_interval)) {
 			do_irq_balance();

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
