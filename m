Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261239AbUHDIfj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbUHDIfj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 04:35:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261300AbUHDIfj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 04:35:39 -0400
Received: from smtp014.mail.yahoo.com ([216.136.173.58]:37732 "HELO
	smtp014.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261239AbUHDIfb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 04:35:31 -0400
Message-ID: <41109FCC.4070906@yahoo.com.au>
Date: Wed, 04 Aug 2004 18:35:24 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040707 Debian/1.7-5
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc2-mm2
References: <20040802015527.49088944.akpm@osdl.org> <410E3CAF.6080305@kolivas.org> <410F3423.3020409@yahoo.com.au> <cone.1091518501.973503.9648.502@pc.kolivas.org> <cone.1091519122.804104.9648.502@pc.kolivas.org>
In-Reply-To: <cone.1091519122.804104.9648.502@pc.kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> Con Kolivas writes:
> 
>> Nick Piggin writes:
>>
>>> Con Kolivas wrote:
>>>
>>>> Andrew Morton wrote:
>>>
>>>
>>>> Anyone with feedback on this please cc me. This was developed 
>>>> separately from the -mm series which has heaps of other scheduler 
>>>> patches which were not trivial to merge with so there may be 
>>>> teething problems. Good reports dont hurt either ;)
>>>>
>>>
>>> I can't get onto the OSDL site now, but I seem to remember staircase
>>> having some performance problems on a few things. Hackbench and reaim
>>> from memory... are these fixed? was I dreaming?
>>
>>
>> Definitely dreaming I'm afraid :D
>>
>> The performance on both reaim and hackbench has always equalled or 
>> exceeded mainline so thanks for bringing it up.

(OSDL's search thingy still isn't working quite right, but I'll get back
to you about this when it does.)


Otherwise, a couple of problems I noticed:

You removed things like this:
-	/*
-	 * The idle thread is not allowed to schedule!
-	 * Remove this check after it has been exercised a bit.
-	 */
-	if (unlikely(current == rq->idle) && current->state != TASK_RUNNING) {
-		printk(KERN_ERR "bad: scheduling from the idle thread!\n");
-		dump_stack();
-	}
-
And child-runs-first in wake_up_new_task. Please don't.

Also, basic interactivity in X is bad with the interactive sysctl set to 0
(is X supposed to be at nice 0?), however fairness is bad when interactive is 1.
I'm not sure if this is an acceptable tradeoff - are you planning to fix it?

It has interactivity problems with "thud". Also the mouse can freeze for .5 to 1
second when moving between windows while there is disk IO going on in the background
(this is with interactive = 1). The test-starve problem is back.

Increasing priority (negative nice) doesn't have much impact. -20 CPU hog only gets
about double the CPU of a 0 priority CPU hog and only about 120% the CPU time of a
nice -10 hog.
