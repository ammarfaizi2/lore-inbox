Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261748AbULJQQS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261748AbULJQQS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 11:16:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261741AbULJQQS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 11:16:18 -0500
Received: from mailfe09.swipnet.se ([212.247.155.1]:15570 "EHLO
	mailfe09.swip.net") by vger.kernel.org with ESMTP id S261759AbULJQKp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 11:10:45 -0500
X-T2-Posting-ID: 2Ngqim/wGkXHuU4sHkFYGQ==
Subject: [PATCH] Warn about dangers of LVM/RAID stacking with 4KSTACKS
From: Alexander Nyberg <alexn@dsv.su.se>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Fri, 10 Dec 2004 17:10:35 +0100
Message-Id: <1102695035.690.11.camel@boxen>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus

On x86 using software RAID on disks and then putting them together in
LVM as a logical volume uses alot of the stack. I've read reports of
doing this on volumes which are shared via NFS causes stack overruns
which it indeed does, I just reproduced it here.

We should play it safe and warn anyone before using CONFIG_4KSTACKS if
the user intends to do software LVM/RAID stacking until this issue is
resolved.


Signed-off-by: Alexander Nyberg <alexn@dsv.su.se>


===== arch/i386/Kconfig.debug 1.4 vs edited =====
--- 1.4/arch/i386/Kconfig.debug	2004-10-20 10:37:19 +02:00
+++ edited/arch/i386/Kconfig.debug	2004-12-10 17:00:01 +01:00
@@ -46,6 +46,8 @@ config DEBUG_PAGEALLOC
 	  This results in a large slowdown, but helps to find certain types
 	  of memory corruptions.
 
+comment "Please read help if you intend to stack software RAID and LVM"
+
 config 4KSTACKS
 	bool "Use 4Kb for kernel stacks instead of 8Kb"
 	help
@@ -54,6 +56,10 @@ config 4KSTACKS
 	  running more threads on a system and also reduces the pressure
 	  on the VM subsystem for higher order allocations. This option
 	  will also use IRQ stacks to compensate for the reduced stackspace.
+
+	  Don't enable this if you intend to stack RAID and LVM on top of
+	  each other. The stack may run out using this combination and
+	  then bad things will happen.
 
 config X86_FIND_SMP_CONFIG
 	bool


