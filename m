Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751264AbVIURcg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751264AbVIURcg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 13:32:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751266AbVIURcg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 13:32:36 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:16284 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751264AbVIURcf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 13:32:35 -0400
Message-ID: <4331990A.80904@engr.sgi.com>
Date: Wed, 21 Sep 2005 10:31:54 -0700
From: Jay Lan <jlan@engr.sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, zh-tw, en, zh-cn, zh-hk
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: Frank van Maarseveen <frankvm@frankvm.com>,
       Christoph Lameter <clameter@engr.sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.14-rc2] fix incorrect mm->hiwater_vm and mm->hiwater_rss
References: <20050921121915.GA14645@janus> <Pine.LNX.4.61.0509211515330.6114@goblin.wat.veritas.com> <43319111.1050803@engr.sgi.com> <Pine.LNX.4.61.0509211802150.8880@goblin.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.61.0509211802150.8880@goblin.wat.veritas.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:
> On Wed, 21 Sep 2005, Jay Lan wrote:
> 
>>Hugh Dickins wrote:
>>
>>>4. If you've noticed a regression, you must be one of the elite that
>>>knows
>>>what these counters are used for: nothing in the kernel.org tree does.
>>>Please add a comment saying what it is that uses them and how, so
>>>developers can make better judgements about how best to maintain them.
>>>
>>>5. Please add appropriate CONFIG, dummy macros etc., so that no time
>>>is wasted on these updates in all the vanilla systems which have no
>>>interest in them - but maybe Christoph already has that well in hand.
>>
>>It is used in enhanced system accounting. An obvious CONFIG would be
>>CONFIG_BSD_PROCESS_ACCT.
>>
>>However, since the CONFIG flag is almost always Yes, people would need
>>to turn it off if they do not want system accounting. Would that be
>>OK?
> 
> 
> Christoph will know the issue better than I.  But I'd say no, that's
> not OK.  You have some out of tree "enhanced system accounting" which
> has been granted the privilege of hooks within the mainline kernel:
> they should be disabled unless a CONFIG option is switched on, which
> your accounting patch can do.  And the (mainline) Kconfig help entry
> for that CONFIG option should point us to the source of your package.

It is not really an issue of out-of-tree accounting package. The
system accounting is based on very old technology and needs improvement.
The issue we face is not an issue of one particular accounting package.

I think the best approach would be to wrap the mm usage accounting
in a new CONFIG_ENHANCED_SYS_ACCT and leave it OFF by default so that
people can still get the minimal accounting with
CONFIG_BSD_PROCESS_ACCT.

- jay

> 
> Hugh
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

