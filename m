Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318079AbSGMAp3>; Fri, 12 Jul 2002 20:45:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318080AbSGMAp2>; Fri, 12 Jul 2002 20:45:28 -0400
Received: from web10908.mail.yahoo.com ([216.136.131.44]:7433 "HELO
	web10908.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S318079AbSGMAp0>; Fri, 12 Jul 2002 20:45:26 -0400
Message-ID: <20020713004815.53870.qmail@web10908.mail.yahoo.com>
Date: Fri, 12 Jul 2002 17:48:15 -0700 (PDT)
From: Kristian Amlie <k_amlie@yahoo.com>
Subject: PROBLEM: Loading module "ide-cd.o" crashes during cd-r/rw burning
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

[1.] PROBLEM: Loading module "ide-cd.o" crashes during cd-r/rw burning

[2.]
I have a configuration with two CD-ROM drives; they are:
1. HL-DT-ST RW/DVD GCC-4120B (Goldstar)
2. Pioneer CD-ROM ATAPI Model DR-A04S 0105
according to "/proc/ide/hdX/model".

I use drive number one to burn CDs using the scsi interface with
scsi_mod ide-scsi, sr_mod and sg. The program I use is cdrecord.
My "modules.conf" file is set up to load "ide-cd ignore=hdc" before the
sg interface is opened. This way, the ide interface takes care of my
second CD-ROM (hdd) and the scsi interface takes care of the first
(hdc).
This configuration works fine. However, a problem arises because the
ide-cd module is often autocleaned while a burning is in progress. If I
then try to access the second CD-ROM (hdd), the ide-cd module hangs on
initialization (at least that's what lsmod tells me).
The burning process also stops, and the programs that tried to access
the second drive are caught in their uninterruptable sleeps.
Shortly after this (about a minute or two) I get a message that loading
the module failed.
And that is almost immediately followed by a complete kernel crash. I
am afraid I cannot provide any screen output, as it starts printing hex
values at unlimited speed, and I am unable to read it.
The kernel doesn't react to any keypresses (like ScrollLock to stop the
output), not even the Magic SysRq key, which I have activated.


[3.] Keywords: ide, cd-rom, atapi, scsi

[4.]
My kernel version is (/proc/version):
Linux version 2.4.18 (root@Kristian) (gcc version 3.1 20020106 (Red Hat
Linux Rawhide 3.1-0.17))

[5.]
Not applicable.

[6.]
Here is a shell script that should hopefully demonstrate the problem:
(replacing some values is necessary, of course)

#!/bin/bash

modprobe ide-cd ignore=hdc
modprobe sg
cdrecord dev=<insert scsi device>  <SomeBigIsoFile> &
# Give it some time to start the burning.
sleep 120
modprobe -r ide-cd
modprobe ide-cd
echo "Shouldn't get here! The problem obviously doesn't reveal itself
under this environment!"


# -------------- End of Script --------------


[7.2]
CPU-info (/proc/cpuinfo)
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 6
model name      : AMD Athlon(tm) XP 1800+
stepping        : 2
cpu MHz         : 1533.411
cache size      : 256 KB
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
pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips        : 3060.53

[7.3]
Module info (/proc/modules)
sg                     28296   0 (unused)
sr_mod                 14536   0 (unused)
ide-scsi                8828   0
ide-cd                 30196   0
cdrom                  29568   0 [sr_mod ide-cd]
scsi_mod               56032   3 [sg sr_mod ide-scsi]
emu10k1                58060   0
ac97_codec             10752   0 [emu10k1]
soundcore               4004   4 [emu10k1]
serial                 48640   1 (autoclean)
binfmt_misc             6256   1
nls_cp865               4440   3 (autoclean)
smbfs                  38124   3 (autoclean)
eepro100               22112   1 (autoclean)
vfat                   10920   2 (autoclean)
nls_iso8859-1           2924   9 (autoclean)
msdos                   6280   1 (autoclean)
fat                    32664   0 (autoclean) [vfat msdos]


[7.4]
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
02f8-02ff : serial(set)
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
d400-d41f : Creative Labs SB Live! EMU10k1
  d400-d41f : EMU10K1
d800-d81f : Intel Corp. 82557 [Ethernet Pro 100]
  d800-d81f : eepro100
dc00-dc07 : Creative Labs SB Live!
ff00-ff0f : Silicon Integrated Systems [SiS] 5513 [IDE]
  ff00-ff07 : ide0
  ff08-ff0f : ide1


[7.5]
I haven't got lspci, please tell me if the output is important in this
case.


[7.6]
/proc/scsi/scsi:
Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: HL-DT-ST Model: RW/DVD GCC-4120B Rev: 2.01
  Type:   CD-ROM                           ANSI SCSI revision: 02



Do not hesitate to email me if you need any further info!

Sincerely yours
Kristian Amlie

__________________________________________________
Do You Yahoo!?
Sign up for SBC Yahoo! Dial - First Month Free
http://sbc.yahoo.com
