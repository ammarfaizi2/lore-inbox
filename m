Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265207AbUJBNDR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265207AbUJBNDR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 09:03:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265211AbUJBNDR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 09:03:17 -0400
Received: from outmx019.isp.belgacom.be ([195.238.2.200]:49338 "EHLO
	outmx019.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S265207AbUJBNCj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 09:02:39 -0400
Message-ID: <415EA6FC.2080807@skynet.be>
Date: Sat, 02 Oct 2004 15:02:52 +0200
From: "Gerard H. Pille" <g.h.p@skynet.be>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6a) Gecko/20031029
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: usb on amd-756 broken since 2.6.6
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hallo,

The last kernel on which I could succesfully mount /proc/bus/usb and 
"cat /proc/bus/usb/devices" is 2.6.5, since then, the cat hangs.  I am 
not sure if the trouble starts with 2.6.6 or 2.6.7, since I can not boot 
with 2.6.6, the boot hangs on the hdd, a cdrom.  If I could find patches 
  to get 2.6.6 working, I might be able to further narrow it down.

In /var/log/messages, I only see this "kernel: usb 1-2: control timeout 
on ep0in".

Linux GHP-AMD650 2.6.8.1 #1 Sat Oct 2 13:28:38 CEST 2004 i686 unknown

Gnu C                  2.95.4
Gnu make               3.79.1
binutils               2.13.90.0.18
util-linux             2.11n
mount                  2.11n
module-init-tools      3.0-pre10
e2fsprogs              1.27
PPP                    2.4.1
nfs-utils              1.0
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.11
Modules Loaded         snd_pcm_oss snd_pcm snd_page_alloc snd_timer 
snd_mixer_oss snd ipt_LOG ipt_limit ipt_TCPMSS ipt_MASQUERADE ipt_state 
iptable_nat ip_conntrack iptable_filter ip_tables parport_pc lp parport 
af_packet ppp_async crc_ccitt ppp_generic slhc 8139too mii crc32 
ohci_hcd usbcore rtc unix

# cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 2
model name      : AMD Athlon(tm) Processor
stepping        : 1
cpu MHz         : 648.946
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov
pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips        : 1277.95

# lsmod
Module                  Size  Used by
snd_pcm_oss            61704  0
snd_pcm               103296  1 snd_pcm_oss
snd_page_alloc         12360  1 snd_pcm
snd_timer              26368  1 snd_pcm
snd_mixer_oss          19904  1 snd_pcm_oss
snd                    61444  4 snd_pcm_oss,snd_pcm,snd_timer,snd_mixer_oss
ipt_LOG                 6656  4
ipt_limit               3008  4
ipt_TCPMSS              4800  1
ipt_MASQUERADE          4224  2
ipt_state               2560  4
iptable_nat            24996  2 ipt_MASQUERADE
ip_conntrack           36036  3 ipt_MASQUERADE,ipt_state,iptable_nat
iptable_filter          3264  1
ip_tables              17872  7 
ipt_LOG,ipt_limit,ipt_TCPMSS,ipt_MASQUERADE,ipt_state,iptable_nat,iptable_filter
parport_pc             33824  1
lp                     10820  2
parport                41792  2 parport_pc,lp
af_packet              21700  4
ppp_async              11648  1
crc_ccitt               2432  1 ppp_async
ppp_generic            26444  5 ppp_async
slhc                    7808  1 ppp_generic
8139too                23680  0
mii                     5376  1 8139too
crc32                   4544  1 8139too
ohci_hcd               33280  0
usbcore               123860  3 ohci_hcd
rtc                    12488  0
unix                   27852  219

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
0170-0177 : ide1
01f0-01f7 : ide0
0376-0376 : ide1
0378-037a : parport0
037b-037f : parport0
03c0-03df : vga+
03f6-03f6 : ide0
0cf8-0cff : PCI conf1
5008-500b : ACPI timer
5010-5015 : ACPI CPU throttle
d000-d003 : 0000:00:00.0
d400-d4ff : 0000:00:08.0
   d400-d4ff : 8139too
d800-d87f : 0000:00:09.0
dc00-dc0f : 0000:00:09.1
e000-e0ff : 0000:00:0b.0
   e000-e0ff : 8139too
f000-f00f : 0000:00:07.1
   f000-f007 : ide0
   f008-f00f : ide1

# cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000cbfff : Video ROM
000f0000-000fffff : System ROM
00100000-17feffff : System RAM
   00100000-0026182a : Kernel code
   0026182b-0032853f : Kernel data
17ff0000-17ff2fff : ACPI Non-volatile Storage
17ff3000-17ffffff : ACPI Tables
d0000000-d7ffffff : 0000:00:00.0
d8000000-dfffffff : PCI Bus #01
   d8000000-dfffffff : 0000:01:05.0
e0000000-e1ffffff : PCI Bus #01
   e0000000-e0ffffff : 0000:01:05.0
e3000000-e300ffff : 0000:00:0a.0
e3010000-e30100ff : 0000:00:08.0
   e3010000-e30100ff : 8139too
e3011000-e3011fff : 0000:00:00.0
e3012000-e3012fff : 0000:00:07.4
   e3012000-e3012fff : ohci_hcd
e3013000-e30130ff : 0000:00:0b.0
   e3013000-e30130ff : 8139too
ffff0000-ffffffff : reserved

# lspci -vvv
00:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-751 [Irongate] 
System Controller (rev 25)
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
         Latency: 32
         Region 0: Memory at d0000000 (32-bit, prefetchable) [size=128M]
         Region 1: Memory at e3011000 (32-bit, prefetchable) [size=4K]
         Region 2: I/O ports at d000 [disabled] [size=4]
         Capabilities: [a0] AGP version 1.0
                 Status: RQ=15 SBA+ 64bit- FW- Rate=x1,x2
                 Command: RQ=0 SBA- AGP+ 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-751 [Irongate] AGP 
Bridge (rev 01) (prog-if 00 [Normal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32
         Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
         I/O behind bridge: 0000f000-00000fff
         Memory behind bridge: e0000000-e1ffffff
         Prefetchable memory behind bridge: d8000000-dfffffff
         BridgeCtl: Parity- SERR+ NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-756 [Viper] ISA 
(rev 01)
         Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0

00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-756 [Viper] IDE 
(rev 03) (prog-if 8a [Master SecP PriP])
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32
         Region 4: I/O ports at f000 [size=16]

00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-756 [Viper] ACPI (rev 03)
         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:07.4 USB Controller: Advanced Micro Devices [AMD] AMD-756 [Viper] USB 
(rev 06) (prog-if 10 [OHCI])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 16 (20000ns max), cache line size 08
         Interrupt: pin D routed to IRQ 11
         Region 0: Memory at e3012000 (32-bit, non-prefetchable) [size=4K]

00:08.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 
(rev 10)
         Subsystem: Realtek Semiconductor Co., Ltd. RT8139
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32 (8000ns min, 16000ns max)
         Interrupt: pin A routed to IRQ 10
         Region 0: I/O ports at d400 [size=256]
         Region 1: Memory at e3010000 (32-bit, non-prefetchable) [size=256]
         Expansion ROM at <unassigned> [disabled] [size=64K]
         Capabilities: [50] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1+,D2+,D3hot+,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 Multimedia audio controller: Fortemedia, Inc Xwave QS3000A 
[FM801] (rev b1)
         Subsystem: Fortemedia, Inc: Unknown device 1319
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32 (1000ns min, 10000ns max)
         Interrupt: pin A routed to IRQ 5
         Region 0: I/O ports at d800 [size=128]
         Capabilities: [dc] Power Management version 1
                 Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.1 Gameport controller: Fortemedia, Inc Xwave QS3000A [FM801 game 
port] (rev b1) (prog-if 10 [Extended])
         Subsystem: Fortemedia, Inc: Unknown device 1319
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32 (1000ns min, 10000ns max)
         Region 0: I/O ports at dc00 [size=16]
         Capabilities: [dc] Power Management version 1
                 Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA 
PME(D0-,D1+,D2-,D3hot+,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 Serial controller: Rockwell International HCF 56k 
Data/Fax/Voice/Spkp (w/Handset) Modem (rev 01) (prog-if 00 [8250])
         Subsystem: GVC Corporation IBM
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32
         Interrupt: pin A routed to IRQ 11
         Region 0: Memory at e3000000 (32-bit, non-prefetchable) [size=64K]
         Capabilities: [40] Power Management version 1
                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 
(rev 10)
         Subsystem: Realtek Semiconductor Co., Ltd. RT8139
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32 (8000ns min, 16000ns max)
         Interrupt: pin A routed to IRQ 11
         Region 0: I/O ports at e000 [size=256]
         Region 1: Memory at e3013000 (32-bit, non-prefetchable) [size=256]
         Capabilities: [50] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA 
PME(D0-,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:05.0 VGA compatible controller: nVidia Corporation NV11 (GeForce2 MX) 
(rev a1) (prog-if 00 [VGA])
         Subsystem: Elsa AG: Unknown device 0c60
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32 (1250ns min, 250ns max)
         Interrupt: pin A routed to IRQ 5
         Region 0: Memory at e0000000 (32-bit, non-prefetchable) [size=16M]
         Region 1: Memory at d8000000 (32-bit, prefetchable) [size=128M]
         Expansion ROM at <unassigned> [disabled] [size=64K]
         Capabilities: [60] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [44] AGP version 2.0
                 Status: RQ=31 SBA- 64bit- FW+ Rate=x1,x2
                 Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>


Any advice would, as usually, be very well come.

Geert

PS. my actual address is   g dot h dot p at s k y n e t dot be
