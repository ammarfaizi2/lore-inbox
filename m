Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129535AbRCAGbf>; Thu, 1 Mar 2001 01:31:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129536AbRCAGb0>; Thu, 1 Mar 2001 01:31:26 -0500
Received: from asbestos.linuxcare.com.au ([203.17.0.30]:17659 "EHLO halfway")
	by vger.kernel.org with ESMTP id <S129535AbRCAGbN>;
	Thu, 1 Mar 2001 01:31:13 -0500
From: Rusty Russell <rusty@linuxcare.com.au>
To: "Christian Worm Mortensen" <worm@dkik.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Networking on 2.4: Finding source of a masqgraded packet and source/destination MAC address 
In-Reply-To: Your message of "Wed, 28 Feb 2001 22:19:29 BST."
             <01a001c0a1cc$22bd5e50$5f01a8c0@worm> 
Date: Thu, 01 Mar 2001 17:30:50 +1100
Message-Id: <E14YMby-00086I-00@halfway>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <01a001c0a1cc$22bd5e50$5f01a8c0@worm> you write:
> Hi,
> 
> I am the author of the WRR (http://wipl-wrr.dkik.dk/wrr) qdisc, an extension 
to the 2.2 kernels which is supposed to run on a router/bridge/firewall and do 
Weighted Round Robin scheduling with a class for each local machine.
> 
> Now, I want to port this scheduler to 2.4. One of the problems is that someti
mes I have an outgoing (to the world) packet which has been masqgraded. I want 
to account this packet to the local machine which has originally generated it. 
On 2.2. I used the following code to get the IP address of the local machine:
> 

If they are using masquerading, the nfct will be set.  Use
#include <linux/netfilter_ipv4/ip_conntrack.h>


enum ip_conntrack_info ctinfo;
struct ip_conntrack *ct;

ct = ip_conntrack_get(skb, &ctinfo);
if (ct) {
	/* We want the initial source. */
	ipaddr = ct->tuplehash[CTINFO2DIR(ctinfo)].tuple.src.ip;
} else {
	ipaddr = skb->nh.iph.saddr;
}

Cheers!
Rusty.
--
Premature optmztion is rt of all evl. --DK
