Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132725AbRDQPca>; Tue, 17 Apr 2001 11:32:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132727AbRDQPcV>; Tue, 17 Apr 2001 11:32:21 -0400
Received: from twinlark.arctic.org ([204.107.140.52]:5893 "HELO
	twinlark.arctic.org") by vger.kernel.org with SMTP
	id <S132725AbRDQPcE>; Tue, 17 Apr 2001 11:32:04 -0400
Date: Tue, 17 Apr 2001 08:32:02 -0700 (PDT)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Eric Weigle <ehw@lanl.gov>
cc: Sampsa Ranta <sampsa@netsonic.fi>, <linux-net@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Broken ARP (was Re: ARP responses broken!)
In-Reply-To: <3ADC5F81.2B13CE5D@lanl.gov>
Message-ID: <Pine.LNX.4.33.0104170828010.19451-100000@twinlark.arctic.org>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Apr 2001, Eric Weigle wrote:

> Ok, I was ignorant of the arp filter functionality in 2.2. I found an old
> (probably painfully out-of-date) posting the patch Andi Kleen was referring to
> in the archive, but I've not used it.
> http://www.uwsg.indiana.edu/hypermail/linux/kernel/0101.2/1198.html

oh heck, why not post a third patch for this problem.  here's the one i
wrote.

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

