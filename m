Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262031AbVGZS60@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262031AbVGZS60 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 14:58:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261994AbVGZSzd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 14:55:33 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:22454 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S262022AbVGZSyI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 14:54:08 -0400
Date: Tue, 26 Jul 2005 14:54:03 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Michel Bouissou <michel@bouissou.net>
cc: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       <dbrownell@users.sourceforge.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [SOLVED ?] VIA KT400 + Kernel 2.6.12 + IO-APIC + ehci_hcd = IRQ
 trouble
In-Reply-To: <200507261248.47286@totor.bouissou.net>
Message-ID: <Pine.LNX.4.44L0.0507261450160.4914-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Jul 2005, Michel Bouissou wrote:

> I'm afraid that I may have accidentally solved my problem ;-)
> 
> I've upgraded my Gigabyte GA7-VAXP motherboard's BIOS from release 7VAXP.F11 
> to 7VAXP.F15, and it seems the problem is gone !
> 
> The strange thing is that now, cat /proc/interrupts shows that both uhci_hcd 
> and ehci_hcd use the same IRQ (21) :
> 
> [root@totor etc]# cat /proc/interrupts
>            CPU0
>   0:     569004    IO-APIC-edge  timer
>   1:       2107    IO-APIC-edge  i8042
>   2:          0          XT-PIC  cascade
>   4:       1589    IO-APIC-edge  serial
>   7:          2    IO-APIC-edge  parport0
>  14:       4615    IO-APIC-edge  ide4
>  15:       4624    IO-APIC-edge  ide5
>  16:      29033   IO-APIC-level  nvidia
>  18:       7684   IO-APIC-level  eth0, eth1
>  19:      28049   IO-APIC-level  ide0, ide1, ide2, ide3
>  21:       7128   IO-APIC-level  ehci_hcd:usb1, uhci_hcd:usb2, uhci_hcd:usb3, 
> uhci_hcd:usb4
>  22:       5969   IO-APIC-level  VIA8233
> NMI:          0
> LOC:     568946
> ERR:          0
> MIS:          0
> 
> ...and then, the system feels happy. I've played around with USB devices of 
> all speeds in all sockets, and there are no "irq 21: nobody cared!" messages 
> anymore...

Not strange at all, since the EHCI controller actually _was_ using IRQ 21!  
The difference is that now Linux knows this.

> Still, high-speed USB devices seem to work only in the motherboard integrated 
> USB sockets, otherwise I get some "usb 1-4: device not accepting address 26, 
> error -71" messages, but this isn't an issue for me, and might be a cable 
> problem as you said...
> 
> So it seems that the BIOS upgrade fixed the IRQ issue (or masked it ?).
> 
> What is weird is that, from the Gigabyte's BIOS list, I wouldn't have expected 
> this upgrade to fix this, as their changelog from F11 to F15 only says:
> 
> F11: AMD Barton CPU support (2500+/2800+/3000+) 
> 
> F13: Fixed BIOS flash utility(flash8xx) can't be used issue
> 
> F14: Support new AMD Duron model8 CPU (64K L2 Cache FSB 266)
> 
> F15: Added AMD Sempron CPU support
> 
> So this BIOS upgrade was just a desperate move on my part ;-)

Sometimes people don't add things into the changelog...

So long as it's working now, that's the important thing.  I'll have to 
remember this BIOS update trick the next time someone has an equivalent 
IRQ-mapping problem.

Alan Stern

