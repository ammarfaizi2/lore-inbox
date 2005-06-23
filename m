Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262761AbVFWVmI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262761AbVFWVmI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 17:42:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262818AbVFWViG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 17:38:06 -0400
Received: from fmr21.intel.com ([143.183.121.13]:45481 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S262774AbVFWVaU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 17:30:20 -0400
Date: Thu, 23 Jun 2005 14:30:03 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, nickpiggin@yahoo.com.au
Subject: recent sched.c broke cpu hotplug
Message-ID: <20050623143003.A25031@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew

trivial fix, this is required for getting cpu hotplug to work. These
functions are called during cpu down, but marked __init instead of __devinit.


-- 
Cheers,
Ashok Raj
- Open Source Technology Center


Some functions should be devinit for cpu hotplug purpose.

Signed-off-by: Ashok Raj <ashok.raj@intel.com>
-----------------------------------------------------
 kernel/sched.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6.12-mm1/kernel/sched.c
===================================================================
--- linux-2.6.12-mm1.orig/kernel/sched.c
+++ linux-2.6.12-mm1/kernel/sched.c
@@ -5207,7 +5207,7 @@ __setup("migration_factor=", setup_migra
  * Estimated distance of two CPUs, measured via the number of domains
  * we have to pass for the two CPUs to be in the same span:
  */
-__init static unsigned long domain_distance(int cpu1, int cpu2)
+__devinit static unsigned long domain_distance(int cpu1, int cpu2)
 {
 	unsigned long distance = 0;
 	struct sched_domain *sd;
@@ -5417,7 +5417,7 @@ measure_cost(int cpu1, int cpu2, void *c
 	return cost1 - cost2;
 }
 
-__init static unsigned long long measure_migration_cost(int cpu1, int cpu2)
+__devinit static unsigned long long measure_migration_cost(int cpu1, int cpu2)
 {
 	unsigned long long max_cost = 0, fluct = 0, avg_fluct = 0;
 	unsigned int max_size, size, size_found = 0;
