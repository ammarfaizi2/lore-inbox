Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264737AbUFVPae@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264737AbUFVPae (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 11:30:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264880AbUFVPaW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 11:30:22 -0400
Received: from holomorphy.com ([207.189.100.168]:34947 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264737AbUFVPQp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 11:16:45 -0400
To: linux-kernel@vger.kernel.org
From: William Lee Irwin III <wli@holomorphy.com>
Subject: [profile]: [4/23] sparc64 profiling cleanups
Message-ID: <0406220816.MbKb2aWaJbWa0aWaYaLbZaWa2aJbYaWaHb3aLb1a3aYa4a3aYaKb2aIbLbLbWa1a15250@holomorphy.com>
In-Reply-To: <0406220816.5aMbHbKb0a3a3a1aMbLbIb2a3a0a4aKb3a5aLb2aWaMbZa3aZaLb0a3aXa1aYa2a15250@holomorphy.com>
CC: rddunlap@osdl.org
Date: Tue, 22 Jun 2004 08:16:44 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert sparc64 to use profiling_on() and profile_tick().

Index: prof-2.6.7/arch/sparc64/kernel/time.c
===================================================================
--- prof-2.6.7.orig/arch/sparc64/kernel/time.c	2004-06-15 22:19:23.000000000 -0700
+++ prof-2.6.7/arch/sparc64/kernel/time.c	2004-06-22 07:25:46.238133904 -0700
@@ -29,6 +29,7 @@
 #include <linux/jiffies.h>
 #include <linux/cpufreq.h>
 #include <linux/percpu.h>
+#include <linux/profile.h>
 
 #include <asm/oplib.h>
 #include <asm/mostek.h>
@@ -451,7 +452,7 @@
 	if (user_mode(regs))
 		return;
 
-	if (!prof_buffer)
+	if (!profiling_on())
 		return;
 
 	{
@@ -472,13 +473,7 @@
 		    (pc >= (unsigned long) &__bitops_begin &&
 		     pc < (unsigned long) &__bitops_end))
 			pc = o7;
-
-		pc -= (unsigned long) _stext;
-		pc >>= prof_shift;
-
-		if(pc >= prof_len)
-			pc = prof_len - 1;
-		atomic_inc((atomic_t *)&prof_buffer[pc]);
+		profile_tick(pc);
 	}
 }
 
