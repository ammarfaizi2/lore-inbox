Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752456AbWCQAhq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752456AbWCQAhq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 19:37:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752461AbWCQAhq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 19:37:46 -0500
Received: from smtp105.mail.mud.yahoo.com ([209.191.85.215]:58489 "HELO
	smtp105.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1752456AbWCQAhp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 19:37:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=w38ZIqcpE5bK8UvseZ63u9BjhpOn+lUrIBL1ZKkEqZU2ISFhxo6PXjxpHcdIMJ+k+iq5WTg6Xjr0OhLPxCwjU+EjPD/joggtdfazAPfx2PGW7RGDpFuXMMExiFX/43nNb5Cc6c3ptPh6c1fHWXDM+daUI0/bBA7Zxe5Lb5kSRqA=  ;
Message-ID: <441A04D0.3060201@yahoo.com.au>
Date: Fri, 17 Mar 2006 11:37:36 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: Roland Dreier <rdreier@cisco.com>, Andrew Morton <akpm@osdl.org>,
       "Bryan O'Sullivan" <bos@pathscale.com>, torvalds@osdl.org,
       hch@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10 of 20] ipath - support for userspace apps using core
 driver
References: <71644dd19420ddb07a75.1141922823@localhost.localdomain> <ada4q27fban.fsf@cisco.com> <1141948516.10693.55.camel@serpentine.pathscale.com> <ada1wxbdv7a.fsf@cisco.com> <1141949262.10693.69.camel@serpentine.pathscale.com> <20060309163740.0b589ea4.akpm@osdl.org> <1142470579.6994.78.camel@localhost.localdomain> <ada3bhjuph2.fsf@cisco.com> <1142475069.6994.114.camel@localhost.localdomain> <adaslpjt8rg.fsf@cisco.com> <1142477579.6994.124.camel@localhost.localdomain> <20060315192813.71a5d31a.akpm@osdl.org> <1142485103.25297.13.camel@camp4.serpentine.com> <20060315213813.747b5967.akpm@osdl.org> <ada8xrbszmx.fsf@cisco.com> <4419062C.6000803@yahoo.com.au> <Pine.LNX.4.61.0603161426010.21570@goblin.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.61.0603161426010.21570@goblin.wat.veritas.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:
> On Thu, 16 Mar 2006, Nick Piggin wrote:
> 
>>>How about the case where one wants to map pages from
>>>dma_alloc_coherent() into userspace?  It seems one should do
>>>get_page() in .nopage, and then the driver can do dma_free_coherent()
>>>when the vma is released.
>>
>>I think so, provided you set VM_IO on the vma. You need VM_IO to
>>ensure that get_user_pages callers can't hijack your page's lifetime
>>rules
> 
> 
> Once __GFP_COMP is passed to the dma_alloc_coherent, as it needs to be
> (unless going VM_PFNMAP), get_user_pages will be safe: no need for VM_IO.
> 

But it doesn't look like dma_alloc_coherent is guaranteed to return
memory allocated from the regular page allocator, nor even memory
backed by a struct page.

For example, I see one that returns kmalloc()ed memory. If the pages
for the slab are already allocated then __GFP_COMP will not do anything
there. i386 looks like it has a path that uses ioremap...

Now I haven't looked through all these closely like you will have, but
I'd like to know how __GFP_COMP solves all the potential problems I
see.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
