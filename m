Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129073AbQKBSlp>; Thu, 2 Nov 2000 13:41:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129089AbQKBSlg>; Thu, 2 Nov 2000 13:41:36 -0500
Received: from chaos.analogic.com ([204.178.40.224]:53508 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S129073AbQKBSlW>; Thu, 2 Nov 2000 13:41:22 -0500
Date: Thu, 2 Nov 2000 13:40:36 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Chris Meadors <clubneon@hereintown.net>
cc: Ulrich Drepper <drepper@redhat.com>, kernel@kvack.org,
        "Dr. David Gilbert" <dg@px.uk.com>, linux-kernel@vger.kernel.org
Subject: Re: Dual XEON - >>SLOW<< on SMP
In-Reply-To: <Pine.LNX.4.21.0011021334170.83-100000@rc.priv.hereintown.net>
Message-ID: <Pine.LNX.3.95.1001102133727.11410A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Nov 2000, Chris Meadors wrote:

> On 2 Nov 2000, Ulrich Drepper wrote:
> 
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
> 
> I reported this on -test6 but got no replies.  I'm now running -test10 and
> still seeing it.
> 

I sure home these ISRs are __tiny__. There is a large amount of
overhead to an interrupt!

           CPU0       CPU1       
  0:    3772079    3803111    IO-APIC-edge  timer
  1:      32410      33467    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  4:          4          2    IO-APIC-edge  Analogic(tm) VXI Driver
  8:          0          0    IO-APIC-edge  rtc
 10:    1089719    1091693   IO-APIC-level  eth0
 11:      98093      96730   IO-APIC-level  BusLogic BT-958
 13:          1          0          XT-PIC  fpu
NMI:          0
ERR:          0

My machine doesn't do any of that stuff but I'm not running the
latest kernel (yet).


Cheers,
Dick Johnson

Penguin : Linux version 2.2.17 on an i686 machine (801.18 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
