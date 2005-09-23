Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751175AbVIWTWN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751175AbVIWTWN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 15:22:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751179AbVIWTWN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 15:22:13 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:3301 "EHLO smtp2-g19.free.fr")
	by vger.kernel.org with ESMTP id S1751175AbVIWTWN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 15:22:13 -0400
From: Arnaud Boulan <arnaud.boulan@libertysurf.fr>
To: linux-kernel@vger.kernel.org
Subject: reiserfs problem after usb hard drive disconnected
Date: Fri, 23 Sep 2005 21:21:51 +0200
User-Agent: KMail/1.8.2
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_QXFNDmoaiPyELfm"
Message-Id: <200509232121.52803.arnaud.boulan@libertysurf.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_QXFNDmoaiPyELfm
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

I am using an external USB hard drive, and i hit a bug in the reiserfs code 
after the drive got disconnected by a power problem. You can see this in the 
attached logs.
The disconnection of the hard drive was not done manually, it has been 
offlined "spontaneously" by what seems to be a power loss. In fact, i suspect 
i have bad power at home since i have had other similar problems with another 
device (an usb tv tuner)

However, i already have disconnected my drive manually a few times by mistake,
and i always recovered from that by unmouting, running reiserfsck and 
remounting the device.

This time, although i can consider it is a hardware problem, it would have 
been nice if the kernel had also recovered from the USB problem. Instead, i 
couldn't unmount the filesystem and the usb stack was stucked, leaving no 
choice but to reboot...

I am using a vanilla 2.6.13 kernel

Regards,
Arnaud

ps: please cc me for any reply since i'm not subscribed

--Boundary-00=_QXFNDmoaiPyELfm
Content-Type: text/plain;
  charset="us-ascii";
  name="kern.log-09-13"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="kern.log-09-13"

Sep 12 19:52:56 t42p usb 4-3: default language 0x0409
Sep 12 19:52:56 t42p usb 4-3: new device strings: Mfr=56, Product=78, SerialNumber=100
Sep 12 19:52:56 t42p usb 4-3: Product: USB2.0 Storage Device
Sep 12 19:52:56 t42p usb 4-3: Manufacturer: Cypress Semiconductor
Sep 12 19:52:56 t42p usb 4-3: SerialNumber: DEF107679C83
Sep 12 19:52:56 t42p usb 4-3: hotplug
Sep 12 19:52:56 t42p usb 4-3: adding 4-3:1.0 (config #1, interface 0)
Sep 12 19:52:56 t42p usb 4-3:1.0: hotplug
Sep 12 19:52:56 t42p Initializing USB Mass Storage driver...
Sep 12 19:52:56 t42p usb-storage 4-3:1.0: usb_probe_interface
Sep 12 19:52:56 t42p usb-storage 4-3:1.0: usb_probe_interface - got id
Sep 12 19:52:56 t42p scsi0 : SCSI emulation for USB Mass Storage devices
Sep 12 19:52:56 t42p usb-storage: device found at 6
Sep 12 19:52:56 t42p usb-storage: waiting for device to settle before scanning
Sep 12 19:52:56 t42p usbcore: registered new driver usb-storage
Sep 12 19:52:56 t42p USB Mass Storage support registered.
Sep 12 19:53:01 t42p Vendor: SAMSUNG   Model: MP0804H           Rev:  0 0
Sep 12 19:53:01 t42p Type:   Direct-Access                      ANSI SCSI revision: 00
Sep 12 19:53:01 t42p usb-storage: device scan complete
Sep 12 19:53:01 t42p SCSI device sda: 156368016 512-byte hdwr sectors (80060 MB)
Sep 12 19:53:01 t42p sda: assuming drive cache: write through
Sep 12 19:53:01 t42p SCSI device sda: 156368016 512-byte hdwr sectors (80060 MB)
Sep 12 19:53:01 t42p sda: assuming drive cache: write through
Sep 12 19:53:01 t42p sda: sda1
Sep 12 19:53:01 t42p Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Sep 12 19:53:11 t42p ReiserFS: sda1: found reiserfs format "3.6" with standard journal
Sep 12 19:53:18 t42p ReiserFS: sda1: using ordered data mode
Sep 12 19:53:18 t42p ReiserFS: sda1: journal params: device sda1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
Sep 12 19:53:18 t42p ReiserFS: sda1: checking transaction log (sda1)
Sep 12 19:53:18 t42p ReiserFS: sda1: Using r5 hash to sort names

[...]

Sep 13 20:53:47 t42p ehci_hcd 0000:00:1d.7: port 3 high speed
Sep 13 20:53:47 t42p ehci_hcd 0000:00:1d.7: GetStatus port 3 status 001005 POWER sig=se0 PE CONNECT
Sep 13 20:53:47 t42p usb 4-3: reset high speed USB device using ehci_hcd and address 6
Sep 13 20:53:47 t42p ehci_hcd 0000:00:1d.7: port 3 high speed
Sep 13 20:53:47 t42p ehci_hcd 0000:00:1d.7: GetStatus port 3 status 001005 POWER sig=se0 PE CONNECT
Sep 13 20:54:13 t42p ehci_hcd 0000:00:1d.7: port 3 high speed
Sep 13 20:54:13 t42p ehci_hcd 0000:00:1d.7: GetStatus port 3 status 001005 POWER sig=se0 PE CONNECT
Sep 13 20:54:13 t42p usb 4-3: reset high speed USB device using ehci_hcd and address 6
Sep 13 20:54:13 t42p ehci_hcd 0000:00:1d.7: port 3 high speed
Sep 13 20:54:13 t42p ehci_hcd 0000:00:1d.7: GetStatus port 3 status 001005 POWER sig=se0 PE CONNECT
Sep 13 20:54:13 t42p scsi: Device offlined - not ready after error recovery: host 0 channel 0 id 0 lun 0
Sep 13 20:54:13 t42p SCSI error : <0 0 0 0> return code = 0x50000
Sep 13 20:54:13 t42p end_request: I/O error, dev sda, sector 61921479
Sep 13 20:54:13 t42p scsi0 (0:0): rejecting I/O to offline device
Sep 13 20:54:13 t42p scsi0 (0:0): rejecting I/O to offline device
Sep 13 20:54:13 t42p scsi0 (0:0): rejecting I/O to offline device
Sep 13 20:54:13 t42p scsi0 (0:0): rejecting I/O to offline device
Sep 13 20:54:13 t42p scsi0 (0:0): rejecting I/O to offline device
Sep 13 20:54:13 t42p scsi0 (0:0): rejecting I/O to offline device
Sep 13 20:54:13 t42p scsi0 (0:0): rejecting I/O to offline device
Sep 13 20:54:13 t42p scsi0 (0:0): rejecting I/O to offline device
Sep 13 20:54:13 t42p scsi0 (0:0): rejecting I/O to offline device
Sep 13 20:54:13 t42p scsi0 (0:0): rejecting I/O to offline device
Sep 13 20:54:13 t42p scsi0 (0:0): rejecting I/O to offline device
Sep 13 20:54:13 t42p scsi0 (0:0): rejecting I/O to offline device
Sep 13 20:54:13 t42p scsi0 (0:0): rejecting I/O to offline device
Sep 13 20:54:13 t42p scsi0 (0:0): rejecting I/O to offline device
Sep 13 20:54:13 t42p scsi0 (0:0): rejecting I/O to offline device
Sep 13 20:54:13 t42p scsi0 (0:0): rejecting I/O to offline device
Sep 13 20:54:13 t42p scsi0 (0:0): rejecting I/O to offline device
Sep 13 20:54:13 t42p scsi0 (0:0): rejecting I/O to offline device
Sep 13 20:54:13 t42p scsi0 (0:0): rejecting I/O to offline device
Sep 13 20:54:13 t42p scsi0 (0:0): rejecting I/O to offline device
Sep 13 20:54:13 t42p scsi0 (0:0): rejecting I/O to offline device
Sep 13 20:54:13 t42p scsi0 (0:0): rejecting I/O to offline device
Sep 13 20:54:13 t42p scsi0 (0:0): rejecting I/O to offline device
Sep 13 20:54:13 t42p scsi0 (0:0): rejecting I/O to offline device
Sep 13 20:54:13 t42p scsi0 (0:0): rejecting I/O to offline device
Sep 13 20:54:13 t42p scsi0 (0:0): rejecting I/O to offline device
Sep 13 20:54:13 t42p scsi0 (0:0): rejecting I/O to offline device
Sep 13 20:54:13 t42p scsi0 (0:0): rejecting I/O to offline device
Sep 13 20:54:13 t42p scsi0 (0:0): rejecting I/O to offline device
Sep 13 20:54:13 t42p scsi0 (0:0): rejecting I/O to offline device
Sep 13 20:54:13 t42p scsi0 (0:0): rejecting I/O to offline device
Sep 13 20:54:13 t42p scsi0 (0:0): rejecting I/O to offline device
Sep 13 20:54:13 t42p scsi0 (0:0): rejecting I/O to offline device
Sep 13 20:54:13 t42p scsi0 (0:0): rejecting I/O to offline device
Sep 13 20:54:13 t42p scsi0 (0:0): rejecting I/O to offline device
Sep 13 20:54:13 t42p scsi0 (0:0): rejecting I/O to offline device
Sep 13 20:54:13 t42p scsi0 (0:0): rejecting I/O to offline device
Sep 13 20:54:13 t42p scsi0 (0:0): rejecting I/O to offline device
Sep 13 20:54:13 t42p scsi0 (0:0): rejecting I/O to offline device
Sep 13 20:54:13 t42p scsi0 (0:0): rejecting I/O to offline device
Sep 13 20:54:13 t42p scsi0 (0:0): rejecting I/O to offline device
Sep 13 20:54:13 t42p scsi0 (0:0): rejecting I/O to offline device
Sep 13 20:54:13 t42p scsi0 (0:0): rejecting I/O to offline device
Sep 13 20:54:13 t42p scsi0 (0:0): rejecting I/O to offline device
Sep 13 20:54:13 t42p scsi0 (0:0): rejecting I/O to offline device
Sep 13 20:54:13 t42p scsi0 (0:0): rejecting I/O to offline device
Sep 13 20:54:13 t42p Buffer I/O error on device sda1, logical block 7740177
Sep 13 20:54:13 t42p scsi0 (0:0): rejecting I/O to offline device
Sep 13 20:54:13 t42p Buffer I/O error on device sda1, logical block 618
Sep 13 20:54:13 t42p lost page write due to I/O error on sda1
Sep 13 20:54:13 t42p Buffer I/O error on device sda1, logical block 619
Sep 13 20:54:13 t42p lost page write due to I/O error on sda1
Sep 13 20:54:13 t42p Buffer I/O error on device sda1, logical block 620
Sep 13 20:54:13 t42p lost page write due to I/O error on sda1
Sep 13 20:54:13 t42p Buffer I/O error on device sda1, logical block 621
Sep 13 20:54:13 t42p lost page write due to I/O error on sda1
Sep 13 20:54:13 t42p Buffer I/O error on device sda1, logical block 622
Sep 13 20:54:13 t42p lost page write due to I/O error on sda1
Sep 13 20:54:13 t42p Buffer I/O error on device sda1, logical block 623
Sep 13 20:54:13 t42p lost page write due to I/O error on sda1
Sep 13 20:54:13 t42p Buffer I/O error on device sda1, logical block 624
Sep 13 20:54:13 t42p lost page write due to I/O error on sda1
Sep 13 20:54:13 t42p Buffer I/O error on device sda1, logical block 625
Sep 13 20:54:13 t42p lost page write due to I/O error on sda1
Sep 13 20:54:13 t42p Buffer I/O error on device sda1, logical block 626
Sep 13 20:54:13 t42p lost page write due to I/O error on sda1
Sep 13 20:54:13 t42p scsi0 (0:0): rejecting I/O to offline device
Sep 13 20:54:13 t42p REISERFS: abort (device sda1): Journal write error in flush_commit_list
Sep 13 20:54:13 t42p REISERFS: Aborting journal for filesystem on sda1
Sep 13 20:54:13 t42p ------------[ cut here ]------------
Sep 13 20:54:13 t42p kernel BUG at /usr/src/linux-2.6.13/fs/reiserfs/journal.c:666!
Sep 13 20:54:13 t42p invalid operand: 0000 [#1]
Sep 13 20:54:13 t42p PREEMPT 
Sep 13 20:54:13 t42p CPU:    0
Sep 13 20:54:13 t42p EIP:    0060:[<b01c3aab>]    Tainted: P      VLI
Sep 13 20:54:13 t42p EFLAGS: 00010246   (2.6.13) 
Sep 13 20:54:13 t42p EIP is at submit_ordered_buffer+0x1b/0x40
Sep 13 20:54:13 t42p eax: 0000002c   ebx: 00000001   ecx: eb37eb28   edx: b3c0ebdc
Sep 13 20:54:13 t42p esi: efd63e44   edi: f0cc20d4   ebp: dc382c58   esp: efd63dfc
Sep 13 20:54:13 t42p ds: 007b   es: 007b   ss: 0068
Sep 13 20:54:13 t42p Process reiserfs/0 (pid: 238, threadinfo=efd62000 task=efcea020)
Sep 13 20:54:13 t42p Stack: 010758ec 7a9313dc b01c3bec b3c0ebdc efd63e44 00000001 b01c3c79 efd63e44 
Sep 13 20:54:13 t42p b3b10d48 efd63e3c fffffffb b01c4025 efd63e44 b3b10d48 f0cc20d4 b01c3bb0 
Sep 13 20:54:13 t42p eb37eb28 b489d568 b3c0ebdc b3fb921c b3fb92ec b3fb9320 b3fb9354 b3fb9388 
Sep 13 20:54:13 t42p Call Trace:
Sep 13 20:54:13 t42p [<b01c3bec>] write_ordered_chunk+0x3c/0x60
Sep 13 20:54:13 t42p [<b01c3c79>] add_to_chunk+0x69/0xa0
Sep 13 20:54:13 t42p [<b01c4025>] write_ordered_buffers+0xd5/0x270
Sep 13 20:54:13 t42p [<b01c3bb0>] write_ordered_chunk+0x0/0x60
Sep 13 20:54:13 t42p [<b01c4748>] flush_commit_list+0x448/0x4d0
Sep 13 20:54:13 t42p [<b01c852e>] flush_async_commits+0x8e/0x90
Sep 13 20:54:13 t42p [<b012e7e3>] worker_thread+0x233/0x300
Sep 13 20:54:13 t42p [<b01c84a0>] flush_async_commits+0x0/0x90
Sep 13 20:54:13 t42p [<b0119800>] default_wake_function+0x0/0x20
Sep 13 20:54:13 t42p [<b0119800>] default_wake_function+0x0/0x20
Sep 13 20:54:13 t42p [<b012e5b0>] worker_thread+0x0/0x300
Sep 13 20:54:13 t42p [<b0133199>] kthread+0xa9/0xf0
Sep 13 20:54:13 t42p [<b01330f0>] kthread+0x0/0xf0
Sep 13 20:54:13 t42p [<b0101395>] kernel_thread_helper+0x5/0x10
Sep 13 20:54:13 t42p Code: 01 00 00 00 e8 97 29 fa ff 83 c4 08 c3 8d 76 00 83 ec 08 8b 54 24 0c ff 42 0c c7 42 24 10 3a 1c b0 0f ba 32 01 8b 02 a8 01 75 08 <0f> 0b 9a 02 18 7e 37 b0 89 54 24 04 c7 04 24 01 00 00 00 e8 5d 
Sep 13 20:54:13 t42p Badness in do_exit at /usr/src/linux-2.6.13/kernel/exit.c:787
Sep 13 20:54:13 t42p [<b01200d9>] do_exit+0x419/0x460
Sep 13 20:54:13 t42p [<b0104940>] do_invalid_op+0x0/0xb0
Sep 13 20:54:13 t42p [<b01045bb>] die+0x18b/0x190
Sep 13 20:54:13 t42p [<b01049e6>] do_invalid_op+0xa6/0xb0
Sep 13 20:54:13 t42p [<b0166de0>] bio_alloc+0x20/0x30
Sep 13 20:54:13 t42p [<b01c3aab>] submit_ordered_buffer+0x1b/0x40
Sep 13 20:54:13 t42p [<b021ad43>] radix_tree_gang_lookup_tag+0x63/0x80
Sep 13 20:54:13 t42p [<b0101a87>] __switch_to+0x27/0x210
Sep 13 20:54:13 t42p [<b035c47f>] schedule+0x34f/0x6c0
Sep 13 20:54:13 t42p [<b035c4f1>] schedule+0x3c1/0x6c0
Sep 13 20:54:13 t42p [<b0103d8b>] error_code+0x4f/0x54
Sep 13 20:54:13 t42p [<b011007b>] get_cur_freq+0x5b/0x60
Sep 13 20:54:13 t42p [<b01c3aab>] submit_ordered_buffer+0x1b/0x40
Sep 13 20:54:13 t42p [<b01c3bec>] write_ordered_chunk+0x3c/0x60
Sep 13 20:54:13 t42p [<b01c3c79>] add_to_chunk+0x69/0xa0
Sep 13 20:54:13 t42p [<b01c4025>] write_ordered_buffers+0xd5/0x270
Sep 13 20:54:13 t42p [<b01c3bb0>] write_ordered_chunk+0x0/0x60
Sep 13 20:54:13 t42p [<b01c4748>] flush_commit_list+0x448/0x4d0
Sep 13 20:54:13 t42p [<b01c852e>] flush_async_commits+0x8e/0x90
Sep 13 20:54:13 t42p [<b012e7e3>] worker_thread+0x233/0x300
Sep 13 20:54:13 t42p [<b01c84a0>] flush_async_commits+0x0/0x90
Sep 13 20:54:13 t42p [<b0119800>] default_wake_function+0x0/0x20
Sep 13 20:54:13 t42p [<b0119800>] default_wake_function+0x0/0x20
Sep 13 20:54:13 t42p [<b012e5b0>] worker_thread+0x0/0x300
Sep 13 20:54:13 t42p [<b0133199>] kthread+0xa9/0xf0
Sep 13 20:54:13 t42p [<b01330f0>] kthread+0x0/0xf0
Sep 13 20:54:13 t42p [<b0101395>] kernel_thread_helper+0x5/0x10
Sep 13 20:54:13 t42p ReiserFS: sda1: warning: clm-6006: writing inode 5602431 on readonly FS
Sep 13 20:54:13 t42p scsi0 (0:0): rejecting I/O to offline device
Sep 13 20:54:13 t42p scsi0 (0:0): rejecting I/O to offline device
Sep 13 20:54:18 t42p scsi0 (0:0): rejecting I/O to offline device
Sep 13 20:54:18 t42p printk: 13 messages suppressed.
Sep 13 20:54:18 t42p Buffer I/O error on device sda1, logical block 7776265
Sep 13 20:54:18 t42p lost page write due to I/O error on sda1
Sep 13 20:54:18 t42p scsi0 (0:0): rejecting I/O to offline device
Sep 13 20:54:18 t42p scsi0 (0:0): rejecting I/O to offline device
Sep 13 20:54:18 t42p scsi0 (0:0): rejecting I/O to offline device
Sep 13 20:54:18 t42p scsi0 (0:0): rejecting I/O to offline device
Sep 13 20:54:18 t42p scsi0 (0:0): rejecting I/O to offline device
Sep 13 20:54:18 t42p scsi0 (0:0): rejecting I/O to offline device
Sep 13 20:54:18 t42p scsi0 (0:0): rejecting I/O to offline device
Sep 13 20:54:18 t42p scsi0 (0:0): rejecting I/O to offline device
Sep 13 20:54:18 t42p scsi0 (0:0): rejecting I/O to offline device
Sep 13 20:54:18 t42p scsi0 (0:0): rejecting I/O to offline device
Sep 13 20:54:18 t42p scsi0 (0:0): rejecting I/O to offline device
Sep 13 20:54:18 t42p scsi0 (0:0): rejecting I/O to offline device
Sep 13 20:54:18 t42p scsi0 (0:0): rejecting I/O to offline device
Sep 13 20:54:18 t42p scsi0 (0:0): rejecting I/O to offline device
Sep 13 20:54:18 t42p scsi0 (0:0): rejecting I/O to offline device
Sep 13 20:54:18 t42p scsi0 (0:0): rejecting I/O to offline device
Sep 13 20:54:18 t42p scsi0 (0:0): rejecting I/O to offline device
Sep 13 20:54:18 t42p scsi0 (0:0): rejecting I/O to offline device
Sep 13 20:54:18 t42p scsi0 (0:0): rejecting I/O to offline device
Sep 13 20:54:18 t42p scsi0 (0:0): rejecting I/O to offline device
Sep 13 20:54:18 t42p scsi0 (0:0): rejecting I/O to offline device
Sep 13 20:54:18 t42p scsi0 (0:0): rejecting I/O to offline device
Sep 13 20:54:18 t42p scsi0 (0:0): rejecting I/O to offline device
Sep 13 20:54:18 t42p scsi0 (0:0): rejecting I/O to offline device
Sep 13 21:03:49 t42p scsi0 (0:0): rejecting I/O to offline device
Sep 13 21:03:49 t42p ReiserFS: sda1: warning: zam-7001: io error in reiserfs_find_entry
Sep 13 21:08:02 t42p usb 4-4.4: unlink qh8-0601/ef58b200 start 7 [8/16 us]
Sep 13 21:09:21 t42p SysRq : Keyboard mode set to XLATE
Sep 13 21:09:25 t42p SysRq : Emergency Sync
Sep 13 21:09:29 t42p SysRq : HELP : loglevel0-8 reBoot tErm Full kIll saK showMem Nice powerOff showPc unRaw Sync showTasks Unmount
Sep 13 21:09:36 t42p SysRq : Emergency Remount R/O


--Boundary-00=_QXFNDmoaiPyELfm--
