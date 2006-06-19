Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932533AbWFSSoY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932533AbWFSSoY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 14:44:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932540AbWFSSoF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 14:44:05 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:60104 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932534AbWFSSnX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 14:43:23 -0400
Message-Id: <20060619183405.554656000@klappe.arndb.de>
References: <20060619183315.653672000@klappe.arndb.de>
Date: Mon, 19 Jun 2006 20:33:26 +0200
From: arnd@arndb.de
To: paulus@samba.org
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, Jeremy Kerr <jk@ozlabs.org>
Subject: [patch 11/20] spufs: use kzalloc in create_spu
Content-Disposition: inline; filename=spufs-kzalloc.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeremy Kerr <jk@ozlabs.org>

Clean up create_spu() a little by using kzalloc instead of kmalloc +
assignments.

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

---

 arch/powerpc/platforms/cell/spu_base.c |   17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

Index: powerpc.git/arch/powerpc/platforms/cell/spu_base.c
===================================================================
--- powerpc.git.orig/arch/powerpc/platforms/cell/spu_base.c
+++ powerpc.git/arch/powerpc/platforms/cell/spu_base.c
@@ -701,7 +701,7 @@ static int __init create_spu(struct devi
 	static int number;
 
 	ret = -ENOMEM;
-	spu = kmalloc(sizeof (*spu), GFP_KERNEL);
+	spu = kzalloc(sizeof (*spu), GFP_KERNEL);
 	if (!spu)
 		goto out;
 
@@ -713,28 +713,11 @@ static int __init create_spu(struct devi
 	spu->nid = of_node_to_nid(spe);
 	if (spu->nid == -1)
 		spu->nid = 0;
-
-	spu->stop_code = 0;
-	spu->slb_replace = 0;
-	spu->mm = NULL;
-	spu->ctx = NULL;
-	spu->rq = NULL;
-	spu->pid = 0;
-	spu->class_0_pending = 0;
-	spu->flags = 0UL;
-	spu->dar = 0UL;
-	spu->dsisr = 0UL;
 	spin_lock_init(&spu->register_lock);
-
 	spu_mfc_sdr_set(spu, mfspr(SPRN_SDR1));
 	spu_mfc_sr1_set(spu, 0x33);
-
-	spu->ibox_callback = NULL;
-	spu->wbox_callback = NULL;
-	spu->stop_callback = NULL;
-	spu->mfc_callback = NULL;
-
 	mutex_lock(&spu_mutex);
+
 	spu->number = number++;
 	ret = spu_request_irqs(spu);
 	if (ret)

--

