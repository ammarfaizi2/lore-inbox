Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265970AbUFIUwM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265970AbUFIUwM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 16:52:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265962AbUFIUwM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 16:52:12 -0400
Received: from aun.it.uu.se ([130.238.12.36]:52921 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S265970AbUFIUwC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 16:52:02 -0400
Date: Wed, 9 Jun 2004 22:50:32 +0200 (MEST)
Message-Id: <200406092050.i59KoWoa000621@alkaid.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org
Subject: [PATCH][2.6.7-rc3-mm1] perfctr cpumask cleanup
Cc: linux-kernel@vger.kernel.org, pj@sgi.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up perfctr/virtual by using the new cpus_andnot() operation
instead of messing with cpus_complement() and a new temporary.

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

diff -ruN linux-2.6.7-rc3-mm1/drivers/perfctr/virtual.c linux-2.6.7-rc3-mm1.perfctr-update/drivers/perfctr/virtual.c
--- linux-2.6.7-rc3-mm1/drivers/perfctr/virtual.c	2004-06-09 19:38:38.000000000 +0200
+++ linux-2.6.7-rc3-mm1.perfctr-update/drivers/perfctr/virtual.c	2004-06-09 21:04:33.000000000 +0200
@@ -403,13 +403,11 @@
 		return -EFAULT;
 
 	if (control.cpu_control.nractrs || control.cpu_control.nrictrs) {
-		cpumask_t tmp, old_mask, new_mask, tmp1;
+		cpumask_t tmp, old_mask, new_mask;
 
 		tmp = perfctr_cpus_forbidden_mask;
-		cpus_complement(tmp1, tmp);
-		tmp = tmp1;
 		old_mask = tsk->cpus_allowed;
-		cpus_and(new_mask, old_mask, tmp);
+		cpus_andnot(new_mask, old_mask, tmp);
 
 		if (cpus_empty(new_mask))
 			return -EINVAL;
