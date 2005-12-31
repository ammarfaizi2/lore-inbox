Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751083AbVLaAUd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751083AbVLaAUd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 19:20:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751183AbVLaAUc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 19:20:32 -0500
Received: from [202.67.154.148] ([202.67.154.148]:5051 "EHLO ns666.com")
	by vger.kernel.org with ESMTP id S1751081AbVLaAUa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 19:20:30 -0500
Message-ID: <43B5CEB8.9070801@ns666.com>
Date: Sat, 31 Dec 2005 01:20:08 +0100
From: Mark v Wolher <trilight@ns666.com>
User-Agent: Mozilla/4.8 [en] (Windows NT 5.1; U)
X-Accept-Language: en-us
MIME-Version: 1.0
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
CC: Lee Revell <rlrevell@joe-job.com>,
       Folkert van Heusden <folkert@vanheusden.com>,
       Jesper Juhl <jesper.juhl@gmail.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: system keeps freezing once every 24 hours / random apps crashing
References: <43B53EAB.3070800@ns666.com> <200512302311.27125.s0348365@sms.ed.ac.uk> <43B5C5F6.5070500@ns666.com> <200512302356.59749.s0348365@sms.ed.ac.uk>
In-Reply-To: <200512302356.59749.s0348365@sms.ed.ac.uk>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alistair John Strachan wrote:
> On Friday 30 December 2005 23:42, Mark v Wolher wrote:
> 
>>Alistair John Strachan wrote:
>>
>>>On Friday 30 December 2005 22:16, Mark v Wolher wrote:
>>>[snip]
>>>
>>>
>>>>>Basically you are asking for help with an unsupported configuration.  In
>>>>>general people on LKML will be more helpful if you take the time to find
>>>>>out what the bug reporting guidelines are before posting.
>>>>>
>>>>>Lee
>>>>
>>>>Thank you for your input, but sometimes thinking out of the box gives a
>>>>solution instead of hiding behind "guidelines".
>>>
>>>I'm surprised Lee fed you this long, but the cold hard fact of the matter
>>>is that you are posting to the Linux kernel mailing lists, and you will
>>>comply with these guidelines if you expect help.
>>>
>>>I'm sure the problem might not be with VMWare, but there is absolutely
>>>nothing stopping you from switching nvidia with nv, not loading
>>>nvidia/vmware modules, then running the TV card doing *something else*
>>>for a few hours. If you do not detect lockups, contact VMWare. They will
>>>probably do the exact opposite of what Lee has done and suggest
>>>non-VMWare parts of the system are at fault.
>>>
>>>However, unlike VMWare or NVIDIA, we can actually debug problems if you
>>>use source-available modules. Thinking outside of the box here is
>>>irrelevant -- a problem requires logical procedure to gain a solution.
>>>Any engineer will tell you the same thing. Ordinarily, this is test,
>>>observe, retest, and all Lee is suggesting is that you do *not* load the
>>>proprietary modules.
>>>
>>>Try it before responding to this email, so you do not have to write
>>>another.
>>
>>I already switched nvidia for the nv driver in the kernel. Also disabled
>>by unloading all modules.
> 
> 
> As Lee already explained, "unloading" is insufficient. If you continue to 
> argue that it is sufficient, then you are only exposing your own ignorance of 
> the issues at hand. Please physically delete the modules so that they cannot 
> ever be loaded by the kernel during or after bootup, then reboot the machine 
> before testing.
> 
> 
>>You're saying i should then see what happens after doing the above ...
>>This is exactly what i'm now doing, tvcard is active (tv) and i'm doing
>>some work as usual. I get the feeling some people consider everyone who
>>is a bit different in approach as either some newbie or an idiot, well
>>wake up, sometimes by looking from a different view at a problem it can
>>be solved. This doesn't mean i don't appreciate the advise of Lee or
>>yours, i only ask for some patience. It's not like the world is going
>>under if we don't solve this in an hour with traditional logic. :)
> 
> 
> Feel free to try any method you like, but the method myself and Lee have 
> stated is the only one acceptable on this list.
> 
> 
>>And at this point the system is still working, i'm increasing the load
>>by making it crush numbers, doing a full virusscan and so on.
> 
> 
> This is good news -- you stand a better chance of achieving the stability you 
> require by eliminating variables. VMWare and NVIDIA are useful softwares, and 
> I would not deny that, but they are closed source and thus any conflicts 
> resulting from their use are not necessary LKML material (however, if the 
> interaction is generic and is as a result of a kernel bug, then the 
> maintainer would very much like to hear it).
> 

Okay, i have something interesting now, i only had the nvidia module
loaded so my x-configuration starts up as usual. (not saying the nvidia
module is flawless, i'm sure it still contains bugs)
But here is the crash info, this time it was mozilla, i think this
speaks more hehe :

Dec 31 00:55:28 localhost kernel: mm/memory.c:106: bad pgd 061f0c08.
Dec 31 00:55:28 localhost kernel: mm/memory.c:106: bad pgd 06b96000.
Dec 31 00:55:28 localhost kernel: mm/memory.c:106: bad pgd 18000bf8.
Dec 31 00:55:28 localhost kernel: ------------[ cut here ]------------
Dec 31 00:55:28 localhost kernel: kernel BUG at mm/mmap.c:2214!
Dec 31 00:55:28 localhost kernel: invalid operand: 0000 [#1]
Dec 31 00:55:28 localhost kernel: SMP
Dec 31 00:55:28 localhost kernel: Modules linked in: nvidia
Dec 31 00:55:28 localhost kernel: CPU:    2
Dec 31 00:55:28 localhost kernel: EIP:    0060:[exit_mmap+323/400]
Tainted: PF     VLI
Dec 31 00:55:28 localhost kernel: EFLAGS: 00010202   (2.6.14.5)
Dec 31 00:55:28 localhost kernel: eax: 00000071   ebx: 00000000   ecx:
c9b02660   edx: dff65e00
Dec 31 00:55:28 localhost kernel: esi: 00000000   edi: 00000007   ebp:
de48d0c0   esp: cb4b5dfc
Dec 31 00:55:28 localhost kernel: ds: 007b   es: 007b   ss: 0068
Dec 31 00:55:28 localhost kernel: Process mozilla-bin (pid: 22417,
threadinfo=cb4b4000 task=c9f25030)
Dec 31 00:55:28 localhost kernel: Stack: c9b02628 00000000 00000000 00000000
ffffffff cb4b5e1c 00000000 c1411600
Dec 31 00:55:28 localhost kernel: 000070a6 de48d080 de48d0c4 c9f254dc
00000009 c0162d68 de48d080 c9f25030
Dec 31 00:55:28 localhost kernel: cb4b4000 c0167b7b de48d080 00000009
00000009 cb4b4000 00000001 00000009
Dec 31 00:55:28 localhost kernel: Call Trace:
Dec 31 00:55:28 localhost kernel: [mmput+56/160]
Dec 31 00:55:28 localhost kernel: [do_exit+235/1040]
Dec 31 00:55:28 localhost kernel: [do_group_exit+64/176]
Dec 31 00:55:28 localhost kernel: [get_signal_to_deliver+560/832]
Dec 31 00:55:28 localhost kernel: [do_signal+143/288]
Dec 31 00:55:28 localhost kernel: [free_task+39/48]
Dec 31 00:55:28 localhost kernel: [pg0+548271682/1066550272]
Dec 31 00:55:28 localhost kernel: [pg0+550504623/1066550272]
Dec 31 00:55:28 localhost kernel: [__do_softirq+214/240]
Dec 31 00:55:28 localhost kernel: [do_notify_resume+55/64]
Dec 31 00:55:28 localhost kernel: [work_notifysig+19/37]
Dec 31 00:55:28 localhost kernel: Code: 00 85 f6 74 14 8d 76 00 8b 5e 0c 89
34 24 e8 45 d7 ff ff 85 db 89 de 75 ef 8b bf 94 00 00 00 85 ff 75 08 83 c4
24 5b 5e 5f 5d c3 <0f> 0b a6 08 73 e3 57 c0 eb ee c7 43 08 00 00 00 00 8b 03
89 04
Dec 31 00:55:28 localhost kernel: <1>Fixing recursive fault but reboot is
needed!


And i appreciate your time and bother.











