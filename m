Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262395AbSKMTtV>; Wed, 13 Nov 2002 14:49:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262449AbSKMTtV>; Wed, 13 Nov 2002 14:49:21 -0500
Received: from mail.parknet.co.jp ([210.134.213.6]:59916 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S262395AbSKMTtU>; Wed, 13 Nov 2002 14:49:20 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] init_timer for fmvj18x_cs.c and pcnet_cs.c
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Thu, 14 Nov 2002 04:56:01 +0900
Message-ID: <874ralp7la.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This adds init_timer() to fmvj18x_cs.c and pcnet_cs.c.

Please apply.

 drivers/net/pcmcia/fmvj18x_cs.c |    1 +
 drivers/net/pcmcia/pcnet_cs.c   |    3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

--- linux-2.5.47/drivers/net/pcmcia/fmvj18x_cs.c~init_timer-fix	2002-11-14 02:41:44.000000000 +0900
+++ linux-2.5.47-hirofumi/drivers/net/pcmcia/fmvj18x_cs.c	2002-11-14 02:41:44.000000000 +0900
@@ -291,6 +291,7 @@ static dev_link_t *fmvj18x_attach(void)
     link = &lp->link; dev = &lp->dev;
     link->priv = dev->priv = link->irq.Instance = lp;
 
+    init_timer(&link->release);
     link->release.function = &fmvj18x_release;
     link->release.data = (u_long)link;
 
--- linux-2.5.47/drivers/net/pcmcia/pcnet_cs.c~init_timer-fix	2002-11-14 02:41:44.000000000 +0900
+++ linux-2.5.47-hirofumi/drivers/net/pcmcia/pcnet_cs.c	2002-11-14 02:41:44.000000000 +0900
@@ -301,7 +301,8 @@ static dev_link_t *pcnet_attach(void)
     memset(info, 0, sizeof(*info));
     link = &info->link; dev = &info->dev;
     link->priv = info;
-    
+
+    init_timer(&link->release);
     link->release.function = &pcnet_release;
     link->release.data = (u_long)link;
     link->irq.Attributes = IRQ_TYPE_EXCLUSIVE;

_
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
