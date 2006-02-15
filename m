Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030529AbWBOCRa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030529AbWBOCRa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 21:17:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030592AbWBOCRa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 21:17:30 -0500
Received: from nproxy.gmail.com ([64.233.182.205]:56879 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030529AbWBOCRa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 21:17:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lQ63v0KwKPzYHZFqVYN4ic/qEhEm17CJc10ORUF6i6mJBjWfn3W9x50RYF+ylbBg85gwVhp/9cKFW/RI7/1YsKN578t1vSXr5NCXHaJZt8fME0QigUkX/SK1s+k/9HSwQicx1XQ6OkRzlN0HiN+GRbfe1yxIbh/8CpOzITOiIsk=
Message-ID: <9871ee5f0602141817p12617034o7f118710775cc73c@mail.gmail.com>
Date: Tue, 14 Feb 2006 21:17:28 -0500
From: Timothy Miller <theosib@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: HELP: Problem with radeonfb setting wrong resolution
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1139955612.7903.46.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9871ee5f0602141233t3cf11775lcb6351f31d4f377e@mail.gmail.com>
	 <1139955612.7903.46.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/06, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> On Tue, 2006-02-14 at 15:33 -0500, Timothy Miller wrote:
> > I humbly apologize if it is inappropriate for me to post this question
> > here.  I'm not subscribed, and I haven't been in a while.  I've
> > googled around for answers to this, but I don't find anything that
> > directly addresses the issue I'm seeing.  Please cc me.
> >
> > I'm installing a new Gentoo box, and I have configured the
> > 2.6.12-gentoo-r6 kernel.
> >
> > Here's what I have enabled:
> >
> > + Support for framebuffer devices
> > + ATI Radeon display support
> > + DDC/I2C for ATI Radeon support
> > + Lots of debug output from Radeon drive
> > + VGA text console
> > + Framebuffer Console support
> >
> > In the grub.conf file, I have this at the end of the kernel line:
> >
> > video=radeonfb:1024x768
> >
> > When booting up, radeonfb finds the device (A Radeon 7000 PCI card),
> > the monitor flickers for a second, and then what I get is a 640x480
> > screen, but the kernel seems to think it's 1024x768, because text goes
> > off the screen.
> >
> > I've googled for this, but what I find is old stuff where people are
> > complaining about seeing a higher resolution than the one they asked
> > for.  I'm getting a LOWER resolution.
> >
> > I can't figure out what I'm doing wrong, but there are no kernel error
> > messages that tell me anything has gone wrong.
> >
> > Can anyone help me figure out what I'm doing wrong here?  BTW, the
> > monitor is a 19" NEC.  No chance that the monitor reports via DDC that
> > it can't do 1024x768.
>
> Can you send me the debug output ? (dmesg)
>

I just installed 2.6.15-gentoo-5, so I have a much more recent kernel.
 This strange behavior still happens.  I forgot to mention that I'm
using this on an P4, and the kernel is compiled 64-bit.

I sent Ben a copy of the whole dmesg output.  Here's the portion that
everyone else might be interested in:

radeonfb_pci_register BEGIN
ACPI: PCI Interrupt 0000:02:05.0[A] -> GSI 21 (level, low) -> IRQ 193
radeonfb (0000:02:05.0): Found 65536k of DDR 64 bits wide videoram
radeonfb (0000:02:05.0): mapped 16384k videoram
radeonfb: Found Intel x86 BIOS ROM Image
radeonfb: Retreived PLL infos from BIOS
radeonfb: Reference=27.00 MHz (RefDiv=60) Memory=150.00 Mhz, System=150.00 MHz
radeonfb: PLL min 12000 max 35000
1 chips in connector info
 - chip 1 has 2 connectors
  * connector 0 of type 2 (CRT) : 2300
  * connector 1 of type 3 (DVI-I) : 3201
Starting monitor auto detection...
radeonfb: I2C (port 1) ... not found
radeonfb: I2C (port 2) ... not found
radeonfb: I2C (port 3) ... found TMDS panel
radeonfb: I2C (port 4) ... not found
radeonfb: I2C (port 2) ... not found
radeonfb: I2C (port 4) ... not found
radeonfb: I2C (port 3) ... found TMDS panel
radeonfb: Monitor 1 type DFP found
radeonfb: EDID probed
radeonfb: Monitor 2 type no found
Parsing EDID data for panel info
Guessing panel info...
radeonfb: Assuming panel size 8x1
hStart = 664, hEnd = 760, hTotal = 800
vStart = 409, vEnd = 411, vTotal = 450
h_total_disp = 0x4f0063	   hsync_strt_wid = 0x8c0292
v_total_disp = 0x18f01c1	   vsync_strt_wid = 0x820198
pixclock = 39729
freq = 2517
freq = 2517, PLL min = 12000, PLL max = 35000
ref_div = 60, ref_clk = 2700, output_freq = 20136
ref_div = 60, ref_clk = 2700, output_freq = 20136
post div = 0x3
fb_div = 0x1bf
ppll_div_3 = 0x301bf
hStart = 664, hEnd = 760, hTotal = 800
vStart = 409, vEnd = 411, vTotal = 450
h_total_disp = 0x4f0063	   hsync_strt_wid = 0x8c0292
v_total_disp = 0x18f01c1	   vsync_strt_wid = 0x820198
pixclock = 39729
freq = 2517
freq = 2517, PLL min = 12000, PLL max = 35000
ref_div = 60, ref_clk = 2700, output_freq = 20136
ref_div = 60, ref_clk = 2700, output_freq = 20136
post div = 0x3
fb_div = 0x1bf
ppll_div_3 = 0x301bf
hStart = 664, hEnd = 760, hTotal = 800
vStart = 409, vEnd = 411, vTotal = 450
h_total_disp = 0x4f0063	   hsync_strt_wid = 0x8c0292
v_total_disp = 0x18f01c1	   vsync_strt_wid = 0x820198
pixclock = 39729
freq = 2517
freq = 2517, PLL min = 12000, PLL max = 35000
ref_div = 60, ref_clk = 2700, output_freq = 20136
ref_div = 60, ref_clk = 2700, output_freq = 20136
post div = 0x3
fb_div = 0x1bf
ppll_div_3 = 0x301bf
Console: switching to colour frame buffer device 128x48
radeonfb (0000:02:05.0): ATI Radeon QY
radeonfb_pci_register END
