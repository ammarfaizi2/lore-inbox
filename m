Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265181AbUBOTxM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 14:53:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265178AbUBOTxM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 14:53:12 -0500
Received: from [217.7.64.198] ([217.7.64.198]:39302 "EHLO mx1.net4u.de")
	by vger.kernel.org with ESMTP id S265188AbUBOTwx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 14:52:53 -0500
From: Ernst Herzberg <earny@net4u.de>
Reply-To: earny@net4u.de
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.3-rc3
Date: Sun, 15 Feb 2004 20:52:50 +0100
User-Agent: KMail/1.6
Cc: Peter Osterlund <petero2@telia.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <Pine.LNX.4.58.0402141931050.14025@home.osdl.org> <m2znbk4s8j.fsf@p4.localdomain>
In-Reply-To: <m2znbk4s8j.fsf@p4.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200402152052.50596.earny@net4u.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sonntag, 15. Februar 2004 10:17, Peter Osterlund wrote:
> Linus Torvalds <torvalds@osdl.org> writes:
> > Benjamin Herrenschmidt:
> >   o New radeonfb
> >   o Fix a link conflict between radeonfb and the radeon DRI
> >   o Fix incorrect kfree in radeonfb
>
> It doesn't seem to work on my x86 laptop. The screen goes black when
> the framebuffer is enabled early in the boot sequence. The machine
> boots normally anyway and I can log in from the network or log in
> blindly at the console. I can then start the X server which appears to
> work correctly, but switching back to a console still gives me a black
> screen. Running "setfont" doesn't fix it. Here is what dmesg reports
> when running 2.6.3-rc3:

Looks like the same problem on a desktop:

Mobo Asus A7V8X-X:
earny:~ # lspci
00:00.0 Host bridge: VIA Technologies, Inc. VT8377 [KT400 AGP] Host Bridge (rev 80)
00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI Bridge
00:10.0 USB Controller: VIA Technologies, Inc. USB (rev 80)
00:10.1 USB Controller: VIA Technologies, Inc. USB (rev 80)
00:10.2 USB Controller: VIA Technologies, Inc. USB (rev 80)
00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82)
00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
00:11.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE (rev 06)
00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233/A/8235 AC97 Audio Controller (rev 50)
00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev 74)
01:00.0 VGA compatible controller: ATI Technologies Inc RV350 AQ [Radeon 9600]
01:00.1 Display controller: ATI Technologies Inc RV350 AQ [Radeon 9600] (Secondary)

Never tried this machine with kernel older than 2.6.2. 
FB VESA works fine. If i use ATI Radeon (does'n matter old or new) the screen 
goes dark until i start X. With the new driver i found in dmesg:

[...]
Kernel command line: root=/dev/hda1 vga=0x31a
[...]
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
radeonfb: cannot map FB
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x1
[....]


Compile warnings with new driver:

[...]
drivers/video/aty/radeon_base.c: In function `radeon_probe_pll_params':
drivers/video/aty/radeon_base.c:474: warning: `xtal' might be used uninitialized in this function
drivers/video/aty/radeon_base.c: In function `radeon_screen_blank':
drivers/video/aty/radeon_base.c:944: warning: `val2' might be used uninitialized in this function
drivers/video/aty/radeon_base.c: In function `radeonfb_setcolreg':
drivers/video/aty/radeon_base.c:1025: warning: `vclk_cntl' might be used uninitialized in this function
  CC      net/sunrpc/timer.o
drivers/video/aty/radeon_base.c: In function `radeon_calc_pll_regs':
drivers/video/aty/radeon_base.c:1319: warning: `pll_output_freq' might be used uninitialized in this function
[...]

~Earny

