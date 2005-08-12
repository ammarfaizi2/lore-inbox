Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750738AbVHLRYa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750738AbVHLRYa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 13:24:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750742AbVHLRY3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 13:24:29 -0400
Received: from deadlock.et.tudelft.nl ([130.161.36.93]:9175 "EHLO
	deadlock.et.tudelft.nl") by vger.kernel.org with ESMTP
	id S1750738AbVHLRY3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 13:24:29 -0400
Date: Fri, 12 Aug 2005 19:24:15 +0200 (CEST)
From: =?ISO-8859-1?Q?Dani=EBl_Mantione?= <daniel@deadlock.et.tudelft.nl>
To: Jim Ramsay <jim.ramsay@gmail.com>
cc: alex.kern@gmx.de, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Atyfb questions and issues
In-Reply-To: <4789af9e050812101110d3642d@mail.gmail.com>
Message-ID: <Pine.LNX.4.44.0508121918200.10526-100000@deadlock.et.tudelft.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Op Fri, 12 Aug 2005, schreef Jim Ramsay:

> I have the following issue.  I am trying to get an ATI Rage XL chip
> working on a MIPS-based processor, with a 2.6.11-based kernel from
> linux-mips.org.  Now, I know that this was working with a 2.4.25-based
> kernel previously.

Okay, the 2.4 driver is more intrusive, it programs the chip from start as
much as possible, while the 2.6 driver tries to depend on Bios settings. I
haven't checked out the 2.6 driver enough to see if it is still possible
to program from scratch.

> I seem to get intermittent strange issues, such as the machine
> freezing from time to time, but in general I get the following in my
> dmesg when I load the atyfb module:
>
> atyfb: using auxiliary register aperture
> atyfb: 3D RAGE XL (Mach64 GR, PCI-33MHz) [0x4752 rev 0x27]
> atyfb(aty_valid_pll_ct): pllvclk=50 MHz, vclk=25 MHz
> atyfb(aty_dsp_gt): dsp_config 0x307c0001, dsp_on_off 0x14fffff0
> < Sometimes it will hang here >
> atyfb: 512K RESV, 29.498928 MHz XTAL, 230 MHz PLL, 83 Mhz MCLK, 63 MHz XCLK
> atyfb: Unsupported xclk source:  7.

> I'm assuming that most of my issues are due to the "Unsupported xclk
> source" message.  Any ideas what I can do about this, or where I can
> go to learn more about how to make this thing work?

Yes, according to my register data sheet a 7 means the memory clock
frequency is derived from DLLCLK. Unfortunately I don't know what this
DLLCLK is. I think it means the chip isn't properly initialized yet and it
clocks the memory from a safe clock source to allow the computer to start.

However, we most likely have no way to find out the speed of this DLLCLK.

The memory clock frequency is important for the driver to be able to set a
display mode; it needs to program a memory reload frequency into the chip
which depends on the memory frequency.

Daniël

