Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264124AbTFPSXg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 14:23:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264115AbTFPSXg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 14:23:36 -0400
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:1800 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S264091AbTFPSXZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 14:23:25 -0400
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: linux-ppp@vger.kernel.org
Subject: [PATCH] 2.5.71: remove MOD_{INC,DEC}_USE_COUNT from ppp_async
Date: Mon, 16 Jun 2003 22:34:33 +0400
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_52g7++T7qfisoTv"
Message-Id: <200306162234.33350.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_52g7++T7qfisoTv
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

It compiles and runs and does not allow me to unload ppp_async while up and 
running.

regards

-andrey
--Boundary-00=_52g7++T7qfisoTv
Content-Type: text/x-diff;
  charset="us-ascii";
  name="2.5.71-ppp_async.USE_COUNT.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="2.5.71-ppp_async.USE_COUNT.patch"

--- linux-2.5.71/drivers/net/ppp_async.c.USE_COUNT	2003-06-16 20:43:03.000000000 +0400
+++ linux-2.5.71/drivers/net/ppp_async.c	2003-06-16 21:41:07.000000000 +0400
@@ -147,7 +147,6 @@ ppp_asynctty_open(struct tty_struct *tty
 	struct asyncppp *ap;
 	int err;
 
-	MOD_INC_USE_COUNT;
 	err = -ENOMEM;
 	ap = kmalloc(sizeof(*ap), GFP_KERNEL);
 	if (ap == 0)
@@ -183,7 +182,6 @@ ppp_asynctty_open(struct tty_struct *tty
  out_free:
 	kfree(ap);
  out:
-	MOD_DEC_USE_COUNT;
 	return err;
 }
 
@@ -223,7 +221,6 @@ ppp_asynctty_close(struct tty_struct *tt
 	if (ap->tpkt != 0)
 		kfree_skb(ap->tpkt);
 	kfree(ap);
-	MOD_DEC_USE_COUNT;
 }
 
 /*
@@ -351,6 +348,7 @@ ppp_asynctty_wakeup(struct tty_struct *t
 
 
 static struct tty_ldisc ppp_ldisc = {
+	.owner	= THIS_MODULE,
 	.magic	= TTY_LDISC_MAGIC,
 	.name	= "ppp",
 	.open	= ppp_asynctty_open,

--Boundary-00=_52g7++T7qfisoTv--

