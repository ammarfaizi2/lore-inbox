Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262356AbUCVTol (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 14:44:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262353AbUCVTok
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 14:44:40 -0500
Received: from flexcell.com ([206.208.54.2]:23010 "HELO djb.cybermetrix.com")
	by vger.kernel.org with SMTP id S262339AbUCVTob (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 14:44:31 -0500
Message-ID: <01bb01c41046$0a1f8710$1c30d0ce@cybermetrix.com>
From: "Curt" <cfiene@cybermetrix.com>
To: <linux-kernel@vger.kernel.org>
Subject: PROBLEM: handling 4G+ files
Date: Mon, 22 Mar 2004 14:44:07 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I received the following kernel error while copying a file a little than 4G
from one system to another (using scp).  This happened last week after the
kernel upgrade, but a re-try was successful.

Mar 22 13:18:28 tapesys kernel: ------------[ cut here ]------------
Mar 22 13:18:28 tapesys kernel: kernel BUG at filemap.c:3264!
Mar 22 13:18:28 tapesys kernel: invalid operand: 0000
Mar 22 13:18:28 tapesys kernel: nfs lockd sunrpc iptable_filter ip_tables
via-rhine mii st keybdev mousedev hid input usb-uhci usbcore aic7xxx sd_mod
scsi_mod
Mar 22 13:18:28 tapesys kernel: CPU:    0
Mar 22 13:18:28 tapesys kernel: EIP:    0060:[<c013130d>]    Not tainted
Mar 22 13:18:28 tapesys kernel: EFLAGS: 00010246
Mar 22 13:18:28 tapesys kernel:
Mar 22 13:18:28 tapesys kernel: EIP is at generic_file_write [kernel] 0x3bd
(2.4.20-30.9)
Mar 22 13:18:28 tapesys kernel: eax: 00000000   ebx: 00001000   ecx:
c1029930   edx: c1029914
Mar 22 13:18:28 tapesys kernel: esi: c1029914   edi: c1029914   ebp:
08050c40   esp: c3009f48
Mar 22 13:18:28 tapesys kernel: ds: 0068   es: 0068   ss: 0068
Mar 22 13:18:28 tapesys kernel: Process scp (pid: 24008, stackpage=c3009000)
Mar 22 13:18:28 tapesys kernel: Stack: ffffffff c3008000 00000000 c1275190
c1029914 00000001 00000000 c1be44cc
Mar 22 13:18:28 tapesys kernel:        00001000 fffffff4 00000000 08162000
00000000 c1be4460 c1be4508 00000000
Mar 22 13:18:28 tapesys kernel:        f1001000 08050c40 c3ac6740 ffffffea
00001000 c0140375 c3ac6740 08050c40
Mar 22 13:18:28 tapesys kernel: Call Trace:   [<c0140375>] sys_write
[kernel] 0x85 (0xc3009f9c))
Mar 22 13:18:28 tapesys kernel: [<c0109103>] system_call [kernel] 0x33
(0xc3009fc0))
Mar 22 13:18:28 tapesys kernel:
Mar 22 13:18:28 tapesys kernel:
Mar 22 13:18:28 tapesys kernel: Code: 0f 0b c0 0c 52 1c 24 c0 8b 4c 24 10 31
c0 8b 7c 24 20 8a 41


/proc/version
Linux version 2.4.20-30.9 (bhcompile@daffy.perf.redhat.com) (gcc version
3.2.2 20030222 (Red Hat Linux 3.2.2-5)) #1 Wed Feb 4 20:45:57 EST 2004


/proc/cpuinfo
processor : 0
vendor_id : CyrixInstead
cpu family : 5
model  : 4
model name : 6x86L 2x Core/Bus Clock
stepping : 2
fdiv_bug : no
hlt_bug  : no
f00f_bug : no
coma_bug : yes
fpu  : yes
fpu_exception : yes
cpuid level : 1
wp  : yes
flags  : fpu de cx8 cyrix_arr
bogomips : 149.91

lsmod
Module                  Size  Used by    Not tainted
nfs                    74424   1  (autoclean)
lockd                  53968   1  (autoclean) [nfs]
sunrpc                 77084   1  (autoclean) [nfs lockd]
via-rhine              15344   1
mii                     3720   0  [via-rhine]
st                     29932   0  (unused)
keybdev                 2752   0  (unused)
mousedev                5236   0  (unused)
hid                    20868   0  (unused)
input                   5632   0  [keybdev mousedev hid]
usb-uhci               24684   0  (unused)
usbcore                73280   1  [hid usb-uhci]
aic7xxx               130932   0  (unused)
sd_mod                 13004   0  (unused)
scsi_mod              102968   3  [st aic7xxx sd_mod]

/proc/ioports
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
0cf8-0cff : PCI conf1
4000-403f : Intel Corp. 82371AB/EB/MB PIIX4 ACPI
5000-501f : Intel Corp. 82371AB/EB/MB PIIX4 ACPI
6400-64ff : Adaptec AIC-7861
6800-687f : VIA Technologies, Inc. VT86C100A [Rhine]
  6800-687f : via-rhine
6900-691f : Intel Corp. 82371AB/EB/MB PIIX4 USB
  6900-691f : usb-uhci
f000-f00f : Intel Corp. 82371AB/EB/MB PIIX4 IDE
  f000-f007 : ide0
  f008-f00f : ide1

/proc/iomem
00000000-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000c87ff : Extension ROM
000f0000-000fffff : System ROM
00100000-03ffffff : System RAM
  00100000-00233f7b : Kernel code
  00233f7c-0032d9a3 : Kernel data
e0000000-e07fffff : S3 Inc. 86c764/765 [Trio32/64/64V+]
e0800000-e080007f : VIA Technologies, Inc. VT86C100A [Rhine]
  e0800000-e080007f : via-rhine
e0801000-e0801fff : Adaptec AIC-7861
  e0801000-e0801fff : aic7xxx
ffff0000-ffffffff : reserved

lspci -vvv
00:00.0 Host bridge: Intel Corp. 430TX - 82439TX MTXC (rev 01)
 Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
 Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort+ >SERR- <PERR-
 Latency: 32

00:07.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 01)
 Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
 Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
 Latency: 0

00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01) (prog-if
80 [Master])
 Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
 Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
 Latency: 32
 Region 4: I/O ports at f000 [size=16]

00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01)
(prog-if 00 [UHCI])
 Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
 Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
 Latency: 32
 Interrupt: pin D routed to IRQ 11
 Region 4: I/O ports at 6900 [size=32]

00:07.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 01)
 Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
 Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
 Interrupt: pin ? routed to IRQ 9

00:09.0 VGA compatible controller: S3 Inc. 86c764/765 [Trio32/64/64V+]
(prog-if 00 [VGA])
 Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
 Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
 Interrupt: pin A routed to IRQ 11
 Region 0: Memory at e0000000 (32-bit, non-prefetchable) [size=8M]
 Expansion ROM at <unassigned> [disabled] [size=64K]

00:0b.0 Ethernet controller: VIA Technologies, Inc. VT86C100A [Rhine] (rev
06)
 Subsystem: D-Link System Inc DFE-530TX rev A
 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
 Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
 Latency: 32 (29500ns min, 38000ns max), cache line size 08
 Interrupt: pin A routed to IRQ 7
 Region 0: I/O ports at 6800 [size=128]
 Region 1: Memory at e0800000 (32-bit, non-prefetchable) [size=128]
 Expansion ROM at <unassigned> [disabled] [size=64K]

00:0f.0 SCSI storage controller: Adaptec AIC-7861 (rev 01)
 Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
 Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
 Latency: 32 (1000ns min, 1000ns max), cache line size 08
 Interrupt: pin A routed to IRQ 10
 Region 0: I/O ports at 6400 [disabled] [size=256]
 Region 1: Memory at e0801000 (32-bit, non-prefetchable) [size=4K]
 Expansion ROM at <unassigned> [disabled] [size=64K]


/proc/scsi/scsi

Attached devices:
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: HP       Model: C1537A           Rev: L111
  Type:   Sequential-Access                ANSI SCSI revision: 02




