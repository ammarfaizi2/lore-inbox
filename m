Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268120AbTBWKLq>; Sun, 23 Feb 2003 05:11:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268127AbTBWKLq>; Sun, 23 Feb 2003 05:11:46 -0500
Received: from packet.digeo.com ([12.110.80.53]:28380 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S268120AbTBWKLm>;
	Sun, 23 Feb 2003 05:11:42 -0500
Date: Sun, 23 Feb 2003 02:21:48 -0800
From: Andrew Morton <akpm@digeo.com>
To: James Harper <james.harper@bigpond.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SMP and CPU1 not showing interrupts in /proc/interrupts
Message-Id: <20030223022148.7f71398b.akpm@digeo.com>
In-Reply-To: <3E589799.3000105@bigpond.com>
References: <3E589799.3000105@bigpond.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 Feb 2003 10:21:46.0372 (UTC) FILETIME=[5E649C40:01C2DB25]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Harper <james.harper@bigpond.com> wrote:
>
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

That is a deliberate part of the new interrupt balancing code.

If the interrupt rate is low, it is better to keep all the interrupt
processing code and data in the cache of a single CPU.

It is only if that CPU starts to run out of steam that it is worthwhile
taking the hit of getting other CPUs to service interrupts as well.

(I think.  At least, it sounds good and the benchmarks came out well).

