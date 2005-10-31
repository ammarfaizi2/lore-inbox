Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964871AbVKAAkq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964871AbVKAAkq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 19:40:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751362AbVKAAkq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 19:40:46 -0500
Received: from smtp203.mail.sc5.yahoo.com ([216.136.129.93]:165 "HELO
	smtp203.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1751361AbVKAAkp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 19:40:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=0CqkB5xcMrKr5AjNqEKrf7IMIwNUOapWSOQMIyivWv/BxQnHofK16vhBI5rZEbGKmesMP1toLmqeNzoiwSmFNnqtkuk5UcioQuyywmYXq13bYoDP4jaD2px0gNls8SnthngzpxziR3YKq4X8jN8a4CDLMtSiFn42c7QPIgsJTso=  ;
Message-ID: <4366AFC7.3060505@yahoo.com.au>
Date: Tue, 01 Nov 2005 10:59:03 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@mbligh.org>
CC: Andrew Morton <akpm@osdl.org>, kravetz@us.ibm.com, mel@csn.ul.ie,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       lhms-devel@lists.sourceforge.net
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
References: <20051030183354.22266.42795.sendpatchset@skynet.csn.ul.ie><20051031055725.GA3820@w-mikek2.ibm.com><4365BBC4.2090906@yahoo.com.au><20051030235440.6938a0e9.akpm@osdl.org><27700000.1130769270@[10.10.2.4]> <20051031112409.153e7048.akpm@osdl.org> <3660000.1130787652@flay>
In-Reply-To: <3660000.1130787652@flay>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:
> --On Monday, October 31, 2005 11:24:09 -0800 Andrew Morton <akpm@osdl.org> wrote:

>>I suspect this would all be a non-issue if the net drivers were using
>>__GFP_NOWARN ;)
> 
> 
> We still need to allocate them, even if it's GFP_KERNEL. As memory gets
> larger and larger, and we have no targetted reclaim, we'll have to blow
> away more and more stuff at random before we happen to get contiguous
> free areas. Just statistics aren't in your favour ... Getting 4 contig
> pages on a 1GB desktop is much harder than on a 128MB machine. 
> 

However, these allocations are not of the "easy to reclaim" type, in
which case they just use the regular fragmented-to-shit areas. If no
contiguous pages are available from there, then an easy-reclaim area
needs to be stolen, right?

In which case I don't see why these patches don't have similar long
term failure cases if there is strong demand for higher order
allocations. Prolong things a bit, perhaps, but...

> Is not going to get better as time goes on ;-) Yeah, yeah, I know, you
> want recreates, numbers, etc. Not the easiest thing to reproduce in a
> short-term consistent manner though.
> 

Regardless, I think we need to continue our steady move away from
higher order allocation requirements.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
