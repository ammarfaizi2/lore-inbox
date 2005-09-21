Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751139AbVIUQ6c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751139AbVIUQ6c (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 12:58:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751187AbVIUQ6b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 12:58:31 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:46814 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751139AbVIUQ6b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 12:58:31 -0400
Message-ID: <43319111.1050803@engr.sgi.com>
Date: Wed, 21 Sep 2005 09:57:53 -0700
From: Jay Lan <jlan@engr.sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, zh-tw, en, zh-cn, zh-hk
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: Frank van Maarseveen <frankvm@frankvm.com>,
       Christoph Lameter <clameter@engr.sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.14-rc2] fix incorrect mm->hiwater_vm and mm->hiwater_rss
References: <20050921121915.GA14645@janus> <Pine.LNX.4.61.0509211515330.6114@goblin.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.61.0509211515330.6114@goblin.wat.veritas.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:
> On Wed, 21 Sep 2005, Frank van Maarseveen wrote:
> 
>>This fixes a post 2.6.11 regression in maintaining the mm->hiwater_* counters.
> 
> 
> It would be a good idea to CC Christoph Lameter, who I believe was the
> one who very intentionally moved most of these updates out to timer tick.
> Is that significantly missing updates?
> 
> If it turns out that your patch is appropriate:
> 
> 1. The change from tsk to mm is good (but not urgent 2.6.14 material).
> 
> 2. You've missed the instance Dave Miller recently added in fs/compat.c.
> 
> 3. If these are to be peppered back all over, then the places where
>    total_vm changes and the places where rss changes are almost completely
>    disjoint, so it's lazy to be calling one function to do both all over.
> 
> 4. If you've noticed a regression, you must be one of the elite that knows
>    what these counters are used for: nothing in the kernel.org tree does.
>    Please add a comment saying what it is that uses them and how, so
>    developers can make better judgements about how best to maintain them.
> 
> 5. Please add appropriate CONFIG, dummy macros etc., so that no time
>    is wasted on these updates in all the vanilla systems which have no
>    interest in them - but maybe Christoph already has that well in hand.

It is used in enhanced system accounting. An obvious CONFIG would be
CONFIG_BSD_PROCESS_ACCT.

However, since the CONFIG flag is almost always Yes, people would need
to turn it off if they do not want system accounting. Would that be
OK?

Thanks,
  - jay


> 
> Sorry for the rifle fire, you did put your head above the parapet!
> 
> Hugh
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

