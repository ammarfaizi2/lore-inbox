Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751319AbVJGCJk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751319AbVJGCJk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 22:09:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751304AbVJGCJk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 22:09:40 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:43245 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751319AbVJGCJj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 22:09:39 -0400
Message-ID: <4345D8DB.7070901@engr.sgi.com>
Date: Thu, 06 Oct 2005 19:09:31 -0700
From: Jay Lan <jlan@engr.sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040906
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
Cc: David Wright <daw@sgi.com>, Frank van Maarseveen <frankvm@frankvm.com>,
       Christoph Lameter <clameter@engr.sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.14-rc2] fix incorrect mm->hiwater_vm and mm->hiwater_rss
References: <20050921121915.GA14645@janus> <Pine.LNX.4.61.0509211515330.6114@goblin.wat.veritas.com> <43319111.1050803@engr.sgi.com> <Pine.LNX.4.61.0509211802150.8880@goblin.wat.veritas.com> <4331990A.80904@engr.sgi.com> <Pine.LNX.4.61.0509211835190.9340@goblin.wat.veritas.com> <4331A0DA.5030801@engr.sgi.com> <20050921182627.GB17272@janus> <Pine.LNX.4.61.0509211958410.10449@goblin.wat.veritas.com> <4339AED4.8030108@engr.sgi.com> <Pine.LNX.4.61.0509281337420.6830@goblin.wat.veritas.com> <433AD359.8070509@engr.sgi.com> <Pine.LNX.4.61.0510032030320.13179@goblin.wat.veritas.com> <4342F8BA.8050002@engr.sgi.com>
In-Reply-To: <4342F8BA.8050002@engr.sgi.com>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jay Lan wrote:
> Hugh Dickins wrote:
> 
>>
>>
>> See comment in fs/proc/task_mmu.c for the principle.  Could maintain
>> hiwater_vm straightforwardly, but I think it's easier to remember if
>> we handle them both in the same way.
>>
>> I did look into doing the total_vm increment and calling vm_stat_account
>> in insert_vm_struct, but concluded it solved no particular problem, and
>> raised some questions (where architectures, notably ia64, have special
>> vmas which they may have good reason to leave out of total_vm).
>>
>> I haven't cross-checked the mm_struct cacheline rearrangement yet,
>> it looks plausible, but could easily turn out to straddle boundaries.
>>
>> Christoph, Frank, Jay: does this patch look like it fits your needs?
> 
> 
> I am building a kernel with your patch and am going to run some test
> to compare the statistics.

My testing showed the same number on hiwater_vm, but hiwater_rss from
Hugh's version was consistently ~1.5% lower. Where was the loss?

The fact that i have consistent hiwater_vm and hiwater_rss
in a few hundreds of processes suggests that that test may not
be a good test for comparing hiwater_vm and hiwater_rss.

I guess it allocates same amount of memory up front in every sub-tests
processes and never get over it. However, it also showed the way Hugh
did hiwater_rss in new code missed something.

Tomorrow i will be very busy at my work. I will be back on this
next Monday.

Thanks,
  - jay

> 
> Thanks,
>  - jay
> 
>>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

