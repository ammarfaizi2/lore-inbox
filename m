Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262190AbTA2AA1>; Tue, 28 Jan 2003 19:00:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262201AbTA2AA1>; Tue, 28 Jan 2003 19:00:27 -0500
Received: from sex.inr.ac.ru ([193.233.7.165]:16803 "HELO sex.inr.ac.ru")
	by vger.kernel.org with SMTP id <S262190AbTA2AA0>;
	Tue, 28 Jan 2003 19:00:26 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200301290009.DAA30355@sex.inr.ac.ru>
Subject: Re: [TEST FIX] Re: SSH Hangs in 2.5.59 and 2.5.55 but not 2.4.x,
To: davem@redhat.com (David S. Miller)
Date: Wed, 29 Jan 2003 03:09:21 +0300 (MSK)
Cc: benoit-lists@fb12.de, dada1@cosmosbay.com, cgf@redhat.com, andersg@0x63.nu,
       lkernel2003@tuxers.net, linux-kernel@vger.kernel.org, tobi@tobi.nu
In-Reply-To: <20030128.152102.12708956.davem@redhat.com> from "David S. Miller" at Jan 28, 3 03:21:02 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

The proposed fix is enclosed. Please, check.

Alexey

===== net/ipv4/tcp_output.c 1.19 vs edited =====
--- 1.19/net/ipv4/tcp_output.c	Fri Oct 25 15:46:21 2002
+++ edited/net/ipv4/tcp_output.c	Wed Jan 29 03:07:26 2003
@@ -786,13 +786,13 @@
 		/* Ok.  We will be able to collapse the packet. */
 		__skb_unlink(next_skb, next_skb->list);
 
+		memcpy(skb_put(skb, next_skb_size), next_skb->data, next_skb_size);
+
 		if (next_skb->ip_summed == CHECKSUM_HW)
 			skb->ip_summed = CHECKSUM_HW;
 
-		if (skb->ip_summed != CHECKSUM_HW) {
-			memcpy(skb_put(skb, next_skb_size), next_skb->data, next_skb_size);
+		if (skb->ip_summed != CHECKSUM_HW)
 			skb->csum = csum_block_add(skb->csum, next_skb->csum, skb_size);
-		}
 
 		/* Update sequence range on original skb. */
 		TCP_SKB_CB(skb)->end_seq = TCP_SKB_CB(next_skb)->end_seq;
