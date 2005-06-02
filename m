Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261275AbVFBA46@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261275AbVFBA46 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 20:56:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261323AbVFBA46
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 20:56:58 -0400
Received: from host-148-244-76-242.block.alestra.net.mx ([148.244.76.242]:5606
	"EHLO gr13v0u5.icontrol.com.mx") by vger.kernel.org with ESMTP
	id S261275AbVFBAzN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 20:55:13 -0400
Subject: PROBLEM: doing a dd to a dbfile
From: "Ing." =?ISO-8859-1?Q?Ra=FAl?= Alvarez Aguileta 
	<l0rd4gu1@icontrol.com.mx>
Reply-To: l0rd4gu1@icontrol.com.mx
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Red de Control Corporativo
Date: Wed, 01 Jun 2005 19:59:59 -0500
Message-Id: <1117673999.28282.2.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I've a corruption problem with one innodb file, when i'm trying to
recover a corrupted file (it's filled with no data at byte 524288+, but
it have valid info later [aprox 4mb ahead] ) with:

# dd if=/dev/zero of=ibdata1 bs=1 seek=524288 count=4194304 conv=notrunc

the command ends dumping the folllowing message:

output from /var/log/messages
---->
Jun  1 18:43:07 g4nd4lf Kernel BUG at file:534
Jun  1 18:43:07 g4nd4lf invalid operand: 0000 [1] SMP
Jun  1 18:43:07 g4nd4lf CPU 0
Jun  1 18:43:07 g4nd4lf Modules linked in: ipt_LOG ipt_state
iptable_filter ip_tables ip_conntrack_tftp ip_conntrack_irc
ip_conntrack_ftp ip_conntrack_amanda ip_conntrack amd74xx sd_mod aic79xx
mptctl mptscsih mptbase sata_sx4 sata_promise libata usb_storage
ide_core scsi_mod ohci_hcd uhci_hcd ehci_hcd usbcore
Jun  1 18:43:07 g4nd4lf Pid: 8993, comm: dd Not tainted 2.6.11-gentoo-r9
Jun  1 18:43:07 g4nd4lf RIP: 0010:[<ffffffff801a9372>]
<ffffffff801a9372>{reiserfs_file_write+5298}
Jun  1 18:43:07 g4nd4lf RSP: 0018:ffff81007c273ba8  EFLAGS: 00010246
Jun  1 18:43:08 g4nd4lf RAX: 0000000001000020 RBX: 0000000000000000 RCX:
0000000000000001
Jun  1 18:43:08 g4nd4lf RDX: ffff810002b04038 RSI: ffff81007c26e670 RDI:
ffff81007c273d98
Jun  1 18:43:08 g4nd4lf RBP: ffff81007e8bbdf0 R08: 0000000000000000 R09:
ffff810002c13c80
Jun  1 18:43:08 g4nd4lf R10: ffff81007fdd8ec0 R11: ffff81007e8bbdf0 R12:
0000000000000001
Jun  1 18:43:08 g4nd4lf R13: 0000000000000000 R14: ffff81007c26e670 R15:
ffff81007e8c0678
Jun  1 18:43:08 g4nd4lf FS:  00002aaaaade7b00(0000)
GS:ffffffff803ed880(0000) knlGS:0000000000000000
Jun  1 18:43:08 g4nd4lf CS:  0010 DS: 0000 ES: 0000 CR0:
000000008005003b
Jun  1 18:43:08 g4nd4lf CR2: 00002aaaaac4d3e0 CR3: 000000007c267000 CR4:
00000000000006e0
Jun  1 18:43:08 g4nd4lf Process dd (pid: 8993, threadinfo
ffff81007c272000, task ffff81007f6fa1b0)
Jun  1 18:43:08 g4nd4lf Stack: 0000000000000286 ffff81000000d680
0000000000000000 ffff81007c26e730
Jun  1 18:43:08 g4nd4lf 0000000100000000 000000000008cfff
00000000000080d2 0000000000000000
Jun  1 18:43:08 g4nd4lf 0000000000000000 0000000000000001
Jun  1 18:43:08 g4nd4lf Call Trace:<ffffffff80145f9e>{buffered_rmqueue
+654} <ffffffff801527ab>{do_no_page+939}
Jun  1 18:43:08 g4nd4lf <ffffffff8010de4d>{error_exit+0}
<ffffffff8018b88f>{inotify_inode_queue_event+47}
Jun  1 18:43:08 g4nd4lf <ffffffff801f1160>{read_zero+480}
<ffffffff80164669>{vfs_write+233}
Jun  1 18:43:08 g4nd4lf <ffffffff801647f3>{sys_write+83}
<ffffffff8010d44a>{system_call+126}
Jun  1 18:43:08 g4nd4lf
Jun  1 18:43:08 g4nd4lf
Jun  1 18:43:08 g4nd4lf Code: 0f 0b 8b f1 2d 80 ff ff ff ff 16 02 8b 02
4c 8b 42 10 f6 c4
Jun  1 18:43:08 g4nd4lf RIP <ffffffff801a9372>{reiserfs_file_write+5298}
RSP <ffff81007c273ba8>
<----

# sh /usr/src/linux/scripts/ver_linux
---->
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux g4nd4lf 2.6.11-gentoo-r9 #1 SMP Wed May 18 07:53:38 CDT 2005
x86_64 AMD Opteron(tm) Processor 250 AuthenticAMD GNU/Linux

Gnu C                  3.4.3
Gnu make               3.80
binutils               2.15.92.0.2
util-linux             2.12i
mount                  2.12i
module-init-tools      3.0
e2fsprogs              1.35
reiserfsprogs          3.6.19
reiser4progs           line
Linux C Library        2.3.4
Dynamic linker (ldd)   2.3.4
Procps                 3.2.5
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1
udev                   045

Modules Loaded         ipt_LOG ipt_state iptable_filter ip_tables
ip_conntrack_tftp ip_conntrack_irc ip_conntrack_ftp
ip_conntrack_amanda ip_conntrack amd74xx sd_mod aic79xx mptctl
mptscsih mptbase sata_sx4 sata_promise libata usb_storage ide_core
scsi_mod ohci_hcd uhci_hcd ehci_hcd usbcore
<----

# cat /proc/version
Linux version 2.6.11-gentoo-r9 (mailto:root@g4nd4lf) (gcc version 3.4.3
20041125 (Gentoo Linux 3.4.3-r1, ssp-3.4.3-0, pie-8.7.7)) #1 SMP Wed May
1807:53:38 CDT 2005

# cat /proc/cpuinfo

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 5
model name      : AMD Opteron(tm) Processor 250
stepping        : 10
cpu MHz         : 2392.943
cache size      : 1024 KB
physical id     : 255
siblings        : 1
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush mmx fxsr sse sse2 pni syscall nx mmxext lm
3dnowext 3dnow
bogomips        : 4734.97
TLB size        : 1024 4K pages
clflush size    : 64
cache_alignment : 64
address sizes   : 40 bits physical, 48 bits virtual
power management: ts fid vid ttp


processor       : 1
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 5
model name      : AMD Opteron(tm) Processor 250
stepping        : 10
cpu MHz         : 2392.943
cache size      : 1024 KB
physical id     : 255
siblings        : 1
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush mmx fxsr sse sse2 pni syscall nx mmxext lm
3dnowext 3dnow
bogomips        : 4784.12
TLB size        : 1024 4K pages
clflush size    : 64
cache_alignment : 64
address sizes   : 40 bits physical, 48 bits virtual
power management: ts fid vid ttp

# cat /proc/modules

ipt_state 2752 24 - Live 0xffffffff88156000
iptable_filter 4032 1 - Live 0xffffffff88154000
ip_tables 24640 3 ipt_LOG,ipt_state,iptable_filter, Live
0xffffffff8814c000
ip_conntrack_tftp 5552 0 - Live 0xffffffff88149000
ip_conntrack_irc 73520 0 - Live 0xffffffff88136000
ip_conntrack_ftp 74416 0 - Live 0xffffffff88122000
ip_conntrack_amanda 71520 0 - Live 0xffffffff8810f000
ip_conntrack 58428 5
ipt_state,ip_conntrack_tftp,ip_conntrack_irc,ip_conntrack_ftp,ip_conntrack_amanda,
Live 0xffffffff880ff000
amd74xx 14128 0 [permanent], Live 0xffffffff880fa000
sd_mod 18240 3 - Live 0xffffffff880f4000
aic79xx 194428 0 - Live 0xffffffff880c3000
mptctl 26656 0 - Live 0xffffffff880bb000
mptscsih 37876 0 - Live 0xffffffff880b0000
mptbase 44512 2 mptctl,mptscsih, Live 0xffffffff880a4000
sata_sx4 15300 0 - Live 0xffffffff8809f000
sata_promise 12676 0 - Live 0xffffffff8809a000
libata 50696 2 sata_sx4,sata_promise, Live 0xffffffff8808c000
usb_storage 72064 0 - Live 0xffffffff88079000
ide_core 143936 2 amd74xx,usb_storage, Live 0xffffffff88054000
scsi_mod 102480 7
sd_mod,aic79xx,mptscsih,sata_sx4,sata_promise,libata,usb_storage, Live
0xffffffff88039000
ohci_hcd 19464 0 - Live 0xffffffff88033000
uhci_hcd 32736 0 - Live 0xffffffff8802a000
ehci_hcd 32776 0 - Live 0xffffffff88020000
usbcore 126480 5 usb_storage,ohci_hcd,uhci_hcd,ehci_hcd, Live
0xffffffff88000000

# cat /proc/ioports

0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
0376-0376 : ide1
03c0-03df : vesafb
03f8-03ff : serial
0cf8-0cff : PCI conf1
1020-102f : 0000:00:07.1
 1020-1027 : ide0
 1028-102f : ide1
2000-2fff : PCI Bus #01
 2000-20ff : 0000:01:05.0
 2400-240f : 0000:01:06.0
 2410-2413 : 0000:01:06.0
 2414-2417 : 0000:01:06.0
 2418-241f : 0000:01:06.0
 2420-2427 : 0000:01:06.0
3000-3fff : PCI Bus #02
 3000-30ff : 0000:02:02.0
8000-8003 : PM1a_EVT_BLK
8004-8005 : PM1a_CNT_BLK
8008-800b : PM_TMR
8020-8023 : GPE0_BLK
80b0-80b7 : GPE1_BLK

# cat /proc/iomem

0009ac00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000c97ff : Adapter ROM
000c9800-000cafff : Adapter ROM
000cb000-000cefff : Adapter ROM
000f0000-000fffff : System ROM
00100000-7ff6ffff : System RAM
 00100000-002cb3be : Kernel code
 002cb3bf-003b011f : Kernel data
7ff70000-7ff7afff : ACPI Tables
7ff7b000-7ff7ffff : ACPI Non-volatile Storage
7ff80000-7fffffff : reserved
fc000000-fc000fff : 0000:00:0a.1
fc001000-fc001fff : 0000:00:0b.1
fc100000-fdffffff : PCI Bus #01
 fc100000-fc100fff : 0000:01:00.0
   fc100000-fc100fff : ohci_hcd
 fc101000-fc101fff : 0000:01:00.1
   fc101000-fc101fff : ohci_hcd
 fc102000-fc102fff : 0000:01:05.0
 fc103000-fc1031ff : 0000:01:06.0
 fd000000-fdffffff : 0000:01:05.0
   fd000000-fd7effff : vesafb
fe000000-fe0fffff : PCI Bus #02
 fe000000-fe00ffff : 0000:02:01.0
   fe000000-fe00ffff : tg3
 fe010000-fe01ffff : 0000:02:01.0
   fe010000-fe01ffff : tg3
 fe020000-fe02ffff : 0000:02:01.1
   fe020000-fe02ffff : tg3
 fe030000-fe03ffff : 0000:02:01.1
   fe030000-fe03ffff : tg3
 fe040000-fe04ffff : 0000:02:02.0
 fe050000-fe05ffff : 0000:02:02.0
fec00000-fec003ff : reserved
fee00000-fee00fff : reserved
fff80000-ffffffff : reserved

# cat /proc/scsi/scsi

Host: scsi0 Channel: 00 Id: 00 Lun: 00
 Vendor: LSILOGIC Model: 1030 IM       IM Rev: 1000
 Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 08 Lun: 00
 Vendor: IBM      Model: 25P3495a S320  1 Rev: 1
 Type:   Processor                        ANSI SCSI revision: 02

# lspci -vvv

0000:00:06.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8111 PCI
(rev 07) (prog-if 00 [Normal decode])
       Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-
       Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
       Latency: 115
       Bus: primary=00, secondary=01, subordinate=01, sec-latency=68
       I/O behind bridge: 00002000-00002fff
       Memory behind bridge: fc100000-fdffffff
       Prefetchable memory behind bridge: fff00000-000fffff
       Expansion ROM at 00002000 [disabled] [size=4K]
       BridgeCtl: Parity- SERR+ NoISA+ VGA+ MAbort- >Reset- FastB2B-
       Capabilities: [c0] #08 [0086]
       Capabilities: [f0] #08 [8000]

0000:00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-8111 LPC (rev
05)
       Subsystem: Advanced Micro Devices [AMD] AMD-8111 LPC
       Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
       Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
       Latency: 0

0000:00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-8111 IDE
(rev 03) (prog-if 8a [Master SecP PriP])
       Subsystem: IBM: Unknown device 7469
       Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
       Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
       Latency: 64
       Region 4: I/O ports at 1020 [size=16]

0000:00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-8111 ACPI (rev 05)
       Subsystem: IBM: Unknown device 746b
       Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
       Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-

0000:00:0a.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X
Bridge (rev 12) (prog-if 00 [Normal decode])
       Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
       Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
       Latency: 64
       Bus: primary=00, secondary=02, subordinate=02, sec-latency=64
       I/O behind bridge: 00003000-00003fff
       Memory behind bridge: fe000000-fe0fffff
       Prefetchable memory behind bridge:
00000000fff00000-0000000000000000
       Expansion ROM at 00003000 [disabled] [size=4K]
       BridgeCtl: Parity+ SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
       Capabilities: [a0]      Capabilities: [b8] #08 [8000]
       Capabilities: [c0] #08 [004a]

0000:00:0a.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X APIC
(rev 01) (prog-if 10 [IO-APIC])
       Subsystem: Advanced Micro Devices [AMD] AMD-8131 PCI-X APIC
       Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
       Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
       Latency: 0
       Region 0: Memory at fc000000 (64-bit, non-prefetchable)

0000:00:0b.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X
Bridge (rev 12) (prog-if 00 [Normal decode])
       Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
       Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
       Latency: 64
       Bus: primary=00, secondary=03, subordinate=03, sec-latency=64
       I/O behind bridge: 0000f000-00000fff
       Memory behind bridge: fff00000-000fffff
       Prefetchable memory behind bridge:
00000000fff00000-0000000000000000
       BridgeCtl: Parity+ SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
       Capabilities: [a0]      Capabilities: [b8] #08 [8000]

0000:00:0b.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X APIC
(rev 01) (prog-if 10 [IO-APIC])
       Subsystem: Advanced Micro Devices [AMD] AMD-8131 PCI-X APIC
       Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
       Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
       Latency: 0
       Region 0: Memory at fc001000 (64-bit, non-prefetchable)

0000:00:18.0 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] HyperTransport Technology Configuration
       Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
       Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
       Capabilities: [80] #08 [2101]
       Capabilities: [a0] #08 [2101]
       Capabilities: [c0] #08 [2101]

0000:00:18.1 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] Address Map
       Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
       Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

0000:00:18.2 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] DRAM Controller
       Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
       Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

0000:00:18.3 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] Miscellaneous Control
       Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
       Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

0000:00:19.0 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] HyperTransport Technology Configuration
       Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
       Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
       Capabilities: [80] #08 [2101]
       Capabilities: [a0] #08 [2101]
       Capabilities: [c0] #08 [2101]

0000:00:19.1 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] Address Map
       Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
       Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

0000:00:19.2 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] DRAM Controller
       Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
       Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

0000:00:19.3 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] Miscellaneous Control
       Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
       Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

0000:01:00.0 USB Controller: Advanced Micro Devices [AMD] AMD-8111 USB
(rev 0b) (prog-if 10 [OHCI])
       Subsystem: IBM: Unknown device 7464
       Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-
       Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
       Latency: 64 (20000ns max)
       Interrupt: pin D routed to IRQ 19
       Region 0: Memory at fc100000 (32-bit, non-prefetchable)

0000:01:00.1 USB Controller: Advanced Micro Devices [AMD] AMD-8111 USB
(rev 0b) (prog-if 10 [OHCI])
       Subsystem: IBM: Unknown device 7464
       Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-
       Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
       Latency: 64 (20000ns max)
       Interrupt: pin D routed to IRQ 19
       Region 0: Memory at fc101000 (32-bit, non-prefetchable)

0000:01:05.0 VGA compatible controller: ATI Technologies Inc Rage XL
(rev 27) (prog-if 00 [VGA])
       Subsystem: IBM: Unknown device 0240
       Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping+ SERR- FastB2B-
       Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
       Latency: 64 (2000ns min), cache line size 10
       Interrupt: pin A routed to IRQ 10
       Region 0: Memory at fd000000 (32-bit, non-prefetchable)
       Region 1: I/O ports at 2000 [size=256]
       Region 2: Memory at fc102000 (32-bit, non-prefetchable) [size=4K]
       Capabilities: [5c] Power Management version 2
               Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
               Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:01:06.0 RAID bus controller: Silicon Image, Inc. (formerly CMD
Technology Inc) SiI 3512 [SATALink/SATARaid] Serial ATA Controller
(rev 01)
       Subsystem: IBM: Unknown device 3512
       Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
       Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
       Latency: 64, cache line size 10
       Interrupt: pin A routed to IRQ 7
       Region 0: I/O ports at 2420
       Region 1: I/O ports at 2414 [size=4]
       Region 2: I/O ports at 2418 [size=8]
       Region 3: I/O ports at 2410 [size=4]
       Region 4: I/O ports at 2400 [size=16]
       Region 5: Memory at fc103000 (32-bit, non-prefetchable)
[size=512]
       Capabilities: [60] Power Management version 2
               Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
               Status: D0 PME-Enable- DSel=0 DScale=2 PME-

0000:02:01.0 Ethernet controller: Broadcom Corporation NetXtreme
BCM5704 Gigabit Ethernet (rev 03)
       Subsystem: IBM: Unknown device 02a6
       Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
       Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
       Latency: 64 (16000ns min), cache line size 10
       Interrupt: pin A routed to IRQ 24
       Region 0: Memory at fe010000 (64-bit, non-prefetchable)
       Region 2: Memory at fe000000 (64-bit, non-prefetchable)
[size=64K]
       Capabilities: [40]      Capabilities: [48] Power Management
version 2
               Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot+,D3cold+)
               Status: D0 PME-Enable+ DSel=0 DScale=1 PME-
       Capabilities: [50] Vital Product Data
       Capabilities: [58] Message Signalled Interrupts: 64bit+
Queue=0/3 Enable-
               Address: 02c0488909912014  Data: 6880

0000:02:01.1 Ethernet controller: Broadcom Corporation NetXtreme
BCM5704 Gigabit Ethernet (rev 03)
       Subsystem: IBM: Unknown device 02a6
       Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
       Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
       Latency: 64 (16000ns min), cache line size 10
       Interrupt: pin B routed to IRQ 25
       Region 0: Memory at fe030000 (64-bit, non-prefetchable)
       Region 2: Memory at fe020000 (64-bit, non-prefetchable)
[size=64K]
       Capabilities: [40]      Capabilities: [48] Power Management
version 2
               Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot+,D3cold+)
               Status: D0 PME-Enable- DSel=0 DScale=1 PME-
       Capabilities: [50] Vital Product Data
       Capabilities: [58] Message Signalled Interrupts: 64bit+
Queue=0/3 Enable-
               Address: 0980096b281c28a4  Data: 0000

0000:02:02.0 SCSI storage controller: LSI Logic / Symbios Logic
53c1030 PCI-X Fusion-MPT Dual Ultra320 SCSI (rev 07)
       Subsystem: IBM: Unknown device 026d
       Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-
       Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
       Latency: 72 (4250ns min, 4500ns max), cache line size 10
       Interrupt: pin A routed to IRQ 26
       Region 0: I/O ports at 3000
       Region 1: Memory at fe050000 (64-bit, non-prefetchable)
[size=64K]
       Region 3: Memory at fe040000 (64-bit, non-prefetchable)
[size=64K]
       Capabilities: [50] Power Management version 2
               Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
               Status: D0 PME-Enable- DSel=0 DScale=0 PME-
       Capabilities: [58] Message Signalled Interrupts: 64bit+
Queue=0/0 Enable-
               Address: 0000000000000000  Data: 0000
       Capabilities: [68] PCI-X non-bridge device.
               Command: DPERE- ERO- RBC=2 OST=0
               Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-,
DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-


Thanks and Regards

-- 
Ing. Ral Alvarez Aguileta <l0rd4gu1@icontrol.com.mx>
Red de Control Corporativo


