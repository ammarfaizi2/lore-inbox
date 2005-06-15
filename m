Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261577AbVFOVT5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261577AbVFOVT5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 17:19:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261578AbVFOVT5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 17:19:57 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:40392 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261577AbVFOVTx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 17:19:53 -0400
Subject: Re: 2.6.12-rc6-mm1 & 2K lun testing
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org
In-Reply-To: <42B07B44.9040408@yahoo.com.au>
References: <1118856977.4301.406.camel@dyn9047017072.beaverton.ibm.com>
	 <42B073C1.3010908@yahoo.com.au>
	 <1118860223.4301.449.camel@dyn9047017072.beaverton.ibm.com>
	 <42B07B44.9040408@yahoo.com.au>
Content-Type: text/plain
Organization: 
Message-Id: <1118868979.4301.458.camel@dyn9047017072.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 15 Jun 2005 13:56:19 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-06-15 at 12:02, Nick Piggin wrote:
> Badari Pulavarty wrote:
> > On Wed, 2005-06-15 at 11:30, Nick Piggin wrote:
> > 
> >>Badari Pulavarty wrote:
> >>
> >>
> >>>------------------------------------------------------------------------
> >>>
> >>>elm3b29 login: dd: page allocation failure. order:0, mode:0x20
> >>>
> >>>Call Trace: <IRQ> <ffffffff801632ae>{__alloc_pages+990} <ffffffff801668da>{cache_grow+314}
> >>>       <ffffffff80166d7f>{cache_alloc_refill+543} <ffffffff80166e86>{kmem_cache_alloc+54}
> >>>       <ffffffff8033d021>{scsi_get_command+81} <ffffffff8034181d>{scsi_prep_fn+301}
> >>
> >>They look like they're all in scsi_get_command.
> >>I would consider masking off __GFP_HIGH in the gfp_mask of that
> >>function, and setting __GFP_NOWARN. It looks like it has a mempoolish
> >>thingy in there, so perhaps it shouldn't delve so far into reserves.
> > 
> > 
> > You want me to take off GFP_HIGH ? or just set GFP_NOWARN with GFP_HIGH
> > ?
> > 
> 
> Yeah, take off GFP_HIGH and set GFP_NOWARN (always). I would be
> interested to see how that goes.
> 
> Obviously it won't eliminate your failures there (it will probably
> produce more of them), however it might help the scsi command
> allocation from overwhelming the system.

Hmm.. seems to help little. IO rate is not great (compared to 90MB/sec
with "raw") - but machine is making progress. But again, its pretty
unresponsive.

Thanks,
Badari

procs -----------memory---------- ---swap-- -----io---- --system--
----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy
id wa
131 254  34896  31328   2540 4982740    0    0    29 101877 1086 11220 
0 100  0  0
149 268  34896  32824   2536 4983712   13    0    42 39505  439  4454  0
100  0  0
135 254  34896  31112   2536 4984768   11    0    20 36233  373  4078  0
100  0  0
130 242  34896  32600   2536 4987364    6    0   161 33626  377  3957  0
100  0  0
153 263  34896  32592   2532 4993560    0    0    14 37124  385  4468  0
100  0  0
144 236  34896  32668   2548 5013148    6    0   154 220366 2360 27530 
0 100  0  0
112 243  34896  34636   2544 5011112    5    0    62 79160  850 10540  0
100  0  0
103 234  34896  31980   2544 5014744    0    0   135 33814  363  4511  0
100  0  0
112 230  34896  32204   2552 5012156    0    0   140 33200  378  4812  0
100  0  0
139 212  34896  32832   2528 5020928   31    0   542 142834 1536 18007 
0 100  0  0
144 215  34896  32896   2528 5019872   17    0    74 41957  449  4781  0
100  0  0
184 252  34896  33252   2504 5024564    0    0    19 34506  374  4616  0
100  0  0
141 240  34896  31624   2516 5026616    0    0   153 31896  378  4904  0
100  0  0


