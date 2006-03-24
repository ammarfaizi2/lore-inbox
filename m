Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423162AbWCXGLj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423162AbWCXGLj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 01:11:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161010AbWCXGLj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 01:11:39 -0500
Received: from mail.kroah.org ([69.55.234.183]:34266 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161007AbWCXGLi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 01:11:38 -0500
Cc: "Ed L. Cashin" <ecashin@coraid.com>, "Ed L. Cashin" <ecashin@coraid.com>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 06/12] aoe [6/8]: update device information on last close
In-Reply-To: <11431806531102-git-send-email-gregkh@suse.de>
X-Mailer: git-send-email
Date: Thu, 23 Mar 2006 22:10:53 -0800
Message-Id: <11431806531230-git-send-email-gregkh@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of making the user wait or do it manually, refresh
device information on its last close by issuing a config
query to the device.

Signed-off-by: "Ed L. Cashin" <ecashin@coraid.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---

 drivers/block/aoe/aoeblk.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

5f7702fd737d14de3ed06a94a1655be9d43f7e35
diff --git a/drivers/block/aoe/aoeblk.c b/drivers/block/aoe/aoeblk.c
index 039c091..32fea55 100644
--- a/drivers/block/aoe/aoeblk.c
+++ b/drivers/block/aoe/aoeblk.c
@@ -109,7 +109,7 @@ aoeblk_release(struct inode *inode, stru
 
 	spin_lock_irqsave(&d->lock, flags);
 
-	if (--d->nopen == 0 && !(d->flags & DEVFL_UP)) {
+	if (--d->nopen == 0) {
 		spin_unlock_irqrestore(&d->lock, flags);
 		aoecmd_cfg(d->aoemajor, d->aoeminor);
 		return 0;
-- 
1.2.4


