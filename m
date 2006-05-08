Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932367AbWEHQfB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932367AbWEHQfB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 12:35:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932409AbWEHQfB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 12:35:01 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:42767 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932367AbWEHQfA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 12:35:00 -0400
Date: Mon, 8 May 2006 17:34:53 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Andreas Mohr <andi@rhlx01.fht-esslingen.de>, florin@iucha.net,
       linux-kernel@vger.kernel.org, torvalds@osdl.org,
       linux@dominikbrodowski.net
Subject: Re: pcmcia oops on 2.6.17-rc[12]
Message-ID: <20060508163453.GB19040@flint.arm.linux.org.uk>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Andreas Mohr <andi@rhlx01.fht-esslingen.de>, florin@iucha.net,
	linux-kernel@vger.kernel.org, torvalds@osdl.org,
	linux@dominikbrodowski.net
References: <20060423192251.GD8896@iucha.net> <20060423150206.546b7483.akpm@osdl.org> <20060508145609.GA3983@rhlx01.fht-esslingen.de> <20060508084301.5025b25d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060508084301.5025b25d.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 08, 2006 at 08:43:01AM -0700, Andrew Morton wrote:
> Andreas Mohr <andi@rhlx01.fht-esslingen.de> wrote:
> >
> > Hi,
> > 
> > On Sun, Apr 23, 2006 at 03:02:06PM -0700, Andrew Morton wrote:
> > > It's actually not an oops - it's a warning, telling us that i82365 is
> > > requesting an IRQ in non-sharing mode, but there's already a handler
> > > registered for that IRQ (which might or might not be shareable).
> > 
> > And the same thing on a Toshiba Satellite 4280, P3/450, 2.6.17-rc3-ck2:
> > 
> > setup_irq: irq handler mismatch
> >  <c0103248> show_trace+0xd/0xf   <c010325f> dump_stack+0x15/0x17
> >  <c012aeca> setup_irq+0xd9/0xe8   <c012b002> request_irq+0x6e/0x8c
> >  <c020cdfd> serial8250_startup+0x263/0x394   <c020a1aa> uart_startup+0x68/0xf1
> >  <c020adba> uart_ioctl+0x554/0x847   <c01f31ed> tty_ioctl+0xbae/0xc36
> >  <c0151eec> do_ioctl+0x3c/0x4f   <c01520ed> vfs_ioctl+0x1ee/0x205
> >  <c015212e> sys_ioctl+0x2a/0x44   <c01029bb> sysenter_past_esp+0x54/0x75

Hmm, someone's fiddling with setserial here...

> > # cat /proc/interrupts
> >            CPU0
> >   0:   31607214          XT-PIC  timer
> >   1:      11092          XT-PIC  i8042
> >   2:          0          XT-PIC  cascade
> >   3:      36368          XT-PIC  pcnet_cs
> >   8:          3          XT-PIC  rtc
> >   9:         84          XT-PIC  acpi
> >  11:      73639          XT-PIC  yenta, yenta, uhci_hcd:usb1, YMFPCI, irda0
> >  12:       9996          XT-PIC  i8042
> >  14:      63830          XT-PIC  ide0
> >  15:     536942          XT-PIC  ide1
> > NMI:          0
> > LOC:          0
> > ERR:          0
> 
> So 8250 is requesting an IRQ for non-sharing mode and it's actually
> failing, because something else is already using that IRQ.  The difference
> is that the kernel now generates a warning when this happens.

Maybe someone is clearing the UPF_SHARE_IRQ flag?  Which port is this?

> Russell, any opinions?

I'd like to get a better idea what's going on here.  Is this a port on a
PCMCIA card?  Is it a motherboard serial port?  Which IRQ is it trying
to use?  How was it setup?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
