Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262485AbUC3EPi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 23:15:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262497AbUC3EPi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 23:15:38 -0500
Received: from fmr05.intel.com ([134.134.136.6]:26034 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S262485AbUC3EPe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 23:15:34 -0500
Subject: Re: 2.6.5-rc2-mm4 (and 3) IRQ problem
From: Len Brown <len.brown@intel.com>
To: Fabio Coatti <cova@ferrara.linux.it>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <200403300029.29809.cova@ferrara.linux.it>
References: <A6974D8E5F98D511BB910002A50A6647615F68B9@hdsmsx402.hd.intel.com>
	 <1080536373.16220.196.camel@dhcppc4>
	 <200403300029.29809.cova@ferrara.linux.it>
Content-Type: text/plain
Organization: 
Message-Id: <1080620118.989.80.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 29 Mar 2004 23:15:21 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fabio,
no ACPI badness jumps out at me.
libata, uhci_hcd, or eth0 is likely at fault -- I'm not
going to venture which -- remove what you can and
see what makes the problem go away.

cheers,
-Len

On Mon, 2004-03-29 at 17:29, Fabio Coatti wrote:

> irq 18: nobody cared!
> Call Trace:
>  [<c010882b>] __report_bad_irq+0x2a/0x8b
>  [<c0108937>] note_interrupt+0x91/0xaf
>  [<c0108c4a>] do_IRQ+0x151/0x19a
>  [<c034b4c8>] common_interrupt+0x18/0x20
>  [<c0104c2e>] default_idle+0x0/0x2c
>  [<c0104c57>] default_idle+0x29/0x2c
>  [<c0104cbb>] cpu_idle+0x2e/0x3c
>  [<c0430a02>] start_kernel+0x196/0x1c5
>  [<c0430436>] unknown_bootoption+0x0/0x126
> 
> handlers:
> [<c02a7b0b>] (ata_interrupt+0x0/0x173)
> [<c02d2f9c>] (usb_hcd_irq+0x0/0x67)
> Disabling IRQ #18

> > > [root@kefk root]# cat /proc/interrupts
> > >            CPU0       CPU1
> > >   0:    1002506          0    IO-APIC-edge  timer
> > >   1:       4722          0    IO-APIC-edge  i8042
> > >   2:          0          0          XT-PIC  cascade
> > >   9:          0          0   IO-APIC-level  acpi
> > >  12:       8826          0    IO-APIC-edge  i8042
> > >  14:      11920          0    IO-APIC-edge  ide0
> > >  15:         23          0    IO-APIC-edge  ide1
> > >  16:     278123          0   IO-APIC-level  uhci_hcd, uhci_hcd, nvidia
> > >  17:       2337          0   IO-APIC-level  Intel ICH5
> > >  18:      56240          0   IO-APIC-level  libata, uhci_hcd, eth0
> > >  19:         55          0   IO-APIC-level  uhci_hcd
> > >  22:        279          0   IO-APIC-level  aic7xxx
> > >  23:          0          0   IO-APIC-level  ehci_hcd
> > > NMI:          0          0
> > > LOC:    1002427    1002439
> > > ERR:          0
> > > MIS:          0


