Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132796AbRD1Rxh>; Sat, 28 Apr 2001 13:53:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132932AbRD1Rx2>; Sat, 28 Apr 2001 13:53:28 -0400
Received: from mail.s.netic.de ([212.9.160.11]:53778 "EHLO mail.netic.de")
	by vger.kernel.org with ESMTP id <S132796AbRD1RxT>;
	Sat, 28 Apr 2001 13:53:19 -0400
Date: Sat, 28 Apr 2001 19:42:29 +0200 (MEST)
From: Roman Fietze <fietze@s.netic.de>
To: linux-kernel@vger.kernel.org
Subject: Kernel 2.4.[234] kernel panic, DMA Pool, CDROM Mount Failure
Message-ID: <Pine.LNX.4.21.0104281935560.687-100000@rfhome.fietze.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I reported this before and the bug still exists in 2.4.4. The problem can
be circumvented by using drivers/scsi/sr.c from kernel 2.4.[01]. This
"fix" did not help just me, but somebody else I had contact with on the
net.

[1.] One line summary of the problem:    

Kernel Panic and mount problems since 2.4.2, machine works and worked
properly with kernels < 2.4.2 and 2.2.x and fails since 2.4.2. The mount
fails on all three sr's on my system.


[2.] Full description of the problem/report:

When I try a

	mount /dev/scd[012] /mnt

I get

mount: wrong fs type, bad option, bad superblock on /dev/scd0,
       or too many mounted file systems

or repeating the mount command I sometimes get:

/dev/scd[012]: Input/output error


When continuing to work on the box after a short time I get

kernel: Kernel panic: DMA pool exhausted


[3.] Keywords (i.e., modules, networking, kernel):

kernel panic mount DMA pool

or other panics. I think it's a memory problem.


[4.] Kernel version (from /proc/version):

Linux version 2.4.4 (root@rfhome) (gcc version 2.95.2 19991024
(release)) #1 Mon Apr 2 21:20:59 MEST 2001


[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)

sorry, none


[6.] A small shell script or example program which triggers the
     problem (if possible)

see [2.]


[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)

ver_linux:

-- Versions installed: (if some fields are empty or looks
-- unusual then possibly you have very old versions)
Linux rfhome 2.4.4 #1 Mon Apr 2 21:20:59 MEST 2001 i586 unknown
Kernel modules         found
Gnu C                  2.95.2
Binutils               2.9.5.0.24
Linux C Library        ..
ldd: missing file arguments
Try `ldd --help' for more information.
ls: /usr/lib/libg++.so: No such file or directory
Procps                 2.0.6
Mount                  2.10m
Net-tools              (2000-05-21)
Kbd                    0.99
Sh-utils               2.0
Sh-utils               Parker.
Sh-utils               
Sh-utils               Inc.
Sh-utils               NO
Sh-utils               PURPOSE.


my own script testing for versions of tools listed in
Documentation/Changes:

Gnu C      required: 2.91.66    found: 2.95.2
Gnu make   required:    3.77    found: GNU Make version 3.79.1
binutils   required: 2.9.1.0.25 found: GNU ld version 2.9.5
					 (with BFD 2.9.5.0.24)
util-linux required:   2.10o    found: fdformat from
					 util-linux-2.10m
modutils   required:   2.4.2    found: insmod version 2.4.5
e2fsprogs  required:    1.19    found: tune2fs 1.18, 11-Nov-1999
					for EXT2 FS 0.5b, 95/08/09
pcmcia-cs  required:  3.1.21    found: listlinuxversions: cardmgr: command not found
PPP        required:   2.4.0    found: pppd version 2.4.1
isdn4k-utils required: 3.1pre1  found: listlinuxversions: isdnctrl: command not found


I know e2fsprogs and util-linux are not completely up to date. Sorry if
this is the complete problem. But at work at least two boxes work with
this setup w/o any problem.


[7.2.] Processor information (from /proc/cpuinfo):

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 5
model           : 8
model name      : AMD-K6(tm) 3D processor
stepping        : 12
cpu MHz         : 350.809
cache size      : 64 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8 pge mmx syscall 3dnow
k6_mtrr
bogomips        : 699.59


[7.3.] Module information (from /proc/modules):

empty


[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-017f : PCI device 10b9:5229
01f0-01ff : PCI device 10b9:5229
02f8-02ff : serial(auto)
0330-0333 : aha1542
0376-0376 : PCI device 10b9:5229
03c0-03df : vga+
03f6-03f6 : PCI device 10b9:5229
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
5c20-5c3f : PCI device 10b9:7101
b000-b00f : PCI device 10b9:5229
b400-b43f : PCI device 10b7:9050
  b400-b43f : eth0
b800-b8ff : PCI device 1000:0001
  b800-b87f : sym53c8xx
d000-dfff : PCI Bus #01
  d800-d8ff : PCI device 1002:4742


[7.5.] PCI information ('lspci -vvv' as root)

not installed, the distro contains 2.1.8-17


[7.6.] SCSI information (from /proc/scsi/scsi)

Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: FUJITSU  Model: M2624F-512       Rev: 0405
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: TEAC     Model: CD-ROM CD-56S    Rev: 1.0D
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: SANKYO   Model: CP525            Rev: 5.13
  Type:   Sequential-Access                ANSI SCSI revision: 01
Host: scsi0 Channel: 00 Id: 03 Lun: 00
  Vendor: NEC      Model: CD-ROM DRIVE:222 Rev: 3.1k
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 05 Lun: 00
  Vendor: HP       Model: C4324/C4325      Rev: 1.26
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 06 Lun: 00
  Vendor: EXABYTE  Model: EXB-8200         Rev: 251K
  Type:   Sequential-Access                ANSI SCSI revision: 01
Host: scsi1 Channel: 00 Id: 03 Lun: 00
  Vendor: SEAGATE  Model: ST41600N SUN1.3G Rev: 0040
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 04 Lun: 00
  Vendor: SEAGATE  Model: ST41600N SUN1.3G Rev: 0040
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 05 Lun: 00
  Vendor: MAXTOR   Model: LXT-213S SUN0207 Rev: 4.24
  Type:   Direct-Access                    ANSI SCSI revision: 01 CCS
Host: scsi1 Channel: 00 Id: 06 Lun: 00
  Vendor: MAXTOR   Model: 7120SCS          Rev: 3235
  Type:   Direct-Access                    ANSI SCSI revision: 01 CCS


[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

System works and worked w/o any flaws since months with kernels <
2.4.2. Reverting e.g. to 2.4.0 is absolutely fine. 2.4.4 was configured
using .config from 2.4.0 and running make oldconfig (as always), always
selecting the default. No device filesystem used.


[X.] Other notes, patches, fixes, workarounds:

Sorry. Tried different methods, but it always crashed. I do not know if
the mount (isofs is module) command causes the trouble, but testing it
once more is risky, because I already lost a few files on root fs because
of the panic/crash.


Roman

-- 
Roman Fietze      fietze@s.netic.de
Short is beautiful, esp. signatures


