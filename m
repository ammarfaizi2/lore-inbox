Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750916AbWELFRm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750916AbWELFRm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 01:17:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750917AbWELFRm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 01:17:42 -0400
Received: from smtp103.mail.mud.yahoo.com ([209.191.85.213]:7870 "HELO
	smtp103.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750912AbWELFRm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 01:17:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=H2tpj3iYuThirCBugayr4wrQ1r8iOszBDRTJCHczatQCsrPMV9rXk04vGWh+pLgGtdx1zdUvJqZRA3ruToyLBX8B7X54JhQrYjzgJK2HAWRp+bJ8fmo5XHiofZ3PHb7ZWs7HN81VFElnzVY4MAJck4M4Dw8ULCdD4BTufXJdNO8=  ;
Message-ID: <44641A72.8050801@yahoo.com.au>
Date: Fri, 12 May 2006 15:17:38 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Brian Twichell <tbrian@us.ibm.com>
CC: Hugh Dickins <hugh@veritas.com>, Dave McCracken <dmccr@us.ibm.com>,
       Linux Memory Management <linux-mm@kvack.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2][RFC] New version of shared page tables
References: <1146671004.24422.20.camel@wildcat.int.mccr.org> <Pine.LNX.4.64.0605031650190.3057@blonde.wat.veritas.com> <57DF992082E5BD7D36C9D441@[10.1.1.4]> <Pine.LNX.4.64.0605061620560.5462@blonde.wat.veritas.com> <445FA0CA.4010008@us.ibm.com> <44600F9B.1060207@yahoo.com.au> <446242CB.4090106@us.ibm.com>
In-Reply-To: <446242CB.4090106@us.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian Twichell wrote:
> Nick Piggin wrote:

>> Of course if it was free performance then we'd want it. The downsides 
>> are that it
>> is a significant complexity for a pretty small (3%) performance gain 
>> for your apparent
>> target workload, which is pretty uncommon among all Linux users.
> 
> 
> Our performance data demonstrated that the potential gain for the 
> non-hugepage case is much higher than 3%.

The point is, there are hugepages. They were a significant additional
complexity but the concession was made because they did provide a
large speedup for databases.

> 
>>
>> Ignoring the complexity, it is still not free. Sharing data across 
>> processes adds to
>> synchronisation overhead and hurts scalability. Some of these page 
>> fault scalability
>> scenarios have shown to be important enough that we have introduced 
>> complexity _there_.
> 
> 
> True, but this needs to be balanced against the fact that pagetable 
> sharing will reduce the number of page faults when it is achieved.  
> Let's say you have N processes which touch all the pages in an M page 
> shared memory region.  Without shared pagetables this requires N*M page 
> faults; if pagetable sharing is achieved, only M pagefaults are required.
> 
>>
>> And it seems customers running "out-of-the-box" settings really want 
>> to start using
>> hugepages if they're interested in getting the most performance 
>> possible, no?
> 
> 
> My perspective is that, once the customer is required to invoke "echo 
> XXX > /proc/sys/vm/nr_hugepages" they've left the "out-of-the-box" 
> domain, and entered the domain of hoping that the number of hugepages is 
> sufficient, because if it's not, they'll probably need to reboot, which 
> can be pretty inconvenient for a production transaction-processing 
> application.

I think it is pretty easy to reserve hugepages at bootup. This is what
a production transaction processing system will be doing, won't it?
Especially if they're performance constrained and hugepages gives them
a 30% performance boost.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
