Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262118AbVBZAvw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262118AbVBZAvw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 19:51:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262132AbVBZAvw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 19:51:52 -0500
Received: from gate.crashing.org ([63.228.1.57]:23705 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262118AbVBZAvi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 19:51:38 -0500
Subject: Re: 2.6.11-rc5
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mws <mws@twisted-brains.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200502251430.16860.mws@twisted-brains.org>
References: <Pine.LNX.4.58.0502232014190.18997@ppc970.osdl.org>
	 <20050225070813.GA13735@suse.de> <1109316551.14993.63.camel@gaston>
	 <200502251430.16860.mws@twisted-brains.org>
Content-Type: text/plain
Date: Sat, 26 Feb 2005 11:50:43 +1100
Message-Id: <1109379043.14993.93.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-02-25 at 14:30 +0100, Mws wrote:
> hi,
> 
> i also have problems with 2.6.11-rc5 and radeon:
> 
> i am using a ATI Radeon X600 PciExpress.
> 
> a) now the console framebuffer seems to bee working, thx benjamin :)
> b) when bootup seq ist completed and i want to start X (xorg-x11) with ati-drivers
>     x is freezing - not your problem, but the console is not correctly restored :/ the only way
>     out is to reset the machine :/
>     2.6.11-rc3 was running fine in this case

Hrm, the binary drivers ? oh well... some users had them freezing vs.
radeonfb before and not now. I don't know what they do and don't have
access to a machine with them (there are no ppc versions) so it will be
difficult to track. I suspect they completely reconfigure the chip and
don't restore it properly tho.

What exactly is happening. Does X launches at all ? When does it
freeze ? On X launch or when exiting it ? Have you tried disabling
dynamic clock tweaking ? (radeonfb.default_dynclk=-1 or 0 on the
cmdline, first one means "don't touch the registers", secoond one means
"disable dynamic clocks").

> i have attached my lspci -vv & lspci -tv output and following a small seq of the dmesg output
> when initializing the radeon fb.
> 
> if i can provide/assit  you with testing, i am available to do so, also if you need more information
> on my system.
> 
> i am subscribed to lkml, but i would like to be included into cc seprately, thx.
> 
> 
>  radeonfb_pci_register BEGIN
> ACPI: PCI interrupt 0000:05:00.0[A] -> GSI 16 (level, low) -> IRQ 16
> radeonfb (0000:05:00.0): Found 131072k of DDR 128 bits wide videoram
> radeonfb (0000:05:00.0): mapped 16384k videoram
> radeonfb: Found Intel x86 BIOS ROM Image
> radeonfb: Retreived PLL infos from BIOS
> radeonfb: Reference=27.00 MHz (RefDiv=12) Memory=400.00 Mhz, System=300.00 MHz
> radeonfb: PLL min 20000 max 40000
> 1 chips in connector info
>  - chip 1 has 2 connectors
>   * connector 0 of type 2 (CRT) : 2300
>   * connector 1 of type 3 (DVI-I) : 3221
> Starting monitor auto detection...
> radeonfb: I2C (port 1) ... not found
> radeonfb: I2C (port 2) ... not found
> radeonfb: I2C (port 3) ... found CRT display
> radeonfb: I2C (port 4) ... not found
> radeonfb: I2C (port 2) ... not found
> radeonfb: I2C (port 4) ... not found
> radeonfb: I2C (port 3) ... found CRT display
> radeonfb: Monitor 1 type CRT found
> radeonfb: EDID probed
> radeonfb: Monitor 2 type no found
>       Display is GTF capable
> hStart = 1344, hEnd = 1504, hTotal = 1728
> vStart = 1025, vEnd = 1028, vTotal = 1072
> h_total_disp = 0x9f00d7	   hsync_strt_wid = 0x14054a
> v_total_disp = 0x3ff042f	   vsync_strt_wid = 0x30400
> pixclock = 6349
> freq = 15750
> freq = 15750, PLL min = 20000, PLL max = 40000
> ref_div = 12, ref_clk = 2700, output_freq = 31500
> ref_div = 12, ref_clk = 2700, output_freq = 31500
> post div = 0x1
> fb_div = 0x8c
> ppll_div_3 = 0x1008c
> Console: switching to colour frame buffer device 160x64
> radeonfb (0000:05:00.0): ATI Radeon [b 
> radeonfb_pci_register END
> 
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>

