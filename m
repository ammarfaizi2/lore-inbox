Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269223AbSISNq1>; Thu, 19 Sep 2002 09:46:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269269AbSISNq1>; Thu, 19 Sep 2002 09:46:27 -0400
Received: from mail.options-direct.co.uk ([213.38.148.2]:30055 "EHLO
	odlsecurities.com") by vger.kernel.org with ESMTP
	id <S269223AbSISNqY>; Thu, 19 Sep 2002 09:46:24 -0400
Message-ID: <3D89D674.4060402@tart.net>
Date: Thu, 19 Sep 2002 14:51:48 +0100
From: Chris Underhill <chris@tart.net>
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Ooops with 2.4.20-pre7-ac2
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've seen this oops with 2.4.20-pre5-ac5 and ac6 as well as 2.4.20-pre7-ac2. 
It will always happen when the startup scripts are running updfstab and kudzu 
- my machine is running Red Hat 7.3 plus latest patches.

After the oops happens, the machine is still useable. My previous kernel, 
2.4.19-pre10-ac2 does not oops - I suspect there is something in the IDE (or 
ide/scsi) changes that is the cause.

The IDE-relevant section of dmesg (with 2.4.19-pre10-ac2) contains:

---
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
     ide0: BM-DMA at 0xd400-0xd407, BIOS settings: hda:DMA, hdb:DMA
     ide1: BM-DMA at 0xd408-0xd40f, BIOS settings: hdc:DMA, hdd:pio
hda: QUANTUM FIREBALLP AS40.0, ATA DISK drive
hdb: QUANTUM FIREBALLP AS40.0, ATA DISK drive
hdc: Hewlett-Packard CD-Writer cd12d, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: host protected area => 1
hda: 78177792 sectors (40027 MB) w/1902KiB Cache, CHS=4866/255/63, UDMA(100)
hdb: host protected area => 1
hdb: 78177792 sectors (40027 MB) w/1902KiB Cache, CHS=4866/255/63, UDMA(100)
Partition check:
  hda: hda1 hda2 hda3
  hdb: hdb1 hdb2
...
ide-cd: ignoring drive hdc
hdc: driver not present
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
   Vendor: HP        Model: CD-Writer cd12d   Rev: LKS2
   Type:   CD-ROM                             ANSI SCSI revision: 02
   Vendor: HP        Model: CD-Writer cd12d   Rev: LKS2
   Type:   CD-ROM                             ANSI SCSI revision: 02
scsi : 0 hosts left.
...
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
   Vendor: HP        Model: CD-Writer cd12d   Rev: LKS2
   Type:   CD-ROM                             ANSI SCSI revision: 02
   Vendor: HP        Model: CD-Writer cd12d   Rev: LKS2
   Type:   CD-ROM                             ANSI SCSI revision: 02
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
Attached scsi CD-ROM sr1 at scsi0, channel 0, id 0, lun 1
sr0: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
sr1: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray
---

/dev/cdrom is a symlink to /dev/scd0 - though gawd knows why the kernel thinks 
I have more than 1 cdrom. ide-cd and scsi stuff are compiled as modules.

Kernel 2.4.20-pre7-ac2 has the following IDE-related messages:

---
Sep 19 14:03:32 cunderhill kernel: ide: Assuming 33MHz system bus speed for 
PIO modes; override with idebus=xx
Sep 19 14:03:32 cunderhill kernel: VP_IDE: IDE controller at PCI slot 00:07.1
Sep 19 14:03:32 cunderhill kernel: VP_IDE: chipset revision 6
Sep 19 14:03:32 cunderhill kernel: VP_IDE: not 100%% native mode: will probe 
irqs later
Sep 19 14:03:32 cunderhill kernel: ide: Assuming 33MHz system bus speed for 
PIO modes; override with idebus=xx
Sep 19 14:03:32 cunderhill kernel: VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 
controller on pci00:07.1
Sep 19 14:03:32 cunderhill kernel:     ide0: BM-DMA at 0xd400-0xd407, BIOS 
settings: hda:DMA, hdb:DMA
Sep 19 14:03:32 cunderhill kernel:     ide1: BM-DMA at 0xd408-0xd40f, BIOS 
settings: hdc:DMA, hdd:pio
Sep 19 14:03:32 cunderhill kernel: hda: QUANTUM FIREBALLP AS40.0, ATA DISK drive
Sep 19 14:03:32 cunderhill kernel: hdb: QUANTUM FIREBALLP AS40.0, ATA DISK drive
Sep 19 14:03:32 cunderhill kernel: hda: DMA disabled
Sep 19 14:03:32 cunderhill kernel: blk: queue c0260760, I/O limit 4095Mb (mask 
0xffffffff)
Sep 19 14:03:32 cunderhill kernel: hdb: DMA disabled
Sep 19 14:03:32 cunderhill kernel: blk: queue c026089c, I/O limit 4095Mb (mask 
0xffffffff)
Sep 19 14:03:32 cunderhill kernel: hdc: Hewlett-Packard CD-Writer cd12d, ATAPI 
CD/DVD-ROM drive
Sep 19 14:03:32 cunderhill kernel: hdc: DMA disabled
Sep 19 14:03:32 cunderhill kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Sep 19 14:03:32 cunderhill kernel: ide1 at 0x170-0x177,0x376 on irq 15
Sep 19 14:03:32 cunderhill kernel: hda: host protected area => 1
Sep 19 14:03:32 cunderhill kernel: hda: 78177792 sectors (40027 MB) w/1902KiB 
Cache, CHS=4866/255/63, UDMA(100)
Sep 19 14:03:32 cunderhill kernel: hdb: host protected area => 1
Sep 19 14:03:32 cunderhill kernel: hdb: 78177792 sectors (40027 MB) w/1902KiB 
Cache, CHS=4866/255/63, UDMA(100)
Sep 19 14:03:32 cunderhill kernel: Partition check:
Sep 19 14:03:32 cunderhill kernel:  hda: hda1 hda2 hda3
Sep 19 14:03:32 cunderhill kernel:  hdb: hdb1 hdb2
...
Sep 19 14:03:32 cunderhill kernel: ide-cd: ignoring drive hdc
Sep 19 14:03:32 cunderhill kernel: hdc: driver not present
Sep 19 14:03:32 cunderhill kernel: SCSI subsystem driver Revision: 1.00
Sep 19 14:03:32 cunderhill kernel: scsi0 : SCSI host adapter emulation for IDE 
ATAPI devices
Sep 19 14:03:32 cunderhill kernel:   Vendor: HP        Model: CD-Writer cd12d 
   Rev: LKS2
Sep 19 14:03:32 cunderhill kernel:   Type:   CD-ROM 
   ANSI SCSI revision: 02
Sep 19 14:03:32 cunderhill kernel:   Vendor: HP        Model: CD-Writer cd12d 
   Rev: LKS2
Sep 19 14:03:32 cunderhill kernel:   Type:   CD-ROM 
   ANSI SCSI revision: 02
Sep 19 14:03:32 cunderhill kernel: scsi : 0 hosts left.
Sep 19 14:03:32 cunderhill kernel: idescsi_cleanup: hdc: failed to unregister!
Sep 19 14:03:32 cunderhill kernel: hdc: usage 0, busy 0, driver f892e800, Dbusy 1
Sep 19 14:03:32 cunderhill kernel: hdc: exit_idescsi_module() called while 
still busy
Sep 19 14:03:32 cunderhill kernel: Unable to handle kernel paging request at 
virtual address f892e804
...
Sep 19 14:03:32 cunderhill kernel: parport_pc: Via 686A parallel port: io=0x378
Sep 19 14:03:32 cunderhill kernel: SCSI subsystem driver Revision: 1.00
Sep 19 14:03:32 cunderhill kernel: scsi0 : SCSI host adapter emulation for IDE 
ATAPI devices
Sep 19 14:03:32 cunderhill kernel: scsi : 0 hosts left.
Sep 19 14:03:32 cunderhill kernel: Unable to handle kernel paging request at 
virtual address ffffffff
---

Again the cdrom device is duplicated but with this kernel DMA is disabled on 
all devices and oopsen are generated. ksymoops output follows.  More 
information available on request.

Cheers,


Chris.


Unable to handle kernel paging request at virtual address f892e804
c0188380
*pde = 37bf6067
Oops: 0000
CPU:    0
EIP:    0010:[<c0188380>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: f892e800   ebx: f7a5d000   ecx: f7b938e0   edx: c0188350
esi: 00000032   edi: 00000000   ebp: f7a5d000   esp: f7a63f34
ds: 0018   es: 0018   ss: 0018
Process updfstab (pid: 243, stackpage=f7a63000)
Stack: 00000000 00000032 ffffffea c014cd2b f7a5d000 f7a63f68 00000000 00000032
        f7a63f64 c0260b9c f7ecf1c0 00000000 00000000 00000000 00000000 f7b938c0
        ffffffea 00000032 c0131fd5 f7b938c0 bffffae0 00000032 f7b938e0 c013aadd
Call Trace:    [<c014cd2b>] [<c0131fd5>] [<c013aadd>] [<c0131af3>] [<c0106c83>]
Code: ff 70 04 ff 30 68 ec 17 1e c0 53 e8 e0 46 04 00 89 c1 83 c4

 >>EIP; c0188380 <proc_ide_read_driver+30/80>   <=====
Trace; c014cd2b <seq_printf+4cab/5330>
Trace; c0131fd5 <default_llseek+275/a50>
Trace; c013aadd <getname+5d/a0>
Trace; c0131af3 <get_unused_fd+1a3/1f0>
Trace; c0106c83 <__up_wakeup+10c7/1484>
Code;  c0188380 <proc_ide_read_driver+30/80>
00000000 <_EIP>:
Code;  c0188380 <proc_ide_read_driver+30/80>   <=====
    0:   ff 70 04                  pushl  0x4(%eax)   <=====
Code;  c0188383 <proc_ide_read_driver+33/80>
    3:   ff 30                     pushl  (%eax)
Code;  c0188385 <proc_ide_read_driver+35/80>
    5:   68 ec 17 1e c0            push   $0xc01e17ec
Code;  c018838a <proc_ide_read_driver+3a/80>
    a:   53                        push   %ebx
Code;  c018838b <proc_ide_read_driver+3b/80>
    b:   e8 e0 46 04 00            call   446f0 <_EIP+0x446f0> c01cca70 
<sprintf+0/20>
Code;  c0188390 <proc_ide_read_driver+40/80>
   10:   89 c1                     mov    %eax,%ecx
Code;  c0188392 <proc_ide_read_driver+42/80>
   12:   83 c4 00                  add    $0x0,%esp

Unable to handle kernel paging request at virtual address ffffffff
c01cc84b
*pde = 00001063
Oops: 0000
CPU:    0
EIP:    0010:[<c01cc84b>]    Not tainted
EFLAGS: 00010297
eax: ffffffff   ebx: f7a42000   ecx: ffffffff   edx: fffffffe
esi: ffffffff   edi: f7a65f30   ebp: ffffffff   esp: f7a65ee0
ds: 0018   es: 0018   ss: 0018
Process kudzu (pid: 251, stackpage=f7a65000)
Stack: 00000000 ffffffff 0000000a f7a42000 00000032 00000000 f7a42000 c01cca63
        f7a42000 085be000 c01e17ed f7a65f2c c01cca82 f7a42000 c01e17ec f7a65f2c
        c0188390 f7a42000 c01e17ec ffffffff 00000000 00000000 00000032 ffffffea
Call Trace:    [<c01cca63>] [<c01cca82>] [<c0188390>] [<c014cd2b>] [<c0131fd5>]
   [<c013aadd>] [<c0131af3>] [<c0106c83>]
Code: 80 38 00 74 07 40 4a 83 fa ff 75 f4 29 c8 f6 04 24 10 89 c6

 >>EIP; c01cc84b <vsnprintf+1fb/3e0>   <=====
Trace; c01cca63 <vsprintf+13/20>
Trace; c01cca82 <sprintf+12/20>
Trace; c0188390 <proc_ide_read_driver+40/80>
Trace; c014cd2b <seq_printf+4cab/5330>
Trace; c0131fd5 <default_llseek+275/a50>
Trace; c013aadd <getname+5d/a0>
Trace; c0131af3 <get_unused_fd+1a3/1f0>
Trace; c0106c83 <__up_wakeup+10c7/1484>
Code;  c01cc84b <vsnprintf+1fb/3e0>
00000000 <_EIP>:
Code;  c01cc84b <vsnprintf+1fb/3e0>   <=====
    0:   80 38 00                  cmpb   $0x0,(%eax)   <=====
Code;  c01cc84e <vsnprintf+1fe/3e0>
    3:   74 07                     je     c <_EIP+0xc> c01cc857 
<vsnprintf+207/3e0>
Code;  c01cc850 <vsnprintf+200/3e0>
    5:   40                        inc    %eax
Code;  c01cc851 <vsnprintf+201/3e0>
    6:   4a                        dec    %edx
Code;  c01cc852 <vsnprintf+202/3e0>
    7:   83 fa ff                  cmp    $0xffffffff,%edx
Code;  c01cc855 <vsnprintf+205/3e0>
    a:   75 f4                     jne    0 <_EIP>
Code;  c01cc857 <vsnprintf+207/3e0>
    c:   29 c8                     sub    %ecx,%eax
Code;  c01cc859 <vsnprintf+209/3e0>
    e:   f6 04 24 10               testb  $0x10,(%esp,1)
Code;  c01cc85d <vsnprintf+20d/3e0>
   12:   89 c6                     mov    %eax,%esi





