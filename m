Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932492AbVJaGgV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932492AbVJaGgV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 01:36:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932494AbVJaGgV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 01:36:21 -0500
Received: from smtp205.mail.sc5.yahoo.com ([216.136.129.95]:18523 "HELO
	smtp205.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932492AbVJaGgU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 01:36:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=F6oQy5x3DWLaGA9Q9BTfxQu2GYd1ULYcQTY5W76qo4Nw4QD3Fq5UbXHdtyfdhTLf51yWByQW6VjxFtcIVzPUExUJMCaFE+ItXQ8wtalJoC2k38lt5en74icAynGurmZWGkIvQQIsmzu38Gyo2OkJ75jF5CmFyCShbawLEviuOvQ=  ;
Message-ID: <4365BBC4.2090906@yahoo.com.au>
Date: Mon, 31 Oct 2005 17:37:56 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Mike Kravetz <kravetz@us.ibm.com>
CC: Mel Gorman <mel@csn.ul.ie>, akpm@osdl.org, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, lhms-devel@lists.sourceforge.net
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
References: <20051030183354.22266.42795.sendpatchset@skynet.csn.ul.ie> <20051031055725.GA3820@w-mikek2.ibm.com>
In-Reply-To: <20051031055725.GA3820@w-mikek2.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Kravetz wrote:
> On Sun, Oct 30, 2005 at 06:33:55PM +0000, Mel Gorman wrote:
> 
>>Here are a few brief reasons why this set of patches is useful;
>>
>>o Reduced fragmentation improves the chance a large order allocation succeeds
>>o General-purpose memory hotplug needs the page/memory groupings provided
>>o Reduces the number of badly-placed pages that page migration mechanism must
>>  deal with. This also applies to any active page defragmentation mechanism.
> 
> 
> I can say that this patch set makes hotplug memory remove be of
> value on ppc64.  My system has 6GB of memory and I would 'load
> it up' to the point where it would just start to swap and let it
> run for an hour.  Without these patches, it was almost impossible
> to find a section that could be offlined.  With the patches, I
> can consistently reduce memory to somewhere between 512MB and 1GB.
> Of course, results will vary based on workload.  Also, this is
> most advantageous for memory hotlug on ppc64 due to relatively
> small section size (16MB) as compared to the page grouping size
> (8MB).  A more general purpose solution is needed for memory hotplug
> support on architectures with larger section sizes.
> 
> Just another data point,

Despite what people were trying to tell me at Ottawa, this patch
set really does add quite a lot of complexity to the page
allocator, and it seems to be increasingly only of benefit to
dynamically allocating hugepages and memory hot unplug.

If that is the case, do we really want to make such sacrifices
for the huge machines that want these things? What about just
making an extra zone for easy-to-reclaim things to live in?

This could possibly even be resized at runtime according to
demand with the memory hotplug stuff (though I haven't been
following that).

Don't take this as criticism of the actual implementation or its
effectiveness.

Nick

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
