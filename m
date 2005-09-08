Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965042AbVIHWYz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965042AbVIHWYz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 18:24:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965055AbVIHWYr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 18:24:47 -0400
Received: from mail.kroah.org ([69.55.234.183]:42430 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965042AbVIHWW5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 18:22:57 -0400
Cc: johnpol@2ka.mipt.ru
Subject: [PATCH] w1: Decreased debug level.
In-Reply-To: <11262181623853@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 8 Sep 2005 15:22:42 -0700
Message-Id: <11262181623532@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] w1: Decreased debug level.

Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 7c8f5703de91ade517d4fd6c3cc8e08dbba2b739
tree aa01c3513c66569f9626a51978cd82b10fd6615e
parent 3aca692d3ec7cf89da4575f598e41f74502b22d7
author Evgeniy Polyakov <johnpol@2ka.mipt.ru> Thu, 11 Aug 2005 17:27:50 +0400
committer Greg Kroah-Hartman <gregkh@suse.de> Thu, 08 Sep 2005 14:41:27 -0700

 drivers/w1/w1.c |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/w1/w1.c b/drivers/w1/w1.c
--- a/drivers/w1/w1.c
+++ b/drivers/w1/w1.c
@@ -527,8 +527,6 @@ static int w1_attach_slave_device(struct
 	msg.type = W1_SLAVE_ADD;
 	w1_netlink_send(dev, &msg);
 
-	dev_info(&dev->dev, "Finished %s for sl=%p.\n", __func__, sl);
-
 	return 0;
 }
 
@@ -536,7 +534,7 @@ static void w1_slave_detach(struct w1_sl
 {
 	struct w1_netlink_msg msg;
 
-	dev_info(&sl->dev, "%s: detaching %s [%p].\n", __func__, sl->name, sl);
+	dev_dbg(&sl->dev, "%s: detaching %s [%p].\n", __func__, sl->name, sl);
 
 	list_del(&sl->w1_slave_entry);
 
@@ -579,7 +577,7 @@ void w1_reconnect_slaves(struct w1_famil
 
 	spin_lock_bh(&w1_mlock);
 	list_for_each_entry(dev, &w1_masters, w1_master_entry) {
-		dev_info(&dev->dev, "Reconnecting slaves in %s into new family %02x.\n",
+		dev_dbg(&dev->dev, "Reconnecting slaves in %s into new family %02x.\n",
 				dev->name, f->fid);
 		set_bit(W1_MASTER_NEED_RECONNECT, &dev->flags);
 	}
@@ -768,7 +766,7 @@ static int w1_control(void *data)
 			}
 
 			if (test_bit(W1_MASTER_NEED_RECONNECT, &dev->flags)) {
-				dev_info(&dev->dev, "Reconnecting slaves in device %s.\n", dev->name);
+				dev_dbg(&dev->dev, "Reconnecting slaves in device %s.\n", dev->name);
 				down(&dev->mutex);
 				list_for_each_entry_safe(sl, sln, &dev->slist, w1_slave_entry) {
 					if (sl->family->fid == W1_FAMILY_DEFAULT) {
@@ -780,7 +778,7 @@ static int w1_control(void *data)
 						w1_attach_slave_device(dev, &rn);
 					}
 				}
-				dev_info(&dev->dev, "Reconnecting slaves in device %s has been finished.\n", dev->name);
+				dev_dbg(&dev->dev, "Reconnecting slaves in device %s has been finished.\n", dev->name);
 				clear_bit(W1_MASTER_NEED_RECONNECT, &dev->flags);
 				up(&dev->mutex);
 			}

