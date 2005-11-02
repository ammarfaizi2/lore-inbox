Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932322AbVKBGYE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932322AbVKBGYE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 01:24:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932346AbVKBGYE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 01:24:04 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:11164 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932322AbVKBGYC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 01:24:02 -0500
Message-ID: <43685B63.7020701@jp.fujitsu.com>
Date: Wed, 02 Nov 2005 15:23:31 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@mbligh.org>
CC: Nick Piggin <nickpiggin@yahoo.com.au>,
       Joel Schopp <jschopp@austin.ibm.com>, Mel Gorman <mel@csn.ul.ie>,
       Andrew Morton <akpm@osdl.org>, kravetz@us.ibm.com, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, lhms-devel@lists.sourceforge.net,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
References: <20051030183354.22266.42795.sendpatchset@skynet.csn.ul.ie><20051031055725.GA3820@w-mikek2.ibm.com><4365BBC4.2090906@yahoo.com.au> <20051030235440.6938a0e9.akpm@osdl.org> <27700000.1130769270@[10.10.2.4]> <4366A8D1.7020507@yahoo.com.au> <Pine.LNX.4.58.0510312333240.29390@skynet> <4366C559.5090504@yahoo.com.au> <Pine.LNX.4.58.0511010137020.29390@skynet> <4366D469.2010202@yahoo.com.au> <4367D71A.1030208@austin.ibm.com> <43681100.1000603@yahoo.com.au> <214340000.1130895665@[10.10.2.4]> <43681E89.8070905@yahoo.com.au> <216280000.1130898244@[10.10.2.4]> <43682940.3020200@yahoo.com.au> <217570000.1130906356@[10.10.2.4]> <43684A16.70401@yahoo.com.au> <231260000.1130908490@[10.10.2.4]>
In-Reply-To: <231260000.1130908490@[10.10.2.4]>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:
>>True, but we don't seem to have huge problems with other things. The
>>main ones that have come up on lkml are e1000 which is getting fixed,
>>and maybe XFS which I think there are also moves to improve.
> 
> 
> It should be fairly easy to trawl through the list of all allocations 
> and pull out all the higher order ones from the whole source tree. I
> suspect there's a lot ... maybe I'll play with it later on.
> 

please check kmalloc(32k,64k)

For example, loopback device's default MTU=16436 means order=3 and
maybe there are other high MTU device.

I suspect skb_makewritable()/skb_copy()/skb_linearize() function can be
sufferd from fragmentation when MTU is big. They allocs large skb by
gathering fragmented skbs.When these skb_* funcs failed, the packet
is silently discarded by netfilter. If fragmentation is heavy, packets
(especialy TCP) uses large MTU never reachs its end, even if loopback.

Honestly, I'm not familiar with network code, could anyone comment this ?

-- Kame


