Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750738AbVJ3URV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750738AbVJ3URV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 15:17:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750829AbVJ3URV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 15:17:21 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:44048 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750738AbVJ3URV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 15:17:21 -0500
Date: Sun, 30 Oct 2005 21:17:19 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: ak@suse.de, linux-kernel@vger.kernel.org
Subject: [2.6 patch] unexport phys_proc_id and cpu_core_id
Message-ID: <20051030201719.GM4180@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

EXPORT_SYMBOL's for phys_proc_id and cpu_core_id were added this year 
but never used.

Let's kill this bloat.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 arch/i386/kernel/smpboot.c   |    2 --
 arch/x86_64/kernel/smpboot.c |    2 --
 2 files changed, 4 deletions(-)

--- linux-2.6.14-rc5-mm1-full/arch/i386/kernel/smpboot.c.old	2005-10-30 20:51:35.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/arch/i386/kernel/smpboot.c	2005-10-30 20:51:45.000000000 +0100
@@ -68,11 +68,9 @@
 
 /* Package ID of each logical CPU */
 int phys_proc_id[NR_CPUS] __read_mostly = {[0 ... NR_CPUS-1] = BAD_APICID};
-EXPORT_SYMBOL(phys_proc_id);
 
 /* Core ID of each logical CPU */
 int cpu_core_id[NR_CPUS] __read_mostly = {[0 ... NR_CPUS-1] = BAD_APICID};
-EXPORT_SYMBOL(cpu_core_id);
 
 /* representing HT siblings of each logical CPU */
 cpumask_t cpu_sibling_map[NR_CPUS] __read_mostly;
--- linux-2.6.14-rc5-mm1-full/arch/x86_64/kernel/smpboot.c.old	2005-10-30 20:51:58.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/arch/x86_64/kernel/smpboot.c	2005-10-30 20:52:02.000000000 +0100
@@ -66,8 +66,6 @@
 u8 phys_proc_id[NR_CPUS] __read_mostly = { [0 ... NR_CPUS-1] = BAD_APICID };
 /* core ID of each logical CPU */
 u8 cpu_core_id[NR_CPUS] __read_mostly = { [0 ... NR_CPUS-1] = BAD_APICID };
-EXPORT_SYMBOL(phys_proc_id);
-EXPORT_SYMBOL(cpu_core_id);
 
 /* Bitmask of currently online CPUs */
 cpumask_t cpu_online_map __read_mostly;

