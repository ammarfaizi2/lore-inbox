Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267599AbUHEIan@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267599AbUHEIan (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 04:30:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267602AbUHEIan
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 04:30:43 -0400
Received: from hermine.aitel.hist.no ([158.38.50.15]:20748 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S267599AbUHEIak (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 04:30:40 -0400
Message-ID: <4111F0FF.7090301@hist.no>
Date: Thu, 05 Aug 2004 10:34:07 +0200
From: Helge Hafting <helge.hafting@hist.no>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc2-mm2
References: <20040802015527.49088944.akpm@osdl.org> <410E3CAF.6080305@kolivas.org> <410F3423.3020409@yahoo.com.au> <cone.1091518501.973503.9648.502@pc.kolivas.org> <cone.1091519122.804104.9648.502@pc.kolivas.org> <41109FCC.4070906@yahoo.com.au> <20040804103143.GA13072@elte.hu> <cone.1091616443.996442.9775.502@pc.kolivas.org> <20040804124538.GA15505@elte.hu> <cone.1091674380.801763.9775.502@pc.kolivas.org>
In-Reply-To: <cone.1091674380.801763.9775.502@pc.kolivas.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:

> Ingo Molnar writes:
>
>>
>> * Con Kolivas <kernel@kolivas.org> wrote:
>>
>>>
>>> Can you define them please? I haven't had any reported to me.
>>
>>
>> sure: take a process that uses 85% of CPU time (and sleeps 15% of the
>> time) if running on an idle system. Start just two of these hogs at
>> normal priority. 2.6.8-rc2-mm2 becomes almost instantly unusable even
>> over a text console: a single 'top' refresh takes ages, 'ls' displays
>> one line per second or so. Start more of these and the system
>> effectively locks up.
>
>
> It's only if I physically try and create such a test application that 
> I can reproduce it. I haven't found any real world load that does that 
> - but of course that doesn't mean I should discount it. However, 
> interactive mode off doesn't exhibit it and it should be easy enough 
> to fix for interactive mode on. Thanks for pointing it out.

I can easily imagine this sort of real-life application.  Anything that 
generate real-time data, such as sound or video for immediate playback 
will use some continous fraction of cpu, depending on how much data and 
how fast the cpu happens to be.   A scheduler with such
a problem will now and then cause trouble when some processor needs just the
"wrong" percentage of its capacity to run the task(s). 
Consider someone playing several video files until he exceeds the 
capacity of the machine. Video skipping frames is then ok, a frozen UI 
is not.  Or consider a multiuser machine running several games.  Or even 
a parallell kernel compile when the source isn't cached. The compiler(s) 
will work for a while, wait for disk for a while, work for a while . . .

2.6.8-rc2-mm2 seems to work fine for me right now, but I hope there will 
be solutions for this sort of problem.

Helge Hafting


