Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263645AbUEXWb7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263645AbUEXWb7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 18:31:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264550AbUEXWb6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 18:31:58 -0400
Received: from mailhub.wolfram.com ([140.177.10.16]:64218 "EHLO wolfram.com")
	by vger.kernel.org with ESMTP id S263645AbUEXWbY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 18:31:24 -0400
Mime-Version: 1.0 (Apple Message framework v613)
Content-Transfer-Encoding: 7bit
Message-Id: <14F9BF1A-ADD2-11D8-9EE1-0003933EFBDC@wolfram.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
To: linux-kernel@vger.kernel.org
From: Ryan Tokarek <tokarek@wolfram.com>
Subject: Problem: network drops; ethernet driver problem?  (IRQ 11 disabled)
Date: Mon, 24 May 2004 17:31:21 -0500
X-Mailer: Apple Mail (2.613)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Problem: The network drops out with message: "irq 11: nobody cared! 
(screaming interrupt?)"

After some variable amount of time (that might be influenced by how 
much ethernet traffic is happening on the machine) the network drops 
out on the stock Fedora Core 2 kernel on a Dell PowerEdge 2550. The 
machine keeps running, but the network is gone. `ifdown eth1; ifup 
eth1` works for a while (using dhcp for IP configuration, BTW). The 
ethernet port that the cable is plugged into leads to a Broadcom 
Corporation NetXtreme BCM5700 Gigabit Ethernet (rev 10) chipset as 
reported by `lspci -vvv` below.

I'm not really sure what useful information I can provide so I'm using 
the REPORTING-BUGS document as a guide. I'm also not sure to whom I 
should send this. It wasn't clear to me from the MAINTAINERS file.  Let 
me know if I should be sending this somewhere else.

dmesg from the local console reports:
irq 11: nobody cared! (screaming interrupt?)
Call Trace:
  [<021070c9>] __report_bad_irq+0x2b/0x67
  [<02107161>] note_interrupt+0x43/0x66
  [<02107327>] do_IRQ+0x109/0x169
  [<0223007b>] sock_ioctl+0x13e/0x280
  [<0211af64>] __do_softirq+0x2c/0x73
  [<021078f5>] do_softirq+0x46/0x4d
  =======================
  [<0210737b>] do_IRQ+0x15d/0x169
  [<0210403b>] default_idle+0x23/0x26
  [<0210408c>] cpu_idle+0x1f/0x34
  [<02318612>] start_kernel+0x174/0x176

handlers:
[<62c7da6a>] (tg3_interrupt+0x0/0xe8 [tg3])
Disabling IRQ #11
tg3: tg3_stop_block timed out, ofs=3400 enable_bit=2
tg3: tg3_stop_block timed out, ofs=2400 enable_bit=2
tg3: tg3_stop_block timed out, ofs=1400 enable_bit=2
tg3: tg3_stop_block timed out, ofs=c00 enable_bit=2
tg3: eth1: Link is up at 1000 Mbps, full duplex.
tg3: eth1: Flow control is on for TX and on for RX.
eth1: no IPv6 routers present
irq 11: nobody cared! (screaming interrupt?)
[repeating ....]

Thanks much,
Ryan Tokarek
System Administrator
Wolfram Research Inc.
(not speaking for my employer)


Machine configuration information:

# cat /proc/version
Linux version 2.6.5-1.358 (bhcompile@bugs.build.redhat.com) (gcc 
version 3.3.3 20040412 (Red Hat Linux 3.3.3-7)) #1 Sat May 8 09:04:50 
EDT 2004

# /usr/src/linux-2.6.5-1.358/scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux cupsserver 2.6.5-1.358 #1 Sat May 8 09:04:50 EDT 2004 i686 i686 
i386 GNU/Linux

Gnu C                  3.3.3
Gnu make               3.80
binutils               2.15.90.0.3
util-linux             2.12
mount                  2.12
module-init-tools      2.4.26
e2fsprogs              1.35
pcmcia-cs              3.2.7
quota-tools            3.10.
PPP                    2.4.2
isdn4k-utils           3.3
nfs-utils              1.0.6
Linux C Library        2.3.3
Dynamic linker (ldd)   2.3.3
Procps                 3.2.0
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1
Modules Loaded         ipv6 parport_pc lp parport autofs4 sunrpc tg3 
e100 mii floppy sg microcode dm_mod button battery asus_acpi ac 
reiserfs aacraid sd_mod scsi_mod

# cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 10
cpu MHz         : 931.774
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic mtrr pge mca 
cmov pat pse36 mmx fxsr sse
bogomips        : 1847.29

# cat /proc/modules
ipv6 184288 10 - Live 0x62cfa000
parport_pc 19392 1 - Live 0x62ca0000
lp 8236 0 - Live 0x62c55000
parport 29640 2 parport_pc,lp, Live 0x62c97000
autofs4 10624 0 - Live 0x62c51000
sunrpc 101064 1 - Live 0x62caa000
tg3 62596 0 - Live 0x62c7b000
e100 25348 0 - Live 0x62c3a000
mii 3584 1 e100, Live 0x62c38000
floppy 47440 0 - Live 0x62c5b000
sg 27552 0 - Live 0x62c42000
microcode 4768 0 - Live 0x62c35000
dm_mod 33184 0 - Live 0x62878000
button 4504 0 - Live 0x6286a000
battery 6924 0 - Live 0x6285c000
asus_acpi 8472 0 - Live 0x62866000
ac 3340 0 - Live 0x6285f000
reiserfs 187604 5 - Live 0x62889000
aacraid 32832 6 - Live 0x6284a000
sd_mod 16384 8 - Live 0x62818000
scsi_mod 91344 3 sg,aacraid,sd_mod, Live 0x62832000

# cat /proc/ioports
0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
02f8-02ff : serial
0378-037a : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial
08b0-08bf : 0000:00:0f.1
   08b0-08b7 : ide0
   08b8-08bf : ide1
0cf8-0cff : PCI conf1
ccc0-ccff : 0000:02:04.0
   ccc0-ccff : e100
ec00-ecff : 0000:00:0e.0

# cat /proc/iomem
00000000-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000cbfff : Adapter ROM
000f0000-000fffff : System ROM
00100000-5ffeffff : System RAM
   00100000-00280fff : Kernel code
   00281000-00316bff : Kernel data
5fff0000-5fffebff : ACPI Tables
5fffec00-5fffefff : reserved
f0000000-f7ffffff : 0000:02:02.1
fd000000-fdffffff : 0000:00:0e.0
fe100000-fe100fff : 0000:00:0e.0
fe700000-fe7fffff : 0000:02:04.0
   fe700000-fe7fffff : e100
fe900000-fe900fff : 0000:02:04.0
   fe900000-fe900fff : e100
feb00000-feb0ffff : 0000:01:08.0
   feb00000-feb0ffff : tg3
fec00000-fec0ffff : reserved
fee00000-fee0ffff : reserved
fff80000-ffffffff : reserved

# lspci -vvv
00:00.0 Host bridge: ServerWorks CNB20HE Host Bridge (rev 23)
         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-

00:00.1 Host bridge: ServerWorks CNB20HE Host Bridge (rev 01)
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr+ Stepping- SERR+ FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
         Latency: 32, Cache Line Size 08

00:00.2 Host bridge: ServerWorks CNB20HE Host Bridge (rev 01)
         Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr+ Stepping- SERR+ FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort+ >SERR- <PERR-

00:00.3 Host bridge: ServerWorks CNB20HE Host Bridge (rev 01)
         Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr+ Stepping- SERR+ FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort+ >SERR- <PERR-

00:0e.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 
27) (prog-if 00 [VGA])
         Subsystem: Dell Computer Corporation PowerEdge 2550
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping+ SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32 (2000ns min), Cache Line Size 08
         Region 0: Memory at fd000000 (32-bit, non-prefetchable)
         Region 1: I/O ports at ec00 [size=256]
         Region 2: Memory at fe100000 (32-bit, non-prefetchable) 
[size=4K]
         Capabilities: [5c] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0f.0 ISA bridge: ServerWorks OSB4 South Bridge (rev 50)
         Subsystem: ServerWorks OSB4 South Bridge
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0

00:0f.1 IDE interface: ServerWorks OSB4 IDE Controller (prog-if 8a 
[Master SecP PriP])
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 64
         Region 4: I/O ports at 08b0 [size=16]

01:08.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5700 
Gigabit Ethernet (rev 10)
         Subsystem: Dell Computer Corporation Broadcom BCM5700
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32 (16000ns min), Cache Line Size 08
         Interrupt: pin A routed to IRQ 11
         Region 0: Memory at feb00000 (64-bit, non-prefetchable)
         Capabilities: [40] PCI-X non-bridge device.
                 Command: DPERE- ERO- RBC=0 OST=0
                 Status: Bus=255 Dev=31 Func=1 64bit+ 133MHz+ SCD- USC-, 
DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-
         Capabilities: [48] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot+,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=1 PME-
         Capabilities: [50] Vital Product Data
         Capabilities: [58] Message Signalled Interrupts: 64bit+ 
Queue=0/3 Enable-
                 Address: 0944990024c45090  Data: 018a

02:02.0 PCI bridge: Intel Corp. 80960RM [i960RM Bridge] (rev 01) 
(prog-if 00 [Normal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32, Cache Line Size 10
         Bus: primary=02, secondary=03, subordinate=03, sec-latency=32
         I/O behind bridge: 0000f000-00000fff
         Memory behind bridge: fff00000-000fffff
         Prefetchable memory behind bridge: fff00000-000fffff
         BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

02:02.1 RAID bus controller: Dell Computer Corporation PowerEdge 
Expandable RAID Controller 3 (rev 01)
         Subsystem: Dell Computer Corporation PowerEdge Expandable RAID 
Controller 3/Di
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32, Cache Line Size 08
         Interrupt: pin A routed to IRQ 5
         Region 0: Memory at f0000000 (32-bit, prefetchable) 
[size=fe800000]
         Expansion ROM at 00010000 [disabled]

02:04.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] 
(rev 08)
         Subsystem: Dell Computer Corporation PowerEdge 2550
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32 (2000ns min, 14000ns max), Cache Line Size 08
         Interrupt: pin A routed to IRQ 10
         Region 0: Memory at fe900000 (32-bit, non-prefetchable) 
[size=fe800000]
         Region 1: I/O ports at ccc0 [size=64]
         Region 2: Memory at fe700000 (32-bit, non-prefetchable) 
[size=1M]
         Expansion ROM at 00100000 [disabled]
         Capabilities: [dc] Power Management version 2
                 Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable+ DSel=0 DScale=2 PME-

