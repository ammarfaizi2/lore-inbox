Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268005AbTBWKnJ>; Sun, 23 Feb 2003 05:43:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268024AbTBWKnJ>; Sun, 23 Feb 2003 05:43:09 -0500
Received: from gw1.cosmosbay.com ([62.23.185.226]:45513 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP
	id <S268005AbTBWKnI>; Sun, 23 Feb 2003 05:43:08 -0500
Message-ID: <01a601c2db29$98fd89d0$c700a8c0@edumazet>
From: "dada1" <dada1@cosmosbay.com>
To: "James Harper" <james.harper@bigpond.com>, <linux-kernel@vger.kernel.org>
References: <3E589799.3000105@bigpond.com>
Subject: Re: SMP and CPU1 not showing interrupts in /proc/interrupts
Date: Sun, 23 Feb 2003 11:52:01 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I too had such interrupt distribution...

In my case, absolutely no interrupts was taken by CPU1, even the timer...
and I recall that timer interrupts should hit all the CPUS or strange things
can appear.

But, curiously, a

echo 3 >/proc/irq/0/smp_affinity

solved the problem for me (for IRQ 0 only of course)

I say curiously because the old smp_affinity value was 0xffffffff, so
masking the unused bits should have no effect.

Eric

> somewhere between about 2.5.53 and 2.5.62 my /proc/interrupts has gone
> from an approximately even distribution of interrupts between CPU0 and
> CPU1 to grossly uneven:
>
>            CPU0       CPU1
>   0:   13223321    2233217    IO-APIC-edge  timer
>   1:      13442          0    IO-APIC-edge  i8042
>   2:          0          0          XT-PIC  cascade
>   3:     291874          0    IO-APIC-edge  serial
>   8:          3          0    IO-APIC-edge  rtc
>   9:          0          0    IO-APIC-edge  acpi
>  14:      18932          0    IO-APIC-edge  ide0
>  15:         14          0    IO-APIC-edge  ide1
>  16:     190607          1   IO-APIC-level  eth0, nvidia
>  17:       3214          0   IO-APIC-level  bttv0
>  18:      14249          1   IO-APIC-level  ide2
>  19:     121942          0   IO-APIC-level  uhci-hcd, wlan0
> NMI:          0          0
> LOC:   15458218   15458423
> ERR:          0
> MIS:          0
>
> if i really hit the system hard then CPU1 will start accruing interrupts
> but in a mostly idle state CPU1 just sits on its bum and lets CPU0
> handle them all, with the exception of irq #0, for some reason.
>
> any ideas?
>
> thanks
>
> James
>


