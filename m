Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423178AbWCXGMn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423178AbWCXGMn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 01:12:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423175AbWCXGMU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 01:12:20 -0500
Received: from mail.kroah.org ([69.55.234.183]:35290 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161007AbWCXGLk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 01:11:40 -0500
Cc: "Ed L. Cashin" <ecashin@coraid.com>, "Ed L. Cashin" <ecashin@coraid.com>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 01/12] aoe [1/8]: zero packet data after skb allocation
In-Reply-To: <20060324060905.GA20310@kroah.com>
X-Mailer: git-send-email
Date: Thu, 23 Mar 2006 22:10:53 -0800
Message-Id: <1143180653125-git-send-email-gregkh@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zero the data in new socket buffers to prevent leaking information.

Signed-off-by: "Ed L. Cashin" <ecashin@coraid.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---

 drivers/block/aoe/aoecmd.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

50bba752ca0a740a6ba9eb96d61ef7bbdfe405cf
diff --git a/drivers/block/aoe/aoecmd.c b/drivers/block/aoe/aoecmd.c
index 326ca38..4ab01ce 100644
--- a/drivers/block/aoe/aoecmd.c
+++ b/drivers/block/aoe/aoecmd.c
@@ -28,6 +28,7 @@ new_skb(struct net_device *if_dev, ulong
 		skb->protocol = __constant_htons(ETH_P_AOE);
 		skb->priority = 0;
 		skb_put(skb, len);
+		memset(skb->head, 0, len);
 		skb->next = skb->prev = NULL;
 
 		/* tell the network layer not to perform IP checksums
-- 
1.2.4


