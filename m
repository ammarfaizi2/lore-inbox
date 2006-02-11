Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751422AbWBKNck@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751422AbWBKNck (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Feb 2006 08:32:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751423AbWBKNck
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Feb 2006 08:32:40 -0500
Received: from mx2.mail.ru ([194.67.23.122]:40573 "EHLO mx2.mail.ru")
	by vger.kernel.org with ESMTP id S1751422AbWBKNcj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Feb 2006 08:32:39 -0500
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: bridge@osdl.org
Subject: [PATCH] [2.6.15.4] Fix has_bridge_parent undefined with CONFIG_NETFILTER_DEBUG
Date: Sat, 11 Feb 2006 16:32:35 +0300
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602111632.36093.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Apparently introduced in the latest stable set; I am not sure if this is a 
right fix but given that bridge parent already exists at this point it was 
rather silly to fetch it again.

- -regards

- -andrey

Subject: [PATCH] [2.6.15.4] Fix has_bridge_parent undefined with 
CONFIG_NETFILTER_DEBUG

This changes br_nf_post_routing to use realoutdev in debug print. At this
time it is equal to bridge_parent and is guaranteed to be not NULL.

Signed-off-by: Andrey Borzenkov <arvidjaar@mail.ru>


- ---

 net/bridge/br_netfilter.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

db15f4ffe50096ba1585cfa344a440626724cfda
diff --git a/net/bridge/br_netfilter.c b/net/bridge/br_netfilter.c
index 0770664..37e085b 100644
- --- a/net/bridge/br_netfilter.c
+++ b/net/bridge/br_netfilter.c
@@ -793,9 +793,7 @@ static unsigned int br_nf_post_routing(u
 #ifdef CONFIG_NETFILTER_DEBUG
 print_error:
 	if (skb->dev != NULL) {
- -		printk("[%s]", skb->dev->name);
- -		if (has_bridge_parent(skb->dev))
- -			printk("[%s]", bridge_parent(skb->dev)->name);
+		printk("[%s][%s]", skb->dev->name, realoutdev->name);
 	}
 	printk(" head:%p, raw:%p, data:%p\n", skb->head, skb->mac.raw,
 					      skb->data);
- -- 
1.1.6
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFD7edzR6LMutpd94wRAngvAJsGuZqITozDySJ1UOHH2fs9zkoRMACfXT19
RvWlH+TGksJk+hDU9d2pR+o=
=yXVz
-----END PGP SIGNATURE-----
