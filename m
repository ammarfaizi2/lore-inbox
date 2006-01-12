Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932305AbWALRRE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932305AbWALRRE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 12:17:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932278AbWALRRD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 12:17:03 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:46767 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S932305AbWALRQ7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 12:16:59 -0500
Date: Thu, 12 Jan 2006 18:16:42 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, adobriyan@gmail.com, linux-kernel@vger.kernel.org
Subject: [patch 7/13] s390: fix cpcmd calls on UP.
Message-ID: <20060112171642.GH16629@skybase.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexey Dobriyan <adobriyan@gmail.com>

[patch 7/13] s390: fix cpcmd calls on UP.

Add missing fourth argument to cpcmd calls under !CONFIG_SMP.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

---

 arch/s390/kernel/setup.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff -urpN linux-2.6/arch/s390/kernel/setup.c linux-2.6-patched/arch/s390/kernel/setup.c
--- linux-2.6/arch/s390/kernel/setup.c	2006-01-12 15:43:19.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/setup.c	2006-01-12 15:43:57.000000000 +0100
@@ -268,7 +268,7 @@ static void do_machine_restart_nonsmp(ch
 	reipl_diag();
 
 	if (MACHINE_IS_VM)
-		cpcmd ("IPL", NULL, 0);
+		cpcmd ("IPL", NULL, 0, NULL);
 	else
 		reipl (0x10000 | S390_lowcore.ipl_device);
 }
@@ -276,14 +276,14 @@ static void do_machine_restart_nonsmp(ch
 static void do_machine_halt_nonsmp(void)
 {
         if (MACHINE_IS_VM && strlen(vmhalt_cmd) > 0)
-                cpcmd(vmhalt_cmd, NULL, 0);
+                cpcmd(vmhalt_cmd, NULL, 0, NULL);
         signal_processor(smp_processor_id(), sigp_stop_and_store_status);
 }
 
 static void do_machine_power_off_nonsmp(void)
 {
         if (MACHINE_IS_VM && strlen(vmpoff_cmd) > 0)
-                cpcmd(vmpoff_cmd, NULL, 0);
+                cpcmd(vmpoff_cmd, NULL, 0, NULL);
         signal_processor(smp_processor_id(), sigp_stop_and_store_status);
 }
 
