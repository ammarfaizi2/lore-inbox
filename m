Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263772AbUFKILs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263772AbUFKILs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 04:11:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261925AbUFKIHQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 04:07:16 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:64708 "EHLO
	out2.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S262874AbUFKHra (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 03:47:30 -0400
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="ISO-8859-1"
MIME-Version: 1.0
X-Mailer: MIME::Lite 1.3  (F2.72; T1.001; A1.62; B3.01; Q3.01)
From: "Kai OM" <epimetreus@fastmail.fm>
To: "Bruce Ferrell" <bferrell@baywinds.org>
Date: Fri, 11 Jun 2004 03:47:28 -0400
X-Sasl-Enc: 2c4JJEz70LhVLL9sXMOXcw 1086940048
Message-Id: <1086940048.7140.198212371@webmail.messagingengine.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SCSI related hang on boot
References: <1086409188.23970.197814826@webmail.messagingengine.com> <40C7F08B.2080900@baywinds.org> <1086860696.14607.198141025@webmail.messagingengine.com> <40C87620.9080703@baywinds.org>
In-Reply-To: <40C87620.9080703@baywinds.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not using a module. I compiled it Y into the kernel, because it's the
device I boot from.


----- Original message -----
From: "Bruce Ferrell" <bferrell@baywinds.org>
To: "Kai OM" <epimetreus@fastmail.fm>
Date: Thu, 10 Jun 2004 07:54:24 -0700
Subject: Re: SCSI related hang on boot

Re: which distro - there are different versions of the symbios module. 
The hardware detection for a particular distro and the module used by 
that would affect how how the system behaves.

Kai OM wrote:
> I did some digging around, and found a patch issued in 2.6.6 - here's the
> entry in the changelog:
> 
> <willy@debian.org>
> 	[PATCH] sym 2.1.18j
> 	
> 	sym 2.1.18j:
> 	 - Add SPI transport attributes (James Bottomley)
> 	 - Use generic code to do Domain Validation (James Bottomley)
> 	 - Stop using scsi_to_pci_dma_dir() (Christoph Hellwig)
> 	 - Change some constants to their symbolic names (Grant Grundler)
> 	 - Handle a race between a postponed command completing and the EH retrying
> 	   it (James Bottomley)
> 	 - If the auto request sense fails, issue a device reset (James Bottomley)
> 
> It looks like this patch broke something, though I have no clue what,
> because ALL tested previous versions of the Sym driver have worked for
> me.
> 
> I tested 2.6.6-r1 a little bit with noapic and nolapic, and it didn't
> help, but I can see if 2.6.6 is any different. Either way, that's just a
> workaround, and doesn't address whatever was broken in the actual code.
> 
> So far, I've tested this in Slackware and Gentoo, though I can't imagine
> how the distro you use would affect the boot process before the root FS
> is even mounted. I'm not terribly informed, though, so 
> 
> 
> ----- Original message -----
> From: "Bruce Ferrell" <bferrell@baywinds.org>
> To: "Kai OM" <epimetreus@fastmail.fm>
> Date: Wed, 09 Jun 2004 22:24:27 -0700
> Subject: Re: SCSI related hang on boot
> 
> I've seen something similar on my intel 440bx with a dual integrated 
> sym53c875.  With some distro kernels booting with noapic helps.  In 
> other cases I have to be sure the use the older symbios module.
> 
> Kai OM wrote:
> 
>>I sent this before, but I forgot to type in a subject for the message,
>>and I have no idea what filters some of you guys might have set up -.-;;
>>-- anyway, here's the original e-mail(with a few corrections):
>>
>>Hello, list.
>>
>>I'm hoping someone here can shed some insight into just a weird issue I'm
>>having with 2.6.6-rc1 - or, if it's a bug, hoping the right person hears
>>about it so it can get fixed.
>>
>>Note that I've been able to boot into other 2.6 kernels in the past, even
>>very recent ones, so it's something related to this specific version, I'm
>>convinced. I've not installed any new hardware, or done anything drastic
>>to the kernel config; in fact, I'm pretty sure the pertinent bits of the
>>kernel config are identical to the configs I used in older kernels, which
>>didn't cause the problem I'm outlining.
>>
>>Anyway, here's my hardware:
>>Athlon-XP 2500
>>1024 MB DDR RAM
>>A7N8X 2.0
>>Onboard sound and ethernet
>>Geforce FX 5900
>>LSIU160 SCSI controller
>>Onboard SiI3112 SATA controller
>>WD Raptor 10K 70 GB HDD
>>Atlas 10K II SCSI HDD
>>
>>Here's my issue:
>>
>>I installed the 2.6.6-rc1 kernel a couple days ago, and tried to boot up
>>as normal. Here's the last bit of output to the screen(Had to record it
>>on paper). I'm going to insert a notification of where I believe the
>>output begins to deviate from what I've seen in the past(I apologize if
>>I'm overdetailing things, but I want to be as informative as possible):
>>
>>sym0:<1010-33> rev 0x1 PCI 0000:01:0a.0 irq 16
>>sym0: using 64 bit DMA addressing
>>sym0: Symbios NVRAM ID7, fast 80, LVD, parity checking
>>sym0: Open drain IRQ driver, using on-chip SRAM
>>sym0: using LOAD/STORE based firmware
>>sym0: handling phase mismatch from SCRIPTS
>>sym0: scan at boot disabled for targets 0 1 2 3 4 5 6 7 8 9 10 11 12 13
>>14 15
>>sym0: scan for LUNS disabled for targets 0 1 2 3 4 5 6 7 8 9 10 11 12 13
>>14 15
>>scsi0: Sym-2.1.18j
>>Vendor: QUANTUM Model: ATLAS10K2-TY734J
>>Type: Direct-access ANSI SCSI revision: 03
>>
>>/*I believe that all output above this point is identical to output from
>>previous kernel versions;
>> *I know for sure all output below this point deviates from before. */
>>
>>scsi(0:0:0:0): Beginning Domain Validation
>>sym0:0:Wide asynchronous                   #<---The system hangs at this
>>point for about 20 seconds,
>>sym0:0: ABORT operation started            #and also waits about 20-30
>>seconds at each ABORT and DEVICE RESET attempt
>>sym0:0: ABORT operation timed out
>>sym0:0: DEVICE RESET operation started
>>sym0:0: DEVICE RESET operation completed
>>sym0: SCSI bus has been reset
>>sym0:0: ABORT operation started
>>sym0:0: ABORT operation timed out
>>sym0:0: DEVICE RESET operation started
>>sym0:0: DEVICE RESET operation completed
>>sym0: SCSI bus has been reset
>>
>>After this, it just hangs for about three minutes, then the screen goes
>>blank(presumably due to inactivity), and the system remains unresponsive.
>>Ctrl-Alt-Del does nothing. I
>>had to power off.
>>
>>I am able to use the Gentoo 2.6.5 kernel without any problems, as well as
>>older 2.6 kernels, such as 2.6.4, without a hint of this happening.
>>
>>Attached are my kernel configs for the Gentoo 2.6.5-rc1 and vanilla
>>2.6.6-rc1 kernels, as well as the output from lspci, just in case that's
>>needed.
>>
>>Thanks in advance for any help.
>>
>>
>>------------------------------------------------------------------------
>>
>>00:00.0 Host bridge: nVidia Corporation nForce2 AGP (different version?) (rev c1)
>>	Subsystem: Asustek Computer, Inc.: Unknown device 80ac
>>	Flags: bus master, 66Mhz, fast devsel, latency 0
>>	Memory at d0000000 (32-bit, prefetchable) [size=128M]
>>	Capabilities: [40] AGP version 3.0
>>	Capabilities: [60] #08 [2001]
>>
>>00:00.1 RAM memory: nVidia Corporation nForce2 Memory Controller 1 (rev c1)
>>	Subsystem: Asustek Computer, Inc.: Unknown device 80ac
>>	Flags: 66Mhz, fast devsel
>>
>>00:00.2 RAM memory: nVidia Corporation nForce2 Memory Controller 4 (rev c1)
>>	Subsystem: Asustek Computer, Inc.: Unknown device 80ac
>>	Flags: 66Mhz, fast devsel
>>
>>00:00.3 RAM memory: nVidia Corporation nForce2 Memory Controller 3 (rev c1)
>>	Subsystem: Asustek Computer, Inc.: Unknown device 80ac
>>	Flags: 66Mhz, fast devsel
>>
>>00:00.4 RAM memory: nVidia Corporation nForce2 Memory Controller 2 (rev c1)
>>	Subsystem: Asustek Computer, Inc.: Unknown device 80ac
>>	Flags: 66Mhz, fast devsel
>>
>>00:00.5 RAM memory: nVidia Corporation nForce2 Memory Controller 5 (rev c1)
>>	Subsystem: Asustek Computer, Inc.: Unknown device 80ac
>>	Flags: 66Mhz, fast devsel
>>
>>00:01.0 ISA bridge: nVidia Corporation nForce2 ISA Bridge (rev a4)
>>	Subsystem: Asustek Computer, Inc. A7N8X Mainboard
>>	Flags: bus master, 66Mhz, fast devsel, latency 0
>>	Capabilities: [48] #08 [01e1]
>>
>>00:01.1 SMBus: nVidia Corporation nForce2 SMBus (MCP) (rev a2)
>>	Subsystem: Asustek Computer, Inc.: Unknown device 0c11
>>	Flags: 66Mhz, fast devsel, IRQ 5
>>	I/O ports at ec00 [size=32]
>>	Capabilities: [44] Power Management version 2
>>
>>00:02.0 USB Controller: nVidia Corporation nForce2 USB Controller (rev a4) (prog-if 10 [OHCI])
>>	Subsystem: Asustek Computer, Inc. A7N8X Mainboard
>>	Flags: bus master, 66Mhz, fast devsel, latency 0, IRQ 12
>>	Memory at e4080000 (32-bit, non-prefetchable) [size=4K]
>>	Capabilities: [44] Power Management version 2
>>
>>00:02.1 USB Controller: nVidia Corporation nForce2 USB Controller (rev a4) (prog-if 10 [OHCI])
>>	Subsystem: Asustek Computer, Inc. A7N8X Mainboard
>>	Flags: bus master, 66Mhz, fast devsel, latency 0, IRQ 11
>>	Memory at e4082000 (32-bit, non-prefetchable) [size=4K]
>>	Capabilities: [44] Power Management version 2
>>
>>00:02.2 USB Controller: nVidia Corporation nForce2 USB Controller (rev a4) (prog-if 20 [EHCI])
>>	Subsystem: Asustek Computer, Inc. A7N8X Mainboard
>>	Flags: bus master, 66Mhz, fast devsel, latency 0, IRQ 3
>>	Memory at e4083000 (32-bit, non-prefetchable) [size=256]
>>	Capabilities: [44] #0a [2080]
>>	Capabilities: [80] Power Management version 2
>>
>>00:04.0 Ethernet controller: nVidia Corporation nForce2 Ethernet Controller (rev a1)
>>	Subsystem: Asustek Computer, Inc.: Unknown device 80a7
>>	Flags: bus master, 66Mhz, fast devsel, latency 0, IRQ 3
>>	Memory at e4084000 (32-bit, non-prefetchable) [size=4K]
>>	I/O ports at e000 [size=8]
>>	Capabilities: [44] Power Management version 2
>>
>>00:05.0 Multimedia audio controller: nVidia Corporation nForce MultiMedia audio [Via VT82C686B] (rev a2)
>>	Subsystem: Asustek Computer, Inc.: Unknown device 0c11
>>	Flags: bus master, 66Mhz, fast devsel, latency 0, IRQ 12
>>	Memory at e4000000 (32-bit, non-prefetchable) [size=512K]
>>	Capabilities: [44] Power Management version 2
>>
>>00:06.0 Multimedia audio controller: nVidia Corporation nForce2 AC97 Audio Controler (MCP) (rev a1)
>>	Subsystem: Asustek Computer, Inc.: Unknown device 8095
>>	Flags: bus master, 66Mhz, fast devsel, latency 0, IRQ 5
>>	I/O ports at e400 [size=256]
>>	I/O ports at e800 [size=128]
>>	Memory at e4081000 (32-bit, non-prefetchable) [size=4K]
>>	Capabilities: [44] Power Management version 2
>>
>>00:08.0 PCI bridge: nVidia Corporation nForce2 External PCI Bridge (rev a3) (prog-if 00 [Normal decode])
>>	Flags: bus master, 66Mhz, fast devsel, latency 0
>>	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
>>	I/O behind bridge: 0000c000-0000dfff
>>	Memory behind bridge: e2000000-e3ffffff
>>
>>00:09.0 IDE interface: nVidia Corporation nForce2 IDE (rev a2) (prog-if 8a [Master SecP PriP])
>>	Subsystem: Asustek Computer, Inc.: Unknown device 0c11
>>	Flags: bus master, 66Mhz, fast devsel, latency 0
>>	I/O ports at f000 [size=16]
>>	Capabilities: [44] Power Management version 2
>>
>>00:1e.0 PCI bridge: nVidia Corporation nForce2 AGP (rev c1) (prog-if 00 [Normal decode])
>>	Flags: bus master, 66Mhz, medium devsel, latency 32
>>	Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
>>	Memory behind bridge: e0000000-e1ffffff
>>	Prefetchable memory behind bridge: d8000000-dfffffff
>>
>>01:08.0 Communication controller: Intel Corp. 536EP Data Fax Modem
>>	Subsystem: Intel Corp.: Unknown device 1000
>>	Flags: bus master, medium devsel, latency 32, IRQ 5
>>	Memory at e3000000 (32-bit, non-prefetchable) [size=4M]
>>	Capabilities: [e0] Power Management version 2
>>
>>01:0a.0 SCSI storage controller: LSI Logic / Symbios Logic 53c1010 Ultra3 SCSI Adapter (rev 01)
>>	Subsystem: LSI Logic / Symbios Logic: Unknown device 1030
>>	Flags: bus master, medium devsel, latency 72, IRQ 12
>>	I/O ports at c000 [size=256]
>>	Memory at e3405000 (64-bit, non-prefetchable) [size=1K]
>>	Memory at e3400000 (64-bit, non-prefetchable) [size=8K]
>>	Expansion ROM at <unassigned> [disabled] [size=128K]
>>	Capabilities: [40] Power Management version 2
>>
>>01:0a.1 SCSI storage controller: LSI Logic / Symbios Logic 53c1010 Ultra3 SCSI Adapter (rev 01)
>>	Subsystem: LSI Logic / Symbios Logic: Unknown device 1030
>>	Flags: bus master, medium devsel, latency 32, IRQ 11
>>	I/O ports at c400 [size=256]
>>	Memory at e3404000 (64-bit, non-prefetchable) [size=1K]
>>	Memory at e3402000 (64-bit, non-prefetchable) [size=8K]
>>	Expansion ROM at <unassigned> [disabled] [size=128K]
>>	Capabilities: [40] Power Management version 2
>>
>>01:0b.0 RAID bus controller: CMD Technology Inc Silicon Image SiI 3112 SATARaid Controller (rev 02)
>>	Subsystem: CMD Technology Inc: Unknown device 6112
>>	Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 5
>>	I/O ports at c800 [size=8]
>>	I/O ports at cc00 [size=4]
>>	I/O ports at d000 [size=8]
>>	I/O ports at d400 [size=4]
>>	I/O ports at d800 [size=16]
>>	Memory at e3406000 (32-bit, non-prefetchable) [size=512]
>>	Expansion ROM at <unassigned> [disabled] [size=512K]
>>	Capabilities: [60] Power Management version 2
>>
>>02:00.0 VGA compatible controller: nVidia Corporation NV35 [GeForce FX 5900] (rev a1) (prog-if 00 [VGA])
>>	Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 11
>>	Memory at e0000000 (32-bit, non-prefetchable) [size=16M]
>>	Memory at d8000000 (32-bit, prefetchable) [size=128M]
>>	Expansion ROM at <unassigned> [disabled] [size=128K]
>>	Capabilities: [60] Power Management version 2
>>	Capabilities: [44] AGP version 3.0
>>
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

