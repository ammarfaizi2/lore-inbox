Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262103AbVAOBcP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262103AbVAOBcP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 20:32:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262099AbVAOBcP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 20:32:15 -0500
Received: from holomorphy.com ([66.93.40.71]:49873 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262089AbVAOBbU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 20:31:20 -0500
Date: Fri, 14 Jan 2005 17:31:06 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Mel Gorman <mel@csn.ul.ie>,
       Linux Memory Management List <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Avoiding fragmentation through different allocator
Message-ID: <20050115013106.GC3474@holomorphy.com>
References: <Pine.LNX.4.58.0501122101420.13738@skynet> <20050113073146.GB1226@holomorphy.com> <20050114214218.GB3336@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050114214218.GB3336@logos.cnet>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2005 at 11:31:46PM -0800, William Lee Irwin III wrote:
>> I'd expect to do better with kernel/user discrimination only, having
>> address-ordering biases in opposite directions for each case.

On Fri, Jan 14, 2005 at 07:42:18PM -0200, Marcelo Tosatti wrote:
> What you mean with "address-ordering biases in opposite directions
> for each case" ? 
> You mean to have each case allocate from the top and bottom of the
> free list, respectively, and in opposite address direction ? What you
> gain from that?
> And what that means during a long period of VM stress ?

It's one of the standard anti-fragmentation tactics. The large free
areas come from the middle, address ordering disposes of holes in the
used areas, and the areas at opposite ends reflect expected lifetimes.

It's more useful for cases where there is not an upper bound on the
size of an allocation (or power-of-two blocksizes). On second thought,
Mel's approach exploits both the bound and the power-of-two restriction
advantageously.


-- wli
