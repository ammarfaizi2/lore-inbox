Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266775AbUIAQHU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266775AbUIAQHU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 12:07:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267335AbUIAP5y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 11:57:54 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:59314 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S267294AbUIAPvn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 11:51:43 -0400
Date: Wed, 1 Sep 2004 16:51:20 +0100
Message-Id: <200409011551.i81FpKj2000605@delerium.codemonkey.org.uk>
From: Dave Jones <davej@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix leak in PNP interface code.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Spotted with the source checker from Coverity.com.

Signed-off-by: Dave Jones <davej@redhat.com>


diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/pnp/interface.c linux-2.6/drivers/pnp/interface.c
--- bk-linus/drivers/pnp/interface.c	2004-06-03 13:40:04.000000000 +0100
+++ linux-2.6/drivers/pnp/interface.c	2004-06-03 13:42:25.000000000 +0100
@@ -244,8 +244,10 @@ static ssize_t pnp_show_current_resource
 				pnp_alloc(sizeof(pnp_info_buffer_t));
 	if (!buffer)
 		return -ENOMEM;
-	if (!dev)
+	if (!dev) {
+		kfree(buffer);
 		return -EINVAL;
+	}
 	buffer->len = PAGE_SIZE;
 	buffer->buffer = buf;
 	buffer->curr = buffer->buffer;
