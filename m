Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750906AbWDBXg4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750906AbWDBXg4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 19:36:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750833AbWDBXg4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 19:36:56 -0400
Received: from swan.nt.tuwien.ac.at ([128.131.67.158]:22509 "EHLO
	swan.nt.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S1750906AbWDBXgz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 19:36:55 -0400
Date: Mon, 3 Apr 2006 01:36:53 +0200
From: Thomas Zeitlhofer <thomas.zeitlhofer@nt.tuwien.ac.at>
To: Patrick McHardy <kaber@trash.net>
Cc: linux-kernel@vger.kernel.org,
       Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>,
       netdev@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: bridge+netfilter broken for IP fragments in 2.6.16?
Message-ID: <20060402233653.GA30271@swan.nt.tuwien.ac.at>
References: <20060401143011.GA28333@swan.nt.tuwien.ac.at> <443023C2.6020401@trash.net> <20060402225625.GA22612@swan.nt.tuwien.ac.at> <44305A32.1010109@trash.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44305A32.1010109@trash.net>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 03, 2006 at 01:11:46AM +0200, Patrick McHardy wrote:
> Thomas Zeitlhofer wrote:
> > On Sun, Apr 02, 2006 at 09:19:30PM +0200, Patrick McHardy wrote:
> > 
> >>>Doing the same on 2.6.15.x shows:
> >>>
> >>>  1) on tap1: fragmented packets
> >>>  2) on br0: the defragmented packet (connection tracking)
> >>>  3) on eth1: fragmented packets
> >>
> >>Are you sure this is correct? I think in 2.6.15 you should see
> >>the fragments on br0 already.
> > 
> > 
> > Just verified it, at least in 2.6.15.6 tcpdump shows the defragmented
> > packet on br0.
> 
> I'm probably missing something, but that still seems stange.
> Are you also seeing the defragmented packet on br0 with my
> patch?

Yes, here is the tcpdump output on all interfaces: 

1) on tap1
23:22:51.830046 IP (tos 0x0, ttl  64, id 21174, offset 0, flags [+], proto: UDP (17), length: 1500) 192.168.10.1.500 > 192.168.20.1.500: isakmp 1.0 msgid : phase 1 I ident[E]: [encrypted id] (len mismatch: isakmp 2572/ip 1472)
23:22:51.830084 IP (tos 0x0, ttl  64, id 21174, offset 1480, flags [none], proto: UDP (17), length: 1120) 192.168.10.1 > 192.168.20.1: udp 

2) on br0
23:22:51.830084 IP (tos 0x0, ttl  64, id 21174, offset 0, flags [none], proto: UDP (17), length: 2600) 192.168.10.1.500 > 192.168.20.1.500: isakmp 1.0 msgid : phase 1 I ident[E]: [encrypted id]

3) on eth1 
23:22:51.830120 IP (tos 0x0, ttl  64, id 21174, offset 0, flags [+], proto: UDP (17), length: 1500) 192.168.10.1.500 > 192.168.20.1.500: isakmp 1.0 msgid : phase 1 I ident[E]: [encrypted id] (len mismatch: isakmp 2572/ip 1472)
23:22:51.830133 IP (tos 0x0, ttl  64, id 21174, offset 1480, flags [none], proto: UDP (17), length: 1120) 192.168.10.1 > 192.168.20.1: udp

--
Thomas
