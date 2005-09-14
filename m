Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030182AbVINPZS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030182AbVINPZS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 11:25:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965246AbVINPZS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 11:25:18 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:15377 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S965243AbVINPZR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 11:25:17 -0400
Message-ID: <43283C11.70203@tmr.com>
Date: Wed, 14 Sep 2005 11:04:49 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: "Read my lips: no more merges" - aka Linux 2.6.14-rc1
References: <Pine.LNX.4.58.0509122019560.3351@g5.osdl.org>  <1126608030.3455.23.camel@localhost.localdomain>  <1126630878.2066.6.camel@localhost.localdomain>  <Pine.LNX.4.58.0509131010010.3351@g5.osdl.org> <1126635160.2183.6.camel@localhost.localdomain> <Pine.LNX.4.58.0509131210090.3351@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0509131210090.3351@g5.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Tue, 13 Sep 2005, Mathieu Fluhr wrote:
> 
>>Okay, here is the point: I will have these bloody buffer underruns
>>unless I select a 'Timer frequency' of 1000 Hz in 'Processor type and
>>features' section of the kernel configuration. That's quite
>>understandable, as recording a DVD at 16x requires a throughput of 22160
>>KB/s, which is quite fast.
>>
>>I will have a deep look in the patch, and maybe write a patched patch
>>(Ooooo my god what am I writing ?) in the next few days.
> 
> 
> It may just be an application bug too. Too small a buffer, and depending 
> on 2.6.x with a 1kHz timer having timers that run faster...

With cdrecord I can set the FIFO buffer size up to 20MB or so, which is 
locked in memory when running as root. The issue seems to be moving the 
data from the application buffer to the device buffer. Something in the 
kernel would appear to only do that data transfer on a timer tick. It 
may be that the dispatch latency is just too high, and that the thread 
pushing the data to the device is just not getting the CPU in time, even 
with the application buffer locked and the application running at RT 
priority.

I generally build my kernels with voluntary preempt, I think I tried a 
real preempt kernel without improvement, but I can't swear to it. If the 
O.P. doesn't mind a 14th build that might be a decent data point.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me

