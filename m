Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264898AbUGBTSj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264898AbUGBTSj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 15:18:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264902AbUGBTSj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 15:18:39 -0400
Received: from aun.it.uu.se ([130.238.12.36]:15568 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S264898AbUGBTSi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 15:18:38 -0400
Date: Fri, 2 Jul 2004 21:18:27 +0200 (MEST)
Message-Id: <200407021918.i62JIRmU004560@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org
Subject: [PATCH][2.6.7-mm5] perfctr ppc32 buglet fix
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

This patch fixes a minor buglet in perfctr's ppc32 driver,
which prevented 7400/7410-type processors from specifying
a non-zero value for the MMCR2[THRESHMULT] control field.

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

--- linux-2.6.7-mm5/drivers/perfctr/ppc.c.~1~	2004-07-01 18:54:13.000000000 +0200
+++ linux-2.6.7-mm5/drivers/perfctr/ppc.c	2004-07-02 20:53:10.000000000 +0200
@@ -310,6 +310,7 @@
 
 	switch (pm_type) {
 	case PM_7450:
+	case PM_7400:
 		if (state->control.ppc.mmcr2 & MMCR2_RESERVED)
 			return -EINVAL;
 		state->ppc_mmcr[2] = state->control.ppc.mmcr2;
