Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265942AbUBPXFT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 18:05:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265924AbUBPXEZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 18:04:25 -0500
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:35269 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S265984AbUBPXCM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 18:02:12 -0500
Date: Mon, 16 Feb 2004 18:01:52 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Rusty Russell <rusty@rustcorp.com.au>,
       lhcs-devel@lists.sourceforge.net
Subject: [PATCH][2.6-mm] CPU hotplug, rcupdate high NR_CPUS fix
Message-ID: <Pine.LNX.4.58.0402161800440.11793@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Small fix for NR_CPUS > BITS_PER_LONG

Index: linux-2.6.3-rc3-mm1/kernel/rcupdate.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.3-rc3-mm1/kernel/rcupdate.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 rcupdate.c
--- linux-2.6.3-rc3-mm1/kernel/rcupdate.c	16 Feb 2004 20:42:49 -0000	1.1.1.1
+++ linux-2.6.3-rc3-mm1/kernel/rcupdate.c	16 Feb 2004 22:47:25 -0000
@@ -182,7 +182,7 @@ static void rcu_offline_cpu(int cpu)
 	 * it here
 	 */
 	spin_lock_irq(&rcu_ctrlblk.mutex);
-	if (!rcu_ctrlblk.rcu_cpu_mask)
+	if (cpus_empty(rcu_ctrlblk.rcu_cpu_mask))
 		goto unlock;

 	cpu_clear(cpu, rcu_ctrlblk.rcu_cpu_mask);
