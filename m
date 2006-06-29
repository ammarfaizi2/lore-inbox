Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751816AbWF2JDR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751816AbWF2JDR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 05:03:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751817AbWF2JDR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 05:03:17 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:36016 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751816AbWF2JDQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 05:03:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:date:x-x-sender:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type:from;
        b=WfwYCmR74usVwQ3ezNv6gclwEu2khJwhbTNDywy9Lzlwl5w+faNXpB5e+Mkif0Pr6p5q3nULCxYHCvlWzVbPLm1CYpXtSjo39PYqy6Y7yUNjUrV5UXi/HCm84DP34puIdggDeQZXrMHjEfb8hV/Vp8t2aaKWHvIT94hMtpBDFSM=
Date: Thu, 29 Jun 2006 11:03:25 +0100 (BST)
X-X-Sender: simlo@localhost.localdomain
To: Milan Svoboda <msvoboda@ra.rockwell.com>
cc: Esben Nielsen <nielsen.esben@googlemail.com>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] Linux-2.6.17-rt3 on arm ixdp465
In-Reply-To: <OF333B3CA3.DCE515CC-ONC125719C.00265C3B-C125719C.0026A1E2@ra.rockwell.com>
Message-ID: <Pine.LNX.4.64.0606291051400.10401@localhost.localdomain>
References: <OF333B3CA3.DCE515CC-ONC125719C.00265C3B-C125719C.0026A1E2@ra.rockwell.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
From: Esben Nielsen <nielsen.esben@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jun 2006, Milan Svoboda wrote:

>> #
>> # Tulip family network device support
>> #
>> # CONFIG_NET_TULIP is not set
>> # CONFIG_HP100 is not set
>> CONFIG_NET_PCI=y
>> # CONFIG_PCNET32 is not set
>> # CONFIG_AMD8111_ETH is not set
>> # CONFIG_ADAPTEC_STARFIRE is not set
>> # CONFIG_B44 is not set
>> # CONFIG_FORCEDETH is not set
>> # CONFIG_DGRS is not set
>> CONFIG_EEPRO100=y
>> # CONFIG_E100 is not set
>> # CONFIG_FEALNX is not set
>
> I use "old" eepro100 network device driver...
>

"old"?

> Thank you for your answer, I look at it too...
>

eepro100 seems to be SMP safe, so it shouldn't be there.
Have anyone else used eepro100 with preempt-realtime?

Anyway: I miss stack trace from the bugs. I don't know what to swich on at 
arm to get it to work - I think I remember getting stack traces years ago 
when I succeed in getting Linux 2.4 to run on a custom SA1110 based board. 
Try to swich on various debug like
  CONFIG_DEBUG_INFO
  CONFIG_UNWIND_INFO
  CONFIG_BUGVERBOSE
  CONFIG_FRAME_POINTER

Esben

> Milan
>
>
>
>
>
>
> Esben Nielsen <nielsen.esben@googlemail.com>
> 06/28/2006 07:02 PM
>
>
>        To:     Milan Svoboda <msvoboda@ra.rockwell.com>
>        cc:     linux-kernel@vger.kernel.org
>        Subject:        Re: [BUG] Linux-2.6.17-rt3 on arm ixdp465
>
>
> On Wed, 28 Jun 2006, Milan Svoboda wrote:
>
>> Hello,
>>
>> I tried this kernel on arm ixdp465, it works well, but I got many
>> of these messages:
>>
>> BUG: scheduling with irqs disabled: IRQ 25/0x00000000/683
>> caller is rt_lock_slowlock+0xd8/0x1c8
>> BUG: scheduling with irqs disabled: IRQ 25/0x00000000/683
>> caller is rt_lock_slowlock+0xd8/0x1c8
>> BUG: scheduling with irqs disabled: IRQ 25/0x00000000/683
>> caller is rt_lock_slowlock+0xd8/0x1c8
>> BUG: scheduling with irqs disabled: IRQ 25/0x00000000/683
>> caller is rt_lock_slowlock+0xd8/0x1c8
>> BUG: scheduling with irqs disabled: IRQ 25/0x00000000/683
>> caller is rt_lock_slowlock+0xd8/0x1c8
>>
>> # cat /proc/interrupts
>>           CPU0
>> 5:      29620   IXP4xx Timer Tick
>> 15:        876   serial
>> 25:       3813   eth0
>> Err:          0
>>
>
> Looks like a bug in your ethernet driver, which is?
> It could be that that driver is not SMP compliant and uses irq
> disable/enable
> as locking method instead of a spinlock.
>
> Esben
>
>> PS: Please CC me, I'm not subscribed...
>>
>> Best Regards,
>> Milan Svoboda
>>
>>
>>
>
>
>
