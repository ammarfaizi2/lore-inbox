Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262972AbVCDTQy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262972AbVCDTQy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 14:16:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263019AbVCDTQq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 14:16:46 -0500
Received: from az33egw01.freescale.net ([192.88.158.102]:21496 "EHLO
	az33egw01.freescale.net") by vger.kernel.org with ESMTP
	id S262972AbVCDTJd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 14:09:33 -0500
Date: Fri, 4 Mar 2005 13:09:18 -0600 (CST)
From: Kumar Gala <galak@freescale.com>
X-X-Sender: galak@blarg.somerset.sps.mot.com
To: akpm@osdl.org, greg@kroah.com
cc: linuxppc-embedded@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ppc32: trivial fix for e500 oprofile build
Message-ID: <Pine.LNX.4.61.0503041303290.18551@blarg.somerset.sps.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, Greg

Here is a patch for the new 2.6.11 release tree and for Linus.

Fix for trivial fix for 2.6.11 oprofile compilation on e500 based ppc.

Signed-off-by: Andy Fleming <afleming@freescale.com>
Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---

diff -Nru a/arch/ppc/oprofile/op_model_fsl_booke.c b/arch/ppc/oprofile/op_model_fsl_booke.c
--- a/arch/ppc/oprofile/op_model_fsl_booke.c	2005-03-04 13:02:52 -06:00
+++ b/arch/ppc/oprofile/op_model_fsl_booke.c	2005-03-04 13:02:52 -06:00
@@ -150,7 +150,6 @@
 	int is_kernel;
 	int val;
 	int i;
-	unsigned int cpu = smp_processor_id();
 
 	/* set the PMM bit (see comment below) */
 	mtmsr(mfmsr() | MSR_PMM);
@@ -162,7 +161,7 @@
 		val = ctr_read(i);
 		if (val < 0) {
 			if (oprofile_running && ctr[i].enabled) {
-				oprofile_add_sample(pc, is_kernel, i, cpu);
+				oprofile_add_pc(pc, is_kernel, i);
 				ctr_write(i, reset_value[i]);
 			} else {
 				ctr_write(i, 0);
