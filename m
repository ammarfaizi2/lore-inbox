Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261941AbUKCWbx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261941AbUKCWbx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 17:31:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261963AbUKCW3M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 17:29:12 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:43393 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261941AbUKCW0Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 17:26:25 -0500
Message-ID: <41895A91.8090502@tmr.com>
Date: Wed, 03 Nov 2004 17:24:17 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: Con Kolivas <kernel@kolivas.org>, linux <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] remove interactive credit
References: <418707CD.1080903@kolivas.org><418707CD.1080903@kolivas.org> <41877DF5.8070008@yahoo.com.au>
In-Reply-To: <41877DF5.8070008@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> Con Kolivas wrote:
> 
>> remove interactive credit
>>
>>
>>
>> ------------------------------------------------------------------------
>>
>> Special casing tasks by interactive credit was helpful for preventing 
>> fully
>> cpu bound tasks from easily rising to interactive status.
>> However it did not select out tasks that had periods of being fully 
>> cpu bound
>> and then sleeping while waiting on pipes, signals etc. This led to a more
>> disproportionate share of cpu time.
>>
>> Backing this out will no longer special case only fully cpu bound 
>> tasks, and
>> prevents the variable behaviour that occurs at startup before tasks 
>> declare
>> themseleves interactive or not, and speeds up application startup 
>> slightly
>> under certain circumstances. It does cost in interactivity slightly as 
>> load
>> rises but it is worth it for the fairness gains.
>>
>> Signed-off-by: Con Kolivas <kernel@kolivas.org>
>>
> 
> I'm scared :(
> 
> I'm in favour of any attempts to simplify things... but will it be two
> months or three before this spontaneously explodes for half our userbase?
> 
> Andrew's boss so he gets to decide >:)

If I read the intent right, this is an example of worst case avoidance, 
where a little average interactivity is traded for preventing the case 
where a single misguided process gets most/all of the CPU and 
performance falls off the edge of the table. As a user I see that as the 
same line of thought which gave us low-latency patches, to trade a 
miniscule bit of one thing to avoid something really undesirable.

I suspect there will be people who don't want to make this trade, 
although it sounds like a good one to me.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
