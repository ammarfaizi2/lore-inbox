Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422676AbWCWUoq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422676AbWCWUoq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 15:44:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422685AbWCWUoI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 15:44:08 -0500
Received: from moutng.kundenserver.de ([212.227.126.186]:37621 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751493AbWCWUkW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 15:40:22 -0500
Message-Id: <20060323203523.069903000@dyn-9-152-242-103.boeblingen.de.ibm.com>
References: <20060323203423.620978000@dyn-9-152-242-103.boeblingen.de.ibm.com>
User-Agent: quilt/0.44-1
Date: Thu, 23 Mar 2006 00:00:13 +0100
From: Arnd Bergmann <abergman@de.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Cc: cbe-oss-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd.bergmann@de.ibm.com>
Subject: [patch 13/13] spufs: initialize context correctly
Content-Disposition: inline; filename=init_mfc.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

the mfc member of a new context was not initialized to zero,
which potentially leads to wild memory accesses.

From: Dirk Herrendoerfer <herrendo@de.ibm.com>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

Index: linux-2.6.16-rc/arch/powerpc/platforms/cell/spufs/context.c
===================================================================
--- linux-2.6.16-rc.orig/arch/powerpc/platforms/cell/spufs/context.c
+++ linux-2.6.16-rc/arch/powerpc/platforms/cell/spufs/context.c
@@ -51,6 +51,7 @@ struct spu_context *alloc_spu_context(vo
 	ctx->ibox_fasync = NULL;
 	ctx->wbox_fasync = NULL;
 	ctx->mfc_fasync = NULL;
+	ctx->mfc = NULL;
 	ctx->tagwait = 0;
 	ctx->state = SPU_STATE_SAVED;
 	ctx->local_store = NULL;

--

