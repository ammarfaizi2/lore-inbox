Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261276AbVDBVLF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261276AbVDBVLF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 16:11:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261294AbVDBVLE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 16:11:04 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:28845 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261276AbVDBVIl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 16:08:41 -0500
Date: Sat, 2 Apr 2005 23:08:09 +0200
From: Pavel Machek <pavel@suse.cz>
To: ak@suse.de, kernel list <linux-kernel@vger.kernel.org>
Subject: Fix u32 vs. pm_message_t in x86-64
Message-ID: <20050402210809.GA2025@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I thought I'm done with fixing u32 vs. pm_message_t ... unfortunately
that turned out not to be the case... Here are fixes x86-64. [These
patches are independend and change no object code; therefore not
numbered].

Please apply,

Signed-off-by: Pavel Machek <pavel@suse.cz>
                                                        Pavel

--- clean-cvs/arch/x86_64/kernel/apic.c	2005-03-29 13:29:28.000000000 +0200
+++ linux-cvs/arch/x86_64/kernel/apic.c	2005-03-31 23:54:43.000000000 +0200
@@ -457,7 +457,7 @@
 	unsigned int apic_thmr;
 } apic_pm_state;
 
-static int lapic_suspend(struct sys_device *dev, u32 state)
+static int lapic_suspend(struct sys_device *dev, pm_message_t state)
 {
 	unsigned long flags;
 
--- clean-cvs/arch/x86_64/kernel/i8259.c	2005-03-31 23:32:33.000000000 +0200
+++ linux-cvs/arch/x86_64/kernel/i8259.c	2005-03-31 23:54:43.000000000 +0200
@@ -409,7 +409,7 @@
 	return 0;
 }
 
-static int i8259A_suspend(struct sys_device *dev, u32 state)
+static int i8259A_suspend(struct sys_device *dev, pm_message_t state)
 {
 	save_ELCR(irq_trigger);
 	return 0;
--- clean-cvs/arch/x86_64/kernel/io_apic.c	2005-03-29 13:29:28.000000000 +0200
+++ linux-cvs/arch/x86_64/kernel/io_apic.c	2005-03-31 23:54:43.000000000 +0200
@@ -1712,7 +1712,7 @@
 };
 static struct sysfs_ioapic_data * mp_ioapic_data[MAX_IO_APICS];
 
-static int ioapic_suspend(struct sys_device *dev, u32 state)
+static int ioapic_suspend(struct sys_device *dev, pm_message_t state)
 {
 	struct IO_APIC_route_entry *entry;
 	struct sysfs_ioapic_data *data;
--- clean-cvs/arch/x86_64/kernel/nmi.c	2005-01-31 00:26:51.000000000 +0100
+++ linux-cvs/arch/x86_64/kernel/nmi.c	2005-03-31 23:54:43.000000000 +0200
@@ -254,7 +254,7 @@
 
 static int nmi_pm_active; /* nmi_active before suspend */
 
-static int lapic_nmi_suspend(struct sys_device *dev, u32 state)
+static int lapic_nmi_suspend(struct sys_device *dev, pm_message_t state)
 {
 	nmi_pm_active = nmi_active;
 	disable_lapic_nmi_watchdog();
--- clean-cvs/arch/x86_64/kernel/time.c	2005-03-31 23:32:33.000000000 +0200
+++ linux-cvs/arch/x86_64/kernel/time.c	2005-03-31 23:54:43.000000000 +0200
@@ -957,7 +957,7 @@
 static long clock_cmos_diff;
 static unsigned long sleep_start;
 
-static int timer_suspend(struct sys_device *dev, u32 state)
+static int timer_suspend(struct sys_device *dev, pm_message_t state)
 {
 	/*
 	 * Estimate time zone so that set_time can update the clock


-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
