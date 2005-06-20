Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262277AbVFTWM1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262277AbVFTWM1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 18:12:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262142AbVFTWLh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 18:11:37 -0400
Received: from coderock.org ([193.77.147.115]:59799 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261699AbVFTVuE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 17:50:04 -0400
Message-Id: <20050620214926.542498000@nd47.coderock.org>
Date: Mon, 20 Jun 2005 23:49:27 +0200
From: domen@coderock.org
To: rmk@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org, Nishanth Aravamudan <nacc@us.ibm.com>,
       domen@coderock.org
Subject: [patch 4/4] arm/cpu-sa1110: replace schedule_timeout() with msleep()
Content-Disposition: inline; filename=msleep-arch_arm_mach-sa1100_cpu-sa1110.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nishanth Aravamudan <nacc@us.ibm.com>



Use msleep() instead of schedule_timeout() to guarantee the task
delays as expected. Neither signals nor wait-queue events are important at this
point in the code, I believe.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Domen Puncer <domen@coderock.org>
---
 cpu-sa1110.c |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)

Index: quilt/arch/arm/mach-sa1100/cpu-sa1110.c
===================================================================
--- quilt.orig/arch/arm/mach-sa1100/cpu-sa1110.c
+++ quilt/arch/arm/mach-sa1100/cpu-sa1110.c
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

--
