Return-Path: <linux-kernel-owner+w=401wt.eu-S1751722AbWLMXRl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751722AbWLMXRl (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 18:17:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751725AbWLMXRl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 18:17:41 -0500
Received: from mga09.intel.com ([134.134.136.24]:6764 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751722AbWLMXRk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 18:17:40 -0500
X-Greylist: delayed 588 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 18:17:40 EST
X-ExtLoop1: 1
X-IronPort-AV: i="4.12,164,1165219200"; 
   d="scan'208"; a="26701391:sNHT27804960"
Subject: [PATCH] sched: remove __cpuinitdata anotation to cpu_isolated_map
From: Tim Chen <tim.c.chen@linux.intel.com>
Reply-To: tim.c.chen@linux.intel.com
To: linux-kernel@vger.kernel.org
Cc: suresh.b.siddha@intel.com
Content-Type: text/plain
Organization: Intel
Date: Wed, 13 Dec 2006 14:17:58 -0800
Message-Id: <1166048278.6772.20.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-8) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The structure cpu_isolated_map is used not only during initialization. 
Multi-core scheduler configuration changes and exclusive cpusets 
use this during run time.  During setting of sched_mc_power_savings
 policy, this structure is accessed to update sched_domains.

Thanks.

Tim Chen

Signed-off-by: Tim Chen <tim.c.chen@intel.com>
Acked-by: Suresh Siddha <suresh.b.siddha@intel.com>

diff --git a/kernel/sched.c b/kernel/sched.c
index f385eff..3de0deb 100644
--- a/kernel/sched.c
+++ b/kernel/sched.c
@@ -5510,7 +5510,7 @@ static void cpu_attach_domain(struct sch
 }
 
 /* cpus with isolated domains */
-static cpumask_t __cpuinitdata cpu_isolated_map = CPU_MASK_NONE;
+static cpumask_t cpu_isolated_map = CPU_MASK_NONE;
 
 /* Setup the mask of cpus configured for isolated domains */
 static int __init isolated_cpu_setup(char *str)
