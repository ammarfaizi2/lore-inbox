Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263740AbUGLVrz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263740AbUGLVrz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 17:47:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263752AbUGLVrz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 17:47:55 -0400
Received: from mail.tmr.com ([216.238.38.203]:62217 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S263740AbUGLVru (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 17:47:50 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: post 2.6.7 BK change breaks Java?
Date: Mon, 12 Jul 2004 17:50:00 -0400
Organization: TMR Associates, Inc
Message-ID: <ccv0ki$sma$2@gatekeeper.tmr.com>
References: <40F20372.9000205@quark.didntduck.org><40F20372.9000205@quark.didntduck.org> <40F20C23.9050705@quark.didntduck.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1089668562 29386 192.168.12.100 (12 Jul 2004 21:42:42 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040608
X-Accept-Language: en-us, en
In-Reply-To: <40F20C23.9050705@quark.didntduck.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian Gerst wrote:
> Brian Gerst wrote:
> 
>> Jesper Juhl wrote:
>>
>>> On Sun, 11 Jul 2004, Jesper Juhl wrote:
>>>
>>>
>>>> On Sun, 11 Jul 2004, Grzegorz Kulewski wrote:
>>>>
>>>>
>>>>> On Sun, 11 Jul 2004, Jesper Juhl wrote:
>>>>>
>>>>>
>>>>>> On Fri, 9 Jul 2004, Jesper Juhl wrote:
>>>>>>
>>>>>>
>>>>>>> On Fri, 9 Jul 2004, Con Kolivas wrote:
>>>>>>>
>>>>>>>
>>>>>>>> but I suspect it's one of those possibly interfering. Looking at 
>>>>>>>> the
>>>>>>>> patches in question I have no idea how they could do it. I guess 
>>>>>>>> if you
>>>>>>>> can try backing them out it would be helpful. Here are links to the
>>>>>>>> patches in question.
>>>>>>>> http://ck.kolivas.org/patches/2.6/2.6.7/2.6.7-ck5/split-out/1100_ip_tabl 
>>>>>>>>
>>>>>>>> es.patch
>>>>>>>> http://ck.kolivas.org/patches/2.6/2.6.7/2.6.7-ck5/split-out/1105_CAN-200 
>>>>>>>>
>>>>>>>> 4-0497.patch
>>>>>>>> http://ck.kolivas.org/patches/2.6/2.6.7/2.6.7-ck5/split-out/1110_proc.pa 
>>>>>>>>
>>>>>>>> tch
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> Thanks Con, I'll try playing with those tomorrow (got no time 
>>>>>>> tonight),
>>>>>>> and report back.
>>>>>>>
>>>>>>
>>>>>> Ok, got them all 3 backed out of 2.6.7-mm7 , but that doesn't 
>>>>>> change a
>>>>>> thing. The JVM still dies when I try to run eclipse.
>>>>>
>>>>>
>>>>>
>>>>> I can run Eclipse without any problems on 2.6.7-bk20-ck5 + few 
>>>>> other not
>>>>> related patches. Maybe try using non -mm? Try 2.6.7-bk20 and then try
>>>>> reverting some patches. Maybe there is some other problem in -mm that
>>>>> gives similar results?
>>>>>
>>>>
>>>> with plain 2.6.7-bk20 I see the issue, same with 2.6.7-mm7. Reverting
>>>> http://linux.bkbits.net:8080/linux-2.6/cset@1.1743 from -mm7 fixes the
>>>> issue. I'm currently building 2.6.7-bk20 minus that cset and I'll 
>>>> report
>>>> back on the results of that in a few minutes.
>>>>
>>>
>>> 2.6.7-bk20 minus the cset works.
>>>
>>> Testing with 2.6.8-rc1 and backing out one or both of the changes in the
>>> cset I get these results :
>>> 2.6.8-rc1       - vanilla                                       - 
>>> breaks Java
>>> 2.6.8-rc1-jju1  - both changes backed out                       - works
>>> 2.6.8-rc1-jju2  - only first change (sys_rt_sigsuspend) applied - works
>>> 2.6.8-rc1-jju3  - only second change (sys_sigaltstack) applied  - 
>>> breaks Java
>>>
>>> -- 
>>> Jesper Juhl <juhl-lkml@dif.dk>
>>
>>
>>
>> Looks like a GCC (gcc version 3.4.1 20040702 (Red Hat Linux 3.4.1-2)) 
>> screwup:
>>
>> sys_sigaltstack:
>>         movl    4(%esp), %eax
>>         movl    8(%esp), %edx
>>         movl    56(%esp), %ecx
>>         jmp     do_sigaltstack
>>
>> The offsets should be 4 more, to account for the return address on the 
>> stack.
> 
> 
> Nevermind, I should have looked more carefully.  The offsets are fine in 
> my example.  What version of GCC are you using?
> 
Not related to passing args in registers or some such, is it? I did a 
brief flirtation with 7-bk20 and didn't see a problem. I have NOT tried 
that option, perhaps some folks did?

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
