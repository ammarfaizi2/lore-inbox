Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262743AbSJRBzW>; Thu, 17 Oct 2002 21:55:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262776AbSJRBzW>; Thu, 17 Oct 2002 21:55:22 -0400
Received: from services.cam.org ([198.73.180.252]:12828 "EHLO mail.cam.org")
	by vger.kernel.org with ESMTP id <S262743AbSJRBzV>;
	Thu, 17 Oct 2002 21:55:21 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: linux-kernel@vger.kernel.org
Subject: usb storage sddr09 
Date: Thu, 17 Oct 2002 21:55:49 -0400
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200210172155.49349.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In the patch fest in the last couple of days usb storage support for sddr09 
has broken.  I see the following in the log (2.5.43-mm2):

Oct 17 21:37:07 oscar kernel: SCSI subsystem driver Revision: 1.00
Oct 17 21:37:07 oscar kernel: Initializing USB Mass Storage driver...
Oct 17 21:37:07 oscar kernel: scsi0 : SCSI emulation for USB Mass Storage devices
Oct 17 21:37:07 oscar kernel:   Vendor: Sandisk   Model: ImageMate SDDR-0  Rev: 0208
Oct 17 21:37:07 oscar kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02
Oct 17 21:37:07 oscar kernel: drivers/usb/core/usb.c: registered new driver usb-storage
Oct 17 21:37:07 oscar kernel: USB Mass Storage support registered.

Oct 17 21:37:07 oscar kernel: Attached scsi removable disk sda at scsi0, channel 0, id 0, lun 0
Oct 17 21:37:07 oscar kernel: sda : status = 0, message = 00, host = 7, driver = 00
Oct 17 21:37:07 oscar kernel: sddr09: Found Flash card, ID = 00 00 00 00: Manuf. unknown, 4096 MB
Oct 17 21:37:07 oscar kernel: sda : unsupported sector size 1.
Oct 17 21:37:07 oscar kernel: SCSI device sda: 0 1-byte hdwr sectors (0 MB)
Oct 17 21:37:07 oscar kernel: sda: Write Protect is off

mounting then complains /dev/sda1 is not a valid block device.  Also attempting to rmmod 
usb-storage gets:

Oct 17 21:53:12 oscar kernel: kernel BUG at drivers/base/core.c:269!
Oct 17 21:53:12 oscar kernel: invalid operand: 0000
Oct 17 21:53:12 oscar kernel: vfat af_packet snd-cs46xx snd-pcm snd-timer snd-rawmidi snd-seq-device snd-ac97-codec snd s
oundcore gameport softdog matroxfb_base matroxfb_g450 matroxfb_DAC1064 g450_pll matroxfb_accel fbcon-cfb32 fbcon-cfb8 fbc
on-cfb24 fbcon-cfb16 matroxfb_misc mga agpgart pppoe pppox ipchains msdos fat sd_mod floppy dummy bsd_comp ppp_generic sl
hc parport_pc lp parport ipip smbfs nls_cp850 nls_cp437 binfmt_aout autofs4 cdrom via-rhine mii tulip crc32 usb-storage s
csi_mod pl2303 usbserial hid
Oct 17 21:53:12 oscar kernel: CPU:    0
Oct 17 21:53:12 oscar kernel: EIP:    0060:[put_device+71/112]    Not tainted
Oct 17 21:53:12 oscar kernel: EFLAGS: 00010202
Oct 17 21:53:12 oscar kernel: EIP is at put_device+0x47/0x70
Oct 17 21:53:12 oscar kernel: eax: 00000000   ebx: df39bd64   ecx: df39bdfc   edx: c5be0000
Oct 17 21:53:12 oscar kernel: esi: dfacaa98   edi: c5b73000   ebp: dfacaa00   esp: c5be1f2c
Oct 17 21:53:12 oscar kernel: ds: 0068   es: 0068   ss: 0068
Oct 17 21:53:12 oscar kernel: Process rmmod (pid: 1353, threadinfo=c5be0000 task=c857b9c0)
Oct 17 21:53:12 oscar kernel: Stack: 00000000 df39bc00 e0958bb0 df39bd64 dfacac00 e0966000 c5b73000 e0966000
Oct 17 21:53:12 oscar kernel:        c03099d0 e096e3d8 c0197f09 c0311980 c031199c c0197f56 e096e3d8 e096e3d8
Oct 17 21:53:12 oscar kernel:        e0966000 c01c942c e096e3d8 c02402c0 e096bffb fffffff0 e096963c dfacacc0
Oct 17 21:53:12 oscar kernel: Call Trace:
Oct 17 21:53:12 oscar kernel:  [<e0958bb0>] scsi_unregister_host_R98f50472+0x214/0x4e8 [scsi_mod]
Oct 17 21:53:12 oscar kernel:  [<e096e3d8>] usb_storage_driver+0x18/0x7c [usb-storage]
Oct 17 21:53:12 oscar kernel:  [__remove_driver+41/48] __remove_driver+0x29/0x30
Oct 17 21:53:12 oscar kernel:  [remove_driver+70/76] remove_driver+0x46/0x4c
Oct 17 21:53:12 oscar kernel:  [<e096e3d8>] usb_storage_driver+0x18/0x7c [usb-storage]
Oct 17 21:53:12 oscar kernel:  [<e096e3d8>] usb_storage_driver+0x18/0x7c [usb-storage]
Oct 17 21:53:12 oscar kernel:  [usb_deregister+32/40] usb_deregister+0x20/0x28
Oct 17 21:53:12 oscar kernel:  [<e096e3d8>] usb_storage_driver+0x18/0x7c [usb-storage]
Oct 17 21:53:12 oscar kernel:  [<e096bffb>] __module_usb_device_size+0x4bf/0xcb5 [usb-storage]
Oct 17 21:53:12 oscar kernel:  [<e096963c>] usb_stor_exit+0x24/0x86 [usb-storage]
Oct 17 21:53:12 oscar kernel:  [free_module+23/192] free_module+0x17/0xc0
Oct 17 21:53:12 oscar kernel:  [sys_delete_module+284/628] sys_delete_module+0x11c/0x274
Oct 17 21:53:12 oscar kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Oct 17 21:53:12 oscar kernel:
Oct 17 21:53:12 oscar kernel: Code: 0f 0b 0d 01 69 70 23 c0 8b 83 d0 00 00 00 85 c0 74 06 53 ff
Oct 17 21:53:12 oscar /sbin/hotplug: no runnable /etc/hotplug/block.agent is installed

Last time I used the device was around 2.5.40 or so - it worked then, but was
much happier if I left a card in the reader during boot.

Ideas?
Ed Tomlinson



