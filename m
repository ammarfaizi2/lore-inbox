Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263385AbVCJXQt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263385AbVCJXQt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 18:16:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263412AbVCJXPh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 18:15:37 -0500
Received: from mail.kroah.org ([69.55.234.183]:29146 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263380AbVCJXKR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 18:10:17 -0500
Date: Thu, 10 Mar 2005 15:08:55 -0800
From: Greg KH <greg@kroah.com>
To: afleming@freescale.com, benh@kernel.crashing.org, paulus@samba.org,
       gjaeger@sysgo.com, mporter@kernel.crashing.org, phil.el@wanadoo.fr,
       oprofile-list@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, stable@kernel.org
Subject: [07/11] ppc32: trivial fix for e500 oprofile build
Message-ID: <20050310230854.GH22112@kroah.com>
References: <20050310230519.GA22112@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050310230519.GA22112@kroah.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


-stable review patch.  If anyone has any objections, please let us know.

------------------



Fix for trivial fix for 2.6.11 oprofile compilation on e500 based ppc.

Signed-off-by: Andy Fleming <afleming@freescale.com>
Signed-off-by: Kumar Gala <kumar.gala@freescale.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

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

