Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318212AbSHDTLO>; Sun, 4 Aug 2002 15:11:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318214AbSHDTLO>; Sun, 4 Aug 2002 15:11:14 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:41223 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318212AbSHDTLM>; Sun, 4 Aug 2002 15:11:12 -0400
To: Linus Torvalds <torvalds@transmeta.com>
CC: <linux-kernel@vger.kernel.org>
From: Russell King <rmk@arm.linux.org.uk>
Subject: [PATCH] 3: 2.5.30-smph
Message-Id: <E17bQpw-0001qM-00@flint.arm.linux.org.uk>
Date: Sun, 04 Aug 2002 20:14:44 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch has been verified to apply cleanly to 2.5.30

This patch fixes a build warning in smp.h.  register_cpu_notifier uses
struct notifier_block in its argument list.  Unfortunately, there are
places where smp.h is included before the definition of this structure.

 include/linux/smp.h |    2 ++
 1 files changed, 2 insertions

--- orig/include/linux/smp.h	Fri Aug  2 21:13:42 2002
+++ linux/include/linux/smp.h	Sun Aug  4 13:08:12 2002
@@ -100,6 +100,8 @@
 #define per_cpu(var, cpu)			var
 #define this_cpu(var)				var
 
+struct notifier_block;
+
 /* Need to know about CPUs going up/down? */
 static inline int register_cpu_notifier(struct notifier_block *nb)
 {
