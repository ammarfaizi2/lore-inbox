Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262508AbVAKBcb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262508AbVAKBcb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 20:32:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262644AbVAKB1n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 20:27:43 -0500
Received: from mail.gmx.net ([213.165.64.20]:11904 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262568AbVAKB1G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 20:27:06 -0500
X-Authenticated: #24390674
From: Hans-Frieder Vogt <hfvogt@gmx.net>
Reply-To: hfvogt@gmx.net
To: andrewm@uow.edu.au, linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.10-mm2] reenable cpufreq for PowerNow-K8 using BIOS tables
Date: Tue, 11 Jan 2005 02:26:49 +0100
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501110226.49542.hfvogt@gmx.net>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With 2.6.10-mm2 (or even with -mm1) some structures in struct psb_s have been 
renamed in powernow-k8.h, but the renaming has not been done properly for all 
occurences in powernow-k8.c.
This prevents cpufreq from accepting the BIOS PST-tables.

The following patch corrects this by renaming the incorrectly named variable 
in powernow-k8.c, following the definition in the powernow-k8.h header file.

Andrew, please include it in your next -mm patch.

Signed-off-by: Hans-Frieder Vogt <hfvogt@arcor.de>

--- linux-2.6.10-mm2/arch/i386/kernel/cpu/cpufreq/powernow-k8.c 2005-01-05 
23:23:07.697728328 -0800
+++ b/arch/i386/kernel/cpu/cpufreq/powernow-k8.c 2005-01-11 01:40:59.633643410 
+0100
@@ -637,8 +637,8 @@ static int find_psb_table(struct powerno
   dprintk("isochronous relief time: %d\n", data->irt);
   dprintk("maximum voltage step: %d - 0x%x\n", mvs, data->vidmvs);
 
-  dprintk("numpst: 0x%x\n", psb->numps);
-  cpst = psb->numps;
+  dprintk("numpst: 0x%x\n", psb->num_tables);
+  cpst = psb->num_tables;
   if ((psb->cpuid == 0x00000fc0) || (psb->cpuid == 0x00000fe0) ){
    thiscpuid = cpuid_eax(CPUID_PROCESSOR_SIGNATURE);
    if ((thiscpuid == 0x00000fc0) || (thiscpuid == 0x00000fe0) ) {

-- 
--
Hans-Frieder Vogt              e-mail: hfvogt <at> arcor .dot. de
                                          hfvogt <at> gmx .dot. net
