Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132780AbRANNWl>; Sun, 14 Jan 2001 08:22:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132896AbRANNWb>; Sun, 14 Jan 2001 08:22:31 -0500
Received: from pizda.ninka.net ([216.101.162.242]:63643 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S132780AbRANNWX>;
	Sun, 14 Jan 2001 08:22:23 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14945.42973.905573.579075@pizda.ninka.net>
Date: Sun, 14 Jan 2001 05:21:33 -0800 (PST)
To: Petru Paler <ppetru@ppetru.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-pre3+zerocopy: weird messages
In-Reply-To: <20010114151257.J1394@ppetru.net>
In-Reply-To: <20010114121105.B1394@ppetru.net>
	<14945.32886.671619.99921@pizda.ninka.net>
	<20010114124549.D1394@ppetru.net>
	<14945.34414.185794.396720@pizda.ninka.net>
	<20010114132845.F1394@ppetru.net>
	<14945.36440.59585.376942@pizda.ninka.net>
	<20010114141003.G1394@ppetru.net>
	<20010114151257.J1394@ppetru.net>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Petru Paler writes:
 > Got more "udp v4 hw csum failure" messages but still no "UDP packet
 > with bad csum was fragmented".

OK, last experiment :-)  Add this patch, and watch to see if
the UDP "InErrors" field in /proc/net/snmp has a non-zero value after
letting it run for a while.  Thanks.

--- drivers/net/sunhme.c.~1~	Wed Dec 13 10:31:46 2000
+++ drivers/net/sunhme.c	Sun Jan 14 05:19:09 2001
@@ -2109,11 +2109,11 @@
 
 			skb = copy_skb;
 		}
-
+#if 0
 		/* This card is _fucking_ hot... */
 		skb->csum = (csum ^ 0xffff);
 		skb->ip_summed = CHECKSUM_HW;
-
+#endif
 		RXD(("len=%d csum=%4x]", len, csum));
 		skb->protocol = eth_type_trans(skb, dev);
 		netif_rx(skb);
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
