Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261420AbVGYVBM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261420AbVGYVBM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 17:01:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261442AbVGYVBM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 17:01:12 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:6148 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261420AbVGYVBL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 17:01:11 -0400
Message-ID: <42E5540D.1030709@tmr.com>
Date: Mon, 25 Jul 2005 17:05:17 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050511
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Brown, Len" <len.brown@intel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Variable ticks
References: <F7DC2337C7631D4386A2DF6E8FB22B300424AA2D@hdsmsx401.amr.corp.intel.com>
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B300424AA2D@hdsmsx401.amr.corp.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brown, Len wrote:
>  
> 
>>I was thinking about variable tick times, and I can think of three 
>>classes of action needing CPU attention.
>>- device interrupts, which occur at no predictable time but would pull 
>>the CPU out of a HLT or low power state.
>>- process sleeps of various kinds, which have a known time of 
>>occurence.
>>- polled devices...
>>
>>Question one, are there other actions to consider?
> 
> 
> Yes.
> Speaking for ACPI C3 state, note that DMA also
> wakes up the CPU -- even if there was no device interrupt.
> (aka, "the trouble with USB")

Trouble? Why would USB do DMA unless there was a device activity?
> 
> 
>>Question two, what about those polled devices?
> 
> 
> it is a real challenge to save power under such conditions,
> unless you can throttle the polling rate such that
> the processor can actually enters idle while polling
> is underway.
> 
> 
>>I've been asked to give a high level overview of the recent discussion 
>>for a meeting, and while I want to keep it at the level of "slower 
>>clock, fewer interrupts" and "faster clock, better sleep 
>>resolution," I 
>>don't want to leave out any important issues, or be asked a question 
>>(like how to handle polling devices) when I have no idea what 
>>people are thinking in an area.
> 
> 
> From a power management point of view, what is important
> is what we do when idle.  ie. on my laptop, from a power
> savings point of view, I wouldn't care
> much if HZ=1000 all the time if HZ=0 when in idle.

That could hurt the polling performance, all right. ;-)
> 
> Outside of idle, the tick rate is much less important to
> power savings, unless the change in tick rate was significant
> enough to change the load enough that we'd want to change the
> target non-idle MHz of the processor.

Isn't that more or less what on demand does?

Thanks for the feedback, I can probably just say that DMA wakes the CPU 
from C3 and let it ride, I don't want to skip it, but neither do I need 
to go into detail.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
