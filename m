Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261302AbVCEWnW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261302AbVCEWnW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 17:43:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261291AbVCEWmG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 17:42:06 -0500
Received: from coderock.org ([193.77.147.115]:28581 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261297AbVCEWle (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 17:41:34 -0500
Subject: [patch 4/4] arm/cpu-sa1110: replace schedule_timeout() with msleep()
To: rmk@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org, domen@coderock.org, nacc@us.ibm.com
From: domen@coderock.org
Date: Sat, 05 Mar 2005 23:41:24 +0100
Message-Id: <20050305224124.C5CC41EE1E@trashy.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Use msleep() instead of schedule_timeout() to guarantee the task
delays as expected. Neither signals nor wait-queue events are important at this
point in the code, I believe.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/arch/arm/mach-sa1100/cpu-sa1110.c |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)

diff -puN arch/arm/mach-sa1100/cpu-sa1110.c~msleep-arch_arm_mach-sa1100_cpu-sa1110 arch/arm/mach-sa1100/cpu-sa1110.c
--- kj/arch/arm/mach-sa1100/cpu-sa1110.c~msleep-arch_arm_mach-sa1100_cpu-sa1110	2005-03-05 16:10:43.000000000 +0100
+++ kj-domen/arch/arm/mach-sa1100/cpu-sa1110.c	2005-03-05 16:10:43.000000000 +0100
@@ -271,8 +271,7 @@ static int sa1110_target(struct cpufreq_
 	 */
 	sdram_set_refresh(2);
 	if (!irqs_disabled()) {
-		set_current_state(TASK_UNINTERRUPTIBLE);
-		schedule_timeout(20 * HZ / 1000);
+		msleep(20);
 	} else {
 		mdelay(20);
 	}
_
