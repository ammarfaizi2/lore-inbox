Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129280AbQKBXbF>; Thu, 2 Nov 2000 18:31:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129426AbQKBXa4>; Thu, 2 Nov 2000 18:30:56 -0500
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:7699
	"EHLO ani.animx.eu.org") by vger.kernel.org with ESMTP
	id <S129280AbQKBXap>; Thu, 2 Nov 2000 18:30:45 -0500
Date: Thu, 2 Nov 2000 18:39:30 -0500
From: Wakko Warner <wakko@animx.eu.org>
To: Chris Meadors <clubneon@hereintown.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Dual XEON - >>SLOW<< on SMP
Message-ID: <20001102183930.A17064@animx.eu.org>
In-Reply-To: <m3bsvy2qlb.fsf@otr.mynet.cygnus.com> <Pine.LNX.4.21.0011021334170.83-100000@rc.priv.hereintown.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <Pine.LNX.4.21.0011021334170.83-100000@rc.priv.hereintown.net>; from Chris Meadors on Thu, Nov 02, 2000 at 01:38:18PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I'm seeing this as well, but only with PIII Xeon systems, not PII
> > Xeon.  Every single timer interrupt on any CPU is accompanied by a NMI
> > and LOC increment on every CPU.
> > 
> >            CPU0       CPU1       
> >   0:     146727     153389    IO-APIC-edge  timer
> > [...]
> > NMI:     300035     300035 
> > LOC:     300028     300028 
> 
> You mean that isn't supposed to happen?
> 
>            CPU0       CPU1
>   0:    8480192    7786028    IO-APIC-edge  timer
>   1:          3          1    IO-APIC-edge  keyboard
>   2:          0          0          XT-PIC  cascade
>   8:          0          0    IO-APIC-edge  rtc
>  13:          0          0          XT-PIC  fpu
>  23:     188915     191259   IO-APIC-level  eth0
>  28:         16         14   IO-APIC-level  sym53c8xx
>  29:      33655      33665   IO-APIC-level  sym53c8xx
>  30:          0          0   IO-APIC-level  es1371
> NMI:   16266140   16266140
> LOC:   16266123   16266122
> ERR:          0
> 
> This machine isn't even a Xeon, just a PIII CuMine on a ServerWorks HeIII
> chipset.

[wakko@gohan:/home/wakko] cat /proc/interrupts 
           CPU0       CPU1       
  0:   15276613   18358687    IO-APIC-edge  timer
  1:        391        455    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  4:          1          0    IO-APIC-edge  serial
 13:          1          0          XT-PIC  fpu
 14:       3013       2422    IO-APIC-edge  ide0
 16:     179450     191589   IO-APIC-level  eth0
 17:         22         23   IO-APIC-level  aic7xxx
 18:      17254      15655   IO-APIC-level  es1371
 19:         11         10   IO-APIC-level  aic7xxx
NMI:   33635184   33635184 
LOC:   33636726   33636725 
ERR:          0
[wakko@gohan:/home/wakko] cat /proc/mtrr 

I noticed it was a tad slow, but I figured it was the fact it was a netboot
machine.  It's a dual ppro 200 192mb ram.
                         
-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
