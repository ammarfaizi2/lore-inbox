Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265006AbUFVQMI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265006AbUFVQMI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 12:12:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264890AbUFVP3b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 11:29:31 -0400
Received: from holomorphy.com ([207.189.100.168]:37251 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264880AbUFVPRL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 11:17:11 -0400
To: linux-kernel@vger.kernel.org
From: William Lee Irwin III <wli@holomorphy.com>
Subject: [profile]: [8/23] arm26 profiling cleanups
Message-ID: <0406220816.JbIb5aKb4aHb0aJb3a5aZaXaXaHbWa1a4a0aJbXaMbYaJb2aLbKb2aZaWaHb2a4a15250@holomorphy.com>
In-Reply-To: <0406220816.4a1a5aIb4aLb1a2a2aHbMbXa3aIb5a0a3aMb2aLbLb0aYaWaZaIbIb4a1aMb2a2a15250@holomorphy.com>
CC: rddunlap@osdl.org
Date: Tue, 22 Jun 2004 08:17:09 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert arm26 to use profiling_on() and profile_tick().

Index: prof-2.6.7/arch/arm26/kernel/time.c
===================================================================
--- prof-2.6.7.orig/arch/arm26/kernel/time.c	2004-06-15 22:19:42.000000000 -0700
+++ prof-2.6.7/arch/arm26/kernel/time.c	2004-06-22 07:25:49.764597800 -0700
@@ -72,21 +72,8 @@
  */
 static inline void do_profile(struct pt_regs *regs)
 {
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
+	if (!user_mode(regs) && profiling_on() && current->pid)
+		profile_tick(instruction_pointer(regs));
 }
 
 static unsigned long next_rtc_update;
