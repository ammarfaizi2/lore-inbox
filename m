Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277385AbRJJT6F>; Wed, 10 Oct 2001 15:58:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277387AbRJJT5q>; Wed, 10 Oct 2001 15:57:46 -0400
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:28944 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id <S277385AbRJJT5o>; Wed, 10 Oct 2001 15:57:44 -0400
From: Norbert Preining <preining@logic.at>
Date: Wed, 10 Oct 2001 21:57:33 +0200
To: linux-parport@torque.net, Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Problems with parallel port io card, emu10k1, system freeze
Message-ID: <20011010215733.B30906@alpha.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!

I have the following problems with shared irqs/configuring an io-card:

HW: socket-a mobo, pci io (2s,1p) card, sb live1024

The soundblaster and the pci io card share the irq 5 (I have a lot
other pci cards so no irq is free).

The IO ports of the card are as follows:
bc00-bc07 : PCI device 9710:9835
c000-c007 : PCI device 9710:9835
c400-c407 : PCI device 9710:9835
c800-c807 : PCI device 9710:9835
cc00-cc07 : PCI device 9710:9835
d000-d00f : PCI device 9710:9835

I can configure the serial ports mit
	setserial /dev/ttyS2 uart 16550A irq 5 port 0xbc00
	setserial /dev/ttyS3 uart 16550A irq 5 port 0xc000
and they are working without any problems, even when sound is played
on the emu10k1.

No for the parallel port: I load parport_pc with
	modprobe parport_pc irq=7,none dma=3,none io=0x0378,0xc400
which works, recognizes my printer on the second printer port (lp0 on
parport1).

But: If I load NOW the emu10k1 the system freezes.
Same with emu10k1 loaded and modprobe parport_pc.

It is always the same freeze, not even sysrq is working.

Well, why is this so strange:
With Windows98 it is working very well, irq5 for live1024 and the 
io card. Printing and playing music at the same time.

What astonishes me is that according to the windows system information
the ports of ttyS2 and ttyS3 and parport1 (lpt1) are different, namely
the normal standard ports
	ttyS2	0x3e8
	ttyS3	0x2e8
	parport1	0x278
In the sysinfo on windows there are io ports at these three points 
AND at the one listed above from the linux /proc/ioports.

When I try on linux side to 
	setserial /dev/ttyS2 uart 16550A irq 5 port 0x03e8
I get
	ttyS2: LSR safety check engaged!
and the ports are not working.

Trying to
	modprobe parport_pc irq=7,none dma=3,none io=0x0378,0x0278
gives me:
	parport 0x278 (WARNING): CTR: wrote 0x0c, read 0xff
	parport 0x278 (WARNING): DATA: wrote 0xaa, read 0xff
	parport 0x278: You gave this address, but there is probably no parallel port there!
	parport1: PC-style at 0x278 [PCSPP,TRISTATE]
	parport1: cpp_daisy: aa5500ff87(b8)
	parport1: assign_addrs: aa5500ff87(b8)
	parport1: cpp_daisy: aa5500ff87(b8)
	parport1: assign_addrs: aa5500ff87(b8)
and printing is not working.

Now I am at the end of my knowledge. Can someone explain me why this is
happening and how I can fix it?

Please: Cc: emails from the lkml to me too, thanks.

Thanks and best wishes




Norbert

-----------------------------------------------------------------------
Norbert Preining <preining@logic.at> 
University of Technology Vienna, Austria            gpg DSA: 0x09C5B094
-----------------------------------------------------------------------
WRITTLE (vb.)

Of a steel ball, to settle into a hole.

			--- Douglas Adams, The Meaning of Liff 
