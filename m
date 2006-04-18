Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750751AbWDRWIf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750751AbWDRWIf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 18:08:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750753AbWDRWHo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 18:07:44 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:7178 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750751AbWDRWH3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 18:07:29 -0400
Date: Wed, 19 Apr 2006 00:07:28 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Jacob Shin <jacob.shin@amd.com>
Cc: Dave Jones <davej@redhat.com>, Thomas Renninger <trenn@suse.de>,
       Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: [2.6 patch] arch/i386/kernel/cpu/cpufreq/powernow-k8.c: fix a check-after-use
Message-ID: <20060418220728.GU11582@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a check-after-use introduced by commit 
4211a30349e8d2b724cfb4ce2584604f5e59c299 and spotted by the Coverity 
checker.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 arch/i386/kernel/cpu/cpufreq/powernow-k8.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- linux-2.6.17-rc1-mm3-full/arch/i386/kernel/cpu/cpufreq/powernow-k8.c.old	2006-04-18 20:32:27.000000000 +0200
+++ linux-2.6.17-rc1-mm3-full/arch/i386/kernel/cpu/cpufreq/powernow-k8.c	2006-04-18 20:33:02.000000000 +0200
@@ -905,14 +905,17 @@ static int powernowk8_target(struct cpuf
 {
 	cpumask_t oldmask = CPU_MASK_ALL;
 	struct powernow_k8_data *data = powernow_data[pol->cpu];
-	u32 checkfid = data->currfid;
-	u32 checkvid = data->currvid;
+	u32 checkfid;
+	u32 checkvid;
 	unsigned int newstate;
 	int ret = -EIO;
 
 	if (!data)
 		return -EINVAL;
 
+	checkfid = data->currfid;
+	checkvid = data->currvid;
+
 	/* only run on specific CPU from here on */
 	oldmask = current->cpus_allowed;
 	set_cpus_allowed(current, cpumask_of_cpu(pol->cpu));

