Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269506AbUI3Vlm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269506AbUI3Vlm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 17:41:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269563AbUI3Vlm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 17:41:42 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:48799 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S269506AbUI3Vk3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 17:40:29 -0400
Message-ID: <415C293D.6030903@comcast.net>
Date: Thu, 30 Sep 2004 15:41:49 +0000
From: "D. Stimits" <stimits@comcast.net>
Reply-To: stimits@comcast.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: kernel oops 2.6.8 SMP
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am not on the kernel mailing list, I would appreciate CC of replies.

I have a dual P2-450 on BX chipset, on occasion (daily) giving a kernel 
OOPS, sometimes fatal, sometimes not. The machine has had several 
processes running at all time, but rarely under heavy load. Three OOPS 
are included at the end of this email.

The machine is using an updated Fecora Core 2, with stock 2.6.8 kernel, 
SMP. The stock kernel for Fedora Core 2 also fails, so this is not 
limited to 2.6.8. This same machine under older Redhat 8 boot does not 
OOPS, although I could just be lucky on that.

The memory on this machine is questionable, though I believe it should 
be ok. The story is that while compiling kernels on Fedora Core 2 (but 
not Redhat 8) I had compile failures and sometimes outright lockups. I 
ran memtest86 and on the upper memory of 2 ram modules (256 MB in 2x128, 
it is mandatory to use matched pairs on this SMP board, I am unable to 
try just 1 by itself), all worked well for the first 6 to 8 hours of 
memtest86 tests. After this time I had random, rare memory failures but 
never twice at the same address (though always on the ram of the upper 
module). I went into the BIOS and set highest wait state on the memory, 
and after an entire day of testing could not get any memory failures. At 
this point I am able to compile kernels all day long without a compile 
failure (and without OOPS), but this of course does not mean memory is 
not suspect, but it gives me much more confidence ram is not at fault. 
Among the following OOPS messages (non-fatal) I need to find out if this 
might still be a ram problem, or if it is a true OOPS. The OOPS being 
shown are the first OOPS after a week or so running around 20 hours a 
day since installing the debug-compiled version of the kernel.

I have been unable to track any OOPS to doing anything in particular, 
quite often the OOPS is while the machine is idle (though of course 
things like anacron will run while it appears idle). FYI, PostgreSQL is 
used on this machine, but at the time of the postmaster failures the 
database was idle without anything connected to it.

The kernel OOPS is on a kernel with all debug information built into the 
kernel, including symbols, frame pointers, stack checks, so on. Thus I 
am not sending a ksymoops feed. Three OOPS that occurred back-to-back 
are being given here. Please let me know if there is anything else I can 
answer.

D. Stimits, stimits AT comcast DOT net
PS: All OOPS and info follows


---------------------------------------------------------------
/proc/version:
Linux version 2.6.8-1smp-dbg (root@thecook) (gcc version 3.3.3 20040412 
(Red Hat Linux 3.3.3-7)) #1 SMP Fri Sep 24 14:10:08 MDT 2004
---------------------------------------------------------------
cat /proc/modules:
# cat /proc/modules
snd_pcm_oss 47912 0 - Live 0xd09ee000
snd_pcm 88708 1 snd_pcm_oss, Live 0xd09d7000
snd_page_alloc 9096 1 snd_pcm, Live 0xd0a1e000
snd_timer 25092 1 snd_pcm, Live 0xd09cc000
snd_mixer_oss 16384 1 snd_pcm_oss, Live 0xd09c7000
snd 49508 4 snd_pcm_oss,snd_pcm,snd_timer,snd_mixer_oss, Live 0xd09b9000
soundcore 8032 1 snd, Live 0xd09b6000
md5 4352 1 - Live 0xd09d4000
ipv6 257572 24 - Live 0xd103f000
parport_pc 30784 1 - Live 0xd0975000
lp 9708 0 - Live 0xd0971000
parport 35912 2 parport_pc,lp, Live 0xd0967000
sunrpc 140772 1 - Live 0xd0981000
tulip 43424 0 - Live 0xd095b000
crc32 4352 1 tulip, Live 0xd097e000
e100 34944 0 - Live 0xd09a6000
mii 4352 1 e100, Live 0xd085d000
ipt_REJECT 5888 59 - Live 0xd08a6000
ipt_LOG 6272 27 - Live 0xd0861000
iptable_filter 2688 1 - Live 0xd0849000
ip_tables 17280 3 ipt_REJECT,ipt_LOG,iptable_filter, Live 0xd0843000
sg 34208 0 - Live 0xd089c000
microcode 6480 0 - Live 0xd0840000
dm_mod 50692 0 - Live 0xd088e000
uhci_hcd 29712 0 - Live 0xd0837000
ext3 103400 2 - Live 0xd08ad000
jbd 63384 1 ext3, Live 0xd084c000
aic7xxx 160696 5 - Live 0xd0865000
---------------------------------------------------------------
cat /proc/ioports:
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
0213-0213 : ISAPnP
0290-0297 : pnp 00:09
02e8-02ef : serial
0378-037a : parport0
0398-0399 : pnp 00:09
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial
0400-043f : 0000:00:07.3
0440-045f : 0000:00:07.3
04d0-04d1 : pnp 00:08
0a79-0a79 : isapnp write
0cf8-0cff : PCI conf1
d000-dfff : PCI Bus #01
e000-e0ff : 0000:00:12.0
   e000-e0ff : tulip
e400-e4ff : 0000:00:0e.0
e800-e8ff : 0000:00:0e.1
ef00-ef3f : 0000:00:10.0
   ef00-ef3f : e100
ef80-ef9f : 0000:00:07.2
ffa0-ffaf : 0000:00:07.1
   ffa0-ffa7 : ide0
---------------------------------------------------------------
# cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000cc7ff : Adapter ROM
000cc800-000cd7ff : Adapter ROM
000f0000-000fffff : System ROM
00100000-0fffffff : System RAM
   00100000-0030d74c : Kernel code
   0030d74d-003ec57f : Kernel data
dea00000-eeafffff : PCI Bus #01
   e4000000-e7ffffff : 0000:01:00.0
   e8000000-ebffffff : 0000:01:00.0
f0000000-f7ffffff : 0000:00:00.0
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ff500000-ff5fffff : PCI Bus #01
   ff5e0000-ff5fffff : 0000:01:00.0
ff900000-ff9fffff : 0000:00:10.0
   ff900000-ff9fffff : e100
ffafcc00-ffafcfff : 0000:00:12.0
   ffafcc00-ffafcfff : tulip
ffafd000-ffafdfff : 0000:00:10.0
   ffafd000-ffafdfff : e100
ffafe000-ffafefff : 0000:00:0e.0
   ffafe000-ffafefff : aic7xxx
ffaff000-ffafffff : 0000:00:0e.1
   ffaff000-ffafffff : aic7xxx
fffc0000-ffffffff : reserved

---------------------------------------------------------------
# cat scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 03 Lun: 00
   Vendor: SEAGATE  Model: ST39140W         Rev: 1281
   Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 04 Lun: 00
   Vendor: SEAGATE  Model: ST39173WC        Rev: 5698
   Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 05 Lun: 00
   Vendor: IBM      Model: DDRS-39130D      Rev: DC1B
   Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 08 Lun: 00
   Vendor: IBM      Model: DDRS-34560D      Rev: DC1B
   Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 09 Lun: 00
   Vendor: IBM      Model: DDRS-34560D      Rev: DC1B
   Type:   Direct-Access                    ANSI SCSI revision: 02

---------------------------------------------------------------
/proc/cpuinfo:
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 5
model name      : Pentium II (Deschutes)
stepping        : 2
cpu MHz         : 451.066
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 mmx fxsr
bogomips        : 888.83

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 5
model name      : Pentium II (Deschutes)
stepping        : 2
cpu MHz         : 451.066
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 mmx fxsr
bogomips        : 899.07
---------------------------------------------------------------
# lspci -vvv
00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge 
(rev 02)
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
         Latency: 64
         Region 0: Memory at f0000000 (32-bit, prefetchable)
         Capabilities: [a0] AGP version 1.0
                 Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- 
HTrans- 64bit- FW- AGP3- Rate=x1,x2
                 Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- 
FW- Rate=<none>

00:01.0 PCI bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge 
(rev 02) (prog-if 00 [Normal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 64
         Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
         I/O behind bridge: 0000d000-0000dfff
         Memory behind bridge: ff500000-ff5fffff
         Prefetchable memory behind bridge: dea00000-eeafffff
         Expansion ROM at 0000d000 [disabled] [size=4K]
         BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B+

00:07.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
         Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0

00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01) 
(prog-if 80 [Master])
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 64
         Region 4: I/O ports at ffa0 [size=16]

00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01) 
(prog-if 00 [UHCI])
         Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Interrupt: pin D routed to IRQ 0
         Region 4: I/O ports at ef80 [size=32]

00:07.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 02)
         Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Interrupt: pin ? routed to IRQ 9

00:0e.0 SCSI storage controller: Adaptec AHA-2940U/UW / AHA-39xx / 
AIC-7895 (rev 04)
         Subsystem: Adaptec AHA-2940U/2940UW Dual AHA-394xAU/AUW/AUWD 
AIC-7895B
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 64 (2000ns min, 2000ns max), Cache Line Size 08
         Interrupt: pin A routed to IRQ 11
         Region 0: I/O ports at e400 [disabled] [size=ffae0000]
         Region 1: Memory at ffafe000 (32-bit, non-prefetchable) [size=4K]
         Expansion ROM at 00010000 [disabled]
         Capabilities: [dc] Power Management version 1
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0e.1 SCSI storage controller: Adaptec AHA-2940U/UW / AHA-39xx / 
AIC-7895 (rev 04)
         Subsystem: Adaptec AHA-2940U/2940UW Dual AHA-394xAU/AUW/AUWD 
AIC-7895B
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 64 (2000ns min, 2000ns max), Cache Line Size 08
         Interrupt: pin B routed to IRQ 11
         Region 0: I/O ports at e800 [disabled]
         Region 1: Memory at ffaff000 (32-bit, non-prefetchable) [size=4K]
         Capabilities: [dc] Power Management version 1
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] 
(rev 08)
         Subsystem: Intel Corp. EtherExpress PRO/100+ Management Adapter
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 64 (2000ns min, 14000ns max), Cache Line Size 08
         Interrupt: pin A routed to IRQ 10
         Region 0: Memory at ffafd000 (32-bit, non-prefetchable) 
[size=ff800000]
         Region 1: I/O ports at ef00 [size=64]
         Region 2: Memory at ff900000 (32-bit, non-prefetchable) [size=1M]
         Expansion ROM at 00100000 [disabled]
         Capabilities: [dc] Power Management version 2
                 Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold-)
                 Status: D0 PME-Enable+ DSel=0 DScale=2 PME-

00:12.0 Ethernet controller: Linksys NC100 Network Everywhere Fast 
Ethernet 10/100 (rev 11)
         Subsystem: Linksys: Unknown device 0574
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 64 (16000ns min, 32000ns max), Cache Line Size 08
         Interrupt: pin A routed to IRQ 9
         Region 0: I/O ports at e000 [size=ffac0000]
         Region 1: Memory at ffafcc00 (32-bit, non-prefetchable) [size=1K]
         Expansion ROM at 00020000 [disabled]
         Capabilities: [c0] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=100mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 Display controller: 3DLabs GLINT R3 (rev 01)
         Subsystem: 3DLabs: Unknown device 0125
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 64 (48000ns min, 48000ns max)
         Interrupt: pin A routed to IRQ 10
         Region 0: Memory at ff5e0000 (32-bit, non-prefetchable) 
[size=ff5d0000]
         Region 1: Memory at e8000000 (32-bit, prefetchable) [size=64M]
         Region 2: Memory at e4000000 (32-bit, prefetchable) [size=64M]
         Expansion ROM at 00010000 [disabled]
         Capabilities: [4c] Power Management version 1
                 Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [40] AGP version 2.0
                 Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- 
HTrans- 64bit- FW- AGP3- Rate=x1
                 Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- 
FW- Rate=<none>
---------------------------------------------------------------


---------------------------------------------------------------
Sep 30 13:53:20 localhost kernel: Unable to handle kernel NULL pointer 
dereference at virtual address 00000004
Sep 30 13:53:20 localhost kernel:  printing eip:
Sep 30 13:53:20 localhost kernel: 00000004
Sep 30 13:53:20 localhost kernel: *pde = 00000000
Sep 30 13:53:20 localhost kernel: Oops: 0000 [#1]
Sep 30 13:53:20 localhost kernel: PREEMPT SMP DEBUG_PAGEALLOC
Sep 30 13:53:20 localhost kernel: Modules linked in: snd_pcm_oss snd_pcm 
snd_page_alloc snd_timer snd_mixer_oss snd soundcore md5 ipv6 parport_pc 
lp parport sunrpc tulip crc32 e100 mii ipt_REJECT ipt_LOG iptable_filter 
ip_tables sg microcode dm_mod uhci_hcd ext3 jbd aic7xxx
Sep 30 13:53:20 localhost kernel: CPU:    0
Sep 30 13:53:20 localhost kernel: EIP:    0060:[<00000004>]    Not tainted
Sep 30 13:53:20 localhost kernel: EFLAGS: 00010296   (2.6.8-1smp-dbg)
Sep 30 13:53:20 localhost kernel: EIP is at 0x4
Sep 30 13:53:20 localhost kernel: eax: c7d68ec0   ebx: 00000040   ecx: 
c017ab80   edx: c7ed3f50
Sep 30 13:53:21 localhost kernel: esi: 00000000   edi: 00000000   ebp: 
00000000   esp: c7ed3f14
Sep 30 13:53:21 localhost kernel: ds: 007b   es: 007b   ss: 0068
Sep 30 13:53:21 localhost kernel: Process postmaster (pid: 2666, 
threadinfo=c7ed2000 task=c7ed19b0)
Sep 30 13:53:21 localhost kernel: Stack: 00000145 00000050 c7ed2000 
cff34fec cff34fe8 cff34fe4 cff34ff4 cff34ff0
Sep 30 13:53:21 localhost kernel:        cff34fec 7fffffff 00000000 
c7ed3f50 c7ed3f8c c7ed3f90 00000007 c0179930
Sep 30 13:53:21 localhost kernel:        00000000 00000000 fffffff4 
00000004 00000000 cff34ff8 c7ed3fbc c017a0c8
Sep 30 13:53:21 localhost kernel: Call Trace:
Sep 30 13:53:21 localhost kernel:  [<c0108795>] show_stack+0x75/0x90
Sep 30 13:53:22 localhost kernel:  [<c01088f3>] show_registers+0x123/0x180
Sep 30 13:53:22 localhost kernel:  [<c0108a96>] die+0xb6/0x170
Sep 30 13:53:22 localhost kernel:  [<c0118bd0>] do_page_fault+0x1e0/0x59d
Sep 30 13:53:22 localhost kernel:  [<c01083fd>] error_code+0x2d/0x40
Sep 30 13:53:22 localhost kernel: Code:  Bad EIP value.
-----------------------------------

Sep 30 13:53:22 localhost kernel:  <1>Unable to handle kernel NULL 
pointer dereference at virtual address 00000004
Sep 30 13:53:22 localhost kernel:  printing eip:
Sep 30 13:53:22 localhost kernel: 00000004
Sep 30 13:53:23 localhost kernel: *pde = 00000000
Sep 30 13:53:23 localhost kernel: Oops: 0000 [#2]
Sep 30 13:53:23 localhost kernel: PREEMPT SMP DEBUG_PAGEALLOC
Sep 30 13:53:23 localhost kernel: Modules linked in: snd_pcm_oss snd_pcm 
snd_page_alloc snd_timer snd_mixer_oss snd soundcore md5 ipv6 parport_pc 
lp parport sunrpc tulip crc32 e100 mii ipt_REJECT ipt_LOG iptable_filter 
ip_tables sg microcode dm_mod uhci_hcd ext3 jbd aic7xxx
Sep 30 13:53:23 localhost kernel: CPU:    1
Sep 30 13:53:23 localhost kernel: EIP:    0060:[<00000004>]    Not tainted
Sep 30 13:53:23 localhost kernel: EFLAGS: 00010296   (2.6.8-1smp-dbg)
Sep 30 13:53:23 localhost kernel: EIP is at 0x4
Sep 30 13:53:23 localhost kernel: eax: cb8d31a0   ebx: 00000040   ecx: 
c017ab80   edx: cbf5df50
Sep 30 13:53:23 localhost kernel: esi: 00000000   edi: 00000000   ebp: 
00000000   esp: cbf5df14
Sep 30 13:53:23 localhost kernel: ds: 007b   es: 007b   ss: 0068
Sep 30 13:53:23 localhost kernel: Process postmaster (pid: 3937, 
threadinfo=cbf5c000 task=cb6528a0)
Sep 30 13:53:23 localhost kernel: Stack: 00000145 00000050 cbf5c000 
ce2751ec ce2751e8 ce2751e4 ce2751f4 ce2751f0
Sep 30 13:53:23 localhost kernel:        ce2751ec 7fffffff 00000000 
cbf5df50 cbf5df8c cbf5df90 00000007 c0179930
Sep 30 13:53:24 localhost kernel:        00000000 00000000 fffffff4 
00000004 00000000 ce2751f8 cbf5dfbc c017a0c8
Sep 30 13:53:24 localhost kernel: Call Trace:
Sep 30 13:53:24 localhost kernel:  [<c0108795>] show_stack+0x75/0x90
Sep 30 13:53:24 localhost kernel:  [<c01088f3>] show_registers+0x123/0x180
Sep 30 13:53:24 localhost kernel:  [<c0108a96>] die+0xb6/0x170
Sep 30 13:53:24 localhost kernel:  [<c0118bd0>] do_page_fault+0x1e0/0x59d
Sep 30 13:53:24 localhost kernel:  [<c01083fd>] error_code+0x2d/0x40
Sep 30 13:53:24 localhost kernel: Code:  Bad EIP value.
-----------------------------------

Sep 30 13:56:15 localhost kernel:  <1>Unable to handle kernel paging 
request at virtual address 36376365
Sep 30 13:56:15 localhost kernel:  printing eip:
Sep 30 13:56:15 localhost kernel: c0190b5b
Sep 30 13:56:15 localhost kernel: *pde = 00000000
Sep 30 13:56:15 localhost kernel: Oops: 0002 [#3]
Sep 30 13:56:15 localhost kernel: PREEMPT SMP DEBUG_PAGEALLOC
Sep 30 13:56:15 localhost kernel: Modules linked in: snd_pcm_oss snd_pcm 
snd_page_alloc snd_timer snd_mixer_oss snd soundcore md5 ipv6 parport_pc 
lp parport sunrpc tulip crc32 e100 mii ipt_REJECT ipt_LOG iptable_filter 
ip_tables sg microcode dm_mod uhci_hcd ext3 jbd aic7xxx
Sep 30 13:56:15 localhost kernel: CPU:    0
Sep 30 13:56:15 localhost kernel: EIP:    0060:[<c0190b5b>]    Not tainted
Sep 30 13:56:15 localhost kernel: EFLAGS: 00010287   (2.6.8-1smp-dbg)
Sep 30 13:56:15 localhost kernel: EIP is at eventpoll_release_file+0x4b/0xd0
Sep 30 13:56:15 localhost kernel: eax: 35343200   ebx: 37343664   ecx: 
c7648ea8   edx: 36376365
Sep 30 13:56:15 localhost kernel: esi: 00000000   edi: c7648e68   ebp: 
c7badf8c   esp: c7badf7c
Sep 30 13:56:15 localhost kernel: ds: 007b   es: 007b   ss: 0068
Sep 30 13:56:15 localhost kernel: Process anacron (pid: 2713, 
threadinfo=c7bac000 task=c706ba10)
Sep 30 13:56:15 localhost kernel: Stack: c7d68ea8 c7d68e20 00000000 
cff7cf80 c7badfa8 c0165217 c79f34a4 c742abe0
Sep 30 13:56:15 localhost kernel:        c7d68e20 00000000 cdae9c80 
c7badfbc c0163846 00000004 00000000 00a800fc
Sep 30 13:56:15 localhost kernel:        c7bac000 c0107289 00000004 
00000009 00000004 00000000 00a800fc bffffd18
Sep 30 13:56:15 localhost kernel: Call Trace:
Sep 30 13:56:15 localhost kernel:  [<c0108795>] show_stack+0x75/0x90
Sep 30 13:56:15 localhost kernel:  [<c01088f3>] show_registers+0x123/0x180
Sep 30 13:56:15 localhost kernel:  [<c0108a96>] die+0xb6/0x170
Sep 30 13:56:15 localhost kernel:  [<c0118bd0>] do_page_fault+0x1e0/0x59d
Sep 30 13:56:15 localhost kernel:  [<c01083fd>] error_code+0x2d/0x40
Sep 30 13:56:15 localhost kernel:  [<c0165217>] __fput+0x137/0x140
Sep 30 13:56:15 localhost kernel:  [<c0163846>] filp_close+0x46/0x70
Sep 30 13:56:15 localhost kernel:  [<c0107289>] sysenter_past_esp+0x52/0x79
Sep 30 13:56:15 localhost kernel: Code: 89 02 89 50 04 c7 01 00 01 10 00 
c7 41 04 00 02 20 00 8d 73
