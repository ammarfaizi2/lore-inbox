Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263980AbTJFFbB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 01:31:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263987AbTJFF3g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 01:29:36 -0400
Received: from TYO202.gate.nec.co.jp ([210.143.35.52]:55497 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S263991AbTJFF3W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 01:29:22 -0400
To: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH][v850]  Add sched_clock on v850
Cc: linux-kernel@vger.kernel.org
Reply-To: Miles Bader <miles@gnu.org>
Message-Id: <20031006052905.78D2537CC@mcspd15.ucom.lsi.nec.co.jp>
Date: Mon,  6 Oct 2003 14:29:05 +0900 (JST)
From: miles@lsi.nec.co.jp (Miles Bader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply.

This is a horrid implementation, but whatever.

diff -ruN -X../cludes linux-2.6.0-test6-moo/arch/v850/kernel/time.c linux-2.6.0-test6-moo-v850-20031006/arch/v850/kernel/time.c
--- linux-2.6.0-test6-moo/arch/v850/kernel/time.c	2003-07-14 13:14:39.000000000 +0900
+++ linux-2.6.0-test6-moo-v850-20031006/arch/v850/kernel/time.c	2003-10-03 17:06:47.000000000 +0900
@@ -29,6 +29,14 @@
 
 #define TICK_SIZE	(tick_nsec / 1000)
 
+/*
+ * Scheduler clock - returns current time in nanosec units.
+ */
+unsigned long long sched_clock(void)
+{
+	return (unsigned long long)jiffies * (1000000000 / HZ);
+}
+
 static inline void do_profile (unsigned long pc)
 {
 	if (prof_buffer && current->pid) {
