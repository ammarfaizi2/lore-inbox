Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261413AbSKBUyh>; Sat, 2 Nov 2002 15:54:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261424AbSKBUyh>; Sat, 2 Nov 2002 15:54:37 -0500
Received: from ns1.alcove-solutions.com ([212.155.209.139]:4574 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S261413AbSKBUye>; Sat, 2 Nov 2002 15:54:34 -0500
Date: Sat, 2 Nov 2002 22:01:04 +0100
From: Luc Saillard <luc.saillard@fr.alcove.com>
To: linux-kernel@vger.kernel.org
Subject: oops when using ide-cd with 2.5.45 and cdrecord
Message-ID: <20021102210103.GA25617@cedar.alcove-fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I'm a using the last cdrecord version (1.11a39) when this oops occurs. I can't sync
my disks with alt-sys-request because we are in interrupt :(
Kernel is build with gcc ersion 2.95.4 20011002 (Debian prerelease). I've two
scsi drives, one scsi cdr and a new one in ide (cdrw). See the dmesg boot below.

Nov  2 21:16:08 darkland kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000000
Nov  2 21:16:08 darkland kernel: c01ca9ad
Nov  2 21:16:08 darkland kernel: *pde = 00000000
Nov  2 21:16:08 darkland kernel: Oops: 0000
Nov  2 21:16:08 darkland kernel: CPU:    0
Nov  2 21:16:08 darkland kernel: EIP:    0060:[ide_outsw+13/20]    Not tainted
Nov  2 21:16:08 darkland kernel: EFLAGS: 00210046
Nov  2 21:16:08 darkland kernel: eax: c01ca9a0   ebx: 0000f801   ecx: 00007c00   edx: 00000170
Nov  2 21:16:08 darkland kernel: esi: 00000000   edi: c034bf18   ebp: 00003e00   esp: ce959d78
Nov  2 21:16:08 darkland kernel: ds: 0068   es: 0068   ss: 0068
Nov  2 21:16:08 darkland kernel: Stack: c034be6c c01cad6a 00000170 00000000 00007c00 0000f801 c034bf18 c034be6c 
Nov  2 21:16:09 darkland kernel:        00000000 c01cadf3 c034bf18 00000000 00003e00 0000f800 d3d4d0e0 c01cadcc 
Nov  2 21:16:09 darkland kernel:        0000f800 c01d6a9e c034bf18 00000000 0000f800 ce958000 c13e1d60 c034bf18 
Nov  2 21:16:09 darkland kernel: Call Trace: [ata_output_data+122/132]  [atapi_output_bytes+39/88]  [atapi_output_bytes+0/88]  [cdrom_newpc_intr+846/1164]  [ide_intr+269/380]  [cdrom_newpc_intr+0/1164]  [handle_IRQ_event+41/76]  [do_IRQ+157/280]  [common_interrupt+24/32]  [vsnprintf+395/1052]  [vsprintf+22/28]  [sprintf+20/24]  [sprintf_stats+130/160]  [dev_get_info+70/168]  [proc_file_read+175/400]  [vfs_read+193/344]  [sys_read+42/60]  [syscall_call+7/11] 
Nov  2 21:16:09 darkland kernel: Code: f3 66 6f 5e c3 89 f6 8b 44 24 04 8b 54 24 08 ef c3 89 f6 56 
Using defaults from ksymoops -t elf32-i386 -a i386


>>eax; c01ca9a0 <ide_outsw+0/14>
>>edi; c034bf18 <ide_hwifs+838/4b78>
>>esp; ce959d78 <_end+e6020dc/145493c4>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   f3 66 6f                  repz outsw %ds:(%esi),(%dx)
Code;  00000003 Before first symbol
   3:   5e                        pop    %esi
Code;  00000004 Before first symbol
   4:   c3                        ret    
Code;  00000005 Before first symbol
   5:   89 f6                     mov    %esi,%esi
Code;  00000007 Before first symbol
   7:   8b 44 24 04               mov    0x4(%esp,1),%eax
Code;  0000000b Before first symbol
   b:   8b 54 24 08               mov    0x8(%esp,1),%edx
Code;  0000000f Before first symbol
   f:   ef                        out    %eax,(%dx)
Code;  00000010 Before first symbol
  10:   c3                        ret    
Code;  00000011 Before first symbol
  11:   89 f6                     mov    %esi,%esi
Code;  00000013 Before first symbol
  13:   56                        push   %esi

Nov  2 21:16:09 darkland kernel:  <0>Kernel panic: Aiee, killing interrupt handler!
Nov  2 21:16:09 darkland kernel: Call Trace: [__might_sleep+84/96]  [get_super+89/160]  [fsync_bdev+12/56]  [go_sync+320/344]  [do_emergency_sync+106/260]  [panic+222/224]  [do_exit+32/776]  [die+119/120]  [do_page_fault+759/1076]  [do_page_fault+0/1076]  [scsi_queue_next_request+86/352]  [__scsi_end_request+192/204]  [scsi_pool_alloc+15/20]  [mempool_alloc+127/368]  [__pagevec_free+31/40]  [error_code+45/56]  [ide_outsw+0/20]  [ide_outsw+13/20]  [ata_output_data+122/132]  [atapi_output_bytes+39/88]  [atapi_output_bytes+0/88]  [cdrom_newpc_intr+846/1164]  [ide_intr+269/380]  [cdrom_newpc_intr+0/1164]  [handle_IRQ_event+41/76]  [do_IRQ+157/280]  [common_interrupt+24/32]  [vsnprintf+395/1052]  [vsprintf+22/28]  [sprintf+20/24]  [sprintf_stats+130/160]  [dev_get_info+70/168]  [proc_file_read+175/400]  [vfs_read+193/344]  [sys_read+42/60]  [syscall_call+7/11] 


This is my new cdrw, my ide setting is the defaut setting so it is not using 32 bits access for the moment.

darkland:~# cat /proc/ide/hdc/settings
name                    value           min             max             mode
----                    -----           ---             ---             ----
current_speed           66              0               70              rw
dsc_overlap             0               0               1               rw
ide-scsi                0               0               1               rw
init_speed              66              0               70              rw
io_32bit                0               0               3               rw
keepsettings            0               0               1               rw
nice1                   1               0               1               rw
number                  2               0               3               rw
pio_mode                write-only      0               255             w
slow                    0               0               1               rw
unmaskirq               0               0               1               rw
using_dma               1               0               1               rw


dmesg output for ide/scsi part:

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller at PCI slot 00:07.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:pio
hda: IC35L060AVER07-0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: YAMAHA CRW-F1E, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: host protected area => 1
hda: 120103200 sectors (61493 MB) w/1916KiB Cache, CHS=119150/16/63, UDMA(33)
 hda: hda1
end_request: I/O error, dev 16:00, sector 0
end_request: I/O error, dev 16:00, sector 0
hdc: ATAPI 44X CD-ROM CD-R/RW drive, 8192kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
SCSI subsystem driver Revision: 1.00
PCI: Found IRQ 10 for device 00:0d.0
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.4
        <Adaptec 2940 Ultra SCSI adapter>
        aic7880: Ultra Wide Channel A, SCSI Id=7, 16/253 SCBs

(scsi0:A:0): 20.000MB/s transfers (20.000MHz, offset 15)
  Vendor: QUANTUM   Model: XP34550S          Rev: LXQ1
  Type:   Direct-Access                      ANSI SCSI revision: 02
scsi0:A:0:0: Tagged Queuing enabled.  Depth 253
(scsi0:A:1): 20.000MB/s transfers (20.000MHz, offset 15)
  Vendor: QUANTUM   Model: XP34550S          Rev: LXQ1
  Type:   Direct-Access                      ANSI SCSI revision: 02
scsi0:A:1:0: Tagged Queuing enabled.  Depth 253
  Vendor: MATSHITA  Model: CD-R   CW-7502    Rev: 4.17
  Type:   CD-ROM                             ANSI SCSI revision: 02
(scsi0:A:2): 10.000MB/s transfers (10.000MHz, offset 8)
scsi1 : SCSI host adapter emulation for IDE ATAPI devices
SCSI device : drive cache: write back
SCSI device : 8890760 512-byte hdwr sectors (4552 MB)
 sda: sda1 sda2 sda4 < sda5 sda6 >
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device : drive cache: write back
SCSI device : 8890760 512-byte hdwr sectors (4552 MB)
 sdb: sdb1 sdb2
Attached scsi disk sdb at scsi0, channel 0, id 1, lun 0
sr0: scsi3-mmc drive: 8x/8x writer xa/form2 cdda tray
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 2, lun 0



Luc
