Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268494AbTBWP2n>; Sun, 23 Feb 2003 10:28:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268505AbTBWP1K>; Sun, 23 Feb 2003 10:27:10 -0500
Received: from franka.aracnet.com ([216.99.193.44]:31967 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S268502AbTBWP0y>; Sun, 23 Feb 2003 10:26:54 -0500
Date: Sun, 23 Feb 2003 07:36:55 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 393] New: IDE-SCSI : bad: scheduling while atomic
Message-ID: <6860000.1046014615@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


http://bugme.osdl.org/show_bug.cgi?id=393

           Summary: IDE-SCSI : bad: scheduling while atomic
    Kernel Version: 2.5.62
            Status: NEW
          Severity: normal
             Owner: alan@lxorguk.ukuu.org.uk
         Submitter: rol@as2917.net
                CC: rol@as2917.net


Distribution: 
  RedHat 8.0

Hardware Environment:
  P4S8X MB
  P-IV 
  2 IDE HD
  1 IDE CD-ROM
  1 IDE DVD
  1 SCSI HD

Software Environment:
  Kernel 2.5.62
  Lilo contains :
image=/boot/vmlinuz-2.5.62-smp-acpi
        label=test
        append="panic=30 hdd=ide-scsi console=ttyS0 console=tty1"
        read-only

Problem Description:
While booting :
...
SIS5513: IDE controller at PCI slot 00:02.5
SIS5513: chipset revision 0
SIS5513: not 100% native mode: will probe irqs later
SiS648    ATA 133 controller
    ide0: BM-DMA at 0xa400-0xa407, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xa408-0xa40f, BIOS settings: hdc:DMA, hdd:DMA
hda: WDC WD800BB-00CAA1, ATA DISK drive
hdb: IC35L040AVER07-0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: MATSHITADVD-ROM SR-8584A, ATAPI CD/DVD-ROM drive
hdd: TDK CDRW4800B, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: host protected area => 1
hda: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=155061/16/63, UDMA(100)
 hda: hda1 hda2 hda3 < hda5 hda6 hda7 hda8 > hda4
hdb: host protected area => 1
hdb: 80418240 sectors (41174 MB) w/1916KiB Cache, CHS=79780/16/63, UDMA(100)
 hdb: hdb1 hdb2 hdb3 < hdb5 hdb6 >
hdc: ATAPI 32X DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
end_request: I/O error, dev hdc, sector 0
ide-floppy driver 0.99.newide
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.28
        <Adaptec 2940 Ultra2 SCSI adapter>
        aic7890/91: Ultra2 Wide Channel A, SCSI Id=7, 32/253 SCBs

(scsi0:A:0): 40.000MB/s transfers (20.000MHz, offset 127, 16bit)
  Vendor: FUJITSU   Model: MAN3367MP         Rev: 5507
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:0:0: Tagged Queuing enabled.  Depth 64
scsi1 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: TDK       Model: CDRW4800B         Rev: S7S3
  Type:   CD-ROM                             ANSI SCSI revision: 02
ide-scsi: abort called for 21
bad: scheduling while atomic!
Call Trace:
 [<c011e242>] schedule+0x34e/0x354
 [<c02bf623>] poke_blanked_console+0x53/0x6e
 [<c0109c2e>] __down+0xa4/0x11a
 [<c011e298>] default_wake_function+0x0/0x12
 [<c0123010>] __call_console_drivers+0x58/0x5a
 [<c0109e80>] __down_failed+0x8/0xc
 [<c031ddbd>] .text.lock.scsi_error+0x8e/0xa9
 [<c031d46e>] scsi_sleep_done+0x0/0x12
 [<c034a7c2>] idescsi_abort+0x116/0x120
 [<c034a6ac>] idescsi_abort+0x0/0x120
 [<c031ce89>] scsi_try_to_abort_cmd+0x83/0xaa
 [<c031cfb5>] scsi_eh_abort_cmd+0x33/0x64
 [<c031cf82>] scsi_eh_abort_cmd+0x0/0x64
 [<c031d897>] scsi_unjam_host+0xa1/0xea
 [<c0109e8b>] __down_failed_interruptible+0x7/0xc
 [<c031d9bb>] scsi_error_handler+0xdb/0x11c
 [<c031d8e0>] scsi_error_handler+0x0/0x11c
 [<c0108c65>] kernel_thread_helper+0x5/0xc

bad: scheduling while atomic!
Call Trace:
 [<c011e242>] schedule+0x34e/0x354
 [<c0109c2e>] __down+0xa4/0x11a
 [<c011e298>] default_wake_function+0x0/0x12
 [<c012a51a>] add_timer+0x7a/0xb8
 [<c0109e80>] __down_failed+0x8/0xc
 [<c031ddbd>] .text.lock.scsi_error+0x8e/0xa9
 [<c031d46e>] scsi_sleep_done+0x0/0x12
 [<c034a7c2>] idescsi_abort+0x116/0x120
 [<c034a6ac>] idescsi_abort+0x0/0x120
 [<c031ce89>] scsi_try_to_abort_cmd+0x83/0xaa
 [<c031cfb5>] scsi_eh_abort_cmd+0x33/0x64
 [<c031cf82>] scsi_eh_abort_cmd+0x0/0x64
 [<c031d897>] scsi_unjam_host+0xa1/0xea
 [<c0109e8b>] __down_failed_interruptible+0x7/0xc
 [<c031d9bb>] scsi_error_handler+0xdb/0x11c
 [<c031d8e0>] scsi_error_handler+0x0/0x11c
 [<c0108c65>] kernel_thread_helper+0x5/0xc

bad: scheduling while atomic!
Call Trace:
 [<c011e242>] schedule+0x34e/0x354
 [<c0109c2e>] __down+0xa4/0x11a
 [<c011e298>] default_wake_function+0x0/0x12
 [<c012a51a>] add_timer+0x7a/0xb8
 [<c0109e80>] __down_failed+0x8/0xc
 [<c031ddbd>] .text.lock.scsi_error+0x8e/0xa9
 [<c031d46e>] scsi_sleep_done+0x0/0x12
 [<c034a7c2>] idescsi_abort+0x116/0x120
 [<c034a6ac>] idescsi_abort+0x0/0x120
 [<c031ce89>] scsi_try_to_abort_cmd+0x83/0xaa
 [<c031cfb5>] scsi_eh_abort_cmd+0x33/0x64
 [<c031cf82>] scsi_eh_abort_cmd+0x0/0x64
 [<c031d897>] scsi_unjam_host+0xa1/0xea
 [<c0109e8b>] __down_failed_interruptible+0x7/0xc
 [<c031d9bb>] scsi_error_handler+0xdb/0x11c
 [<c031d8e0>] scsi_error_handler+0x0/0x11c
 [<c0108c65>] kernel_thread_helper+0x5/0xc

bad: scheduling while atomic!
Call Trace:
 [<c011e242>] schedule+0x34e/0x354
 [<c0109c2e>] __down+0xa4/0x11a
 [<c011e298>] default_wake_function+0x0/0x12
 [<c012a51a>] add_timer+0x7a/0xb8
 [<c0109e80>] __down_failed+0x8/0xc
 [<c031ddbd>] .text.lock.scsi_error+0x8e/0xa9
 [<c031d46e>] scsi_sleep_done+0x
Steps to reproduce:


