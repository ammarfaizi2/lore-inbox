Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750965AbWDJDUF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750965AbWDJDUF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 23:20:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750939AbWDJDUE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 23:20:04 -0400
Received: from smtp.andrew.cmu.edu ([128.2.10.81]:57251 "EHLO
	smtp.andrew.cmu.edu") by vger.kernel.org with ESMTP
	id S1750903AbWDJDUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 23:20:02 -0400
Message-ID: <2595.128.2.140.234.1144639201.squirrel@128.2.140.234>
In-Reply-To: <20060409195906.77744b9b.rdunlap@xenotime.net>
References: <32947.128.2.140.234.1144536454.squirrel@128.2.140.234>
    <20060408.155430.111013393.davem@davemloft.net>
    <33083.128.2.140.234.1144538327.squirrel@128.2.140.234>
    <20060408163743.c59d6e59.rdunlap@xenotime.net>
    <1786.128.2.140.234.1144604245.squirrel@128.2.140.234>
    <20060409130315.50daaec9.rdunlap@xenotime.net>
    <1949.128.2.140.234.1144634733.squirrel@128.2.140.234>
    <20060409192929.28320c00.rdunlap@xenotime.net>
    <2474.128.2.140.234.1144637390.squirrel@128.2.140.234>
    <20060409195906.77744b9b.rdunlap@xenotime.net>
Date: Sun, 9 Apr 2006 23:20:01 -0400 (EDT)
Subject: Re: 2.4.32: unresolved symbol unregister_qdisc
From: "George P Nychis" <gnychis@cmu.edu>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
User-Agent: SquirrelMail/1.5.1 [CVS]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Sun, 9 Apr 2006 22:49:50 -0400 (EDT) George P Nychis wrote:
> 
>> 
>>> On Sun, 9 Apr 2006 22:05:33 -0400 (EDT) George P Nychis wrote:
>>> 
>>>> 
>>>>> On Sun, 9 Apr 2006 13:37:25 -0400 (EDT) George P Nychis wrote:
>>>>> 
>>>>>> Thanks for the help.
>>>>>> 
>>>>>> Here is the makefile:
>>>>>> http://rafb.net/paste/results/auchPH75.html
>>>>>> 
>>>>>> And here is the full errors I receive: 
>>>>>> http://rafb.net/paste/results/Qplpqw74.html
>>>>>> 
>>>>>> Greatly appreciate it
>>>>>> 
>>>>>> - George
>>>>> 
>>>>> [repeat: please don't top-post]
>>>>> 
>>>>> I don't know how much I can help you.  It's been a long time
>>>>> since I've built external modules on 2.4.x.
>>>>> 
>>>>> Problems that I see: - the Makefile does not use the expected 2.4
>>>>>  kernel build infrastructure; - kernel Makefile uses -nostdinc to
>>>>>  prevent use of userspace headers; - Makefile is trying to
>>>>> include userspace headers instead of kernel headers, e.g.: In file
>>>>> included from /usr/include/linux/if_ether.h:107, from 
>>>>> /usr/include/linux/netdevice.h:29, from sch_xcp.c:8: - this
>>>>> specified include directory is only in 2.6.x, not 2.4.x:
>>>>> -I/lib/modules/`uname -r`/build/include/asm/mach-default
>>>>> 
>>>>> It's not clear to me how this makefile could work with 2.4.x at
>>>>> all. Is it supposed to, or that's just what you want to see it do?
>>>>> 
>>>>> 
>>>>> You could try to fix the Makefile based on makefile-changes
>>>>> articles at lwn.net. E.g.: http://lwn.net/Articles/151784/ 
>>>>> http://lwn.net/Articles/79984/ http://lwn.net/Articles/74767/ 
>>>>> http://lwn.net/Articles/69148/ http://lwn.net/Articles/21823/
>>>>> 
>>>>> 
>>>>> 
>>>>>>> On Sat, 8 Apr 2006 19:18:47 -0400 (EDT) George P Nychis
>>>>>>> wrote:
>>>>>>> 
>>>>>>>> Yeah, this module is unfortunately not under the GPL, it
>>>>>>>> was made for research and i am not the author, I was only
>>>>>>>> given the code for my own research.
>>>>>>>> 
>>>>>>>> I enabled that support in the kernel, and then tried to 
>>>>>>>> recompile and get tons of errors/warnings... so maybe I am 
>>>>>>>> missing something else to be enabled in the kernel... here
>>>>>>>> are a few examples of errors:
>>>>>>>> /usr/include/linux/skbuff.h:30:26: net/checksum.h: No such
>>>>>>>> file or directory /usr/include/asm/irq.h:16:25:
>>>>>>>> irq_vectors.h: No such file or directory
>>>>>>>> /usr/include/linux/irq.h:72: error: `NR_IRQS' undeclared
>>>>>>>> here (not in a function) /usr/include/asm/hw_irq.h:28:
>>>>>>>> error: `NR_IRQ_VECTORS' undeclared here (not in a function)
>>>>>>>> 
>>>>>>>> I think those are the top most errors, so if i can fix
>>>>>>>> those hopefully the rest shall vanish!
>>>>>>> 
>>>>>>> Looks like a Makefile problem then.  Can you post the
>>>>>>> Makefile? Hopefully it is using a Makefile and not just an
>>>>>>> elaborate gcc command line.
>>>>>>> 
>>>>>>> [and please don't top-post]
>>>>>>> 
>>>>>>>> - George
>>>>>>>> 
>>>>>>>> 
>>>>>>>>> From: "George P Nychis" <gnychis@cmu.edu> Date: Sat, 8
>>>>>>>>> Apr 2006 18:47:34 -0400 (EDT)
>>>>>>>>> 
>>>>>>>>>> Hey,
>>>>>>>>>> 
>>>>>>>>>> I have a kernel module that uses unregister_qdisc and 
>>>>>>>>>> register_qdisc, whenever i try to insert the module I
>>>>>>>>>> get: /lib/modules/2.4.32/kernel/net/sched/sch_xcp.o: 
>>>>>>>>>> /lib/modules/2.4.32/kernel/net/sched/sch_xcp.o:
>>>>>>>>>> unresolved symbol unregister_qdisc 
>>>>>>>>>> /lib/modules/2.4.32/kernel/net/sched/sch_xcp.o: 
>>>>>>>>>> /lib/modules/2.4.32/kernel/net/sched/sch_xcp.o:
>>>>>>>>>> unresolved symbol register_qdisc
>>>>>>>>>> 
>>>>>>>>>> Am i missing some sort of support in the kernel?
>>>>>>>>> 
>>>>>>>>> Make sure CONFIG_NET_SCHED is enabled and that you
>>>>>>>>> compiled your module against that kernel.
>>>>>>>>> 
>>>>>>>>> Where does this sch_xcp come from?  It's not in the
>>>>>>>>> vanilla sources.
>>>>>>>>> 
>>>>>>>>> Also, please direct networking questions to the 
>>>>>>>>> netdev@vger.kernel.org mailing list which I have added to
>>>>>>>>> the CC:.
>>>>> 
>>>>> --- ~Randy
>>>>> 
>>>>> 
>>>> 
>>>> By the way, if I add -I/usr/src/linux/include to the compile line,
>>>> it successfully compiles, however, i am back to the start:
>>>> lanthanum-ini src-1.0.1 # insmod sch_xcp Using 
>>>> /lib/modules/2.4.32/kernel/net/sched/sch_xcp.o 
>>>> /lib/modules/2.4.32/kernel/net/sched/sch_xcp.o: 
>>>> /lib/modules/2.4.32/kernel/net/sched/sch_xcp.o: unresolved symbol 
>>>> unregister_qdisc /lib/modules/2.4.32/kernel/net/sched/sch_xcp.o: 
>>>> /lib/modules/2.4.32/kernel/net/sched/sch_xcp.o: unresolved symbol 
>>>> register_qdisc
>>> 
>>> Yet your 2.4.32 kernel image file does have those symbols in it? Can
>>> you verify that by using 'nm' on the kernel image file?
>>> 
>>> If so, then I suppose that you'll need to make a small module test
>>> case that exhibits this behavior, or just tell us where to get the
>>> sch_xcp files...
>>> 
>>> (re-added cc: for netdev)
>>> 
>>> --- ~Randy
>>> 
>>> 
>> 
>> By kernel image, do you mean /usr/src/linux/vmlinux ? if so, 
>> lanthanum-ini linux # nm vmlinux | grep register_qdisc c0399200 R
>> __kstrtab_register_qdisc c0399240 R __kstrtab_unregister_qdisc c039ebc8 R
>> __ksymtab_register_qdisc c039ebd0 R __ksymtab_unregister_qdisc c02eda40 T
>> register_qdisc c02edaf0 T unregister_qdisc
> 
> Yes.  That's good, then.
> 
> --- ~Randy
> 
> 

*sigh* ... still getting the unresolved symbols, i totally don't get it, my /usr/src/linux/vmlinux says that the symbols exist, i install the kernel, reboot, and still get the same errors

Any other way of doing this or reason i can find out whats causing this?

thanks for your help

