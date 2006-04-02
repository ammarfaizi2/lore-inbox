Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751523AbWDBXOK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751523AbWDBXOK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 19:14:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751527AbWDBXOJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 19:14:09 -0400
Received: from stinky.trash.net ([213.144.137.162]:39400 "EHLO
	stinky.trash.net") by vger.kernel.org with ESMTP id S1751523AbWDBXOI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 19:14:08 -0400
Message-ID: <44305A32.1010109@trash.net>
Date: Mon, 03 Apr 2006 01:11:46 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Thomas Zeitlhofer <thomas.zeitlhofer@nt.tuwien.ac.at>
CC: linux-kernel@vger.kernel.org,
       Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>,
       netdev@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: bridge+netfilter broken for IP fragments in 2.6.16?
References: <20060401143011.GA28333@swan.nt.tuwien.ac.at> <443023C2.6020401@trash.net> <20060402225625.GA22612@swan.nt.tuwien.ac.at>
In-Reply-To: <20060402225625.GA22612@swan.nt.tuwien.ac.at>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Zeitlhofer wrote:
> On Sun, Apr 02, 2006 at 09:19:30PM +0200, Patrick McHardy wrote:
> 
>>>Doing the same on 2.6.15.x shows:
>>>
>>>  1) on tap1: fragmented packets
>>>  2) on br0: the defragmented packet (connection tracking)
>>>  3) on eth1: fragmented packets
>>
>>Are you sure this is correct? I think in 2.6.15 you should see
>>the fragments on br0 already.
> 
> 
> Just verified it, at least in 2.6.15.6 tcpdump shows the defragmented
> packet on br0.

I'm probably missing something, but that still seems stange.
Are you also seeing the defragmented packet on br0 with my
patch?

>>Anyway, since 2.6.16 ip_conntrack doesn't do refragmentation anymore
>>but relies on fragmentation in the IP layer. Purely bridged packets
>>don't go through the IP layer, so the bridge netfilter code needs to
>>take care of fragmentation itself. Please try if this patch helps.
> 
> 
> Your patch solves the problem - tcpdump now shows the refragmented
> packets on eth1. Thanks for the quick solution.
> 
> Just a note, your patch does not work when bridge is compiled as a
> module. In this case modprobe failes with "bridge: Unknown symbol
> ip_fragment". Using CONFIG_BRIDGE=y works.

Thanks, I missed that the Makefile adds br_netfilter.o to
bridge-$(CONFIG_BRIDGE_NETFILTER), not obj-$(...).
