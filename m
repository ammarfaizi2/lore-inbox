Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130842AbRAKRT3>; Thu, 11 Jan 2001 12:19:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130792AbRAKRTT>; Thu, 11 Jan 2001 12:19:19 -0500
Received: from pizda.ninka.net ([216.101.162.242]:55169 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129990AbRAKRTE>;
	Thu, 11 Jan 2001 12:19:04 -0500
Date: Thu, 11 Jan 2001 09:18:44 -0800
Message-Id: <200101111718.JAA03092@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: pwc@speakeasy.net
CC: andrewm@uow.edu.au, ak@suse.de, linux-kernel@vger.kernel.org,
        linux-net@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0101111023090.716-100000@localhost> (message from
	Paul Cassella on Thu, 11 Jan 2001 10:45:13 -0600 (CST))
Subject: Re: 2.4.0-ac3 write() to tcp socket returning errno of -3 (ESRCH:
 "No such process")
In-Reply-To: <Pine.LNX.4.21.0101111023090.716-100000@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: Thu, 11 Jan 2001 10:45:13 -0600 (CST)
   From: Paul Cassella <pwc@speakeasy.net>

   I'm not familiar enough with the tcp code to know if this patch
   (against -ac6) is a solution, band-aid, or, in fact, wrong, but
   I've run with it (on -ac3) and haven't seen the errors for over
   twelve hours, which is three times longer than it had been able to
   go without it coming up.

See the fix I put in 2.4.1-pre2, which is:

diff -u --recursive --new-file v2.4.0/linux/net/ipv4/tcp.c linux/net/ipv4/tcp.c
--- v2.4.0/linux/net/ipv4/tcp.c	Tue Nov 28 21:53:45 2000
+++ linux/net/ipv4/tcp.c	Wed Jan 10 14:12:12 2001
@@ -954,7 +954,7 @@
 			 */
 			skb = sk->write_queue.prev;
 			if (tp->send_head &&
-			    (mss_now - skb->len) > 0) {
+			    (mss_now > skb->len)) {
 				copy = skb->len;
 				if (skb_tailroom(skb) > 0) {
 					int last_byte_was_odd = (copy % 4);
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
