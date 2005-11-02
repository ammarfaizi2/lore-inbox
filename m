Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932537AbVKBKNb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932537AbVKBKNb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 05:13:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932577AbVKBKNa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 05:13:30 -0500
Received: from smtp204.mail.sc5.yahoo.com ([216.136.130.127]:5558 "HELO
	smtp204.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932537AbVKBKNa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 05:13:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=Acy22bsa1ejQtuVAzMid7OpKCH15QyC+6tkp70FzLwMQ1y4Jm2SKonDtXoypK+cFJKb+NJqX0qDXUN0/cTdTGWfTjiyEWXxxIdVQFTWXHvWdJ62zPHmIthzOWHNqYxY9onh9DtsqSNK/hYrKG/GOe9u9YKsmRt8DDxYsS/gRn5U=  ;
Message-ID: <436891AE.1040709@yahoo.com.au>
Date: Wed, 02 Nov 2005 21:15:10 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
CC: "Martin J. Bligh" <mbligh@mbligh.org>,
       Joel Schopp <jschopp@austin.ibm.com>, Mel Gorman <mel@csn.ul.ie>,
       Andrew Morton <akpm@osdl.org>, kravetz@us.ibm.com, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, lhms-devel@lists.sourceforge.net,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
References: <20051030183354.22266.42795.sendpatchset@skynet.csn.ul.ie><20051031055725.GA3820@w-mikek2.ibm.com><4365BBC4.2090906@yahoo.com.au> <20051030235440.6938a0e9.akpm@osdl.org> <27700000.1130769270@[10.10.2.4]> <4366A8D1.7020507@yahoo.com.au> <Pine.LNX.4.58.0510312333240.29390@skynet> <4366C559.5090504@yahoo.com.au> <Pine.LNX.4.58.0511010137020.29390@skynet> <4366D469.2010202@yahoo.com.au> <4367D71A.1030208@austin.ibm.com> <43681100.1000603@yahoo.com.au> <214340000.1130895665@[10.10.2.4]> <43681E89.8070905@yahoo.com.au> <216280000.1130898244@[10.10.2.4]> <43682940.3020200@yahoo.com.au> <217570000.1130906356@[10.10.2.4]> <43684A16.70401@yahoo.com.au> <231260000.1130908490@[10.10.2.4]> <43685B63.7020701@jp.fujitsu.com>
In-Reply-To: <43685B63.7020701@jp.fujitsu.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

KAMEZAWA Hiroyuki wrote:
> Martin J. Bligh wrote:
> 

> please check kmalloc(32k,64k)
> 
> For example, loopback device's default MTU=16436 means order=3 and
> maybe there are other high MTU device.
> 
> I suspect skb_makewritable()/skb_copy()/skb_linearize() function can be
> sufferd from fragmentation when MTU is big. They allocs large skb by
> gathering fragmented skbs.When these skb_* funcs failed, the packet
> is silently discarded by netfilter. If fragmentation is heavy, packets
> (especialy TCP) uses large MTU never reachs its end, even if loopback.
> 
> Honestly, I'm not familiar with network code, could anyone comment this ?
> 

I'd be interested to know, actually. I was hoping loopback should always
use order-0 allocations, because the loopback driver is SG, FRAGLIST,
and HIGHDMA capable. However I'm likewise not familiar with network code.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
