Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267776AbTBMIuu>; Thu, 13 Feb 2003 03:50:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267961AbTBMIuu>; Thu, 13 Feb 2003 03:50:50 -0500
Received: from stroke.of.genius.brain.org ([206.80.113.1]:22524 "EHLO
	stroke.of.genius.brain.org") by vger.kernel.org with ESMTP
	id <S267776AbTBMIus>; Thu, 13 Feb 2003 03:50:48 -0500
Date: Thu, 13 Feb 2003 04:00:29 -0500
From: "Murray J. Root" <murrayr@brain.org>
To: linux-kernel@vger.kernel.org
Subject: 2.5.60 - BUG() in usb-storage
Message-ID: <20030213090029.GA2304@Master.Wizards>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ASUS P4S533 (SiS645DX)
SanDisk SDDR-77 ImageMate

Attaching SanDisk, insert card, mount:

Feb 13 03:40:05 Master kernel: hub 1-0:0: debounce: port 2: delay 100ms stable 4 status 0x101
Feb 13 03:40:05 Master kernel: hub 1-0:0: new USB device on port 2, assigned address 2
Feb 13 03:40:05 Master kernel: APIC error on CPU0: 40(40)
Feb 13 03:40:06 Master kernel: usb 1-2: Product: ImageMate CF-MS 
Feb 13 03:40:06 Master kernel: usb 1-2: Manufacturer: SanDisk
Feb 13 03:40:06 Master kernel: usb 1-2: SerialNumber: CBCD32354528
Feb 13 03:40:06 Master kernel: scsi0 : SCSI emulation for USB Mass Storage devices
Feb 13 03:40:06 Master kernel:   Vendor: SanDisk   Model: Imagemate CF-MCF  Rev: 0101
Feb 13 03:40:06 Master kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02
Feb 13 03:40:06 Master /sbin/hotplug: no runnable /etc/hotplug/scsi.agent is installed
Feb 13 03:40:06 Master /etc/hotplug/usb.agent: Bad USB agent invocation
Feb 13 03:40:06 Master /sbin/hotplug: no runnable /etc/hotplug/scsi.agent is installed
Feb 13 03:40:06 Master kernel: Attached scsi removable disk sda at scsi0, channel 0, id 0, lun 0
Feb 13 03:40:09 Master /etc/hotplug/usb.agent: Setup usb-storage for USB product 781/820/12
Feb 13 03:41:02 Master kernel: SCSI device sda: 15680 512-byte hdwr sectors (8 MB)
Feb 13 03:41:02 Master kernel: sda: Write Protect is off
Feb 13 03:41:32 Master kernel: sda: asking for cache data failed
Feb 13 03:41:32 Master kernel: sda: assuming drive cache: write through
Feb 13 03:41:40 Master su(pam_unix)[2240]: session opened for user root by grimau(uid=501)
Feb 13 03:41:50 Master kernel: SCSI device sda: 15680 512-byte hdwr sectors (8 MB)
Feb 13 03:41:50 Master kernel: sda: Write Protect is off
Feb 13 03:42:20 Master kernel: sda: asking for cache data failed
Feb 13 03:42:20 Master kernel: sda: assuming drive cache: write through
Feb 13 03:42:20 Master kernel:  sda:<7>usb-storage: queuecommand() called
Feb 13 03:42:50 Master kernel:  sda1

Write to CF card then try to umount it:

Feb 13 03:44:30 Master kernel: drivers/usb/core/message.c: driver for bus 00:02.2 dev 2 ep 2-out corrupted data!
Feb 13 03:44:56 Master kernel: SCSI device not inactive - rq_status=65534, target=0, pid=71, state=4099, owner=258.
Feb 13 03:44:56 Master kernel: Device busy???
Feb 13 03:44:56 Master kernel: ------------[ cut here ]------------
Feb 13 03:44:56 Master kernel: kernel BUG at drivers/usb/storage/usb.c:981!
Feb 13 03:44:56 Master kernel: invalid operand: 0000
Feb 13 03:44:56 Master kernel: CPU:    0
Feb 13 03:44:56 Master kernel: EIP:    0060:[<fa9e6b9f>]    Not tainted
Feb 13 03:44:56 Master kernel: EFLAGS: 00010286
Feb 13 03:44:56 Master kernel: EIP is at storage_disconnect+0xcb/0x561952c [usb_storage]
Feb 13 03:44:56 Master kernel: eax: 0000002e   ebx: f72c4d98   ecx: 00000001   edx: c03ffc7c
Feb 13 03:44:56 Master kernel: esi: f72c4c80   edi: f72c4d98   ebp: edf7df20   esp: edf7df14
Feb 13 03:44:56 Master kernel: ds: 007b   es: 007b   ss: 0068
Feb 13 03:44:56 Master kernel: Process scsi_eh_0 (pid: 2142, threadinfo=edf7c000 task=f254f380)
Feb 13 03:44:56 Master kernel: Stack: fa9ef300 fa9f5118 fa9f5100 edf7df48 c02bc3a1 f72c4d80 c0280103 c028a29a 
Feb 13 03:44:56 Master kernel:        f72c4c80 f72c4d80 f72c4d98 00000000 00000000 edf7df68 fa9e326b f72c4d98 
Feb 13 03:44:56 Master kernel:        fa9f1f5d f72c4c80 edf7c000 00000286 ebdc1200 edf7df84 c028aaa6 ebdc1200 
Feb 13 03:44:56 Master kernel: Call Trace:
Feb 13 03:44:56 Master kernel:  [<fa9ef300>] +0x1c20/0x5612920 [usb_storage]
Feb 13 03:44:56 Master kernel:  [<fa9f5118>] usb_storage_driver+0x18/0x560af00 [usb_storage]
Feb 13 03:44:56 Master kernel:  [<fa9f5100>] usb_storage_driver+0x0/0x560af00 [usb_storage]
Feb 13 03:44:56 Master kernel:  [usb_device_remove+155/247] usb_device_remove+0x9b/0xf7
Feb 13 03:44:56 Master kernel:  [<c02bc3a1>] usb_device_remove+0x9b/0xf7
Feb 13 03:44:56 Master kernel:  [cdrom_start_write+71/140] cdrom_start_write+0x47/0x8c
Feb 13 03:44:56 Master kernel:  [<c0280103>] cdrom_start_write+0x47/0x8c
Feb 13 03:44:56 Master kernel:  [scsi_eh_times_out+0/60] scsi_eh_times_out+0x0/0x3c
Feb 13 03:44:56 Master kernel:  [<c028a29a>] scsi_eh_times_out+0x0/0x3c
Feb 13 03:44:56 Master kernel:  [<fa9e326b>] usb_storage_bus_reset+0xee/0x561ce83 [usb_storage]
Feb 13 03:44:56 Master kernel:  [<fa9f1f5d>] +0x601/0x560e6a4 [usb_storage]
Feb 13 03:44:56 Master kernel:  [scsi_try_bus_reset+93/207] scsi_try_bus_reset+0x5d/0xcf
Feb 13 03:44:56 Master kernel:  [<c028aaa6>] scsi_try_bus_reset+0x5d/0xcf
Feb 13 03:44:56 Master kernel:  [scsi_eh_bus_host_reset+85/189] scsi_eh_bus_host_reset+0x55/0xbd
Feb 13 03:44:56 Master kernel:  [<c028ac3c>] scsi_eh_bus_host_reset+0x55/0xbd
Feb 13 03:44:56 Master kernel:  [scsi_unjam_host+199/227] scsi_unjam_host+0xc7/0xe3
Feb 13 03:44:56 Master kernel:  [<c028b13e>] scsi_unjam_host+0xc7/0xe3
Feb 13 03:44:56 Master kernel:  [__down_failed_interruptible+10/16] __down_failed_interruptible+0xa/0x10
Feb 13 03:44:56 Master kernel:  [<c0108442>] __down_failed_interruptible+0xa/0x10
Feb 13 03:44:56 Master kernel:  [scsi_error_handler+244/301] scsi_error_handler+0xf4/0x12d
Feb 13 03:44:56 Master kernel:  [<c028b24e>] scsi_error_handler+0xf4/0x12d
Feb 13 03:44:56 Master kernel:  [scsi_error_handler+0/301] scsi_error_handler+0x0/0x12d
Feb 13 03:44:56 Master kernel:  [<c028b15a>] scsi_error_handler+0x0/0x12d
Feb 13 03:44:56 Master kernel:  [kernel_thread_helper+5/11] kernel_thread_helper+0x5/0xb
Feb 13 03:44:56 Master kernel:  [<c01072f9>] kernel_thread_helper+0x5/0xb
Feb 13 03:44:56 Master kernel: 
Feb 13 03:44:56 Master kernel: Code: 0f 0b d5 03 8a 20 9f fa 83 c4 04 5b 5e 5d c3 8b 86 a8 00 00 

wmfire shows 100% CPU usage
top shows 99.7% IO-wait
umount process is in D state in ps

SanDisk light blinked a bit as if it were writing to the card. Haven't rebooted yet to
clear the device and see if anything was actually written.

-- 
Murray J. Root

