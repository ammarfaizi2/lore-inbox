Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261430AbVC0Dlw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261430AbVC0Dlw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 22:41:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261437AbVC0Dlw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 22:41:52 -0500
Received: from smtp203.mail.sc5.yahoo.com ([216.136.129.93]:14751 "HELO
	smtp203.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261430AbVC0Dlu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 22:41:50 -0500
Message-ID: <42462B7A.4080305@yahoo.com.au>
Date: Sun, 27 Mar 2005 13:41:46 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: Hugh Dickins <hugh@veritas.com>, akpm@osdl.org, davem@davemloft.net,
       tony.luck@intel.com, benh@kernel.crashing.org, ak@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] freepgt: free_pgtables shakeup
References: <Pine.LNX.4.61.0503231705560.15274@goblin.wat.veritas.com> <20050325212234.F12715@flint.arm.linux.org.uk> <4244C3B7.4020409@yahoo.com.au> <20050326113530.A12809@flint.arm.linux.org.uk> <424566E0.80001@yahoo.com.au> <20050326155254.E12809@flint.arm.linux.org.uk>
In-Reply-To: <20050326155254.E12809@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> On Sun, Mar 27, 2005 at 12:42:56AM +1100, Nick Piggin wrote:
> 
>>OK, thanks that would be good. You could well be right in your analysis.
>>May I suggest a possible avenue of investigation:
> 
> 
> Yes, this patch seems to also be required, otherwise I see:
> 

[...]

OK.

> 
> The above is with my fix to ARMs get_pgd_slow, which shows that we
> accidentally freed the first entry in the L1 page table.  With my
> fix and your patch, low-vectored ARMs work again.
> 
> I don't think it'll be invasive to push my get_pgd_slow() fix before
> these freepgt patches appear.  For the record, this is the patch I'm
> using at present.  With a bit more effort, I could probably eliminate
> pmd_alloc (and therefore the unnecessary spinlocking) here.
> 

Seems OK if you're happy with it. Is this going to leak
"nr_page_table_pages" too, though?

Hmm... no, because free_pgd_slow decrements it? In that case, can
you have free_pgd_slow also decrement nr_ptes, instead of your
below patch?

