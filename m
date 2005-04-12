Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262215AbVDLTGo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262215AbVDLTGo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 15:06:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262217AbVDLTFb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 15:05:31 -0400
Received: from fire.osdl.org ([65.172.181.4]:51401 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262215AbVDLKch (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:32:37 -0400
Message-Id: <200504121032.j3CAWPKZ005589@shell0.pdx.osdl.net>
Subject: [patch 113/198] Fix u32 vs. pm_message_t in x86-64
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, pavel@suse.cz
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:32:19 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Pavel Machek <pavel@suse.cz>

I thought I'm done with fixing u32 vs.  pm_message_t ...  unfortunately that
turned out not to be the case...  Here are fixes x86-64.

Signed-off-by: Pavel Machek <pavel@suse.cz>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/arch/x86_64/kernel/apic.c    |    2 +-
 25-akpm/arch/x86_64/kernel/i8259.c   |    2 +-
 25-akpm/arch/x86_64/kernel/io_apic.c |    2 +-
 25-akpm/arch/x86_64/kernel/nmi.c     |    2 +-
 25-akpm/arch/x86_64/kernel/time.c    |    2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff -puN arch/x86_64/kernel/apic.c~fix-u32-vs-pm_message_t-in-x86-64 arch/x86_64/kernel/apic.c
--- 25/arch/x86_64/kernel/apic.c~fix-u32-vs-pm_message_t-in-x86-64	2005-04-12 03:21:30.700469720 -0700
+++ 25-akpm/arch/x86_64/kernel/apic.c	2005-04-12 03:21:30.710468200 -0700
@@ -457,7 +457,7 @@ static struct {
 	unsigned int apic_thmr;
 } apic_pm_state;
 
-static int lapic_suspend(struct sys_device *dev, u32 state)
+static int lapic_suspend(struct sys_device *dev, pm_message_t state)
 {
 	unsigned long flags;
 
diff -puN arch/x86_64/kernel/i8259.c~fix-u32-vs-pm_message_t-in-x86-64 arch/x86_64/kernel/i8259.c
--- 25/arch/x86_64/kernel/i8259.c~fix-u32-vs-pm_message_t-in-x86-64	2005-04-12 03:21:30.701469568 -0700
+++ 25-akpm/arch/x86_64/kernel/i8259.c	2005-04-12 03:21:30.710468200 -0700
@@ -409,7 +409,7 @@ static int i8259A_resume(struct sys_devi
 	return 0;
 }
 
-static int i8259A_suspend(struct sys_device *dev, u32 state)
+static int i8259A_suspend(struct sys_device *dev, pm_message_t state)
 {
 	save_ELCR(irq_trigger);
 	return 0;
diff -puN arch/x86_64/kernel/io_apic.c~fix-u32-vs-pm_message_t-in-x86-64 arch/x86_64/kernel/io_apic.c
--- 25/arch/x86_64/kernel/io_apic.c~fix-u32-vs-pm_message_t-in-x86-64	2005-04-12 03:21:30.703469264 -0700
+++ 25-akpm/arch/x86_64/kernel/io_apic.c	2005-04-12 03:21:30.712467896 -0700
@@ -1712,7 +1712,7 @@ struct sysfs_ioapic_data {
 };
 static struct sysfs_ioapic_data * mp_ioapic_data[MAX_IO_APICS];
 
-static int ioapic_suspend(struct sys_device *dev, u32 state)
+static int ioapic_suspend(struct sys_device *dev, pm_message_t state)
 {
 	struct IO_APIC_route_entry *entry;
 	struct sysfs_ioapic_data *data;
diff -puN arch/x86_64/kernel/nmi.c~fix-u32-vs-pm_message_t-in-x86-64 arch/x86_64/kernel/nmi.c
--- 25/arch/x86_64/kernel/nmi.c~fix-u32-vs-pm_message_t-in-x86-64	2005-04-12 03:21:30.704469112 -0700
+++ 25-akpm/arch/x86_64/kernel/nmi.c	2005-04-12 03:21:30.712467896 -0700
@@ -248,7 +248,7 @@ void enable_timer_nmi_watchdog(void)
 
 static int nmi_pm_active; /* nmi_active before suspend */
 
-static int lapic_nmi_suspend(struct sys_device *dev, u32 state)
+static int lapic_nmi_suspend(struct sys_device *dev, pm_message_t state)
 {
 	nmi_pm_active = nmi_active;
 	disable_lapic_nmi_watchdog();
diff -puN arch/x86_64/kernel/time.c~fix-u32-vs-pm_message_t-in-x86-64 arch/x86_64/kernel/time.c
--- 25/arch/x86_64/kernel/time.c~fix-u32-vs-pm_message_t-in-x86-64	2005-04-12 03:21:30.706468808 -0700
+++ 25-akpm/arch/x86_64/kernel/time.c	2005-04-12 03:21:30.713467744 -0700
@@ -965,7 +965,7 @@ __setup("report_lost_ticks", time_setup)
 static long clock_cmos_diff;
 static unsigned long sleep_start;
 
-static int timer_suspend(struct sys_device *dev, u32 state)
+static int timer_suspend(struct sys_device *dev, pm_message_t state)
 {
 	/*
 	 * Estimate time zone so that set_time can update the clock
_
