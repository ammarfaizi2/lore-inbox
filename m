Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129038AbQKFJu0>; Mon, 6 Nov 2000 04:50:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129079AbQKFJuQ>; Mon, 6 Nov 2000 04:50:16 -0500
Received: from [62.172.234.2] ([62.172.234.2]:15501 "EHLO saturn.homenet")
	by vger.kernel.org with ESMTP id <S129038AbQKFJuI>;
	Mon, 6 Nov 2000 04:50:08 -0500
Date: Mon, 6 Nov 2000 09:51:17 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: "Dr. David Gilbert" <dg@px.uk.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Dual Xeon, MTRR problem still there?
In-Reply-To: <Pine.LNX.4.21.0011060936200.24579-100000@springhead.px.uk.com>
Message-ID: <Pine.LNX.4.21.0011060949440.11361-100000@saturn.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No, there is nothing dodgy going on -- NMI counter should be incrementing
fast -- this is normal. See the NMI watchdog routine in the source.

However, you can do even more optimization to your machine by tweaking the
memory timings settings (it will cause data corruption sometimes but I
assume it's not a production machine anyway so it's worth to corrupt data
for satisfaction of curiosity).

Regards,
Tigran

On Mon, 6 Nov 2000, Dr. David Gilbert wrote:

> Hi,
>   While my friendly dual Xeon machine now appears to be pretty fast, I
> notice that the NMI counter is still incrementing like topsy; this
> presumably means that there is still something dodgy going on.
> A hdparm -t seems to be giving respectable values, so I am not quite sure
> where the time/performance is going:
> 
> /proc/mtrr shows the following
> 
> reg00: base=0xf9f00000 (3999MB), size=   1MB: uncachable, count=1
> reg01: base=0xfa000000 (4000MB), size=  32MB: uncachable, count=1
> reg02: base=0xfc000000 (4032MB), size=  64MB: uncachable, count=1
> reg03: base=0x00000000 (   0MB), size=4096MB: write-back, count=1
> reg04: base=0x100000000 (4096MB), size=  64MB: write-back, count=1
> reg05: base=0x104000000 (4160MB), size=  32MB: write-back, count=1
> reg06: base=0x106000000 (4192MB), size=   1MB: write-back, count=1
> 
> Here are two /proc/interrupts straight after each other:
> 
>            CPU0       CPU1       
>   0:   14047275   17655700    IO-APIC-edge  timer
>   1:         73         37    IO-APIC-edge  keyboard
>   2:          0          0          XT-PIC  cascade
>   9:          0          0    IO-APIC-edge  acpi
>  12:       1196        928    IO-APIC-edge  PS/2 Mouse
>  13:          0          0          XT-PIC  fpu
>  20:     226485     240634   IO-APIC-level  eth0
>  56:         14         16   IO-APIC-level  sym53c8xx
>  57:      52554      55135   IO-APIC-level  sym53c8xx
>  58:         15         12   IO-APIC-level  sym53c8xx
> NMI:   31702796   31702796 
> LOC:   31702834   31702833 
> ERR:          0
> 
>            CPU0       CPU1       
>   0:   14047328   17655766    IO-APIC-edge  timer
>   1:         73         37    IO-APIC-edge  keyboard
>   2:          0          0          XT-PIC  cascade
>   9:          0          0    IO-APIC-edge  acpi
>  12:       1196        928    IO-APIC-edge  PS/2 Mouse
>  13:          0          0          XT-PIC  fpu
>  20:     226496     240646   IO-APIC-level  eth0
>  56:         14         16   IO-APIC-level  sym53c8xx
>  57:      52554      55135   IO-APIC-level  sym53c8xx
>  58:         15         12   IO-APIC-level  sym53c8xx
> NMI:   31702915   31702915 
> LOC:   31702953   31702952 
> ERR:          0
> 
> Thats 2.4.0-test10 with last weeks patch.
> 
> Dave
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
