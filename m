Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271316AbTGQCnc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 22:43:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271333AbTGQCnc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 22:43:32 -0400
Received: from [66.212.224.118] ([66.212.224.118]:63495 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S271316AbTGQCnb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 22:43:31 -0400
Date: Wed, 16 Jul 2003 22:46:59 -0400 (EDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: "David S. Miller" <davem@redhat.com>
Subject: [PATCH][2.6] propogate rx errors from raw_rcv_skb
Message-ID: <Pine.LNX.4.53.0307162243480.32541@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,
	This looks somewhat sane, ipv6 doesn't seem to need it as it 
always returns 0

Index: linux-2.6.0-test1-mm1/net/ipv4/raw.c
===================================================================
RCS file: /build/cvsroot/linux-2.6.0-test1-mm1/net/ipv4/raw.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 raw.c
--- linux-2.6.0-test1-mm1/net/ipv4/raw.c	16 Jul 2003 06:37:19 -0000	1.1.1.1
+++ linux-2.6.0-test1-mm1/net/ipv4/raw.c	16 Jul 2003 16:11:50 -0000
@@ -252,8 +252,7 @@ int raw_rcv(struct sock *sk, struct sk_b
 
 	skb_push(skb, skb->data - skb->nh.raw);
 
-	raw_rcv_skb(sk, skb);
-	return 0;
+	return raw_rcv_skb(sk, skb);
 }
 
 static int raw_send_hdrinc(struct sock *sk, void *from, int length,
