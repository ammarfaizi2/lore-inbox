Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262339AbUCRCTo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 21:19:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262353AbUCRCTn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 21:19:43 -0500
Received: from tomts15-srv.bellnexxia.net ([209.226.175.3]:29880 "EHLO
	tomts15-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S262339AbUCRCTg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 21:19:36 -0500
Message-ID: <40590737.9060001@cantecsystems.com>
Date: Wed, 17 Mar 2004 21:19:35 -0500
From: Dave Croal <dcroal@cantecsystems.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040312 Debian/1.6-3
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: alim15x3 later than 2.6.1 won't allow DMA to be turned on
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The alim15x3 module in kernels 2.6.3 and 2.6.4 does not allow me to turn
on DMA via hdparm:

hdparm -d1 /dev/hda
HDIO_SET_DMA failed: Operation not permitted using_dma = 0 (off)

dmesg |grep -i ali
ALI15X3: IDE controller at PCI slot 0000:00:0f.0
ALI15X3: chipset revision 32
ALI15X3: not 100% native mode: will probe irqs later
ALI15X3: port 0x01f0 already claimed by ide0
ALI15X3: port 0x0170 already claimed by ide1
ALI15X3: neither IDE port enabled (BIOS)

---

In kernel 2.6.1 it worked OK:

hdparm -d1 /dev/hda
/dev/hda:
  setting using_dma to 1 (on)
  using_dma    =  1 (on)

dmesg |grep -i ali
ALI15X3: IDE controller at PCI slot 0000:00:0f.0
ALI15X3: chipset revision 32
ALI15X3: not 100% native mode: will probe irqs later
     ide0: BM-DMA at 0x78c0-0x78c7, BIOS settings: hda:DMA, hdb:pio
     ide1: BM-DMA at 0x78c8-0x78cf, BIOS settings: hdc:DMA, hdd:pio
ide0: I/O resource 0x3F6-0x3F6 not free.
hda: ERROR, PORTS ALREADY IN USE
register_blkdev: cannot get major 3 for ide0
ide1: I/O resource 0x376-0x376 not free.
hdc: ERROR, PORTS ALREADY IN USE
register_blkdev: cannot get major 22 for ide1
Module alim15x3 cannot be unloaded due to unsafe usage in
include/linux/module.h:483

---
My hardware is an IBM Thinkpad 1461 notebook.
Ouput of lspci -vvv:
00:00.0 Host bridge: ALi Corporation M1621 (rev 05)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort-
<MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
	Capabilities: <available only to root>

00:01.0 PCI bridge: ALi Corporation PCI to AGP Controller (rev 01)
(prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 00008000-00008fff
	Memory behind bridge: 80500000-820fffff
	Prefetchable memory behind bridge: fff00000-000fffff
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-

00:06.0 Communication controller: Lucent Microelectronics WinModem 56k
(rev 01)
	Subsystem: AMBIT Microsystem Corp. Lucent Win Modem
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (63000ns min, 3500ns max)
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at 82400000 (32-bit, non-prefetchable) [size=256]
	Region 1: I/O ports at 90b8 [size=8]
	Region 2: I/O ports at 9400 [size=256]
	Capabilities: <available only to root>

00:07.0 ISA bridge: ALi Corporation M1533 PCI to ISA Bridge [Aladdin IV]
(rev 0a)
	Subsystem: Acer Incorporated [ALI]: Unknown device 1004
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort+ <MAbort+ >SERR- <PERR-
	Latency: 0

00:08.0 Multimedia audio controller: ESS Technology ES1969 Solo-1
Audiodrive (rev 02)
	Subsystem: ESS Technology: Unknown device 8898
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 6000ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at 9000 [size=64]
	Region 1: I/O ports at 9050 [size=16]
	Region 2: I/O ports at 9070 [size=16]
	Region 3: I/O ports at 9090 [size=4]
	Region 4: I/O ports at 90a4 [size=4]
	Capabilities: <available only to root>

00:0f.0 IDE interface: ALi Corporation M5229 IDE (rev 20) (prog-if 8a
[Master SecP PriP])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 1000ns max)
	Interrupt: pin A routed to IRQ 15
	Region 4: I/O ports at 78c0 [size=16]

00:11.0 Bridge: ALi Corporation M7101 PMU (rev 09)
	Subsystem: Acer Incorporated [ALI]: Unknown device 1004
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

00:13.0 CardBus bridge: O2 Micro, Inc. OZ6812 Cardbus Controller (rev 05)
	Subsystem: Acer Incorporated [ALI]: Unknown device 1004
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 168
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at 10000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
	Memory window 0: 10400000-107ff000 (prefetchable)
	Memory window 1: 10800000-10bff000
	I/O window 0: 00004000-000040ff
	I/O window 1: 00004400-000044ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

00:14.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03)
(prog-if 10 [OHCI])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at 82600000 (32-bit, non-prefetchable) [size=4K]

01:00.0 VGA compatible controller: ATI Technologies Inc Rage Mobility
P/M AGP 2x (rev 64) (prog-if 00 [VGA])
	Subsystem: Acer Incorporated [ALI]: Unknown device 1004
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at 81000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: I/O ports at 8000 [size=256]
	Region 2: Memory at 80500000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at 80520000 [disabled] [size=128K]
	Capabilities: <available only to root>

---

output of sh scripts/ver_linux:

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux croalnotebook.localdomain 2.6.1-lz #1 Sun Jan 25 10:59:21 EST 2004
i686 GNU/Linux

Gnu C                  3.3.3
Gnu make               3.80
util-linux             2.12
mount                  2.12
module-init-tools      3.0-pre10
e2fsprogs              1.35
pcmcia-cs              3.2.5
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.2.0
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.0.91
Modules Loaded         Win4Lin mki_adapter md5 ipv6 ds parport_pc lp
parport apm snd_seq_midi snd_opl3_synth snd_seq_instr snd_seq_midi_emul
snd_ainstr_fm snd_seq_oss snd_seq_midi_event snd_seq snd_pcm_oss
snd_mixer_oss af_packet scanner uhci_hcd usblp ehci_hcd ohci_hcd
yenta_socket pcmcia_core ali_agp agpgart tsdev joydev evdev psmouse
mousedev snd_es1938 snd_pcm snd_opl3_lib snd_timer snd_hwdep gameport
snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore
pegasus usbcore alim15x3 rtc unix


Please let me know if you need more information.

Best regards,
Dave Croal

