Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751816AbWKBSZR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751816AbWKBSZR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 13:25:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751887AbWKBSZR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 13:25:17 -0500
Received: from mga05.intel.com ([192.55.52.89]:56139 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751816AbWKBSZP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 13:25:15 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,381,1157353200"; 
   d="scan'208"; a="10844625:sNHT26500986"
Date: Thu, 2 Nov 2006 10:01:34 -0800
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: rjw@sisk.pl, pavel@ucw.cz, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, venkatesh.pallipadi@intel.com
Subject: [patch] don't change cpus_allowed for task initiating the suspend
Message-ID: <20061102100134.A23399@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Don't modify the cpus_allowed of the task initiating the suspend. 
_cpu_down() already makes sure that the task doing the suspend doesn't
run on dying cpu.

Signed-off-by: Suresh Siddha <suresh.b.siddha@intel.com>
Cc: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
---

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 663c920..d21756a 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -270,11 +270,7 @@ int disable_nonboot_cpus(void)
 			goto out;
 		}
 	}
-	error = set_cpus_allowed(current, cpumask_of_cpu(first_cpu));
-	if (error) {
-		printk(KERN_ERR "Could not run on CPU%d\n", first_cpu);
-		goto out;
-	}
+
 	/* We take down all of the non-boot CPUs in one shot to avoid races
 	 * with the userspace trying to use the CPU hotplug at the same time
 	 */
