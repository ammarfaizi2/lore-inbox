Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268702AbRIFWaB>; Thu, 6 Sep 2001 18:30:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268813AbRIFW3v>; Thu, 6 Sep 2001 18:29:51 -0400
Received: from kuroneko.thok.org ([4.36.43.85]:58240 "EHLO kuroneko")
	by vger.kernel.org with ESMTP id <S268702AbRIFW3l>;
	Thu, 6 Sep 2001 18:29:41 -0400
From: "Mark W. Eichin" <eichin@thok.org>
To: linux-kernel@vger.kernel.org
Subject: CONFIG_BLK_DEV_SL82C105 should not be PPC/ARM specific
Message-Id: <20010906223001.A63F613DC7@kuroneko>
Date: Thu,  6 Sep 2001 18:30:01 -0400 (EDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:    
CONFIG_BLK_DEV_SL82C105 should not be PPC/ARM specific

[2.] Full description of the problem/report:

kernel-source-2.4.9/drivers/ide/Config.in:
	 if [ "$CONFIG_PPC" = "y" -o "$CONFIG_ARM" = "y" ]; then
	    bool '    Winbond SL82c105 support' CONFIG_BLK_DEV_SL82C105
	 fi
The ALR Revolution 2XL dual-x86 (well, celeron) motherboard does, in
fact, use this controller:

00:02.0 IDE interface: Symphony Labs SL82c105 (rev 06) (prog-if 8a [Master SecP PriP])
        Flags: bus master, medium devsel, latency 64
        I/O ports at fcd0

and if I bludgeon the config so that it actually builds, it does work
(under 2.2, regrettably in pio-only mode, but I'll try 2.4.9 shortly)

W82C105: IDE controller on PCI bus 00 dev 10
W82C105: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xfcd0-0xfcd7, BIOS settings: hda:pio, hdb:pio
SL82C105 command word: 5
IDE timing: 00001313, resetting to PIO0 timing
IDE control/status register: 08ff0801


[3.] Keywords (i.e., modules, networking, kernel):
kernel Config IDE block architecture x86

[4.] Kernel version (from /proc/version):
2.2.19, 2.4.9 (from inspection of source)

[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)
n/a
[6.] A small shell script or example program which triggers the
     problem (if possible)
n/a
[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)
[7.2.] Processor information (from /proc/cpuinfo):
[7.3.] Module information (from /proc/modules):
[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
[7.5.] PCI information ('lspci -vvv' as root)

00:02.0 IDE interface: Symphony Labs SL82c105 (rev 06) (prog-if 8a [Master SecP PriP])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 2 min, 40 max, 64 set, cache line size 08
        Interrupt: pin A routed to IRQ 0
        Region 4: I/O ports at fcd0

[7.6.] SCSI information (from /proc/scsi/scsi)
[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):
[X.] Other notes, patches, fixes, workarounds:

The hedrick IDE backport doesn't change this either.

			_Mark_ <eichin@thok.org>
			The Herd Of Kittens
