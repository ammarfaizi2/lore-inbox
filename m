Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261294AbVCYFcO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261294AbVCYFcO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 00:32:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261295AbVCYFcO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 00:32:14 -0500
Received: from smtp207.mail.sc5.yahoo.com ([216.136.129.97]:45164 "HELO
	smtp207.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261294AbVCYFcL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 00:32:11 -0500
Message-ID: <4243A257.8070805@yahoo.com.au>
Date: Fri, 25 Mar 2005 16:32:07 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: akpm@osdl.org, davem@davemloft.net, tony.luck@intel.com,
       benh@kernel.crashing.org, ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] freepgt: free_pgtables use vma list
References: <Pine.LNX.4.61.0503231705560.15274@goblin.wat.veritas.com> <Pine.LNX.4.61.0503231710310.15274@goblin.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.61.0503231710310.15274@goblin.wat.veritas.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:

> And the range to sparc64's flush_tlb_pgtables?  It's less clear to me
> now that we need to do more than is done here - every PMD_SIZE ever
> occupied will be flushed, do we really have to flush every PGDIR_SIZE
> ever partially occupied?  A shame to complicate it unnecessarily.

It looks like sparc64 is the only user of this, so it is up to
you Dave.

I don't think I'd be able to decipher how sparc64 implements this.

I think Hugh and I interpreted your message different ways.

So, to make the question more concrete: if a pgd_t is freed due
to freeing the single pmd_t contained within it (which was the
only part of the pgd's address space that contained a valid mapping)
Then do you need the full PGDIR_SIZE width passed to
flush_tlb_pgtables, or just the PMD_SIZE'd start,end that covered
the freed pmd_t?


