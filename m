Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264919AbUFVPaM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264919AbUFVPaM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 11:30:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264881AbUFVPaA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 11:30:00 -0400
Received: from holomorphy.com ([207.189.100.168]:35459 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264822AbUFVPQq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 11:16:46 -0400
To: linux-kernel@vger.kernel.org
From: William Lee Irwin III <wli@holomorphy.com>
Subject: [profile]: [6/23] sparc32 profiling cleanups
Message-ID: <0406220816.5a1aMb2aJbIbJbZa0a5aLbMbIb0a3aXaKb1aYa2aLbJbWa0a3aYaJb3aXaWaLb3a15250@holomorphy.com>
In-Reply-To: <0406220816.LbIbZa1aLbLbIbJb1aWa3aHbWaKbHbLbHb3a1aIbYaZaLbIb0a2a5a4aHbHbLbIb15250@holomorphy.com>
CC: rddunlap@osdl.org
Date: Tue, 22 Jun 2004 08:16:44 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert sparc32 to use profiling_on() and profile_tick().

Index: prof-2.6.7/arch/sparc/kernel/time.c
===================================================================
--- prof-2.6.7.orig/arch/sparc/kernel/time.c	2004-06-15 22:19:36.000000000 -0700
+++ prof-2.6.7/arch/sparc/kernel/time.c	2004-06-22 07:25:48.065856048 -0700
@@ -84,7 +84,7 @@
 /* 32-bit Sparc specific profiling function. */
 void sparc_do_profile(unsigned long pc, unsigned long o7)
 {
-	if(prof_buffer && current->pid) {
+	if(profiling_on() && current->pid) {
 		extern int _stext;
 		extern int __copy_user_begin, __copy_user_end;
 		extern int __atomic_begin, __atomic_end;
@@ -101,14 +101,8 @@
 		     pc < (unsigned long) &__bitops_end))
 			pc = o7;
 
-		pc -= (unsigned long) &_stext;
-		pc >>= prof_shift;
-
 		spin_lock(&ticker_lock);
-		if(pc < prof_len)
-			prof_buffer[pc]++;
-		else
-			prof_buffer[prof_len - 1]++;
+		profile_tick(pc);
 		spin_unlock(&ticker_lock);
 	}
 }
