Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268457AbUILF2S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268457AbUILF2S (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 01:28:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268480AbUILF2S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 01:28:18 -0400
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:60554 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S268457AbUILF16 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 01:27:58 -0400
Message-ID: <4143D246.6030101@yahoo.com.au>
Date: Sun, 12 Sep 2004 14:36:22 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040810 Debian/1.7.2-2
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [pagevec] resize pagevec to O(lg(NR_CPUS))
References: <20040909163929.GA4484@logos.cnet> <20040909155226.714dc704.akpm@osdl.org> <20040909230905.GO3106@holomorphy.com> <20040909162245.606403d3.akpm@osdl.org> <20040910000717.GR3106@holomorphy.com> <414133EB.8020802@yahoo.com.au> <20040910174915.GA4750@logos.cnet> <41439884.8040909@yahoo.com.au> <20040912052308.GE2660@holomorphy.com>
In-Reply-To: <20040912052308.GE2660@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:

> 
> It's unclear what you're estimating the size of. PAGEVEC_SIZE of 62

Overhead of the loaded pagevec.

[snip]

> 
> mapping->tree_lock is affected as well as zone->lru_lock. The workload
> obviously has to touch the relevant locks for pagevecs to be relevant;
> however, the primary factor in the effectiveness of pagevecs is the
> lock transfer time, which is not likely to vary significantly on boxen
> such as the OSDL STP machines. You should use a workload stressing
> mapping->tree_lock via codepaths using radix_tree_gang_lookup() and
> getting runtime on OSDL's NUMA-Q or otherwise asking SGI to test its
> effects, otherwise you're dorking around with boxen with identical
> characteristics as far as batched locking is concerned.
>

Yeah I forgot about that. I guess it probably would be easier to
get contention on the tree lock.
