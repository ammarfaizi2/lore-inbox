Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132581AbRDKOZK>; Wed, 11 Apr 2001 10:25:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132584AbRDKOY7>; Wed, 11 Apr 2001 10:24:59 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:9593 "HELO
	mailhub.stusta.mhn.de") by vger.kernel.org with SMTP
	id <S132578AbRDKOYj>; Wed, 11 Apr 2001 10:24:39 -0400
Content-Type: text/plain; charset=US-ASCII
From: Tobias Landes <landes@informatik.tu-muenchen.de>
To: linux-kernel@vger.kernel.org
Subject: Bug in Kernel 2.4
Date: Wed, 11 Apr 2001 16:23:37 +0200
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01041116233700.04302@r093165>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I believe there is a bug in Linux Kernel 4.2. I tried Kernels 2.4.2 and 2.4.0 
with my german SuSE-Distribution (7.1).
The problem occurs with my SCSI MO drive. while it works fine with Kernel 
2.2.18 on the same machine and distribution, the behaviour with the newer 
Kernels is like that:
I can mount the drive. I can do an 'ls'. I can even copy a file onto the 
drive. But I can't read from the drive (simple 'less' or 'cp' from the 
drive). This results in the immediate message 'Segmentation fault.'. The 
resulting entries in the message log looks like this:

Apr 11 15:22:19 r093165 kernel: Unable to handle kernel NULL pointer 
dereferenceApr 11 15:22:19 r093165 kernel:  printing eip:
Apr 11 15:22:19 r093165 kernel: 00000000
Apr 11 15:22:19 r093165 kernel: *pde = 00000000
Apr 11 15:22:19 r093165 kernel: Oops: 0000
Apr 11 15:22:19 r093165 kernel: CPU:    0
Apr 11 15:22:19 r093165 kernel: EIP:    0010:[<00000000>]
Apr 11 15:22:19 r093165 kernel: EFLAGS: 00010282
Apr 11 15:22:19 r093165 kernel: eax: 00000000   ebx: c5130500   ecx: 00000040
Apr 11 15:22:19 r093165 kernel: esi: bffff6f4   edi: 00000000   ebp: 00000040
Apr 11 15:22:19 r093165 kernel: ds: 0018   es: 0018   ss: 0018
Apr 11 15:22:19 r093165 kernel: Process less (pid: 434, stackpage=c4cc9000)
Apr 11 15:22:19 r093165 kernel: Stack: c015af6d c5130500 bffff6f4 00000040 
c5130Apr 11 15:22:19 r093165 kernel:        c5130500 bffff6f4 00000040 
c5130520 c4cc8Apr 11 15:22:19 r093165 kernel:        c0108f77 00000004 
bffff6f4 00000040 00000Apr 11 15:22:19 r093165 kernel: Call Trace: 
[fat_file_read+45/52] [sys_read+143/Apr 11 15:22:19 r093165 kernel:
Apr 11 15:22:19 r093165 kernel: Code:  Bad EIP value.

To My Hardware and configuration:

SCSI-Controller (Symbios Logic) and MO drive (Fujitsu M2513A):

/proc/scsi/ncr53c8xx/0:
Chip NCR53C810a, device id 0x1, revision id 0x12
  On PCI bus 0, device 13, function 0, IRQ 9
  Synchronous period factor 25, max commands per lun 32
  Debug flags 0x200, verbosity level 1

/proc/scsi/scsi:
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: IBM      Model: DCAS-34330       Rev: S65A
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 04 Lun: 00
  Vendor: PLEXTOR  Model: CD-R   PX-W1210S Rev: 1.00
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 05 Lun: 00
  Vendor: FUJITSU  Model: M2513A           Rev: 1700
  Type:   Optical Device                   ANSI SCSI revision: 02

Linux version (from /proc/version):
Linux version 2.4.2 (root@r093165) (gcc version 2.95.2 19991024 (release)) 
#26 SMP Wed Apr 11 15:18:28 CEST 2001

Processor (from /proc/cpuinfo):
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 5
model           : 4
model name      : Pentium MMX
stepping        : 3
cpu MHz         : 232.673
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : yes
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8 mmx
bogomips        : 463.66

from /proc/ioports:
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0213-0213 : isapnp read
0220-022f : soundblaster
02f8-02ff : serial(auto)
0300-031f : eth0
0330-0333 : MPU-401 UART
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0a79-0a79 : isapnp write
0cf8-0cff : PCI conf1
6100-61ff : Symbios Logic Inc. (formerly NCR) 53c810
  6100-617f : ncr53c8xx
6200-62ff : 3Dfx Interactive, Inc. Voodoo 3
f000-f00f : Intel Corporation 82371SB PIIX3 IDE [Natoma/Triton II]

from /proc/iomen:
00000000-0009fbff : System RAM
0009fc00-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000ca7ff : Extension ROM
000f0000-000fffff : System ROM
00100000-05ffffff : System RAM
  00100000-0022e34b : Kernel code
  0022e34c-002aabff : Kernel data
e0000000-e1ffffff : 3Dfx Interactive, Inc. Voodoo 3
e2000000-e3ffffff : 3Dfx Interactive, Inc. Voodoo 3
e4000000-e40000ff : Symbios Logic Inc. (formerly NCR) 53c810
ffff0000-ffffffff : reserved

Another remark: my MO-disks are FAT formatted and the data was written on 
them using Linux with some 2.2.x kernel.

I hope this helps fixing the bug (or telling me what I've done wrong myself. 
But I tried anything and the older kernels work without problems.).

Tobias Landes
