Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316576AbSHXRnu>; Sat, 24 Aug 2002 13:43:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316578AbSHXRnu>; Sat, 24 Aug 2002 13:43:50 -0400
Received: from lilzclust02.liwest.at ([212.33.55.12]:59841 "EHLO
	lilzcluster.liwest.at") by vger.kernel.org with ESMTP
	id <S316576AbSHXRnr>; Sat, 24 Aug 2002 13:43:47 -0400
Message-Id: <200208241747.g7OHlrX0001317889@lilzcluster.liwest.at>
Date: Sat, 24 Aug 2002 19:49:57 +0200
From: "J.G." <jg@cms.ac>
To: linux-kernel@vger.kernel.org
Subject: 2.4.20-pre2-ac4 crash when mounting cdrw-device (ide-scsi)
X-Mailer: Sylpheed version 0.8.1claws (GTK+ 1.2.10; )
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi

when mounting a cd in my cdrecorder (/dev/hdc, using initrd with ide-scsi module) i receive the following errors that also crash my system (only with sysrq-keys i can reboot).

first, everyday i'm getting those messages in /var/log/warn
without ever mounting my cdrom-devices

ide-scsi: hdc: unsupported command in request queue (0)
end_request: I/O error, dev 16:00 (hdc), sector 0
ide-scsi: hdc: unsupported command in request queue (0)
end_request: I/O error, dev 16:00 (hdc), sector 1
ide-scsi: hdc: unsupported command in request queue (0)
end_request: I/O error, dev 16:00 (hdc), sector 2
ide-scsi: hdc: unsupported command in request queue (0)

...and so on, there are quite many, i don't know yet when they start appearing
mounting cds in my dvd drive (/dev/hdb) works well.

those are the errors i receive:

-----
kernel BUG in header file at line 157
kernel BUG at panic.c:286!
invalid operand: 0000
CPU:    0
EIP:    0010:[__out_of_line_bug+15/32]    Not tainted
EFLAGS: 00010286
eax: 00000026   ebx: 00001000   ecx: dcdfc02c   edx: dcdfc000
esi: 00000001   edi: c16d6000   ebp: 00000000   esp: dcdfdd30
ds: 0018   es: 0018   ss: 0018
Process mount (pid: 20774, stackpage=dcdfd000)
Stack: c0265840 0000009d c01dd441 0000009d c16d9000 c033c4a0 dd961140 dd961000 
        00000000 c16d6000 00000001 c16d6000 c01dd63b c033c3f0 dd961140 c033c3f0 
        c033c4a0 dd961140 dd961000 00000000 00000000 c033c3f0 c01ddac9 c033c4a0 
Call Trace:    [ide_build_sglist+321/384] [ide_build_dmatable+91/416] [__ide_dma_read+41/288] [snd-pcm-oss:__insmod_snd-pcm-oss_O/lib/modules/2.4.20-pre2-ac4/kernel/s+-2180765/96] [snd-pcm-oss:__insmod_snd-pcm-oss_O/lib/modules/2.4.20-pre2-ac4/kernel/s+-2180405/96]
   [start_request+370/464] [ide_do_request+618/704] [ide_do_drive_cmd+218/272] [snd-pcm-oss:__insmod_snd-pcm-oss_O/lib/modules/2.4.20-pre2-ac4/kernel/s+-2177374/96] [scsi_dispatch_cmd+426/544] [scsi_old_done+0/1472]
   [scsi_request_fn+769/832] [snd-pcm-oss:__insmod_snd-pcm-oss_O/lib/modules/2.4.20-pre2-ac4/kernel/s+-1360576/96] [generic_unplug_device+32/48] [__run_task_queue+76/96] [block_sync_page+22/32] [___wait_on_page+134/192]
   [do_generic_file_read+693/1024] [generic_file_read+133/320] [file_read_actor+0/144] [sys_read+150/240] [system_call+51/56]

----
then it says "Segmentation fault"
after some short time i get this =>
----

Code: 0f 0b 1e 01 66 58 26 c0 eb fe 8d b4 26 00 00 00 00 83 ec 18 
scsi : aborting command due to timeout : pid 286, scsi0, channel 0, id 0, lun 0 0x28 00 00 00 00 00 00 00 02 00 
scsi : aborting command due to timeout : pid 287, scsi0, channel 0, id 0, lun 0 0x00 00 00 00 00 00 
modprobe: Can't locate module char-major-10-134
scsi : aborting command due to timeout : pid 286, scsi0, channel 0, id 0, lun 0 0x28 00 00 00 00 00 00 00 02 00 
SCSI host 0 abort (pid 286) timed out - resetting
SCSI bus is being reset for host 0 channel 0.
scsi : aborting command due to timeout : pid 286, scsi0, channel 0, id 0, lun 0 0x28 00 00 00 00 00 00 00 02 00 
SCSI host 0 abort (pid 286) timed out - resetting
-----

i have many! of those "resetting" lines in my log files.

then after some time i get those messages, though i think they appeared because kde crashed
-----

Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c0115a46
*pde = 11f10067
*pte = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[__wake_up+38/96]    Not tainted
EFLAGS: 00010046
eax: c168e750   ebx: 00000000   ecx: 00000000   edx: c168d300
esi: 00000000   edi: 00000282   ebp: d72f9ebc   esp: d72f9ea8
ds: 0018   es: 0018   ss: 0018
Process X (pid: 20244, stackpage=d72f9000)
Stack: c10fd25c c1680c68 d1f1c888 00000003 c1680c68 04de4065 c0128769 c10fd25c 
        00000001 c0125b6c c10fd25c dfaddd40 08e22870 08e22870 d4d3408c c0126392 
        dfaddd40 cc5eec40 08e22870 d1f1c888 04de4065 dfaddd40 08e22870 dfaddd5c 
 Call Trace:    [unlock_page+89/96] [do_wp_page+76/512] [handle_mm_fault+258/320] [do_page_fault+279/1076] [do_page_fault+0/1076]
   [unmap_fixup+310/336] [unmap_fixup+319/336] [do_munmap+492/624] [do_munmap+585/624] [do_munmap+605/624] [sys_munmap+55/96]
   [error_code+52/60]
 
 Code: 8b 03 0f 0d 00 3b 5d fc 74 22 8b 53 fc 8b 02 85 45 f8 74 ea 
  <1>Unable to handle kernel NULL pointer dereference at virtual address 00000000
printing eip:
c0115a46
*pde = 00000000
Oops: 0000
    0
EIP:    0010:[__wake_up+38/96]    Not tainted
EFLAGS: 00010046
eax: c168e750   ebx: 00000000   ecx: 00000000   edx: c168d300
esi: 00000000   edi: 00000282   ebp: cb61bebc   esp: cb61bea8
ds: 0018   es: 0018   ss: 0018
Process run-mozilla.sh (pid: 20633, stackpage=cb61b000)
Stack: c134bf98 c1680c68 ca3b3158 00000003 c1680c68 103af065 c0128769 c134bf98 
        00000001 c0125b6c c134bf98 dfadd4c0 40056848 40056848 daf6a400 c0126392 
        dfadd4c0 d1246bc0 40056848 ca3b3158 103af065 dfadd4c0 40056848 dfadd4dc 
 Call Trace:    [unlock_page+89/96] [do_wp_page+76/512] [handle_mm_fault+258/320] [do_page_fault+279/1076] [do_page_fault+0/1076]
   [do_generic_file_read+1011/1024] [generic_file_read+133/320] [file_read_actor+0/144] [error_code+52/60]
 
Code: 8b 03 0f 0d 00 3b 5d fc 74 22 8b 53 fc 8b 02 85 45 f8 74 ea 

-----
then again many "resetting" lines and =>
-----

 Unable to handle kernel NULL pointer dereference at virtual address 00000000
printing eip:
c0115a46
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[__wake_up+38/96]    Not tainted
EFLAGS: 00010046
eax: c168e750   ebx: 00000000   ecx: 00000000   edx: c168d300
esi: 00000000   edi: 00000282   ebp: dfa1de04   esp: dfa1ddf0
ds: 0018   es: 0018   ss: 0018
Process showconsole (pid: 20792, stackpage=dfa1d000)
Stack: c134bf98 c1680c68 00000306 00000003 c1680c68 00220004 c0128769 c134bf98 
        c16c1180 c013aae9 c134bf98 00000306 00220005 00001000 00000306 00001000 
        00220004 00000044 00220004 c0138b67 00000306 00220004 00001000 00220004 
 Call Trace:    [unlock_page+89/96] [grow_buffers+233/272] [getblk+39/64] [bread+24/112] [ext3_get_inode_loc+276/368]
   [ext3_read_inode+22/704] [get_new_inode+215/368] [iget4+182/208] [ext3_lookup+90/128] [real_lookup+83/192] [link_path_walk+1495/2144]
   [path_walk+26/32] [path_lookup+27/48] [__user_walk+38/64] [sys_lstat64+25/112] [system_call+51/56]

------------------

i've read other posts about problems with the ide-scsi module not being able to burn cds, but i can't even mount a normal iso9660 cd...

JG

---
here's some more info about my system, if you need more, plz tell me.

lspci -v (removed the sblive, realteak (8139) and radeon stuff)

00:00.0 Host bridge: Silicon Integrated Systems [SiS]: Unknown device 0745 (rev 01)
        Flags: bus master, medium devsel, latency 32
        Memory at d0000000 (32-bit, non-prefetchable) [size=64M]
        Capabilities: [c0] AGP version 2.0

00:01.0 PCI bridge: Silicon Integrated Systems [SiS] 5591/5592 AGP (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 64
        Bus: primary=00, secondary=01, subordinate=02, sec-latency=64
        I/O behind bridge: 0000b000-0000bfff
        Memory behind bridge: cfc00000-cfefffff
        Prefetchable memory behind bridge: bf900000-cfafffff

00:02.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513
        Flags: bus master, medium devsel, latency 0

00:02.2 USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 07) (prog-if 10 [OHCI])
        Subsystem: Silicon Integrated Systems [SiS] 7001
        Flags: bus master, medium devsel, latency 64, IRQ 5
        Memory at cfffe000 (32-bit, non-prefetchable) [size=4K]

00:02.3 USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 07) (prog-if 10 [OHCI])
        Subsystem: Silicon Integrated Systems [SiS] 7001
        Flags: bus master, medium devsel, latency 64, IRQ 10
        Memory at cffff000 (32-bit, non-prefetchable) [size=4K]

00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev d0) (prog-if 80 [Master])
        Subsystem: Silicon Integrated Systems [SiS] SiS5513 EIDE Controller (A,B step)
        Flags: bus master, fast devsel, latency 128
        I/O ports at ff00 [size=16]

---
part of the kernel config-file:
# ATA/IDE/MFM/RLL support
#
CONFIG_IDE_KNOWS=y
CONFIG_IDE=y

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=y
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
# CONFIG_IDEDISK_STROKE is not set
# CONFIG_BLK_DEV_IDEDISK_VENDOR is not set
# CONFIG_BLK_DEV_IDEDISK_FUJITSU is not set
# CONFIG_BLK_DEV_IDEDISK_IBM is not set
# CONFIG_BLK_DEV_IDEDISK_MAXTOR is not set
# CONFIG_BLK_DEV_IDEDISK_QUANTUM is not set
# CONFIG_BLK_DEV_IDEDISK_SEAGATE is not set
# CONFIG_BLK_DEV_IDEDISK_WD is not set
# CONFIG_BLK_DEV_COMMERIAL is not set
# CONFIG_BLK_DEV_TIVO is not set
# CONFIG_BLK_DEV_IDECS is not set
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_IDECD_BAILOUT=y
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
CONFIG_BLK_DEV_IDESCSI=m
# CONFIG_IDE_TASK_IOCTL is not set
# CONFIG_IDE_TASKFILE_IO is not set
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
# CONFIG_BLK_DEV_ISAPNP is not set
CONFIG_BLK_DEV_IDEPCI=y
# CONFIG_BLK_DEV_GENERIC is not set
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_PCI_WIP is not set
# CONFIG_IDEDMA_NEW_DRIVE_LISTINGS is not set
CONFIG_BLK_DEV_ADMA=y
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_WDC_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_AMD74XX_OVERRIDE is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_HPT34X_AUTODMA is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_BLK_DEV_NFORCE is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_PDC202XX_BURST is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_PDC202XX_FORCE is not set
# CONFIG_BLK_DEV_RZ1000 is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
CONFIG_BLK_DEV_SIS5513=y
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDE_CHIPSETS is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_IDEDMA_IVB is not set
# CONFIG_DMA_NONPCI is not set
CONFIG_BLK_DEV_IDE_MODES=y
# CONFIG_BLK_DEV_ATARAID is not set
# CONFIG_BLK_DEV_ATARAID_PDC is not set
# CONFIG_BLK_DEV_ATARAID_HPT is not set


# SCSI support

CONFIG_SCSI=y
CONFIG_BLK_DEV_SD=y
CONFIG_SD_EXTRA_DEVS=40
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=m
# CONFIG_BLK_DEV_SR_VENDOR is not set
CONFIG_SR_EXTRA_DEVS=4
CONFIG_CHR_DEV_SG=m
# CONFIG_SCSI_DEBUG_QUEUES is not set
CONFIG_SCSI_MULTI_LUN=y
# CONFIG_SCSI_CONSTANTS is not set
# CONFIG_SCSI_LOGGING is not set

