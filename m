Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129737AbQLJLZj>; Sun, 10 Dec 2000 06:25:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129792AbQLJLZ3>; Sun, 10 Dec 2000 06:25:29 -0500
Received: from pizda.ninka.net ([216.101.162.242]:14737 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129737AbQLJLZM>;
	Sun, 10 Dec 2000 06:25:12 -0500
Date: Sun, 10 Dec 2000 02:38:28 -0800
Message-Id: <200012101038.CAA06747@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: ppetru@ppetru.net
CC: linux-kernel@vger.kernel.org
In-Reply-To: <20001210105553.E728@ppetru.net> (message from Petru Paler on
	Sun, 10 Dec 2000 10:55:53 +0200)
Subject: Re: sparc64 network-related problems
In-Reply-To: <20001210105553.E728@ppetru.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: Sun, 10 Dec 2000 10:55:53 +0200
   From: Petru Paler <ppetru@ppetru.net>

   [5.] Output of Oops.. message (if applicable) with symbolic information
	resolved (see Documentation/oops-tracing.txt)                                               

   This is only one of the repeated oopses, if you need all of them I will
   make the logs available.

Is this always the _first_ OOPS though?  That is what is important,
because after the first OOPS all the others are likely just side
effects of the first one.

Anyways, if it is always the first OOPS, the following debugging patch
may help because this case is the only way that OOPS could possibly
happen all by itself.

--- net/ipv4/tcp.c.~1~	Tue Nov 28 08:33:08 2000
+++ net/ipv4/tcp.c	Sun Dec 10 02:36:43 2000
@@ -1014,6 +1014,14 @@
 
 			/* Determine how large of a buffer to allocate.  */
 			tmp = MAX_TCP_HEADER + 15 + tp->mss_cache;
+#if 1
+			if (copy > tmp) {
+				printk("TCP: MSS out of sync copy(%d) tmp(%d) "
+				       "mss_now(%d) mss_cache(%d)\n",
+				       copy, tmp, mss_now, tp->mss_cache);
+				copy = tmp - (MAX_TCP_HEADER + 15);
+			}
+#endif
 			if (copy < mss_now && !(flags & MSG_OOB)) {
 				/* What is happening here is that we want to
 				 * tack on later members of the users iovec
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
