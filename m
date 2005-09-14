Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751219AbVINRE0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751219AbVINRE0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 13:04:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751220AbVINRE0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 13:04:26 -0400
Received: from eastrmmtao02.cox.net ([68.230.240.37]:10685 "EHLO
	eastrmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1751219AbVINREZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 13:04:25 -0400
From: "Steve Lee" <steve@tuxsoft.com>
To: <linux-kernel@vger.kernel.org>
Subject: Re: "Read my lips: no more merges" - aka Linux 2.6.14-rc1
Date: Wed, 14 Sep 2005 12:04:21 -0500
Message-ID: <000001c5b94e$5de12130$8119fea9@pluto>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4024
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just an FYI,

NeroLINUX is also broken.  I can't successfully burn a DVD.

Steve


Linus Torvalds wrote:
> 
> On Tue, 13 Sep 2005, Mathieu Fluhr wrote:
> 
>>Okay, here is the point: I will have these bloody buffer underruns
>>unless I select a 'Timer frequency' of 1000 Hz in 'Processor type and
>>features' section of the kernel configuration. That's quite
>>understandable, as recording a DVD at 16x requires a throughput of
22160
>>KB/s, which is quite fast.
>>
>>I will have a deep look in the patch, and maybe write a patched patch
>>(Ooooo my god what am I writing ?) in the next few days.
> 
> 
> It may just be an application bug too. Too small a buffer, and
depending 
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


