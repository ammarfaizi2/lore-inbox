Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161008AbWCXGO5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161008AbWCXGO5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 01:14:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423169AbWCXGMK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 01:12:10 -0500
Received: from mail.kroah.org ([69.55.234.183]:39642 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161014AbWCXGLs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 01:11:48 -0500
Cc: "Ed L. Cashin" <ecashin@coraid.com>, "Ed L. Cashin" <ecashin@coraid.com>
Subject: [PATCH 05/12] aoe [5/8]: allow network interface migration on packet retransmit
In-Reply-To: <11431806533029-git-send-email-gregkh@suse.de>
X-Mailer: git-send-email
Date: Thu, 23 Mar 2006 22:10:53 -0800
Message-Id: <11431806531102-git-send-email-gregkh@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Retransmit to the current network interface for an AoE device.

Signed-off-by: "Ed L. Cashin" <ecashin@coraid.com>

---

 drivers/block/aoe/aoecmd.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

2dd5e42269b6f71db8ca519e401ef1e6615b3705
diff --git a/drivers/block/aoe/aoecmd.c b/drivers/block/aoe/aoecmd.c
index 34b8c8c..22bebf8 100644
--- a/drivers/block/aoe/aoecmd.c
+++ b/drivers/block/aoe/aoecmd.c
@@ -286,6 +286,8 @@ rexmit(struct aoedev *d, struct frame *f
 	h = (struct aoe_hdr *) f->data;
 	f->tag = n;
 	h->tag = cpu_to_be32(n);
+	memcpy(h->dst, d->addr, sizeof h->dst);
+	memcpy(h->src, d->ifp->dev_addr, sizeof h->src);
 
 	skb = skb_prepare(d, f);
 	if (skb) {
-- 
1.2.4


