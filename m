Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268240AbUHKVec@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268240AbUHKVec (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 17:34:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268241AbUHKVeb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 17:34:31 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:17401 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S268240AbUHKVeY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 17:34:24 -0400
Date: Wed, 11 Aug 2004 17:38:12 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: RE: [PATCH][2.6] fix i386 idle routine selection
In-Reply-To: <88056F38E9E48644A0F562A38C64FB600296D1A9@scsmsx403.amr.corp.intel.com>
Message-ID: <Pine.LNX.4.58.0408111728520.2544@montezuma.fsmlabs.com>
References: <88056F38E9E48644A0F562A38C64FB600296D1A9@scsmsx403.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Aug 2004, Pallipadi, Venkatesh wrote:

> Agreed that handling asymmetric CPUs here is a bit of overkill.
> We can stick to the original patch + few more cleanups (attached).

Ah yes, the comment needs updating to the fact that the code has changed.
I've rediffed this against 2.6.8-rc4-mm1

Thanks

Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Signed-off-by: Zwane Mwaikambo <zwane@linuxpower.ca>

Index: linux-2.6.8-rc4-mm1/arch/i386/kernel/process.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.8-rc4-mm1/arch/i386/kernel/process.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 process.c
--- linux-2.6.8-rc4-mm1/arch/i386/kernel/process.c	10 Aug 2004 14:49:26 -0000	1.1.1.1
+++ linux-2.6.8-rc4-mm1/arch/i386/kernel/process.c	11 Aug 2004 21:37:29 -0000
@@ -218,9 +218,7 @@ void __init select_idle_routine(const st
 		printk("monitor/mwait feature present.\n");
 		/*
 		 * Skip, if setup has overridden idle.
-		 * Also, take care of system with asymmetric CPUs.
-		 * Use, mwait_idle only if all cpus support it.
-		 * If not, we fallback to default_idle()
+		 * One CPU supports mwait => All CPUs supports mwait
 		 */
 		if (!pm_idle) {
 			printk("using mwait in idle threads.\n");
Index: linux-2.6.8-rc4-mm1/arch/x86_64/kernel/process.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.8-rc4-mm1/arch/x86_64/kernel/process.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 process.c
--- linux-2.6.8-rc4-mm1/arch/x86_64/kernel/process.c	10 Aug 2004 14:49:30 -0000	1.1.1.1
+++ linux-2.6.8-rc4-mm1/arch/x86_64/kernel/process.c	11 Aug 2004 21:36:57 -0000
@@ -169,9 +169,7 @@ void __init select_idle_routine(const st
 	if (cpu_has(c, X86_FEATURE_MWAIT)) {
 		/*
 		 * Skip, if setup has overridden idle.
-		 * Also, take care of system with asymmetric CPUs.
-		 * Use, mwait_idle only if all cpus support it.
-		 * If not, we fallback to default_idle()
+		 * One CPU supports mwait => All CPUs supports mwait
 		 */
 		if (!pm_idle) {
 			if (!printed) {
