Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265215AbUBJDBm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 22:01:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265326AbUBJDBm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 22:01:42 -0500
Received: from awork027051.netvigator.com ([203.198.6.51]:23565 "HELO
	imsmq03.netvigator.com") by vger.kernel.org with SMTP
	id S265215AbUBJDB1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 22:01:27 -0500
Message-ID: <4028497F.5020005@janich.com>
Date: Tue, 10 Feb 2004 11:01:19 +0800
From: Michael Janich <michael@janich.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: de-de, en-gb, en
MIME-Version: 1.0
To: jmorris@redhat.com, davem@redhat.com, linux-kernel@vger.kernel.org
CC: axelboldt <axelboldt@yahoo.com>
Subject: kernel 2.6.2 hang with crypto-partition
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Crypto Team,

my kernel 2.6.2 hangs, when I do this:

./losetup -e aes-cbc-256 /dev/loop0 /dev/hdb1
mkfs /dev/loop0

Every time. Even with blowfish instead of AES.

I use the util-linux-2.12 (without "pre") and with the 
losetup-combined.patch (495 lines)
from http://www.stwing.org/~sluskyb/util-linux/losetup-combined.patch

Then I've tried mkfs with the parameter 10000000 as in:
    mkfs /dev/loop0 10000000

and it does NOT crash. But with the parameter

    mkfs /dev/loop0 20000000

It again hangs. Hope that helps...

BTW: I've tried the same earlier (2.6.0 and some test versions): same 
result.



Here is all the info that you may need:

[1.] One line summary of the problem: 
kernel 2.6.2 hang with crypto-partition
[2.] Full description of the problem/report:
see above
[3.] Keywords (i.e., modules, networking, kernel):
crypto api, crypto loop
[4.] Kernel version (from /proc/version):
Linux version 2.6.2 (root@justine.netvigator.com) (gcc version 3.3.2 20031022 (Red Hat Linux 3.3.2-1)) #3 SMP Thu Feb 5 13:43:15 HKT 2004
[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)
None. Computer hangs.
[6.] A small shell script or example program which triggers the
     problem (if possible)
see above
[7.] Environment
fedora-1. 2 AMD 2000+ CPUs, SMP kernel 2.6.2, 2 IDE harddisks (120G each), tyan main board
[7.1.] Software (add the output of the ver_linux script here)

Linux justine.netvigator.com 2.6.2 #3 SMP Thu Feb 5 13:43:15 HKT 2004 i686 athlon i386 GNU/Linux

Gnu C                  3.3.2
Gnu make               3.79.1
util-linux             2.11y  (the above used one is 2.12 with patch)
mount                  2.11y  ( " )
module-init-tools      2.4.25
e2fsprogs              1.34
reiserfsprogs          3.6.8
quota-tools            3.06.
PPP                    2.4.1
isdn4k-utils           3.3
nfs-utils              1.0.6
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 2.0.17
Net-tools              1.60
Kbd                    1.08
Sh-utils               5.0
Modules Loaded         blowfish crypto_null usblp snd_usb_audio pwc audio videodev sbp2 dv1394 usb_storage ohci_hcd ehci_hcd sd_mod snd_pcm_oss snd_mixer_oss snd_emu10k1 snd_rawmidi snd_pcm snd_timer snd_seq_device snd_ac97_codec snd_page_alloc snd_util_mem snd_hwdep snd eeprom i2c_sensor i2c_amd756 i2c_core ac97_codec tekram irda isofs zlib_inflate udf sha256 aes cryptoloop loop raw1394 video1394 ppp_synctty ppp_async pppoe pppox ppp_generic slhc 3c59x sg scsi_mod parport_pc parport ohci1394 ieee1394 ntfs nls_utf8 nls_cp437 vfat fat hid thermal processor fan button

[7.2.] Processor information (from /proc/cpuinfo):
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 8
model name      : AMD Athlon(tm) MP 2000+
stepping        : 1
cpu MHz         : 1667.062
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse syscall mp mmxext 3dnowext 3dnow
bogomips        : 3276.80

processor       : 1
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 8
model name      : AMD Athlon(tm) Processor
stepping        : 1
cpu MHz         : 1667.062
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse syscall mp mmxext 3dnowext 3dnow
bogomips        : 3325.95

[7.3.] Module information (from /proc/modules):
blowfish 11520 0 - Live 0xf8b97000
crypto_null 4160 0 - Live 0xf8b8f000
usblp 15488 0 - Live 0xf8b60000
snd_usb_audio 71872 0 - Live 0xf8b9d000
pwc 53680 0 - Live 0xf8b69000
audio 50688 0 - Live 0xf8b78000
videodev 11904 1 pwc, Live 0xf8b65000
sbp2 26824 0 - Live 0xf8b51000
dv1394 22660 0 - Live 0xf8b59000
usb_storage 44096 0 - Live 0xf8a9d000
ohci_hcd 32256 0 - Live 0xf8b37000
ehci_hcd 39364 0 - Live 0xf8b2c000
sd_mod 17056 0 - Live 0xf8a67000
snd_pcm_oss 65252 0 - Live 0xf8b40000
snd_mixer_oss 23616 1 snd_pcm_oss, Live 0xf89f5000
snd_emu10k1 105732 0 - Live 0xf8aab000
snd_rawmidi 29536 2 snd_usb_audio,snd_emu10k1, Live 0xf8a4d000
snd_pcm 113632 3 snd_usb_audio,snd_pcm_oss,snd_emu10k1, Live 0xf8a6f000
snd_timer 30788 1 snd_pcm, Live 0xf8a44000
snd_seq_device 11080 2 snd_emu10k1,snd_rawmidi, Live 0xf89e9000
snd_ac97_codec 58436 1 snd_emu10k1, Live 0xf8a34000
snd_page_alloc 14532 2 snd_emu10k1,snd_pcm, Live 0xf89d6000
snd_util_mem 7104 1 snd_emu10k1, Live 0xf89d0000
snd_hwdep 12704 1 snd_emu10k1, Live 0xf89df000
snd 65796 11 snd_usb_audio,snd_pcm_oss,snd_mixer_oss,snd_emu10k1,snd_rawmidi,snd_pcm,snd_timer,snd_seq_device,snd_ac97_codec,snd_util_mem,snd_hwdep, Live 0xf8a22000
eeprom 9736 0 - Live 0xf89db000
i2c_sensor 4992 1 eeprom, Live 0xf89d3000
i2c_amd756 7748 0 - Live 0xf880a000
i2c_core 25540 3 eeprom,i2c_sensor,i2c_amd756, Live 0xf898d000
ac97_codec 21068 0 - Live 0xf89a0000
tekram 5376 0 - Live 0xf898a000
irda 147132 1 tekram, Live 0xf89fd000
isofs 37628 0 - Live 0xf8995000
zlib_inflate 24320 1 isofs, Live 0xf8963000
udf 102916 0 - Live 0xf89a8000
sha256 15232 0 - Live 0xf8985000
aes 33280 0 - Live 0xf8971000
cryptoloop 5568 0 - Live 0xf8939000
loop 20040 1 cryptoloop, Live 0xf88a1000
raw1394 32740 0 - Live 0xf897c000
video1394 20932 0 - Live 0xf896a000
ppp_synctty 11840 0 - Live 0xf8899000
ppp_async 14720 1 - Live 0xf88a7000
pppoe 17088 0 - Live 0xf895d000
pppox 5640 1 pppoe, Live 0xf8877000
ppp_generic 33808 8 ppp_synctty,ppp_async,pppoe,pppox, Live 0xf8953000
slhc 9664 1 ppp_generic, Live 0xf889d000
3c59x 40104 0 - Live 0xf892e000
sg 36312 0 - Live 0xf8924000
scsi_mod 81764 4 sbp2,usb_storage,sd_mod,sg, Live 0xf893e000
parport_pc 28800 0 - Live 0xf891b000
parport 45608 1 parport_pc, Live 0xf88f7000
ohci1394 38020 2 dv1394,video1394, Live 0xf88ec000
ieee1394 83568 5 sbp2,dv1394,raw1394,video1394,ohci1394, Live 0xf8905000
ntfs 119184 1 - Live 0xf88ac000
nls_utf8 3968 2 - Live 0xf880d000
nls_cp437 7616 1 - Live 0xf886b000
vfat 17344 1 - Live 0xf8871000
fat 50336 1 vfat, Live 0xf887a000
hid 27008 0 - Live 0xf8816000
thermal 21456 0 - Live 0xf8825000
processor 23152 1 thermal, Live 0xf881e000
fan 7372 0 - Live 0xf8813000
button 9944 0 - Live 0xf880f000

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial
0cf8-0cff : PCI conf1
1010-1013 : 0000:00:00.0
2000-2fff : PCI Bus #02
  2000-207f : 0000:02:08.0
    2000-207f : 0000:02:08.0
  2080-209f : 0000:02:07.0
    2080-209f : EMU10K1
  20a0-20a7 : 0000:02:07.1
80e0-80ef : amd756-smbus
f000-f00f : 0000:00:07.1
  f000-f007 : ide0
  f008-f00f : ide1
----
00000000-0009f7ff : System RAM
0009f800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c9000-000c97ff : Extension ROM
000e0000-000effff : Extension ROM
000f0000-000fffff : System ROM
00100000-3feeffff : System RAM
  00100000-002c2200 : Kernel code
  002c2201-00396b3f : Kernel data
3fef0000-3fefefff : ACPI Tables
3feff000-3fefffff : ACPI Non-volatile Storage
3ff00000-3ff7ffff : System RAM
3ff80000-3fffffff : reserved
e2000000-e20fffff : PCI Bus #01
  e2000000-e2001fff : 0000:01:05.0
e2100000-e21fffff : PCI Bus #02
  e2100000-e2100fff : 0000:02:00.0
    e2100000-e2100fff : ohci_hcd
  e2101000-e2101fff : 0000:02:06.0
    e2101000-e2101fff : ohci_hcd
  e2102000-e2102fff : 0000:02:06.1
    e2102000-e2102fff : ohci_hcd
  e2103000-e2103fff : 0000:02:06.2
    e2103000-e2103fff : ohci_hcd
  e2104000-e21047ff : 0000:02:06.4
    e2104000-e21047ff : ohci1394
  e2104800-e21048ff : 0000:02:06.3
    e2104800-e21048ff : ehci_hcd
  e2104c00-e2104c7f : 0000:02:08.0
e2400000-e2400fff : 0000:00:00.0
e8000000-efffffff : 0000:00:00.0
f0000000-f7ffffff : PCI Bus #01
  f0000000-f7ffffff : 0000:01:05.0
f8000000-fbffffff : PCI Bus #02
  f8000000-fbffffff : 0000:02:04.0
fec00000-fec03fff : reserved
fee00000-fee00fff : reserved
fff80000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)
0:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] System Controller (rev 11)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 32
        Region 0: Memory at e8000000 (32-bit, prefetchable) [size=128M]
        Region 1: Memory at e2400000 (32-bit, prefetchable) [size=4K]
        Region 2: I/O ports at 1010 [disabled] [size=4]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=15 SBA+ 64bit- FW- Rate=x1,x2,x4
                Command: RQ=0 SBA+ AGP+ 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] AGP Bridge (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 99
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: e2000000-e20fffff
        Prefetchable memory behind bridge: f0000000-f7ffffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] ISA (rev 05)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-768 [Opus] IDE (rev 04) (prog-if 8a [Master SecP PriP])
        Subsystem: Advanced Micro Devices [AMD] AMD-768 [Opus] IDE
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Region 4: I/O ports at f000 [size=16]

00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] ACPI (rev 03)
        Subsystem: Advanced Micro Devices [AMD] AMD-768 [Opus] ACPI
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:10.0 PCI bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] PCI (rev 05) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 64
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=168
        I/O behind bridge: 00002000-00002fff
        Memory behind bridge: e2100000-e21fffff
        Prefetchable memory behind bridge: f8000000-fbffffff
        BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-

01:05.0 VGA compatible controller: Matrox Graphics, Inc. MGA Parhelia AGP (rev 03) (prog-if 00 [VGA])
        Subsystem: Matrox Graphics, Inc. Parhelia 128Mb
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 128 (4000ns min, 8000ns max), cache line size 10
        Interrupt: pin A routed to IRQ 18
        Region 0: Memory at f0000000 (32-bit, prefetchable) [size=128M]
        Region 1: Memory at e2000000 (32-bit, non-prefetchable) [size=8K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [f0] AGP version 2.0
                Status: RQ=31 SBA+ 64bit- FW+ Rate=x1,x2,x4
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

02:00.0 USB Controller: Advanced Micro Devices [AMD] AMD-768 [Opus] USB (rev 07) (prog-if 10 [OHCI])
        Subsystem: Advanced Micro Devices [AMD] AMD-768 [Opus] USB
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR+
        Latency: 64 (20000ns max)
        Interrupt: pin D routed to IRQ 19
        Region 0: Memory at e2100000 (32-bit, non-prefetchable) [size=4K]

02:04.0 Multimedia video controller: Internext Compression Inc iTVC15 MPEG-2 Encoder (rev 01)
        Subsystem: Hauppauge computer works Inc.: Unknown device 4001
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (2000ns max), cache line size 10
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:06.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03) (prog-if 10 [OHCI])
        Subsystem: ALi Corporation USB 1.1 Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (20000ns max), cache line size 10
        Interrupt: pin B routed to IRQ 19
        Region 0: Memory at e2101000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1+,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:06.1 USB Controller: ALi Corporation USB 1.1 Controller (rev 03) (prog-if 10 [OHCI])
        Subsystem: ALi Corporation USB 1.1 Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (20000ns max), cache line size 10
        Interrupt: pin B routed to IRQ 19
        Region 0: Memory at e2102000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1+,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME+

02:06.2 USB Controller: ALi Corporation USB 1.1 Controller (rev 03) (prog-if 10 [OHCI])
        Subsystem: ALi Corporation USB 1.1 Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (20000ns max), cache line size 10
        Interrupt: pin B routed to IRQ 19
        Region 0: Memory at e2103000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1+,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:06.3 USB Controller: ALi Corporation USB 2.0 Controller (rev 01) (prog-if 20 [EHCI])
        Subsystem: ALi Corporation USB 2.0 Controller
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (20000ns max), cache line size 10
        Interrupt: pin A routed to IRQ 18
        Region 0: Memory at e2104800 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME+
        Capabilities: [58] #0a [2090]

02:06.4 FireWire (IEEE 1394): ALi Corporation M5253 P1394 OHCI 1.1 Controller (prog-if 10 [OHCI])
        Subsystem: ALi Corporation M5253 P1394 OHCI 1.1 Controller
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (750ns max), cache line size 10
        Interrupt: pin C routed to IRQ 16
        Region 0: Memory at e2104000 (32-bit, non-prefetchable) [size=2K]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME+

02:07.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 08)
        Subsystem: Creative Labs CT4832 SBLive! Value
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (500ns min, 5000ns max)
        Interrupt: pin A routed to IRQ 19
        Region 0: I/O ports at 2080 [size=32]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:07.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 08)
        Subsystem: Creative Labs Gameport Joystick
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Region 0: I/O ports at 20a0 [size=8]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:08.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] (rev 78)
        Subsystem: Tyan Computer: Unknown device 2466
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 80 (2500ns min, 2500ns max), cache line size 10
        Interrupt: pin A routed to IRQ 19
        Region 0: I/O ports at 2000 [size=128]
        Region 1: Memory at e2104c00 (32-bit, non-prefetchable) [size=128]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-


[7.6.] SCSI information (from /proc/scsi/scsi)
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor:          Model:                  Rev:
  Type:   Direct-Access                    ANSI SCSI revision: 02

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):
none.
[X.] Other notes, patches, fixes, workarounds:

yes, I use the util-linux-2.12 (without "pre") and with the 
losetup-combined.patch (495 lines)


