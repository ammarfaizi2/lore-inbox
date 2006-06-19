Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964843AbWFSSvv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964843AbWFSSvv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 14:51:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964846AbWFSSvV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 14:51:21 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:53704 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S964812AbWFSSnW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 14:43:22 -0400
Message-Id: <20060619183405.408643000@klappe.arndb.de>
References: <20060619183315.653672000@klappe.arndb.de>
Date: Mon, 19 Jun 2006 20:33:25 +0200
From: arnd@arndb.de
To: paulus@samba.org
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: [patch 10/20] spufs: fix initial state of wbox file
Content-Disposition: inline; filename=spufs-initial-wbox-stat.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The wbox channel count of an spu is now initialized
to four for the saved context. This makes it possible
to write to the mailbox right away without waiting
for the SPE to become scheduled first.

Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
---
Index: powerpc.git/arch/powerpc/platforms/cell/spufs/switch.c
===================================================================
--- powerpc.git.orig/arch/powerpc/platforms/cell/spufs/switch.c
+++ powerpc.git/arch/powerpc/platforms/cell/spufs/switch.c
@@ -2129,6 +2129,7 @@ static void init_prob(struct spu_state *
 	csa->spu_chnlcnt_RW[28] = 1;
 	csa->spu_chnlcnt_RW[30] = 1;
 	csa->prob.spu_runcntl_RW = SPU_RUNCNTL_STOP;
+	csa->prob.mb_stat_R = 0x000400;
 }
 
 static void init_priv1(struct spu_state *csa)

--

