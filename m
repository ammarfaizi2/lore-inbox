Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261295AbVCYFfV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261295AbVCYFfV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 00:35:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261309AbVCYFfV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 00:35:21 -0500
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:52088 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261295AbVCYFfR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 00:35:17 -0500
Message-ID: <4243A310.1050904@yahoo.com.au>
Date: Fri, 25 Mar 2005 16:35:12 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>, davem@davemloft.net
CC: akpm@osdl.org, tony.luck@intel.com, benh@kernel.crashing.org, ak@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] freepgt: free_pgtables use vma list
References: <Pine.LNX.4.61.0503231705560.15274@goblin.wat.veritas.com> <Pine.LNX.4.61.0503231710310.15274@goblin.wat.veritas.com> <4243A257.8070805@yahoo.com.au>
In-Reply-To: <4243A257.8070805@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> Hugh Dickins wrote:
> 
>> And the range to sparc64's flush_tlb_pgtables?  It's less clear to me
>> now that we need to do more than is done here - every PMD_SIZE ever
>> occupied will be flushed, do we really have to flush every PGDIR_SIZE
>> ever partially occupied?  A shame to complicate it unnecessarily.
> 
> 
> It looks like sparc64 is the only user of this, so it is up to
> you Dave.
> 

Oh - one other question too. Doing the unmap and page table freeing in
the same pass will put freed pagecache pages in the same mmu_gather as
the freed page table pages. This looks like it may be a problem for
sparc64?

