Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264010AbTASTyq>; Sun, 19 Jan 2003 14:54:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264665AbTASTyq>; Sun, 19 Jan 2003 14:54:46 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:33810 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264010AbTASTyp>; Sun, 19 Jan 2003 14:54:45 -0500
Date: Sun, 19 Jan 2003 20:03:40 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       linux-fbdev-devel@lists.sourceforge.net, jsimmons@infradead.org
Subject: fbcon scrolling + initialisation oddity
Message-ID: <20030119200340.A13758@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	linux-fbdev-devel@lists.sourceforge.net, jsimmons@infradead.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1. YWRAP scrolling.

There appears to be something weird going on with fbcon scrolling in 2.5.59
when using YWRAP.  The best example is what happens when scrolling a large
file (say, /etc/termcap) in less.

While scrolling down in the file, the screen scrolls correctly for the
most part.  At some point, the screen stops scrolling and the last line
which normally displays the less prompt character ":" is replaced by
the next line of text.  Continuing to scroll down produces no visible
changes.

Once enough scrolling has occurred, suddenly the screen jumps and we get
the proper text displayed.

Also, if you scroll line by line until the ":" is replaced by text as
above, scrolling back up one line replaces the ":" and scrolling upwards
scrolls the screen up correctly.

As an additional behaviour point, if you scroll down until the ":" just
disappears and then some extra lines, hit 'q' to exit less, followed by
^L, most of the screen is cleared, except for the very top few lines.
I haven't checked, but I suspect the number of lines left at the top of
the screen is equal to the number of lines we're off the bottom of the
screen.

2. Initialisation

Machine 1: (acornfb)

	parport0: PC-style at 0x278 (0x678) [PCSPP(,...)]
	i2c-dev.o: i2c /dev entries driver module version 2.6.4 (20020719)
	Acornfb: 2048kB VRAM, VIDC20, using 1280x1024, 63.885kHz, 59Hz
	Acornfb: Monitor: 30.000-85.000kHz, 56-76Hz, DPMS
-->	Console: switching to colour frame buffer device 160x128
	pty: 256 Unix98 ptys configured
	i2c-dev.o: Registered 'IOC/IOMD' as minor 0
	mice: PS/2 mouse device common for all mice
	input: Acorn RiscPC mouse
	input: AT Set 2 keyboard on rpckbd/serio0
	...
	SCSI device sda: drive cache: write back
	 sda: sda1 sda2
	Attached scsi removable disk sda at scsi0, channel 0, id 2, lun 0
-->	Console: switching to colour frame buffer device 160x128
	NET4: Linux TCP/IP 1.0 for NET4.0
	IP: routing cache hash table of 512 buckets, 4Kbytes

Machine 2: (sa1100fb)

	i2c-dev.o: i2c /dev entries driver module version 2.6.4 (20020719)
	i2c-proc.o version 2.6.4 (20020719)
	i2c-dev.o: Registered 'l3-bit-sa1100-gpio' as minor 0
	dma period = 1372168 ps, clock = 206400 kHz
-->	Console: switching to colour frame buffer device 40x30
	pty: 256 Unix98 ptys configured
	SA1100 Real Time Clock driver v1.00
	RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
-->	Console: switching to colour frame buffer device 40x30
	drivers/mtd/maps/pcmciamtd.c: PCMCIA Flash memory card driver $Revision: 1.36 $


We seem to be initialising the console twice?  Certainly the position of the
text vs the logo seems to jump around with the second initialisation.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

