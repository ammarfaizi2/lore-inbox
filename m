Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266669AbUIAQVB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266669AbUIAQVB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 12:21:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267325AbUIAP50
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 11:57:26 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:63410 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S267319AbUIAPvo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 11:51:44 -0400
Date: Wed, 1 Sep 2004 16:51:21 +0100
Message-Id: <200409011551.i81FpLho000645@delerium.codemonkey.org.uk>
From: Dave Jones <davej@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix leak in aty fb code.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Spotted with the source checker from Coverity.com.

Signed-off-by: Dave Jones <davej@redhat.com>


diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/video/aty/atyfb_base.c linux-2.6/drivers/video/aty/atyfb_base.c
--- bk-linus/drivers/video/aty/atyfb_base.c	2004-08-01 00:00:35.000000000 +0100
+++ linux-2.6/drivers/video/aty/atyfb_base.c	2004-08-23 14:08:20.000000000 +0100
@@ -2374,6 +2374,7 @@ int __init atyfb_init(void)
 		}
 	}
 #endif				/* CONFIG_ATARI */
+	kfree(info);
 	return 0;
 }
 
