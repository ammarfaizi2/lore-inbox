Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266756AbUIARRg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266756AbUIARRg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 13:17:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267195AbUIAP4N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 11:56:13 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:435 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S267343AbUIAPvp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 11:51:45 -0400
Date: Wed, 1 Sep 2004 16:51:22 +0100
Message-Id: <200409011551.i81FpMa5000670@delerium.codemonkey.org.uk>
From: Dave Jones <davej@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix possible leak in af_ax25
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Spotted with the source checker from Coverity.com.

Signed-off-by: Dave Jones <davej@redhat.com>


diff -urpN --exclude-from=/home/davej/.exclude bk-linus/net/ax25/af_ax25.c linux-2.6/net/ax25/af_ax25.c
--- bk-linus/net/ax25/af_ax25.c	2004-06-07 00:00:22.000000000 +0100
+++ linux-2.6/net/ax25/af_ax25.c	2004-06-07 11:07:06.000000000 +0100
@@ -1272,6 +1272,9 @@ static int ax25_connect(struct socket *s
 
 	sock->state = SS_CONNECTED;
 
+	if (digi != NULL)
+		kfree(digi);
+
 	err=0;
 out:
 	release_sock(sk);
