Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317352AbSFCK3E>; Mon, 3 Jun 2002 06:29:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317353AbSFCK3D>; Mon, 3 Jun 2002 06:29:03 -0400
Received: from holomorphy.com ([66.224.33.161]:18560 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S317352AbSFCK3C>;
	Mon, 3 Jun 2002 06:29:02 -0400
Date: Mon, 3 Jun 2002 03:28:09 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: Re: remove mixture of non-atomic operations with page->flags which requires atomic operations to access
Message-ID: <20020603102809.GA912@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Hugh Dickins <hugh@veritas.com>, linux-kernel@vger.kernel.org,
	trivial@rustcorp.com.au
In-Reply-To: <20020602224422.GP14918@holomorphy.com> <Pine.LNX.4.21.0206031051370.10595-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Jun 2002, William Lee Irwin III wrote:
>> page->flags is effectively a lock word as its various bits are updatable
>> and accessible only by atomic operations. This patch removes the update
>> of page->flags in __free_pages_ok() with non-atomic operations in favor
>> of using atomic bit operations to update the bits to be cleared.
>>  	ClearPageDirty(page);
>> -	page->flags &= ~(1<<PG_referenced);
>> +	ClearPageUptodate(page);
>> +	ClearPageSlab(page);
>> +	ClearPageNosave(page);
>> +	ClearPageChecked(page);

On Mon, Jun 03, 2002 at 11:14:43AM +0100, Hugh Dickins wrote:
> Don't all those atomic volatile bitops slow down a hotpath for no real
> gain?  I'm all for clearing all possible flag bits at that point, but
> would prefer just one mask myself.  But given all the preceding tests,
> and the ClearPageDirty, perhaps I'm foolish to question your additions.
> And wasn't it originally clearing the referenced bit, now leaving it?
> Hugh

It should be clearing it, I'd retransmit if there weren't other objections
to address...


Cheers,
Bill
