Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261310AbVCOO5K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261310AbVCOO5K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 09:57:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261306AbVCOO5K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 09:57:10 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:35514 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261310AbVCOO5D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 09:57:03 -0500
Date: Tue, 15 Mar 2005 06:56:57 -0800
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>, Dave Hansen <haveblue@us.ibm.com>,
       Andy Whitcroft <apw@shadowen.org>, Dave McCracken <dmccr@us.ibm.com>,
       Daniel Phillips <phillips@redhat.com>
cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] sparsemem intro patches
Message-ID: <214580000.1110898616@[10.10.2.4]>
In-Reply-To: <20050314183042.7e7087a2.akpm@osdl.org>
References: <1110834883.19340.47.camel@localhost> <20050314183042.7e7087a2.akpm@osdl.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>  The following four patches provide the last needed changes before the
>>  introduction of sparsemem.  For a more complete description of what this
>>  will do, please see this patch:
>> 
>>  http://www.sr71.net/patches/2.6.11/2.6.11-bk7-mhp1/broken-out/B-sparse-150-sparsemem.patch
> 
> I don't know what to think about this.  Can you describe sparsemem a little
> further, differentiate it from discontigmem and tell us why we want one? 
> Is it for memory hotplug?  If so, how does it support hotplug?
> 
> To which architectures is this useful, and what is the attitude of the
> relevant maintenance teams?

This isn't just for hotplug by any means. Andy wrote it to get rid of a whole
bunch of different problems, roughly based on some previous work by Dan Phillips
and Dave McCracken (I've added a cc to the actual authors of these patches). 
This is the major part of what used to be called CONFIG_NONLINEAR, which we 
discussed at last year's kernel summit, and people were pretty enthusiastic 
about. 

> Quoting from the above patch:
> 
>> Sparsemem replaces DISCONTIGMEM when enabled, and it is hoped that
>> it can eventually become a complete replacement.
>> ...
>> This patch introduces CONFIG_FLATMEM.  It is used in almost all
>> cases where there used to be an #ifndef DISCONTIG, because
>> SPARSEMEM and DISCONTIGMEM often have to compile out the same areas
>> of code.
> 
> Would I be right to worry about increasing complexity, decreased
> maintainability and generally increasing mayhem?

Not really - it cleans up the current mess where discontigmem means, and
is used for, two distinct things: 1. the memory is significantly non-contig
in the physical layout. 2. NUMA support.

It also allows us to support discontiguous memory *within* a NUMA node, which
is important for some systems - we can scrap the added complexity of ia64s
vmemmap stuff, for instance. 

Whatever your opinions are on mem hotplug, I think we want CONFIG_SPARSEMEM
to clean up the existing mess of discontig - with or without hotplug. I've 
wanted this for a very long time, and was dicussing it with Andy at OLS last 
year; he came up with a much better, cleaner way to implement it than I had.

It also makes a lot of sense as a foundation for hotplug, which multiple 
people seem to want for virtualization stuff.

Anyway, that's what I want it for ;-)

> If a competent kernel developer who is not familiar with how all this code
> hangs together wishes to acquaint himself with it, what steps should he
> take?

Andy, can you explain that further? Maybe also worth checking these are the
correct version of your patches.

M.

