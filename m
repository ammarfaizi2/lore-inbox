Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751293AbVL3TW7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751293AbVL3TW7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 14:22:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751294AbVL3TW7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 14:22:59 -0500
Received: from [202.67.154.148] ([202.67.154.148]:4495 "EHLO ns666.com")
	by vger.kernel.org with ESMTP id S1751293AbVL3TW6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 14:22:58 -0500
Message-ID: <43B5890E.30104@ns666.com>
Date: Fri, 30 Dec 2005 20:22:54 +0100
From: Mark v Wolher <trilight@ns666.com>
User-Agent: Mozilla/4.8 [en] (Windows NT 5.1; U)
X-Accept-Language: en-us
MIME-Version: 1.0
To: Folkert van Heusden <folkert@vanheusden.com>
CC: Jesper Juhl <jesper.juhl@gmail.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: system keeps freezing once every 24 hours / random apps crashing
References: <43B53EAB.3070800@ns666.com>	<9a8748490512300627w26569c06ndd4af05a8d6d73b6@mail.gmail.com>	<43B557D7.6090005@ns666.com> <43B5623D.7080402@ns666.com>	<20051230164751.GQ3105@vanheusden.com> <43B56ADD.7040300@ns666.com> <20051230183021.GV3105@vanheusden.com>
In-Reply-To: <20051230183021.GV3105@vanheusden.com>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Folkert van Heusden wrote:
>>>>>I'm not sure what to make of this, but it looks like only 1 cpu is kept
>>>>>busy with interrupts:
>>>>>          CPU0       CPU1       CPU2       CPU3
>>>>> 0:    1033372          0          0          0    IO-APIC-edge  timer
>>>
>>>Install the 'irqbalance' package.
>>
>><..>
>>Thanks ! I installed it now, it asked me something about a "one shot
>>mode" but i chose no. Correct me if i should choose the other mode.
>>Should i reboot for this to take effect ? Cause i still see the 0's
>>under the other cpu's.
> 
> 
> Not one-shot
> reboot? depends on your distribution
> try /usr/sbin/irqbalance from bash
> 
> 
> Folkert van Heusden
> 

Hmm, i disabled MSI in the kernel, irq-balancing is on in the kernel,
and after a restart with irqbalance i see the cpu's show numbers !

I guess MSI was preventing them ? But does that means because of MSI
that performance was lower in some way ?

Here is the current cat:



           CPU0       CPU1       CPU2       CPU3
  0:      59805      40023      42523      38141    IO-APIC-edge  timer
  1:        984        840        795        413    IO-APIC-edge  i8042
  7:          0          0          0          0    IO-APIC-edge  parport0
  8:     204851     189535     184425     184454    IO-APIC-edge  rtc
  9:          0          0          0          0   IO-APIC-level  acpi
 14:         21          0          0          0    IO-APIC-edge  ide0
 15:         13          0          0          0    IO-APIC-edge  ide1
 16:       2206          0          0          0   IO-APIC-level  eth0
 17:       9681       4489       6747      10672   IO-APIC-level  bttv0
 18:         48         16          0          0   IO-APIC-level
uhci_hcd:usb4
 19:       5889       9693      22604       1560   IO-APIC-level  ide2, ide3
 20:          5          0          0          0   IO-APIC-level
ehci_hcd:usb1
 21:      16563      25276      23860      19548   IO-APIC-level
uhci_hcd:usb2, nvidia
 22:      33248      15866      13468      33568   IO-APIC-level
uhci_hcd:usb3
 23:          0          0          0          0   IO-APIC-level  Intel
82801DB-ICH4
 24:          0          0          0          0   IO-APIC-level  EMU10K1
NMI:          0          0          0          0
LOC:     180380     180126     180378     180377
ERR:          0
MIS:          0


