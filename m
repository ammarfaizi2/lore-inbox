Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262759AbVBYR36@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262759AbVBYR36 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 12:29:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262760AbVBYR36
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 12:29:58 -0500
Received: from cantor.suse.de ([195.135.220.2]:46257 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262759AbVBYR3q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 12:29:46 -0500
Date: Fri, 25 Feb 2005 18:29:45 +0100
From: Olaf Hering <olh@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-fbdev-devel@lists.sourceforge.net
Subject: Re: 2.6.11-rc5
Message-ID: <20050225172945.GA31211@suse.de>
References: <Pine.LNX.4.58.0502232014190.18997@ppc970.osdl.org> <20050224145049.GA21313@suse.de> <1109287708.15026.25.camel@gaston> <20050225070813.GA13735@suse.de> <1109316551.14993.63.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1109316551.14993.63.camel@gaston>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Fri, Feb 25, Benjamin Herrenschmidt wrote:

> On Fri, 2005-02-25 at 08:08 +0100, Olaf Hering wrote:
> >  On Fri, Feb 25, Benjamin Herrenschmidt wrote:
> > 
> > > On Thu, 2005-02-24 at 15:50 +0100, Olaf Hering wrote:
> > > >  On Wed, Feb 23, Linus Torvalds wrote:
> > > > 
> > > > > This time it's really supposed to be a quickie, so people who can, please 
> > > > > check it out, and we'll make the real 2.6.11 asap.
> > > > 
> > > > radeonfb oopses on intel.
> > > > Havent checked yet when it started with it.
> > > > 
> > > > ACPI: PCI interrupt 0000:00:12.0[A] -> GSI 11 (level, low) -> IRQ 11
> > > > eth0: VIA Rhine II at 0x1c400, 00:11:5b:83:1e:76, IRQ 11.
> > > > eth0: MII PHY found at address 1, status 0x7869 advertising 05e1 Link 45e1.
> > > > usb 5-1: new low speed USB device using uhci_hcd and address 2
> > > > ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 11 (level, low) -> IRQ 11
> > > > radeonfb: Found Intel x86 BIOS ROM Image
> > > > radeonfb: Retreived PLL infos from BIOS
> > > > radeonfb: Reference=27.00 MHz (RefDiv=60) Memory=133.00 Mhz, System=133.00 MHz
> > > > radeonfb: PLL min 12000 max 35000
> > > > NET: Registered protocol family 23
> > > > radeonfb: Monitor 1 type DFP found
> > > > radeonfb: EDID probed
> > > > radeonfb: Monitor 2 type no found
> > > > radeonfb: Assuming panel size 8x1
> > > 
> > > Hrm... that's totally bogus. What machine is this ?
> > 
> > Some i386 box with radeon 7000.
> 
> It seem to detect the flat panel incorrectly, or the EDID data is bogus,
> maybe that's wrecking something in the new modelist management in
> fbdev ? It might be causing us to use a bogus mode that itself casues
> atyfb to crash. Tried forcing a mode ?

cfb_imageblit(320) dst1 fa51a800 base e0b80000 bitstart 1999a800
fast_imageblit(237) s daea4000 dst1 fa51a800
fast_imageblit(269) j 1 fa51a800 0
Unable to handle kernel paging request at virtual address fa51a800

is bitstart incorrect or is the thing just not (yet) mapped?

radeonfb: Found Intel x86 BIOS ROM Image
radeonfb: Retreived PLL infos from BIOS
radeonfb: Reference=27.00 MHz (RefDiv=60) Memory=133.00 Mhz, System=133.00 MHz
radeonfb: PLL min 12000 max 35000
radeonfb: Monitor 1 type DFP found
radeonfb: EDID probed
radeonfb: Monitor 2 type no found
radeonfb: Assuming panel size 8x1
radeonfb: Can't find mode for panel size, going back to CRT
cfb_imageblit(320) dst1 fa51a800 base e0b80000 bitstart 1999a800
fast_imageblit(237) s daea4000 dst1 fa51a800
fast_imageblit(269) j 1 fa51a800 0
Unable to handle kernel paging request at virtual address fa51a800
 printing eip:
c020f17e
*pde = 00000000
Oops: 0002 [#1]
Modules linked in: ohci1394 ieee1394 radeonfb i2c_algo_bit i2c_core ehci_hcd uhci_hcd capability usbcore
CPU:    0
EIP:    0060:[<c020f17e>]    Tainted: G     U VLI
EFLAGS: 00010282   (2.6.11-rc5-20050225-default)
EIP is at cfb_imageblit+0x57e/0x67c
eax: 00000000   ebx: 00000001   ecx: 00000000   edx: fa51a800
esi: fa51a804   edi: daea4000   ebp: 00000004   esp: dcae9c14
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 2080, threadinfo=dcae8000 task=dc4a7550)
Stack: c01110ac 00000001 c0321d60 dcae9c20 dcae9c20 c01303a2 00000001 c03c87a8
       0000000a dae23ca8 c011c783 00000046 00000000 dc202000 00000046 dcae9c64
       c010513d 0000384d dc202290 00000007 c032db20 daea4000 00000000 0000000f
Call Trace:
 [<c01110ac>] smp_local_timer_interrupt+0xc/0x50
 [<c01303a2>] handle_IRQ_event+0x32/0x70
 [<c011c783>] __do_softirq+0x43/0xa0
 [<c010513d>] do_IRQ+0x3d/0x60
 [<c020d790>] soft_cursor+0x190/0x200
 [<c02043cc>] bit_cursor+0x48c/0x4f0
 [<e0b26c01>] radeonfb_prim_fillrect+0xf1/0x120 [radeonfb]
 [<c012043f>] msleep+0x2f/0x40
 [<c01fff28>] fbcon_cursor+0x1a8/0x280
 [<c023ad08>] hide_cursor+0x18/0x30
 [<c023b014>] redraw_screen+0x174/0x200
 [<c01fed4a>] fbcon_prepare_logo+0x39a/0x3a0
 [<c01ff8a0>] fbcon_init+0x2b0/0x370
 [<c023b1a9>] visual_init+0xe9/0x170


