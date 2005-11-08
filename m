Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932445AbVKHQ0n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932445AbVKHQ0n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 11:26:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932462AbVKHQ0m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 11:26:42 -0500
Received: from pne-smtpout1-sn2.hy.skanova.net ([81.228.8.83]:49616 "EHLO
	pne-smtpout1-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S932445AbVKHQ0l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 11:26:41 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] cpufreq: Fix compiler warning
From: Peter Osterlund <petero2@telia.com>
Date: 08 Nov 2005 17:26:30 +0100
Message-ID: <m3mzkfayx5.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fixe unused variable compiler warning when building cpufreq.c without
CONFIG_SMP.

Signed-off-by: Peter Osterlund <petero2@telia.com>
---

 drivers/cpufreq/cpufreq.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 25acf47..4b11215 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -694,10 +694,6 @@ static int cpufreq_remove_dev (struct sy
 	unsigned int cpu = sys_dev->id;
 	unsigned long flags;
 	struct cpufreq_policy *data;
-	struct sys_device *cpu_sys_dev;
-#ifdef CONFIG_SMP
-	unsigned int j;
-#endif
 
 	cpufreq_debug_disable_ratelimit();
 	dprintk("unregistering CPU %u\n", cpu);
@@ -741,6 +737,8 @@ static int cpufreq_remove_dev (struct sy
 	 * links afterwards.
 	 */
 	if (unlikely(cpus_weight(data->cpus) > 1)) {
+		struct sys_device *cpu_sys_dev;
+		unsigned int j;
 		for_each_cpu_mask(j, data->cpus) {
 			if (j == cpu)
 				continue;

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
