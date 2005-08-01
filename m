Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261225AbVHAVMs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261225AbVHAVMs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 17:12:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261243AbVHAUe0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 16:34:26 -0400
Received: from fmr18.intel.com ([134.134.136.17]:40873 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S261242AbVHAUdW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 16:33:22 -0400
Message-Id: <20050801203011.065721000@araj-em64t>
References: <20050801202017.043754000@araj-em64t>
Date: Mon, 01 Aug 2005 13:20:19 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Ashok Raj <ashok.raj@intel.com>, Andi Kleen <ak@muc.de>,
       zwane@arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: [patch 2/8] x86_64: create sysfs entries for cpu only for present cpus
Content-Disposition: inline; filename=create-sysfs-onlyfor-present-cpus
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Need to create sysfs only for cpus that are present. Without which we see
NR_CPUS entries created when we have CONFIG_HOTPLUG and CONFIG_HOTPLUG_CPU
enabled.

Signed-off-by: Ashok Raj <ashok.raj@intel.com>
--------------------------------------------------------------
 arch/i386/mach-default/topology.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6.13-rc3-ak/arch/i386/mach-default/topology.c
===================================================================
--- linux-2.6.13-rc3-ak.orig/arch/i386/mach-default/topology.c
+++ linux-2.6.13-rc3-ak/arch/i386/mach-default/topology.c
@@ -76,7 +76,7 @@ static int __init topology_init(void)
 	for_each_online_node(i)
 		arch_register_node(i);
 
-	for_each_cpu(i)
+	for_each_present_cpu(i)
 		arch_register_cpu(i);
 	return 0;
 }
@@ -87,7 +87,7 @@ static int __init topology_init(void)
 {
 	int i;
 
-	for_each_cpu(i)
+	for_each_present_cpu(i)
 		arch_register_cpu(i);
 	return 0;
 }

--

