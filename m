Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261170AbVBZAze@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261170AbVBZAze (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 19:55:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262145AbVBZAze
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 19:55:34 -0500
Received: from gate.crashing.org ([63.228.1.57]:27289 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261170AbVBZAzR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 19:55:17 -0500
Subject: Re: 2.6.11-rc5
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olaf Hering <olh@suse.de>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
In-Reply-To: <20050225172945.GA31211@suse.de>
References: <Pine.LNX.4.58.0502232014190.18997@ppc970.osdl.org>
	 <20050224145049.GA21313@suse.de> <1109287708.15026.25.camel@gaston>
	 <20050225070813.GA13735@suse.de> <1109316551.14993.63.camel@gaston>
	 <20050225172945.GA31211@suse.de>
Content-Type: text/plain
Date: Sat, 26 Feb 2005 11:54:13 +1100
Message-Id: <1109379254.14992.96.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > It seem to detect the flat panel incorrectly, or the EDID data is bogus,
> > maybe that's wrecking something in the new modelist management in
> > fbdev ? It might be causing us to use a bogus mode that itself casues
> > atyfb to crash. Tried forcing a mode ?
> 
> cfb_imageblit(320) dst1 fa51a800 base e0b80000 bitstart 1999a800
> fast_imageblit(237) s daea4000 dst1 fa51a800
> fast_imageblit(269) j 1 fa51a800 0
> Unable to handle kernel paging request at virtual address fa51a800
> 
> is bitstart incorrect or is the thing just not (yet) mapped?

It should be all mapped, i suspect the mode set is totally bogus. To
check it, can you enable radeonfb verbose debug ?


> radeonfb: Found Intel x86 BIOS ROM Image
> radeonfb: Retreived PLL infos from BIOS
> radeonfb: Reference=27.00 MHz (RefDiv=60) Memory=133.00 Mhz, System=133.00 MHz
> radeonfb: PLL min 12000 max 35000
> radeonfb: Monitor 1 type DFP found
> radeonfb: EDID probed
> radeonfb: Monitor 2 type no found
> radeonfb: Assuming panel size 8x1
> radeonfb: Can't find mode for panel size, going back to CRT
> cfb_imageblit(320) dst1 fa51a800 base e0b80000 bitstart 1999a800
> fast_imageblit(237) s daea4000 dst1 fa51a800
> fast_imageblit(269) j 1 fa51a800 0
> Unable to handle kernel paging request at virtual address fa51a800
>  printing eip:
> c020f17e
> *pde = 00000000
> Oops: 0002 [#1]
> Modules linked in: ohci1394 ieee1394 radeonfb i2c_algo_bit i2c_core ehci_hcd uhci_hcd capability usbcore
> CPU:    0
> EIP:    0060:[<c020f17e>]    Tainted: G     U VLI
> EFLAGS: 00010282   (2.6.11-rc5-20050225-default)
> EIP is at cfb_imageblit+0x57e/0x67c
> eax: 00000000   ebx: 00000001   ecx: 00000000   edx: fa51a800
> esi: fa51a804   edi: daea4000   ebp: 00000004   esp: dcae9c14
> ds: 007b   es: 007b   ss: 0068
> Process modprobe (pid: 2080, threadinfo=dcae8000 task=dc4a7550)
> Stack: c01110ac 00000001 c0321d60 dcae9c20 dcae9c20 c01303a2 00000001 c03c87a8
>        0000000a dae23ca8 c011c783 00000046 00000000 dc202000 00000046 dcae9c64
>        c010513d 0000384d dc202290 00000007 c032db20 daea4000 00000000 0000000f
> Call Trace:
>  [<c01110ac>] smp_local_timer_interrupt+0xc/0x50
>  [<c01303a2>] handle_IRQ_event+0x32/0x70
>  [<c011c783>] __do_softirq+0x43/0xa0
>  [<c010513d>] do_IRQ+0x3d/0x60
>  [<c020d790>] soft_cursor+0x190/0x200
>  [<c02043cc>] bit_cursor+0x48c/0x4f0
>  [<e0b26c01>] radeonfb_prim_fillrect+0xf1/0x120 [radeonfb]
>  [<c012043f>] msleep+0x2f/0x40
>  [<c01fff28>] fbcon_cursor+0x1a8/0x280
>  [<c023ad08>] hide_cursor+0x18/0x30
>  [<c023b014>] redraw_screen+0x174/0x200
>  [<c01fed4a>] fbcon_prepare_logo+0x39a/0x3a0
>  [<c01ff8a0>] fbcon_init+0x2b0/0x370
>  [<c023b1a9>] visual_init+0xe9/0x170
> 
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>

