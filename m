Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261448AbSKGSuL>; Thu, 7 Nov 2002 13:50:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261472AbSKGSuL>; Thu, 7 Nov 2002 13:50:11 -0500
Received: from 12-237-170-171.client.attbi.com ([12.237.170.171]:31542 "EHLO
	wf-rch.cirr.com") by vger.kernel.org with ESMTP id <S261448AbSKGSuK>;
	Thu, 7 Nov 2002 13:50:10 -0500
Message-ID: <3DCAC5FC.2010205@mvista.com>
Date: Thu, 07 Nov 2002 13:58:52 -0600
From: Corey Minyard <cminyard@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux ppc; en-US; rv:1.1) Gecko/20020828
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: linux-kernel@vger.kernel.org
Subject: Re: NMI handling rework
References: <Pine.LNX.3.95.1021107115259.9343A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:

>On Thu, 7 Nov 2002, Zwane Mwaikambo wrote:
>
>  
>
>>On Thu, 7 Nov 2002, Corey Minyard wrote:
>>
>>    
>>
>>>NMIs cannot be masked, they are by definition non-maskable :-).  You can 
>>>get an NMI while executing an NMI.
>>>      
>>>
>>"After an NMI interrupt is recognized by the P6 family, Pentium, Intel486, 
>>Intel386, and Intel 286 processors, the NMI interrupt is masked until the 
>>first IRET instruction is executed, unlike the 8086 processor."
>>
>>- 18.22.2 NMI Interrupts, Intel IA32 System Developer's Manual vol3d 
>>
Thanks, and thanks to everyone else that pointed this out.

It is still possible, though unlikely, that two NMI sources could occur 
at the same time.  Maybe that's not worth worrying about, and maybe for 
the APICs it works fine.

>>>An NMI-based timer?  I can see the use if you REALLY need accurate 
>>>intervals, but you can't do much in an NMI, no spinlocks, even.
>>>      
>>>
>[SNIPPED...]
>
>You can use a spinlock and, in fact, that's the only way you can
>protect a critical section. The other CPU will spin of course, just
>like the other CPU in a maskable interrupt. That's what spin-locks
>are for. With maskable interrupts, the "cli" affects only the CPU
>that actually fetches that instruction. That's why you need spin-lock
>protection when you have more than one CPU. With NMI, no CPU has
>the effect a "cli" would provide, so they just spin at the lock
>until the lock is released.
>
I should have been more precise here.  You cannot use a spinlock that 
you use outside of the NMI, too.  You might be holding the spinlock when 
the NMI occurs, and you would then be in deadlock.

-Corey

