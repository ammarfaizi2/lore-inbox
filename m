Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265027AbUFVQ0A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265027AbUFVQ0A (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 12:26:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264913AbUFVP3F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 11:29:05 -0400
Received: from holomorphy.com ([207.189.100.168]:40835 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264912AbUFVPRg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 11:17:36 -0400
To: linux-kernel@vger.kernel.org
From: William Lee Irwin III <wli@holomorphy.com>
Subject: [profile]: [15/23] h8300 profiling cleanups
Message-ID: <0406220817.4aZa4aMbJbZaLbHbJbIbKb5aYa1aHbZa2a1a1aHb4a2aWaJb2aKb4aKbIbXa4a2a15250@holomorphy.com>
In-Reply-To: <0406220817.Mb0a3aLbXa2a3a5a4aLbXa1a0aMbZaYaXaYaHb5aIbJbZaXaZaXa1a4aLb3aMb3a15250@holomorphy.com>
CC: rddunlap@osdl.org
Date: Tue, 22 Jun 2004 08:17:35 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert h8300 to use profiling_on() and profile_tick().

Index: prof-2.6.7/arch/h8300/kernel/time.c
===================================================================
--- prof-2.6.7.orig/arch/h8300/kernel/time.c	2004-06-15 22:19:10.000000000 -0700
+++ prof-2.6.7/arch/h8300/kernel/time.c	2004-06-22 07:25:55.750687776 -0700
@@ -38,20 +38,8 @@
 
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
Index: prof-2.6.7/arch/v850/kernel/time.c
===================================================================
--- prof-2.6.7.orig/arch/v850/kernel/time.c	2004-06-15 22:19:37.000000000 -0700
+++ prof-2.6.7/arch/v850/kernel/time.c	2004-06-22 07:25:55.752687472 -0700
@@ -42,20 +42,8 @@
 
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
