Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267898AbTBVNeT>; Sat, 22 Feb 2003 08:34:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267901AbTBVNeS>; Sat, 22 Feb 2003 08:34:18 -0500
Received: from mailout11.sul.t-online.com ([194.25.134.85]:11459 "EHLO
	mailout11.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S267898AbTBVNeR>; Sat, 22 Feb 2003 08:34:17 -0500
Date: Sat, 22 Feb 2003 14:42:11 +0100
From: malware@t-online.de (Malware)
Message-Id: <200302221342.h1MDgBqI029213@debian.malware.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] [m68k] mach_default_handler not always tested against NULL
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.757.40.1 -> 1.757.40.2
#	arch/m68k/kernel/ints.c	1.2     -> 1.3    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/02/22	malware@debian.malware.de	1.757.40.2
# ints.c:
#   Fix: Check mach_default_handler before using it.
# --------------------------------------------
#
diff -Nru a/arch/m68k/kernel/ints.c b/arch/m68k/kernel/ints.c
--- a/arch/m68k/kernel/ints.c	Sat Feb 22 13:29:15 2003
+++ b/arch/m68k/kernel/ints.c	Sat Feb 22 13:29:15 2003
@@ -175,7 +175,8 @@
 		printk("%s: Removing probably wrong IRQ %d from %s\n",
 		       __FUNCTION__, irq, irq_list[irq].devname);
 
-	irq_list[irq].handler = (*mach_default_handler)[irq];
+	if (mach_default_handler)
+		irq_list[irq].handler = (*mach_default_handler)[irq];
 	irq_list[irq].flags   = 0;
 	irq_list[irq].dev_id  = NULL;
 	irq_list[irq].devname = default_names[irq];
