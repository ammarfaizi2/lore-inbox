Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261398AbUBYUFi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 15:05:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261395AbUBYUFh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 15:05:37 -0500
Received: from 217-162-59-239.dclient.hispeed.ch ([217.162.59.239]:20996 "EHLO
	ritz.dnsalias.org") by vger.kernel.org with ESMTP id S261426AbUBYUEb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 15:04:31 -0500
From: Daniel Ritz <daniel.ritz@gmx.ch>
Reply-To: daniel.ritz@gmx.ch
To: Pavel Roskin <proski@gnu.org>
Subject: Re: [PATCH] yenta: irq-routing for TI bridges - take 2
Date: Wed, 25 Feb 2004 21:03:47 +0100
User-Agent: KMail/1.5.2
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       linux-pcmcia <linux-pcmcia@lists.infradead.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <200402240033.31042.daniel.ritz@gmx.ch> <200402250026.20708.daniel.ritz@gmx.ch> <Pine.LNX.4.58.0402250148080.2144@portland.hansa.lan>
In-Reply-To: <Pine.LNX.4.58.0402250148080.2144@portland.hansa.lan>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402252103.48739.daniel.ritz@gmx.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 25 February 2004 07:55, Pavel Roskin wrote:
> On Wed, 25 Feb 2004, Daniel Ritz wrote:
> 
> > hi
> >
> > the last patch was bad...chaning stuff it shouldn't on TI125x, 145x...
> >
> > another try...comments?
> > couldn't find datasheets for 1210, 1220, 1250 so i'm not quite sure about them....
> 
> http://www.mit.edu/afs/sipb/contrib/doc/specs/ic/bridge/

thanks...i looked at the 1220 datasheet and it seems the chip is sane enough
so no special case like the 1250 is needed. the 1210 should be just the same but
with only one slot.

> 
> > compile tested (my TI works, so no difference there)
> 
> Works for me.  yenta_socket is compiled into the kernel.  Two cards:  TI
> 1221 with 2 slots (no fixup needed) and TI 1410 that needs it.
> 

nice to hear it works.

> 
> Yenta: CardBus bridge found at 0000:00:08.0 [133f:1233]
> Yenta: Enabling burst memory read transactions
> Yenta: Using CSCINT to route CSC interrupts to PCI
> Yenta: Routing CardBus interrupts to PCI
> Yenta TI: mfunc 0cc07d92, devctl 60

mfunc0 is inta, mfunc1 is irq9, mfunc2 is activity led, mfunc3 is irq7,
mfunc4 GPI3, mfunc5 is the other led, mfunc6 is irq12...

this would give you irq7,9,12 but device control says parallel PCI only..

> Yenta: ISA IRQ mask 0x0000, PCI irq 5
> Socket status: 30000006
> Yenta: CardBus bridge found at 0000:00:08.1 [133f:1233]
> Yenta: Using CSCINT to route CSC interrupts to PCI
> Yenta: Routing CardBus interrupts to PCI
> Yenta TI: mfunc 0cc07d92, devctl 60
> Yenta: ISA IRQ mask 0x0000, PCI irq 5
> Socket status: 30000006
> Yenta: CardBus bridge found at 0000:00:0a.0 [0000:0000]
> Yenta: Enabling burst memory read transactions
> Yenta: Using CSCINT to route CSC interrupts to PCI
> Yenta: Routing CardBus interrupts to PCI
> Yenta TI: mfunc 00000000, devctl 66

that's just an uninitialized ti1410. so we're using PCI


> Yenta TI: changing mfunc to 00001000
> Yenta TI: falling back to PCI interrupts
> Yenta TI: changing mfunc to 00001002
> Yenta: ISA IRQ mask 0x0000, PCI irq 12
> 
> $ cat /proc/interrupts
>            CPU0
>   0:     664717          XT-PIC  timer
>   1:       1530          XT-PIC  i8042
>   2:          0          XT-PIC  cascade
>   5:          3          XT-PIC  yenta, yenta, orinoco_cs
>   7:          0          XT-PIC  acpi
>   8:          4          XT-PIC  rtc
>  10:       1502          XT-PIC  uhci_hcd, uhci_hcd
>  11:         46          XT-PIC  eth0
>  12:          3          XT-PIC  yenta, VIA686A, orinoco_cs
>  14:      36354          XT-PIC  ide0
>  15:         21          XT-PIC  ide1
> NMI:          0
> ERR:          0
> 
> -- 
> Regards,
> Pavel Roskin
> 

rgds
-daniel 

