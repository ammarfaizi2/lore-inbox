Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264997AbUHCDjt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264997AbUHCDjt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 23:39:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265031AbUHCDjt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 23:39:49 -0400
Received: from alt.aurema.com ([203.217.18.57]:31935 "EHLO smtp.sw.oz.au")
	by vger.kernel.org with ESMTP id S264997AbUHCDjk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 23:39:40 -0400
Message-ID: <410F08D6.5050200@bigpond.net.au>
Date: Tue, 03 Aug 2004 13:39:02 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Michal Kaczmarski <fallow@op.pl>, Shane Shrybman <shrybman@aei.ca>
Subject: Re: [PATCH] V-3.0 Single Priority Array O(1) CPU Scheduler Evaluation
References: <410DDFD2.5090400@bigpond.net.au> <20040802134257.GE2334@holomorphy.com> <410EDD60.8040406@bigpond.net.au> <20040803020345.GU2334@holomorphy.com>
In-Reply-To: <20040803020345.GU2334@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> William Lee Irwin III wrote:
> 
>>>Hmm. Given do_promotions() I'd expect fenceposts, not iteration over
>>>the priority levels of the runqueue.
> 
> 
> On Tue, Aug 03, 2004 at 10:33:36AM +1000, Peter Williams wrote:
> 
>>I don't understand what you mean.  Do you mean something like the more 
>>complex promotion mechanism in the (earlier) EBS scheduler where tasks 
>>only get promoted if they've been on a queue without being serviced 
>>within a given time?
> 
> 
> An array of size N can be rotated in O(1) time

And with a smaller constant than my do_promotions(). :-)

> if an integer is kept
> along with it to represent an offset that has to be added to externally-
> visible indices mod N to recover the true index.

OK.  Now I understand.

The main reason that I didn't do something like that is that 
(considering that real time tasks don't get promoted) it would complicate:

1. the selection (in schedule()) of the next task to be run as it would 
no longer be a case of just finding the first bit in the bitmap,
2. determining the appropriate list to put the task on in 
enqueue_task(), etc., and
3. determining the right bit to turn off in the bit map when dequeuing 
the last task in a slot.

As these are frequent operations compared to promotion I thought it 
would be better to leave the complexity in do_promotion().  Now that 
you've caused me to think about it again I realize that the changes in 
the above areas may not be as complicated as I thought would be 
necessary.  So I'll give it some more thought.

Thanks for the suggestion
Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
