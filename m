Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262641AbUBYGzR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 01:55:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262639AbUBYGzR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 01:55:17 -0500
Received: from cmail.srv.hcvlny.cv.net ([167.206.112.40]:52691 "EHLO
	cmail.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S262641AbUBYGzK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 01:55:10 -0500
Date: Wed, 25 Feb 2004 01:55:09 -0500 (EST)
From: Pavel Roskin <proski@gnu.org>
Subject: Re: [PATCH] yenta: irq-routing for TI bridges - take 2
In-reply-to: <200402250026.20708.daniel.ritz@gmx.ch>
X-X-Sender: proski@portland.hansa.lan
To: Daniel Ritz <daniel.ritz@gmx.ch>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       linux-pcmcia <linux-pcmcia@lists.infradead.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <Pine.LNX.4.58.0402250148080.2144@portland.hansa.lan>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <200402240033.31042.daniel.ritz@gmx.ch>
 <20040224124011.A30975@flint.arm.linux.org.uk>
 <200402241623.11569.daniel.ritz@alcatel.ch>
 <200402250026.20708.daniel.ritz@gmx.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Feb 2004, Daniel Ritz wrote:

> hi
>
> the last patch was bad...chaning stuff it shouldn't on TI125x, 145x...
>
> another try...comments?
> couldn't find datasheets for 1210, 1220, 1250 so i'm not quite sure about them....

http://www.mit.edu/afs/sipb/contrib/doc/specs/ic/bridge/

> compile tested (my TI works, so no difference there)

Works for me.  yenta_socket is compiled into the kernel.  Two cards:  TI
1221 with 2 slots (no fixup needed) and TI 1410 that needs it.


Yenta: CardBus bridge found at 0000:00:08.0 [133f:1233]
Yenta: Enabling burst memory read transactions
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: mfunc 0cc07d92, devctl 60
Yenta: ISA IRQ mask 0x0000, PCI irq 5
Socket status: 30000006
Yenta: CardBus bridge found at 0000:00:08.1 [133f:1233]
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: mfunc 0cc07d92, devctl 60
Yenta: ISA IRQ mask 0x0000, PCI irq 5
Socket status: 30000006
Yenta: CardBus bridge found at 0000:00:0a.0 [0000:0000]
Yenta: Enabling burst memory read transactions
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: mfunc 00000000, devctl 66
Yenta TI: changing mfunc to 00001000
Yenta TI: falling back to PCI interrupts
Yenta TI: changing mfunc to 00001002
Yenta: ISA IRQ mask 0x0000, PCI irq 12

$ cat /proc/interrupts
           CPU0
  0:     664717          XT-PIC  timer
  1:       1530          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  5:          3          XT-PIC  yenta, yenta, orinoco_cs
  7:          0          XT-PIC  acpi
  8:          4          XT-PIC  rtc
 10:       1502          XT-PIC  uhci_hcd, uhci_hcd
 11:         46          XT-PIC  eth0
 12:          3          XT-PIC  yenta, VIA686A, orinoco_cs
 14:      36354          XT-PIC  ide0
 15:         21          XT-PIC  ide1
NMI:          0
ERR:          0

-- 
Regards,
Pavel Roskin
