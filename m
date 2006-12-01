Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759304AbWLAKA4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759304AbWLAKA4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 05:00:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759303AbWLAKA4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 05:00:56 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:55431 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1759304AbWLAKAz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 05:00:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OaQycHyZPCV4MNAfY/LH9ubfSGeggWVVUkh3FqDL0hYM5FLrV+z53evzJibNU7ufj4VRd2OVtknffJfE7HTUOwux66r+Dwm99HsnvB2H5DpEXMryBrLjf252lXcFqZCQwl5SDP+nnMyxKF4N4DxlII3aF/QTvuxb63ENJjyWplA=
Message-ID: <6d6a94c50612010200t2c9dfc36m603ddc4948285bf@mail.gmail.com>
Date: Fri, 1 Dec 2006 18:00:53 +0800
From: Aubrey <aubreylee@gmail.com>
To: "Nick Piggin" <nickpiggin@yahoo.com.au>
Subject: Re: The VFS cache is not freed when there is not enough free memory to allocate
Cc: "Sonic Zhang" <sonic.adi@gmail.com>,
       "Peter Zijlstra" <a.p.zijlstra@chello.nl>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, vapier.adi@gmail.com
In-Reply-To: <456F4A95.2090503@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <6d6a94c50611212351if1701ecx7b89b3fe79371554@mail.gmail.com>
	 <1164185036.5968.179.camel@twins>
	 <6d6a94c50611220202t1d076b4cye70dcdcc19f56e55@mail.gmail.com>
	 <456A964D.2050004@yahoo.com.au>
	 <4e5ebad50611282317r55c22228qa5333306ccfff28e@mail.gmail.com>
	 <6d6a94c50611290127u2b26976en1100217a69d651c0@mail.gmail.com>
	 <456D5347.3000208@yahoo.com.au>
	 <6d6a94c50611300454g22196d2frec54e701abaebf17@mail.gmail.com>
	 <456F4A95.2090503@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/06, Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>
> The pattern you are seeing here is probably due to the page allocator
> always retrying process context allocations which are <= order 3 (64K
> with 4K pages).
>
> You might be able to increase this limit a bit for your system, but it
> could easily cause problems. Especially fragmentation on nommu systems
> where the anonymous memory cannot be paged out.

Thanks for your clue. I found increasing this limit could really help
my test cases.
When MemFree < 8M, and the test case request 1M * 8 times, the
allocation can be sucessful after 81 times rebalance, :). So far I
haven't found any issue.

If I make a patch to move this parameter to be tunable in the proc
filesystem on nommu case, is it acceptable?

Thanks,
-Aubrey
