Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267316AbUHWTAQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267316AbUHWTAQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 15:00:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267317AbUHWS6a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 14:58:30 -0400
Received: from mail.kroah.org ([69.55.234.183]:13508 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267316AbUHWShH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 14:37:07 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI and I2C fixes for 2.6.8
User-Agent: Mutt/1.5.6i
In-Reply-To: <10932860871097@kroah.com>
Date: Mon, 23 Aug 2004 11:34:47 -0700
Message-Id: <10932860873079@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1807.56.29, 2004/08/06 15:32:54-07:00, johnpol@2ka.mipt.ru

[PATCH] w1: Debug output cleanup. memcpy instead of direct structure copying.

Debug output cleanup. memcpy instead of direct structure copying.

Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/w1/w1.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)


diff -Nru a/drivers/w1/w1.c b/drivers/w1/w1.c
--- a/drivers/w1/w1.c	2004-08-23 11:03:51 -07:00
+++ b/drivers/w1/w1.c	2004-08-23 11:03:51 -07:00
@@ -406,8 +406,8 @@
 	f = w1_family_registered(rn->family);
 	if (!f) {
 		spin_unlock(&w1_flock);
-		dev_info(&dev->dev, "Family %x is not registered.\n",
-			  rn->family);
+		dev_info(&dev->dev, "Family %x for %02x.%012llx.%02x is not registered.\n",
+			  rn->family, rn->family, rn->id, rn->crc);
 		kfree(sl);
 		return -ENODEV;
 	}
@@ -428,7 +428,7 @@
 
 	dev->slave_count++;
 
-	msg.id.id = *rn;
+	memcpy(&msg.id.id, rn, sizeof(msg.id.id));
 	msg.type = W1_SLAVE_ADD;
 	w1_netlink_send(dev, &msg);
 
@@ -449,7 +449,7 @@
 	device_unregister(&sl->dev);
 	w1_family_put(sl->family);
 
-	msg.id.id = sl->reg_num;
+	memcpy(&msg.id.id, &sl->reg_num, sizeof(msg.id.id));
 	msg.type = W1_SLAVE_REMOVE;
 	w1_netlink_send(sl->master, &msg);
 }

