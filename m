Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932101AbWBJOwA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932101AbWBJOwA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 09:52:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751273AbWBJOwA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 09:52:00 -0500
Received: from 213-140-2-71.ip.fastwebnet.it ([213.140.2.71]:20186 "EHLO
	aa004msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1751265AbWBJOv7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 09:51:59 -0500
Date: Fri, 10 Feb 2006 15:52:43 +0100
From: Mattia Dongili <malattia@linux.it>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net
Subject: Radeonfb ignores video= parameter [was: Re: 2.6.16-rc2-mm1]
Message-ID: <20060210145243.GA3581@inferi.kami.home>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org,
	linux-fbdev-devel@lists.sourceforge.net
References: <20060207220627.345107c3.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060207220627.345107c3.akpm@osdl.org>
X-Message-Flag: Cranky? Try Free Software instead!
X-Operating-System: Linux 2.6.16-rc2-mm1-1 i686
X-Editor: Vim http://www.vim.org/
X-Disclaimer: Buh!
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2006 at 10:06:27PM -0800, Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc2/2.6.16-rc2-mm1/

Hello,

radeonfb ignores the video= parameter and always run at 1400x1050 (the
highest available). Things where fine with .16-rc1-mm5.
I also tried booting with 640x480-32@60 without success.

# fbset -s
mode "1400x1050-60"
    # D: 108.003 MHz, H: 63.983 kHz, V: 60.021 Hz
    geometry 1400 1050 1408 1050 8
    timings 9259 136 40 13 0 112 3
    hsync high
    vsync high
    rgba 8/0,8/0,8/0,0/0
endmode

Oh, however running
	fbset -xres 800 -yres 600
works when the system is up.

This is the relevant dmesg snippets:

[    0.000000] Linux version 2.6.16-rc2-mm1-1 (mattia@inferi) (gcc version 4.0.3 20051201 (prerelease) (Debian 4.0.2-5)) #1 PREEMPT Wed Feb 8 13:19:29 CET 2006
...
[    8.398523] Kernel command line: root=/dev/hda1 ro vga=extended video=radeonfb:800x600-32@60 fbcon=font:Acorn8x8 lapic resume=/dev/hda2
[    8.399088] CPU 0 irqstacks, hard=c03c1000 soft=c03c2000
[    8.399095] PID hash table entries: 1024 (order: 10, 16384 bytes)
[    8.482408] Console: colour VGA+ 80x50
...
[    8.919903] ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 9
[    8.919950] ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [LNKA] -> GSI 9 (level, low) -> IRQ 9
[    8.930704] radeonfb: Retrieved PLL infos from BIOS
[    8.930750] radeonfb: Reference=27.00 MHz (RefDiv=60) Memory=166.00 Mhz, System=166.00 MHz
[    8.930804] radeonfb: PLL min 12000 max 35000
[    9.865869] Non-DDC laptop panel detected
[   10.861036] radeonfb: Monitor 1 type LCD found
[   10.861080] radeonfb: Monitor 2 type no found
[   10.861127] radeonfb: panel ID string: Samsung LTN150P1-L02    
[   10.861172] radeonfb: detected LVDS panel size from BIOS: 1400x1050
[   10.861217] radeondb: BIOS provided dividers will be used
[   11.096839] radeonfb: Dynamic Clock Power Management enabled
[   11.364622] Console: switching to colour frame buffer device 175x131
[   11.365363] radeonfb (0000:01:00.0): ATI Radeon LY 
...

the only thing being different from -rc1-mm5:
--- boot_as_usual_but_working	2006-02-10 15:43:03.505874694 +0100
+++ boot_as_usual	2006-02-10 15:42:55.322907583 +0100
@@ -1,4 +1,4 @@
-Linux version 2.6.16-rc1-mm5-1 (mattia@inferi) (gcc version 4.0.3 20051201 (prerelease) (Debian 4.0.2-5)) #1 PREEMPT Sat Feb 4 14:38:36 CET 2006
+Linux version 2.6.16-rc2-mm1-1 (mattia@inferi) (gcc version 4.0.3 20051201 (prerelease) (Debian 4.0.2-5)) #1 PREEMPT Wed Feb 8 13:19:29 CET 2006
 BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009e800 (usable)
  BIOS-e820: 000000000009e800 - 00000000000a0000 (reserved)
@@ -144,7 +144,7 @@
 radeonfb: detected LVDS panel size from BIOS: 1400x1050
 radeondb: BIOS provided dividers will be used
 radeonfb: Dynamic Clock Power Management enabled
-Console: switching to colour frame buffer device 100x75
+Console: switching to colour frame buffer device 175x131
 radeonfb (0000:01:00.0): ATI Radeon LY 
 ACPI: AC Adapter [ACAD] (on-line)
 ACPI: Battery Slot [BAT1] (battery present)

And finally lspci:

0000:01:00.0 VGA compatible controller: ATI Technologies Inc Radeon Mobility M6 LY (prog-if 00 [VGA])
	Subsystem: Sony Corporation VAIO PCG-GR214EP/GR214MP/GR215MP/GR314MP/GR315MP
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B+
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 66 (2000ns min), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at d8000000 (32-bit, prefetchable) [size=128M]
	Region 1: I/O ports at 3000 [size=256]
	Region 2: Memory at d0100000 (32-bit, non-prefetchable) [size=64K]
	Expansion ROM at d0120000 [disabled] [size=128K]
	Capabilities: [58] AGP version 2.0
		Status: RQ=48 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP- GART64- 64bit- FW- Rate=<none>
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

-- 
mattia
:wq!
