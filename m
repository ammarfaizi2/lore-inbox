Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129662AbRBPGol>; Fri, 16 Feb 2001 01:44:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129674AbRBPGob>; Fri, 16 Feb 2001 01:44:31 -0500
Received: from www.lahn.de ([213.61.112.58]:33826 "EHLO serv02.lahn.de")
	by vger.kernel.org with ESMTP id <S129668AbRBPGoV>;
	Fri, 16 Feb 2001 01:44:21 -0500
Date: Thu, 15 Feb 2001 08:59:34 +0100 (CET)
From: Philipp Matthias Hahn <pmhahn@titan.lahn.de>
Reply-To: <pmhahn@titan.lahn.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: ACPI <acpi@phobos.fachschaften.tu-muenchen.de>
Subject: [PATCH] acpi/cpu.c on SMP
Message-ID: <Pine.LNX.4.33.0102150854470.4480-100000@titan.lahn.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

acpi_idle is disabled on SMP systems with more then 1 cpu. The boot
message sais otherwise. This patch corrects the message.

--- linux-2.4.2/drivers/acpi/cpu.c.orig	Sat Feb 10 12:01:52 2001
+++ linux-2.4.2/drivers/acpi/cpu.c	Thu Feb 15 08:54:16 2001
@@ -335,13 +335,12 @@

 	acpi_pm_timer_init();

-	if (acpi_use_idle) {
 #ifdef CONFIG_SMP
-		if (smp_num_cpus == 1)
-			pm_idle = acpi_idle;
+	if (acpi_use_idle && (smp_num_cpus == 1)) {
 #else
-		pm_idle = acpi_idle;
+	if (acpi_use_idle) {
 #endif
+		pm_idle = acpi_idle;
 		printk(KERN_INFO "ACPI: Using ACPI idle\n");
 		printk(KERN_INFO "ACPI: If experiencing system slowness, try adding \"acpi=no-idle\" to cmdline\n");
 	}

BYtE
Philipp
-- 
  / /  (_)__  __ ____  __ Philipp Hahn
 / /__/ / _ \/ // /\ \/ /
/____/_/_//_/\_,_/ /_/\_\ pmhahn@titan.lahn.de

