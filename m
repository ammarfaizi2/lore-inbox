Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268206AbRGWMEB>; Mon, 23 Jul 2001 08:04:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268207AbRGWMDv>; Mon, 23 Jul 2001 08:03:51 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:13828 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S268206AbRGWMDc>; Mon, 23 Jul 2001 08:03:32 -0400
Date: Mon, 23 Jul 2001 16:03:31 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Alignment of dev_addr[] field in the struct net_device
Message-ID: <20010723160331.A583@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Increase of MAX_ADDR_LEN to 8 broke that...

Ivan.

--- 2.4.7/include/linux/netdevice.h	Mon Jul 23 12:40:26 2001
+++ linux/include/linux/netdevice.h	Mon Jul 23 14:58:03 2001
@@ -298,8 +298,8 @@ struct net_device
 
 	/* Interface address info. */
 	unsigned char		broadcast[MAX_ADDR_LEN];	/* hw bcast add	*/
-	unsigned char		pad;		/* make dev_addr aligned to 8 bytes */
-	unsigned char		dev_addr[MAX_ADDR_LEN];	/* hw address	*/
+	unsigned char		dev_addr[MAX_ADDR_LEN] __attribute__((aligned(8)));
+						/* hw address, aligned to 8 bytes */
 	unsigned char		addr_len;	/* hardware address length	*/
 
 	struct dev_mc_list	*mc_list;	/* Multicast mac addresses	*/
