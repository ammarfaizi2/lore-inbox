Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964867AbWDMKP1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964867AbWDMKP1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 06:15:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964869AbWDMKP1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 06:15:27 -0400
Received: from tim.rpsys.net ([194.106.48.114]:17638 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S964867AbWDMKP0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 06:15:26 -0400
Subject: Re: 2.6.17-rc1: collie -- oopsen in pccardd?
From: Richard Purdie <rpurdie@rpsys.net>
To: Pavel Machek <pavel@ucw.cz>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       linux-pcmcia@lists.infradead.org
Cc: lenz@cs.wisc.edu, kernel list <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>
In-Reply-To: <20060404000129.GA2590@ucw.cz>
References: <20060404122212.GG19139@elf.ucw.cz>
	 <20060404124350.GA16857@flint.arm.linux.org.uk>
	 <20060404000129.GA2590@ucw.cz>
Content-Type: text/plain
Date: Thu, 13 Apr 2006 11:11:45 +0100
Message-Id: <1144923105.7236.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-04-04 at 00:01 +0000, Pavel Machek wrote:
> Hi!
> 
> On Tue 04-04-06 13:43:50, Russell King wrote:
> > On Tue, Apr 04, 2006 at 02:22:12PM +0200, Pavel Machek wrote:
> > > I'm getting some oopses when inserting/removing pccard (on collie,
> > > oopses in pccardd). It does not break boot, so it is not immediate
> > > problem, but I wonder if it also happens on non-collie machines?
> > 
> > No idea what so ever.  Not even any clues as to what might be going wrong
> > due to the lack of oops dump.  (Not that I even look after PCMCIA anymore.)
> 
> Sorry for lack of oops. I was not expecting you to debug it, I
> expected some voices telling me it is broken for them, too :-).

With a recent git kernel (907d91d708d9999bec0185d630062576ac4181a7) I
see the oops below when booting spitz (SL-C3000 - ARM pxa270 based). Was
this the same oops you saw Pavel?

Spitz boots off a CompactFlash microdrive so this is somewhat fatal for
the device. 2.6.16 is the last kernel version I tested and that works.

Unable to handle kernel NULL pointer dereference at virtual address 0000000c
pgd = c0004000
[0000000c] *pgd=00000000
Internal error: Oops: f5 [#1]
Modules linked in:
CPU: 0
PC is at alloc_io_space+0x188/0x294
LR is at pcmcia_request_io+0x90/0x124
pc : [<c0161ea8>]    lr : [<c0162044>]    Not tainted
sp : c032bdd0  ip : 00000000  fp : c032be04
r10: 00000000  r9 : c3cec220  r8 : 00000010
r7 : c037e6e0  r6 : c032e2f8  r5 : 00000010  r4 : c3cec220
r3 : c4820000  r2 : 00000000  r1 : 00000010  r0 : 00000000
Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  Segment kernel
Control: 397F  Table: A0004000  DAC: 00000017
Process swapper (pid: 1, stack limit = 0xc032a1a8)
Stack: (0xc032bdd0 to 0xc032c000)
bdc0:                                     c015d1dc 00000010 0000004b c3cec220
bde0: c3cec200 c032e2f8 c037e6e0 c035de60 d1b71759 00000000 c032be2c c032be08
be00: c0162044 c0161d2c 00000004 c3cec200 c3caa900 c032be38 c3cec200 c3caa800
be20: c032be84 c032be30 c0150974 c0161fc0 c032be50 00000000 00000000 0000001b
be40: 00000110 00000000 0000004b ff00061b c032be06 c3caa800 c0106294 c022c820
be60: c3cec200 c3cec290 c022c838 00000000 c032bfa0 c0019f58 c032bea4 c032be88
be80: c0161354 c015068c c3cec354 c3cec290 c0161298 c022c838 c032bec4 c032bea8
bea0: c013c048 c01612a4 c3cec354 c3cec290 c022c838 c013c164 c032bedc c032bec8
bec0: c013c248 c013c000 00000000 c032bee4 c032bf0c c032bee0 c013ba0c c013c170
bee0: 00000000 c022e290 c022e290 c3cec2d8 c022c84c c022c838 c022e1a8 c022d07c
bf00: c032bf1c c032bf10 c013bf80 c013b9c4 c032bf44 c032bf20 c013b618 c013bf6c
bf20: c022c838 c022d058 00000004 c022d07c c022c820 c0019f58 c032bf5c c032bf48
bf40: c013c4e4 c013b5b4 c01ff480 00000000 c032bf8c c032bf60 c0161100 c013c488
bf60: c032bf8c c032bf70 c011f960 c0019f4c 00000000 c032a000 00000001 c001a404
bf80: c032bf9c c032bf90 c00166e8 c0161038 c032bff4 c032bfa0 c001c130 c00166e0
bfa0: 00000000 c032bfb0 c001cea4 c0036a9c 00000000 00000000 c001c02c c003db78
bfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
bfe0: 00000000 00000000 00000000 c032bff8 c003db78 c001c038 f818f800 18181818
Backtrace:
[<c0161d20>] (alloc_io_space+0x0/0x294) from [<c0162044>] (pcmcia_request_io+0x90/0x124)
[<c0161fb4>] (pcmcia_request_io+0x0/0x124) from [<c0150974>] (ide_probe+0x2f4/0x570)
 r7 = C3CAA800  r6 = C3CEC200  r5 = C032BE38  r4 = C3CAA900
[<c0150680>] (ide_probe+0x0/0x570) from [<c0161354>] (pcmcia_device_probe+0xbc/0x1b0)
[<c0161298>] (pcmcia_device_probe+0x0/0x1b0) from [<c013c048>] (driver_probe_device+0x54/0xd0)
 r7 = C022C838  r6 = C0161298  r5 = C3CEC290  r4 = C3CEC354
[<c013bff4>] (driver_probe_device+0x0/0xd0) from [<c013c248>] (__driver_attach+0xe4/0xe8)
 r7 = C013C164  r6 = C022C838  r5 = C3CEC290  r4 = C3CEC354
[<c013c164>] (__driver_attach+0x0/0xe8) from [<c013ba0c>] (bus_for_each_dev+0x54/0x80)
 r5 = C032BEE4  r4 = 00000000
[<c013b9b8>] (bus_for_each_dev+0x0/0x80) from [<c013bf80>] (driver_attach+0x20/0x28)
 r7 = C022D07C  r6 = C022E1A8  r5 = C022C838  r4 = C022C84C
[<c013bf60>] (driver_attach+0x0/0x28) from [<c013b618>] (bus_add_driver+0x70/0x140)
[<c013b5a8>] (bus_add_driver+0x0/0x140) from [<c013c4e4>] (driver_register+0x68/0xac)
[<c013c47c>] (driver_register+0x0/0xac) from [<c0161100>] (pcmcia_register_driver+0xd4/0xfc)
 r4 = 00000000
[<c016102c>] (pcmcia_register_driver+0x0/0xfc) from [<c00166e8>] (init_ide_cs+0x14/0x1c)
 r8 = C001A404  r7 = 00000001  r6 = C032A000  r5 = 00000000
 r4 = C0019F4C
[<c00166d4>] (init_ide_cs+0x0/0x1c) from [<c001c130>] (init+0x104/0x2ac)
[<c001c02c>] (init+0x0/0x2ac) from [<c003db78>] (do_exit+0x0/0xa78)
Code: e5893000 e596203c e20010ff e3a00000 (e592300c)
 <0>Kernel panic - not syncing: Attempted to kill init!


