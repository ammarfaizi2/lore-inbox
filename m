Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135574AbREEWyE>; Sat, 5 May 2001 18:54:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135575AbREEWxy>; Sat, 5 May 2001 18:53:54 -0400
Received: from twinlark.arctic.org ([204.107.140.52]:19470 "HELO
	twinlark.arctic.org") by vger.kernel.org with SMTP
	id <S135574AbREEWxl>; Sat, 5 May 2001 18:53:41 -0400
Date: Sat, 5 May 2001 15:53:38 -0700 (PDT)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: "David S. Miller" <davem@redhat.com>
cc: Ben Greear <greearb@candelatech.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Andi Kleen <ak@muc.de>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] arp_filter patch for 2.4.4 kernel.
In-Reply-To: <15092.32371.139915.110859@pizda.ninka.net>
Message-ID: <Pine.LNX.4.33.0105051550000.20277-100000@twinlark.arctic.org>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 May 2001, David S. Miller wrote:

> How difficult is it to compose netfilter rules that do this?

what's the performance impact of doing that?

i've got multiple ip networks on the same gigabit link...  i'm pretty
happy with this tiny patch i've posted before, which is not on any
critical path (it's in the ARP code after all).

-dean

--- linux/net/ipv4/arp.c.badproxy	Mon Feb 12 17:28:48 2001
+++ linux/net/ipv4/arp.c	Tue Feb 13 20:06:37 2001
@@ -737,10 +737,12 @@
 		addr_type = rt->rt_type;

 		if (addr_type == RTN_LOCAL) {
+			if ((rt->rt_flags&RTCF_DIRECTSRC) || IN_DEV_PROXY_ARP(in_dev)) {
 			n = neigh_event_ns(&arp_tbl, sha, &sip, dev);
 			if (n) {
 				arp_send(ARPOP_REPLY,ETH_P_ARP,sip,dev,tip,sha,dev->dev_addr,sha);
 				neigh_release(n);
+			}
 			}
 			goto out;
 		} else if (IN_DEV_FORWARD(in_dev)) {

