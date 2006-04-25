Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932184AbWDYKlA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932184AbWDYKlA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 06:41:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932187AbWDYKlA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 06:41:00 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:61104 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932184AbWDYKk7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 06:40:59 -0400
Message-ID: <444DFD53.2000108@in.ibm.com>
Date: Tue, 25 Apr 2006 16:13:31 +0530
From: Sachin Sant <sachinp@in.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051205
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Bug while executing : cat /proc/iomem on 2.6.17-rc1/rc2
Content-Type: multipart/mixed;
 boundary="------------080609010907020909080804"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080609010907020909080804
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I found this following problem while executing cat/proc/iomem. The 
command causes following BUG.

x236:/linux-2.6.17-rc1/fs # cat /proc/iomem
Segmentation fault
x236:/linux-2.6.17-rc1/fs #

Dmesg has this following stack trace.

Same problem with 2.6.17-rc2. But not with 2.6.16-rc6 [ some old 
precompiled 2.6.16 kernel i had on my machine ]. cat on /proc/ioports 
also causes similar BUG.

Attaching the dmesg log for reference. Arch is IA32.

BUG: unable to handle kernel NULL pointer dereference at virtual address 
00000010
  printing eip:
c011cdef
*pde = 00000000
Oops: 0000 [#1]
Modules linked in:
CPU:    0
EIP:    0060:[<c011cdef>]    Not tainted VLI
EFLAGS: 00010246   (2.6.17-rc1 #12)
EIP is at r_show+0x134/0x157
eax: 00000000   ebx: c05358e8   ecx: ffffffff   edx: 00000000
esi: f54a26c7   edi: c05358eb   ebp: f44f7f14   esp: f44f7ecc
ds: 007b   es: 007b   ss: 0068
Process cat (pid: 11983, threadinfo=f44f6000 task=f54a2540)
Stack: <0>c0157422 c70ff7c0 f4790920 00000000 c70fd6c8 f44f7eec c04ffb30 
c05bd9b8
        f44f7f14 c011cc45 f44f6000 f44f7f14 00000008 00000000 c05bd99c 
c721d280
        f54a26c5 c053961d f44f7f60 c017acf9 f5d94cc0 c721d280 f5f9e2c0 
f47afddc
Call Trace:
  <c01034c8> show_stack_log_lvl+0xcf/0xdf   <c01036b8> 
show_registers+0x192/0x208
  <c01038b1> die+0x100/0x1ee   <c0111858> do_page_fault+0x460/0x670
  <c01030bb> error_code+0x4f/0x54   <c017acf9> seq_read+0xc6/0x3f1
  <c015a3b4> vfs_read+0xa8/0x177   <c015a748> sys_read+0x47/0x6e
  <c0102e2b> sysenter_past_esp+0x54/0x75
Code: c0 83 c4 3c 5b 5e 5f 5d c3 8b 55 ec 8b 42 10 89 54 24 04 c7 04 24 
50 6a 53 c0 89 44 24 08 e8 af af ff ff e9 69 ff ff ff 8b 55 ec <8b> 42 
10 89 54 24 08 89 44 24 0c 8b 45 08 c7 04 24 74 6a 53 c0
  BUG: cat/11983, active lock [f5d94ce0(f5d94cc0-f5d94d40)] freed!
  <c01033f7> show_trace+0x20/0x22   <c0103524> dump_stack+0x1e/0x20
  <c012e199> mutex_debug_check_no_locks_freed+0x10e/0x17e   <c01578f2> 
kfree+0x40/0x73
  <c017b32e> seq_release+0x22/0x2a   <c015b4e9> __fput+0x163/0x192
  <c015b384> fput+0x18/0x1a   <c0159cb9> filp_close+0x45/0x6f
  <c0119428> close_files+0x7f/0x9e   <c0119497> put_files_struct+0x22/0x51
  <c0119f5c> do_exit+0x13b/0x404   <c010399f> do_trap+0x0/0xb4
  <c0111858> do_page_fault+0x460/0x670   <c01030bb> error_code+0x4f/0x54
  <c017acf9> seq_read+0xc6/0x3f1   <c015a3b4> vfs_read+0xa8/0x177
  <c015a748> sys_read+0x47/0x6e   <c0102e2b> sysenter_past_esp+0x54/0x75
  [f5d94ce0] {seq_open}
.. held by:               cat:11983 [f54a2540, 115]
... acquired at:               seq_read+0x27/0x3f1

Thanks
-Sachin

--------------080609010907020909080804
Content-Type: text/plain;
 name="dmesg.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg.log"

0:0: FAST-160 WIDE SCSI 320.0 MB/s DT IU RTI (6.25 ns, offset 127)
 target1:0:0: Ending Domain Validation
I/O scheduler cfq not found
  Vendor: IBM-ESXS  Model: GNS146C3ESTT0ZFN  Rev: JP83
  Type:   Direct-Access                      ANSI SCSI revision: 04
 target1:0:1: asynchronous
scsi1:A:1:0: Tagged Queuing enabled.  Depth 32
 target1:0:1: Beginning Domain Validation
 target1:0:1: wide asynchronous
 target1:0:1: FAST-160 WIDE SCSI 320.0 MB/s DT IU RTI (6.25 ns, offset 127)
 target1:0:1: Ending Domain Validation
I/O scheduler cfq not found
  Vendor: IBM-ESXS  Model: GNS146C3ESTT0ZFN  Rev: JP83
  Type:   Direct-Access                      ANSI SCSI revision: 04
 target1:0:2: asynchronous
scsi1:A:2:0: Tagged Queuing enabled.  Depth 32
 target1:0:2: Beginning Domain Validation
 target1:0:2: wide asynchronous
 target1:0:2: FAST-160 WIDE SCSI 320.0 MB/s DT IU RTI (6.25 ns, offset 127)
 target1:0:2: Ending Domain Validation
I/O scheduler cfq not found
  Vendor: IBM-ESXS  Model: MAT3147NC     FN  Rev: B411
  Type:   Direct-Access                      ANSI SCSI revision: 04
 target1:0:3: asynchronous
scsi1:A:3:0: Tagged Queuing enabled.  Depth 32
 target1:0:3: Beginning Domain Validation
 target1:0:3: wide asynchronous
 target1:0:3: FAST-160 WIDE SCSI 320.0 MB/s DT IU RDSTRM RTI WRFLOW PCOMP (6.25 ns, offset 127)
 target1:0:3: Ending Domain Validation
I/O scheduler cfq not found
  Vendor: IBM-ESXS  Model: GNS146C3ESTT0ZFN  Rev: JP83
  Type:   Direct-Access                      ANSI SCSI revision: 04
 target1:0:4: asynchronous
scsi1:A:4:0: Tagged Queuing enabled.  Depth 32
 target1:0:4: Beginning Domain Validation
 target1:0:4: wide asynchronous
 target1:0:4: FAST-160 WIDE SCSI 320.0 MB/s DT IU RTI (6.25 ns, offset 127)
 target1:0:4: Ending Domain Validation
I/O scheduler cfq not found
  Vendor: IBM-ESXS  Model: GNS146C3ESTT0ZFN  Rev: JP83
  Type:   Direct-Access                      ANSI SCSI revision: 04
 target1:0:5: asynchronous
scsi1:A:5:0: Tagged Queuing enabled.  Depth 32
 target1:0:5: Beginning Domain Validation
 target1:0:5: wide asynchronous
 target1:0:5: FAST-160 WIDE SCSI 320.0 MB/s DT IU RTI (6.25 ns, offset 127)
 target1:0:5: Ending Domain Validation
I/O scheduler cfq not found
I/O scheduler cfq not found
  Vendor: IBM       Model: 02R0962a S320  1  Rev: 1   
  Type:   Processor                          ANSI SCSI revision: 02
 target1:0:8: asynchronous
 target1:0:8: Beginning Domain Validation
 target1:0:8: Ending Domain Validation
I/O scheduler cfq not found
I/O scheduler cfq not found
I/O scheduler cfq not found
I/O scheduler cfq not found
I/O scheduler cfq not found
I/O scheduler cfq not found
I/O scheduler cfq not found
libata version 1.20 loaded.
SCSI device sda: 286748000 512-byte hdwr sectors (146815 MB)
sda: Write Protect is off
sda: Mode Sense: cb 00 10 08
SCSI device sda: drive cache: write through w/ FUA
SCSI device sda: 286748000 512-byte hdwr sectors (146815 MB)
sda: Write Protect is off
sda: Mode Sense: cb 00 10 08
SCSI device sda: drive cache: write through w/ FUA
 sda: sda1 sda2 < sda5 sda6 sda7 sda8 sda9 >
sd 1:0:0:0: Attached scsi disk sda
SCSI device sdb: 286748000 512-byte hdwr sectors (146815 MB)
sdb: Write Protect is off
sdb: Mode Sense: cb 00 10 08
SCSI device sdb: drive cache: write through w/ FUA
SCSI device sdb: 286748000 512-byte hdwr sectors (146815 MB)
sdb: Write Protect is off
sdb: Mode Sense: cb 00 10 08
SCSI device sdb: drive cache: write through w/ FUA
 sdb: sdb1 < sdb5 sdb6 sdb7 sdb8 >
sd 1:0:1:0: Attached scsi disk sdb
SCSI device sdc: 286748000 512-byte hdwr sectors (146815 MB)
sdc: Write Protect is off
sdc: Mode Sense: cb 00 10 08
SCSI device sdc: drive cache: write through w/ FUA
SCSI device sdc: 286748000 512-byte hdwr sectors (146815 MB)
sdc: Write Protect is off
sdc: Mode Sense: cb 00 10 08
SCSI device sdc: drive cache: write through w/ FUA
 sdc: sdc1 < sdc5 sdc6 sdc7 sdc8 sdc9 sdc10 >
sd 1:0:2:0: Attached scsi disk sdc
SCSI device sdd: 286748000 512-byte hdwr sectors (146815 MB)
sdd: Write Protect is off
sdd: Mode Sense: cf 00 00 08
SCSI device sdd: drive cache: write through
SCSI device sdd: 286748000 512-byte hdwr sectors (146815 MB)
sdd: Write Protect is off
sdd: Mode Sense: cf 00 00 08
SCSI device sdd: drive cache: write through
 sdd: sdd1 < sdd5 >
sd 1:0:3:0: Attached scsi disk sdd
SCSI device sde: 286748000 512-byte hdwr sectors (146815 MB)
sde: Write Protect is off
sde: Mode Sense: cb 00 10 08
SCSI device sde: drive cache: write through w/ FUA
SCSI device sde: 286748000 512-byte hdwr sectors (146815 MB)
sde: Write Protect is off
sde: Mode Sense: cb 00 10 08
SCSI device sde: drive cache: write through w/ FUA
 sde: unknown partition table
sd 1:0:4:0: Attached scsi disk sde
SCSI device sdf: 286748000 512-byte hdwr sectors (146815 MB)
sdf: Write Protect is off
sdf: Mode Sense: cb 00 10 08
SCSI device sdf: drive cache: write through w/ FUA
SCSI device sdf: 286748000 512-byte hdwr sectors (146815 MB)
sdf: Write Protect is off
sdf: Mode Sense: cb 00 10 08
SCSI device sdf: drive cache: write through w/ FUA
 sdf: sdf1 < sdf5 sdf6 sdf7 sdf8 >
sd 1:0:5:0: Attached scsi disk sdf
sd 1:0:0:0: Attached scsi generic sg0 type 0
sd 1:0:1:0: Attached scsi generic sg1 type 0
sd 1:0:2:0: Attached scsi generic sg2 type 0
sd 1:0:3:0: Attached scsi generic sg3 type 0
sd 1:0:4:0: Attached scsi generic sg4 type 0
sd 1:0:5:0: Attached scsi generic sg5 type 0
 1:0:8:0: Attached scsi generic sg6 type 3
ieee1394: raw1394: /dev/raw1394 device initialized
ACPI: PCI Interrupt Link [LP07] enabled at IRQ 5
ACPI: PCI Interrupt 0000:00:1d.7[D] -> Link [LP07] -> GSI 5 (level, low) -> IRQ 5
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: irq 5, io mem 0xf0000000
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 4 ports detected
USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt 0000:00:1d.0[A] -> Link [LP00] -> GSI 5 (level, low) -> IRQ 5
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.0: irq 5, io base 0x00002200
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.1[B] -> Link [LP03] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.1: irq 11, io base 0x00002600
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x64,0x60 irq 1,12
PNP: PS/2 controller has invalid data port 0x64; using default 0x60
PNP: PS/2 controller has invalid command port 0x60; using default 0x64
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
Advanced Linux Sound Architecture Driver Version 1.0.11rc4 (Wed Mar 22 10:27:24 2006 UTC).
ALSA device list:
  No soundcards found.
oprofile: using timer interrupt.
NET: Registered protocol family 2
input: AT Translated Set 2 keyboard as /class/input/input0
IP route cache hash table entries: 131072 (order: 7, 524288 bytes)
TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 8, 1310720 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
ip_conntrack version 2.4 (8192 buckets, 65536 max) - 172 bytes per conntrack
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Using IPI Shortcut mode
ACPI wakeup devices: 
PCI0 
ACPI: (supports S0 S4 S5)
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 204k freed
input: ImExPS/2 Generic Explorer Mouse as /class/input/input1
EXT3 FS on sda5, internal journal
Adding 4200956k swap on /dev/sda9.  Priority:42 extents:1 across:4200956k
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda8, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ReiserFS: sdb5: found reiserfs format "3.6" with standard journal
ReiserFS: sdb5: warning: CONFIG_REISERFS_CHECK is set ON
ReiserFS: sdb5: warning: - it is slow mode for debugging.
ReiserFS: sdb5: using ordered data mode
ReiserFS: sdb5: journal params: device sdb5, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: sdb5: checking transaction log (sdb5)
ReiserFS: sdb5: journal-1153: found in header: first_unflushed_offset 2566, last_flushed_trans_id 324114
ReiserFS: sdb5: journal-1206: Starting replay from offset 1392063325145606, trans_id 0
ReiserFS: sdb5: journal-1299: Setting newest_mount_id to 57
ReiserFS: sdb5: Using r5 hash to sort names
jfs_mount: Mount Failure: File System Dirty.
Mount JFS Failure: -22
jfs_mount failed w/return code = -22
XFS mounting filesystem sdb7
Ending clean XFS mount for filesystem: sdb7
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
e1000: eth0: e1000_watchdog_task: NIC Link is Up 100 Mbps Full Duplex
end_request: I/O error, dev fd0, sector 0
end_request: I/O error, dev fd0, sector 0
program hwscan is using a deprecated SCSI ioctl, please convert it to SG_IO
program hwscan is using a deprecated SCSI ioctl, please convert it to SG_IO
program hwscan is using a deprecated SCSI ioctl, please convert it to SG_IO
program hwscan is using a deprecated SCSI ioctl, please convert it to SG_IO
program hwscan is using a deprecated SCSI ioctl, please convert it to SG_IO
program hwscan is using a deprecated SCSI ioctl, please convert it to SG_IO
BUG: unable to handle kernel NULL pointer dereference at virtual address 00000010
 printing eip:
c011cdef
*pde = 00000000
Oops: 0000 [#1]
Modules linked in:
CPU:    0
EIP:    0060:[<c011cdef>]    Not tainted VLI
EFLAGS: 00010246   (2.6.17-rc1 #12) 
EIP is at r_show+0x134/0x157
eax: 00000000   ebx: c05358e8   ecx: ffffffff   edx: 00000000
esi: f54a26c7   edi: c05358eb   ebp: f44f7f14   esp: f44f7ecc
ds: 007b   es: 007b   ss: 0068
Process cat (pid: 11983, threadinfo=f44f6000 task=f54a2540)
Stack: <0>c0157422 c70ff7c0 f4790920 00000000 c70fd6c8 f44f7eec c04ffb30 c05bd9b8 
       f44f7f14 c011cc45 f44f6000 f44f7f14 00000008 00000000 c05bd99c c721d280 
       f54a26c5 c053961d f44f7f60 c017acf9 f5d94cc0 c721d280 f5f9e2c0 f47afddc 
Call Trace:
 <c01034c8> show_stack_log_lvl+0xcf/0xdf   <c01036b8> show_registers+0x192/0x208
 <c01038b1> die+0x100/0x1ee   <c0111858> do_page_fault+0x460/0x670
 <c01030bb> error_code+0x4f/0x54   <c017acf9> seq_read+0xc6/0x3f1
 <c015a3b4> vfs_read+0xa8/0x177   <c015a748> sys_read+0x47/0x6e
 <c0102e2b> sysenter_past_esp+0x54/0x75  
Code: c0 83 c4 3c 5b 5e 5f 5d c3 8b 55 ec 8b 42 10 89 54 24 04 c7 04 24 50 6a 53 c0 89 44 24 08 e8 af af ff ff e9 69 ff ff ff 8b 55 ec <8b> 42 10 89 54 24 08 89 44 24 0c 8b 45 08 c7 04 24 74 6a 53 c0 
 BUG: cat/11983, active lock [f5d94ce0(f5d94cc0-f5d94d40)] freed!
 <c01033f7> show_trace+0x20/0x22   <c0103524> dump_stack+0x1e/0x20
 <c012e199> mutex_debug_check_no_locks_freed+0x10e/0x17e   <c01578f2> kfree+0x40/0x73
 <c017b32e> seq_release+0x22/0x2a   <c015b4e9> __fput+0x163/0x192
 <c015b384> fput+0x18/0x1a   <c0159cb9> filp_close+0x45/0x6f
 <c0119428> close_files+0x7f/0x9e   <c0119497> put_files_struct+0x22/0x51
 <c0119f5c> do_exit+0x13b/0x404   <c010399f> do_trap+0x0/0xb4
 <c0111858> do_page_fault+0x460/0x670   <c01030bb> error_code+0x4f/0x54
 <c017acf9> seq_read+0xc6/0x3f1   <c015a3b4> vfs_read+0xa8/0x177
 <c015a748> sys_read+0x47/0x6e   <c0102e2b> sysenter_past_esp+0x54/0x75
 [f5d94ce0] {seq_open}
.. held by:               cat:11983 [f54a2540, 115]
... acquired at:               seq_read+0x27/0x3f1
 

--------------080609010907020909080804--
