Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284775AbRLRTZO>; Tue, 18 Dec 2001 14:25:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284557AbRLRTYc>; Tue, 18 Dec 2001 14:24:32 -0500
Received: from smtp.integrinautics.com ([204.247.117.11]:26359 "EHLO
	smtp.integrinautics.com") by vger.kernel.org with ESMTP
	id <S284766AbRLRTX7>; Tue, 18 Dec 2001 14:23:59 -0500
Message-ID: <3C1F970A.3B2AEE55@integrinautics.com>
Date: Tue, 18 Dec 2001 11:20:42 -0800
From: Dave Lawrence <dgl@integrinautics.com>
Organization: IntegriNautics Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: IDE bug in 2.4.* with compact flash?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:
Cannot access two compact flash disks with IDE driver in kernel 2.4.*
    [2.] Full description of the problem/report:
When upgrading from kernel 2.2.17 to 2.4.7, I lost the ability to access
two
compact flash disks.  I posted a more complete description several weeks
ago;
my original post is included near the end of this post.
    [3.] Keywords (i.e., modules, networking, kernel):
IDE, compact flash, CDROM
    [4.] Kernel version (from /proc/version):
Linux version 2.4.13 (dgl@endor) (gcc version 3.0) #6 Fri Nov 9 13:36:00
PST 2001
Also tried 2.4.1, 2.4.7 (similar problems have been produced by others
with
2.4.10 & 2.4.16)
    [5.] Output of Oops.. message with symbolic information resolved
N/A
    [6.] A small shell script or example program which triggers the
         problem (if possible)
N/A
    [7.] Environment
    [7.1.] Software
bash# /sbin/insmod -V
insmod version 2.1.121
bash# mount --version
mount: mount-2.9u
    [7.2.] Processor information (from /proc/cpuinfo):
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 5
model           : 8
model name      : Mobile Pentium MMX
stepping        : 1
cpu MHz         : 166.453
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : yes
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8 mmx
bogomips        : 331.77
    [7.3.] Module information (from /proc/modules):
ide-probe-mod           7820   0
ide-disk                6928   0
ide-mod                66884   0 [ide-probe-mod ide-disk]
nfs                    44344   3
lockd                  33596   1 [nfs]
sunrpc                 60092   1 [nfs lockd]
eepro100               18416   1
    [7.4.] SCSI information (from /proc/scsi/scsi):
N/A
    [7.5.] Other information that might be relevant to the problem
           (please look in /proc and include all information that you
            think to be relevant):
bash# cat /proc/ide/ali

                                Ali M15x3 Chipset.
                                ------------------
PCI Clock: 33.
CD_ROM FIFO:No , CD_ROM DMA:Yes
FIFO Status: contains 0 Words, runs.

-------------------primary channel-------------------secondary
channel---------

channel status:       On                                Off
both channels togth:  Yes                               No
Channel state:        OK                                OK
Add. Setup Timing:    2T                                8T
Command Act. Count:   8T                                8T
Command Rec. Count:   16T                               16T

----------------drive0-----------drive1------------drive0-----------drive1------

DMA enabled:      No               No                Yes
Yes
FIFO threshold:    8 Words          4 Words           4 Words          4
Words
FIFO mode:        FIFO On          FIFO Off          FIFO Off
FIFO Off
Dt RW act. Cnt     5T               8T                8T
8T
Dt RW rec. Cnt     6T              16T               16T
16T

-----------------------------------UDMA
Timings--------------------------------

UDMA:             No               No                No               No

UDMA timings:     1.5T             1.5T              1.5T
1.5T

bash# cat /proc/ide/drivers
ide-disk version 1.10

bash# cat /proc/ide/hda/driver
(none)
bash# cat /proc/ide/hda/identify
848a 02f1 0000 0004 4000 0200 0020 0001
7880 0000 3131 3430 3138 3331 3130 3931
3939 3039 3030 3333 0002 0002 0004 5631
2e30 3120 2020 4c45 5841 5220 4154 4120
464c 4153 4820 2020 2020 2020 2020 2020
2020 2020 2020 2020 2020 2020 2020 0001
0000 0200 0000 0400 0000 0001 02f1 0004
0020 7880 0001 0100 7880 0001 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 4245 5248 414e 5520 494d 414e 2020
2020 4849 524f 2054 4148 4152 4120 2020
204d 2e20 4153 4e41 4153 4841 5249 2020
2020 204d 494b 4520 4153 5341 5220 5c8d
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
bash# cat /proc/ide/hda/media
disk
bash# cat /proc/ide/hda/model
LEXAR ATA FLASH

bash# cat /proc/ide/hda/settings
name                    value           min             max
mode
----                    -----           ---             ---
----
current_speed           0               0               69
rw
ide_scsi                0               0               1
rw
init_speed              0               0               69
rw
io_32bit                0               0               3
rw
keepsettings            0               0               1
rw
nice1                   0               0               1
rw
number                  0               0               3
rw
pio_mode                write-only      0               255
w
slow                    0               0               1
rw
unmaskirq               0               0               1
rw
using_dma               0               0               1
rw
bash# cat /proc/ide/ide0/channel
0
bash# cat /proc/ide/ide0/config
pci bus 00 device 58 vid 10b9 did 5229 channel 0
b9 10 29 52 05 00 80 02 c1 a4 01 01 00 40 00 00
00 00 00 00 00 00 00 00 71 01 00 00 75 03 00 00
01 14 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 ff 01 02 04
00 00 00 00 00 00 00 00 00 00 00 4a 00 80 ba 4a
03 00 00 89 05 00 00 00 02 00 56 00 00 00 00 00
00 00 00 01 02 00 00 01 00 00 00 00 00 00 ec 00
8f 00 00 00 00 00 00 00 21 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
bash# cat /proc/ide/ide0/mate
(none)
bash# cat /proc/ide/ide0/model
pci

    [X.] Other notes, patches, fixes, workarounds:

My original post:

I can't access the
second CF disk (/dev/hdb) using the 2.4 kernels.  I tried sending
a "hda=flash hdb=flash" switch to loadlin, but it doesn't seem to help.
The BIOS
recognizes that the second disk is there, but I can't access it.  Linux
also recognizes
that I sent the hdb=flash switch.  Here is the relavent output of dmesg:

vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv

Kernel command line: hdb=flash hdB=flash root=/dev/ram rw
BOOT_IMAGE=bzimage
...
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
ALI15X3: IDE controller on PCI bus 00 dev 58
PCI: No IRQ known for interrupt pin A of device 00:0b.0. Please try
using pci=biosirq.
ALI15X3: chipset revision 193
ALI15X3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1400-0x1407, BIOS settings: hda:pio, hdb:pio
ALI15X3: simplex device:  DMA disabled
ide1: ALI15X3 Bus-Master DMA disabled (BIOS)
hda: LEXAR ATA FLASH, ATA DISK drive
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
ide2: ports already in use, skipping probe
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Note that it does not detect hdb despite the fact that hdb is there.
The BIOS sees it, DOS sees it before loadlin runs, and 2.2.17 sees it.
Why can't I access if from 2.4.x?


My hardware:

A Jumptec MOPSLCD6 Pentium 166 single board computer with an ALI
M1543C/M1531 chipset.  On ide0, there are two Compact Flash cards, one
configured as master and one as slave (they are both plugged onto a PCB
that accepts two CF devices and has a master/slave jumper).  For
historical reasons, I boot to DOS and then use loadlin to load the
kernel.
__________________________________________________________________
A similar problem reported to me after my original post:

Dave
        I saw your post on daja about the compact flash IDE problem and
am experiencing the same type of problem here. I noticed there was no
response to you post as there has been not response to mine.

        I have been able to get the kernel to recognize the CD-Rom or
the Compact Flash, one or the other but not both at the same time.  In
those cases I can mount and use them.

        I can get the kernel to recognize both by sending the following
kernel params:

boot: linux hdd=noprobe hdd=977,4,32 hdc=cdrom

In this case I can  mount and use the CD-Rom but  I can't do anything
with the the compact flash.
/proc/ide/hdd/capacity says that the capacity of the CF is 0. I try to
sfdisk hdd and it reports the CF capacity to be zero.

        I wondered if you had had any luck. I am using a 2.4.10 and
2.4.16 kernel.

any ideas?
_____________________________________________________
A message from somebody else who reproduced my problem:
No I can't get it to work at all.

It looks to me like a bug in the ide driver for the chipset. The best I
can get
is
hdb: C/H/S=0/0/0 from BIOS ignored
hda: SanDisk SDCFB-96, ATA DISK drive


