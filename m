Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262788AbVCXPZq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262788AbVCXPZq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 10:25:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262526AbVCXPX0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 10:23:26 -0500
Received: from geode.he.net ([216.218.230.98]:5903 "HELO noserose.net")
	by vger.kernel.org with SMTP id S262788AbVCXPRW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 10:17:22 -0500
From: ecashin@noserose.net
Message-Id: <1111677437.28285@geode.he.net>
Date: Thu, 24 Mar 2005 07:17:17 -0800
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.11] aoe [5/12]: don't try to free null bufpool
References: <87mztbi79d.fsf@coraid.com> <20050317234641.GA7091@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


don't try to free null bufpool

Signed-off-by: Ed L. Cashin <ecashin@coraid.com>

diff -uprN a/drivers/block/aoe/aoedev.c b/drivers/block/aoe/aoedev.c
--- a/drivers/block/aoe/aoedev.c	2005-03-10 12:19:11.000000000 -0500
+++ b/drivers/block/aoe/aoedev.c	2005-03-10 12:19:25.000000000 -0500
@@ -146,7 +146,8 @@ aoedev_freedev(struct aoedev *d)
 		put_disk(d->gd);
 	}
 	kfree(d->frames);
-	mempool_destroy(d->bufpool);
+	if (d->bufpool)
+		mempool_destroy(d->bufpool);
 	kfree(d);
 }
 


-- 
  Ed L. Cashin <ecashin@coraid.com>
