Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264881AbUFVPaN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264881AbUFVPaN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 11:30:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264917AbUFVP3u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 11:29:50 -0400
Received: from holomorphy.com ([207.189.100.168]:37507 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264881AbUFVPRL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 11:17:11 -0400
To: linux-kernel@vger.kernel.org
From: William Lee Irwin III <wli@holomorphy.com>
Subject: [profile]: [9/23] m68k profiling cleanups
Message-ID: <0406220816.0a0a1aMbIbXa5a1aIb1a2aJbYaLbLb5aXaHbZaXaIbXa2aWaJbMbIbZa5a5aZa4a15250@holomorphy.com>
In-Reply-To: <0406220816.JbIb5aKb4aHb0aJb3a5aZaXaXaHbWa1a4a0aJbXaMbYaJb2aLbKb2aZaWaHb2a4a15250@holomorphy.com>
CC: rddunlap@osdl.org
Date: Tue, 22 Jun 2004 08:17:09 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert m68k to use profiling_on() and profile_tick().

Index: prof-2.6.7/arch/m68k/kernel/time.c
===================================================================
--- prof-2.6.7.orig/arch/m68k/kernel/time.c	2004-06-15 22:19:02.000000000 -0700
+++ prof-2.6.7/arch/m68k/kernel/time.c	2004-06-22 07:25:50.615468448 -0700
@@ -40,20 +40,8 @@
 
 static inline void do_profile (unsigned long pc)
 {
-	if (prof_buffer && current->pid) {
-		extern int _stext;
-		pc -= (unsigned long) &_stext;
-		pc >>= prof_shift;
-		if (pc < prof_len)
-			++prof_buffer[pc];
-		else
-		/*
-		 * Don't ignore out-of-bounds PC values silently,
-		 * put them into the last histogram slot, so if
-		 * present, they will show up as a sharp peak.
-		 */
-			++prof_buffer[prof_len-1];
-	}
+	if (current->pid)
+		profile_tick(pc);
 }
 
 /*
