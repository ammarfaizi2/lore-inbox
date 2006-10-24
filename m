Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932435AbWJXQ2L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932435AbWJXQ2L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 12:28:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932444AbWJXQ2F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 12:28:05 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:30665 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932435AbWJXQ1s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 12:27:48 -0400
Message-Id: <20061024160406.923275000@arndb.de>
References: <20061024160140.452484000@arndb.de>
User-Agent: quilt/0.45-1
Date: Tue, 24 Oct 2006 18:01:42 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, Arnd Bergmann <arnd.bergmann@de.ibm.com>
Subject: [PATCH 2/3] spufs: fix another off-by-one bug in mbox_read
Content-Disposition: inline; filename=spufs-mbox-fix-fix.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Next try, the previous one did not do what I expected.

Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

Index: linux-2.6/arch/powerpc/platforms/cell/spufs/file.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/spufs/file.c
+++ linux-2.6/arch/powerpc/platforms/cell/spufs/file.c
@@ -385,7 +385,7 @@ static ssize_t spufs_mbox_read(struct fi
 	udata = (void __user *)buf;
 
 	spu_acquire(ctx);
-	for (count = 0; count <= len; count += 4, udata++) {
+	for (count = 0; (count + 4) <= len; count += 4, udata++) {
 		int ret;
 		ret = ctx->ops->mbox_read(ctx, &mbox_data);
 		if (ret == 0)

--

