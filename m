Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261278AbVFDVQe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261278AbVFDVQe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Jun 2005 17:16:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261277AbVFDVQe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Jun 2005 17:16:34 -0400
Received: from build.arklinux.osuosl.org ([140.211.166.26]:30080 "EHLO
	mail.arklinux.org") by vger.kernel.org with ESMTP id S261272AbVFDVQP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Jun 2005 17:16:15 -0400
From: Bernhard Rosenkraenzer <bero@arklinux.org>
Organization: Ark Linux team
To: linux-kernel@vger.kernel.org
Subject: 2.6.12-rc5-mm2: Problems with USB storage
Date: Sat, 4 Jun 2005 23:16:27 +0200
User-Agent: KMail/1.8
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506042316.27615.bero@arklinux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trying to use an USB 5-in-1 card reader that worked well last time I checked 
(2.6.10-mm2) with 2.6.12-rc5-mm2 results in:

usb 2-1: new full speed USB device using uhci_hcd and address 3
scsi1 : SCSI emulation for USB Mass Storage devices
usb-storage: device found at 3
usb-storage: waiting for device to settle before scanning
  Vendor: Generic   Model: STORAGE DEVICE    Rev: 9135
  Type:   Direct-Access                      ANSI SCSI revision: 00
usbcore: deregistering driver usb-storage
scsi: Device offlined - not ready after error recovery: host 1 channel 0 id 0 
lun 0
scsi1 (0:0): rejecting I/O to offline device
scsi1 (0:0): rejecting I/O to offline device
scsi1 (0:0): rejecting I/O to offline device
sda : READ CAPACITY failed.
sda : status=0, message=00, host=5, driver=04
sda : sense not available.
scsi1 (0:0): rejecting I/O to offline device
sda: Write Protect is off
sda: Mode Sense: 00 00 00 00
sda: assuming drive cache: write through


Trying to remove usb-storage (in an attempt to re-load it) Oopses:
Attached scsi removable disk sda at scsi1, channel 0, id 0, lun 0
usb-storage: device scan complete
BUG: atomic counter underflow at:
 [<c01c985a>] kref_put+0x4f/0xa1
 [<c01c8d1c>] unlink+0x29/0x2e
 [<c01c8c49>] kobject_put+0x1e/0x22
 [<c01c8ce9>] kobject_release+0x0/0xa
 [<e086c85a>] scsi_remove_device+0x87/0xc0 [scsi_mod]
 [<e086cb98>] __scsi_remove_target+0x70/0x8a [scsi_mod]
 [<e086bb2f>] scsi_forget_host+0x2b/0x46 [scsi_mod]
 [<e0864eec>] scsi_remove_host+0x12/0x10d [scsi_mod]
 [<c01172e5>] default_wake_function+0x0/0x18
 [<e0d7aa08>] storage_disconnect+0x62/0x7e [usb_storage]
 [<e0d02207>] usb_unbind_interface+0x78/0x7a [usbcore]
 [<c0228600>] __device_release_driver+0x82/0x84
 [<c022868f>] driver_detach+0x62/0x64
 [<e0d817c4>] usb_stor_exit+0x0/0x2e [usb_storage]
 [<c0228085>] bus_remove_driver+0x3b/0xb2
 [<e0d817c4>] usb_stor_exit+0x0/0x2e [usb_storage]
 [<c02288a1>] driver_unregister+0x10/0x1c
 [<e0d02317>] usb_deregister+0x34/0x42 [usbcore]
 [<e0d817d3>] usb_stor_exit+0xf/0x2e [usb_storage]
 [<c0131f55>] sys_delete_module+0x18a/0x1ee
 [<c0102d73>] sysenter_past_esp+0x54/0x75
Unable to handle kernel paging request at virtual address 766f6d65
 printing eip:
e086cb6b
*pde = 00000000
Oops: 0000 [#1]
Modules linked in: sr_mod ide_cd cdrom vfat fat eeprom i2c_sensor radeon drm 
i2c_algo_bit i2c_core intel_agp agpgart snd_intel8x0 snd_via82xx gameport 
snd_ac97_codec ac97_bus snd_pcm snd_timer snd_page_alloc snd_mpu401_uart 
snd_rawmidi snd_seq_device snd soundcore psmouse evdev binfmt_misc md5 ipv6 
pcmcia firmware_class yenta_socket rsrc_nonstatic pcmcia_core 8139too mii 
af_packet sd_mod tcp_bic ohci1394 ieee1394 usb_storage scsi_mod ehci_hcd 
uhci_hcd usbcore video thermal processor fan container button battery ac rtc
CPU:    0
EIP:    0060:[<e086cb6b>]    Not tainted VLI
EFLAGS: 00010002   (2.6.12-0.rc5.3ark)
EIP is at __scsi_remove_target+0x43/0x8a [scsi_mod]
eax: 00000000   ebx: 766f6d5d   ecx: 00000286   edx: 766f6d5d
esi: dad4fc00   edi: d78a7800   ebp: e0d87f08   esp: dd07fe2c
ds: 007b   es: 007b   ss: 0068
Process rmmod (pid: 3611, threadinfo=dd07f000 task=d745b030)
Stack: c5fa3c00 00000282 c78db800 dad4fc08 e086bb2f d78a7800 dad4fe50 dad4fc00
       e0d87ec0 e0864eec dad4fc00 00000001 00000000 00000000 dad4fe58 00000292
       00000001 d745b030 c01172e5 00100100 00200200 00000286 e0d87ec0 dd07fea4
Call Trace:
 [<e086bb2f>] scsi_forget_host+0x2b/0x46 [scsi_mod]
 [<e0864eec>] scsi_remove_host+0x12/0x10d [scsi_mod]
 [<c01172e5>] default_wake_function+0x0/0x18
 [<e0d7aa08>] storage_disconnect+0x62/0x7e [usb_storage]
 [<e0d02207>] usb_unbind_interface+0x78/0x7a [usbcore]
 [<c0228600>] __device_release_driver+0x82/0x84
 [<c022868f>] driver_detach+0x62/0x64
 [<e0d817c4>] usb_stor_exit+0x0/0x2e [usb_storage]
 [<c0228085>] bus_remove_driver+0x3b/0xb2
 [<e0d817c4>] usb_stor_exit+0x0/0x2e [usb_storage]
 [<c02288a1>] driver_unregister+0x10/0x1c
 [<e0d02317>] usb_deregister+0x34/0x42 [usbcore]
 [<e0d817d3>] usb_stor_exit+0xf/0x2e [usb_storage]
 [<c0131f55>] sys_delete_module+0x18a/0x1ee
 [<c0102d73>] sysenter_past_esp+0x54/0x75
Code: 89 1c 24 e8 70 83 ff ff 85 c0 74 eb 8d b3 20 ff ff ff 9c 59 fa 83 87 14 
01 00 00 01 8b 06 8d 50 f8 8b 5a 08 83 eb 08 eb 0b 89 da <8b> 5b 08 83 eb 08 
8d 42 08 39 f0 74 29 8b 87 18 01 00 00 39 42

