Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264896AbUFVQMK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264896AbUFVQMK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 12:12:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264916AbUFVP3T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 11:29:19 -0400
Received: from holomorphy.com ([207.189.100.168]:40323 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264911AbUFVPRf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 11:17:35 -0400
To: linux-kernel@vger.kernel.org
From: William Lee Irwin III <wli@holomorphy.com>
Subject: [profile]: [13/23] arm profiling cleanups
Message-ID: <0406220817.YaIb4aKb1aMbLbMbKbZaWa1aHbHbIbXaWa1aKbWaJbMbKbLbZa3aXa5a1aHbZaLb15250@holomorphy.com>
In-Reply-To: <0406220817.YaIbJb2a2aYaIbZaJbKb3a1a0aZaXa0aIb0aLbIbLbKbZa4aYa5aYaWaXa4a4aHb15250@holomorphy.com>
CC: rddunlap@osdl.org
Date: Tue, 22 Jun 2004 08:17:34 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert ARM to use profiling_on() and profile_tick().

Index: prof-2.6.7/arch/arm/kernel/time.c
===================================================================
--- prof-2.6.7.orig/arch/arm/kernel/time.c	2004-06-15 22:19:43.000000000 -0700
+++ prof-2.6.7/arch/arm/kernel/time.c	2004-06-22 07:25:54.061944504 -0700
@@ -85,24 +85,9 @@
  */
 static inline void do_profile(struct pt_regs *regs)
 {
-
 	profile_hook(regs);
-
-	if (!user_mode(regs) &&
-	    prof_buffer &&
-	    current->pid) {
-		unsigned long pc = instruction_pointer(regs);
-		extern int _stext;
-
-		pc -= (unsigned long)&_stext;
-
-		pc >>= prof_shift;
-
-		if (pc >= prof_len)
-			pc = prof_len - 1;
-
-		prof_buffer[pc] += 1;
-	}
+	if (!user_mode(regs) && current->pid)
+		profile_tick(instruction_pointer(regs));
 }
 
 static unsigned long next_rtc_update;
