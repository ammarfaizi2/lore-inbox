Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129742AbRANLdu>; Sun, 14 Jan 2001 06:33:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130018AbRANLdj>; Sun, 14 Jan 2001 06:33:39 -0500
Received: from pizda.ninka.net ([216.101.162.242]:8091 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129741AbRANLd2>;
	Sun, 14 Jan 2001 06:33:28 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14945.36440.59585.376942@pizda.ninka.net>
Date: Sun, 14 Jan 2001 03:32:40 -0800 (PST)
To: Petru Paler <ppetru@ppetru.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-pre3+zerocopy: weird messages
In-Reply-To: <20010114132845.F1394@ppetru.net>
In-Reply-To: <20010114121105.B1394@ppetru.net>
	<14945.32886.671619.99921@pizda.ninka.net>
	<20010114124549.D1394@ppetru.net>
	<14945.34414.185794.396720@pizda.ninka.net>
	<20010114132845.F1394@ppetru.net>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Petru Paler writes:
 > > Oh, I think I know why this happens.  Can you add this patch, and next
 > > time the UDP bad csum message appears, tell me if it says "UDP packet
 > > with bad csum was fragmented." in the next line of your syslog
 > > messages?  Thanks.
 > 
 > Sure, but I also need the actual patch :)

Duh, here it is :-)

--- net/ipv4/udp.c.~1~	Thu Jan 11 10:20:40 2001
+++ net/ipv4/udp.c	Sun Jan 14 02:58:07 2001
@@ -855,6 +855,8 @@
 		if (!udp_check(uh, ulen, saddr, daddr, skb->csum))
 			return 0;
 		NETDEBUG(printk(KERN_DEBUG "udp v4 hw csum failure.\n"));
+		if (skb_shinfo(skb)->frag_list != NULL)
+			printk(KERN_DEBUG "UDP packet with bad csum was fragmented.\n");
 		skb->ip_summed = CHECKSUM_NONE;
 	}
 	if (skb->ip_summed != CHECKSUM_UNNECESSARY)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
