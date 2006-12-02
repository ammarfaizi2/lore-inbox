Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423750AbWLBLkJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423750AbWLBLkJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 06:40:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423710AbWLBLjr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 06:39:47 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:23918 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1423697AbWLBLji (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 06:39:38 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:to:cc:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=Bt0rlKtdu6OmqOum8x5mw2sIO7C8VLOgzTHUTCffflok726hMR0caxgvctqIPwKmr/rjiqyIypIbIaNWhFimikpgxtXYRgkHLiI4dtLUU4EgNbh4R05np/o1vaLbSTmRGLqMhjvZzKcd0SatQWkKoU2AEgU/o5L4HrvVAZJ6gSs=
Subject: [PATCH 2.6.19] ipw2200: replace kmalloc+memset with kcalloc
From: Yan Burman <burman.yan@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: trivial@kernel.org
Content-Type: text/plain
Date: Sat, 02 Dec 2006 13:38:14 +0200
Message-Id: <1165059494.4523.43.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 (2.6.0-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replace kmalloc+memset with kcalloc

Signed-off-by: Yan Burman <burman.yan@gmail.com>

diff -rubp linux-2.6.19-rc5_orig/drivers/net/wireless/ipw2200.c linux-2.6.19-rc5_kzalloc/drivers/net/wireless/ipw2200.c
--- linux-2.6.19-rc5_orig/drivers/net/wireless/ipw2200.c	2006-11-09 12:16:21.000000000 +0200
+++ linux-2.6.19-rc5_kzalloc/drivers/net/wireless/ipw2200.c	2006-11-11 22:44:04.000000000 +0200
@@ -11129,14 +11129,13 @@ static int ipw_up(struct ipw_priv *priv)
 		return -EIO;
 
 	if (cmdlog && !priv->cmdlog) {
-		priv->cmdlog = kmalloc(sizeof(*priv->cmdlog) * cmdlog,
+		priv->cmdlog = kcalloc(cmdlog, sizeof(*priv->cmdlog),
 				       GFP_KERNEL);
 		if (priv->cmdlog == NULL) {
 			IPW_ERROR("Error allocating %d command log entries.\n",
 				  cmdlog);
 			return -ENOMEM;
 		} else {
-			memset(priv->cmdlog, 0, sizeof(*priv->cmdlog) * cmdlog);
 			priv->cmdlog_len = cmdlog;
 		}
 	}


