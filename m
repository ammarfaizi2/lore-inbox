Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261501AbVCRI7b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261501AbVCRI7b (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 03:59:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261508AbVCRI7b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 03:59:31 -0500
Received: from moutng.kundenserver.de ([212.227.126.188]:39403 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261501AbVCRI7F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 03:59:05 -0500
Message-ID: <423A9856.7070909@whiteowl.co.uk>
Date: Fri, 18 Mar 2005 08:59:02 +0000
From: Simon Geard <simon@whiteowl.co.uk>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: USB pen drive connect/disconnect oops
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:af30f4b6ef93ce3756749c134795ccb9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I connect and disconnect my new USB Pen drive (BAR 512MB) I get 
stack dump messages from the kernel. The drive does seem to be usable at 
the end of this sequence albeit very slowly. Disconnection gives a 
kernel oops and the device isn't usable until the next reboot. Does 
anyone know if there is a patch to fix this problem?

Please cc any replies to me. Thanks

Simon Geard

Linux localhost 2.6.8.1-12mdk #1 Fri Oct 1 12:53:41 CEST 2004 i686 
Unknown CPU Type unknown GNU/Linux

Initializing USB Mass Storage driver...
scsi0 : SCSI emulation for USB Mass Storage devices
  Vendor: USB       Model: BAR               Rev: 2.00
  Type:   Direct-Access                      ANSI SCSI revision: 02
USB Mass Storage device found at 3
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
sda: Unit Not Ready, sense:
Current : sense key Unit Attention
Additional sense: Not ready to ready change, medium may have changed
sda : READ CAPACITY failed.
sda : status=1, message=00, host=0, driver=08
Current sd: sense key Unit Attention
Additional sense: Not ready to ready change, medium may have changed
sda: test WP failed, assume Write Enabled
sda: assuming drive cache: write through
sda: Unit Not Ready, sense:
Current : sense key Unit Attention
Additional sense: Not ready to ready change, medium may have changed
sda : READ CAPACITY failed.
sda : status=1, message=00, host=0, driver=08
Current sd: sense key Unit Attention
Additional sense: Not ready to ready change, medium may have changed
sda: test WP failed, assume Write Enabled
sda: assuming drive cache: write through
SCSI device sda: 1023744 512-byte hdwr sectors (524 MB)
sda: Write Protect is off
sda: Mode Sense: 03 00 00 00
sda: assuming drive cache: write through
 /dev/scsi/host0/bus0/target0/lun0:<3>Buffer I/O error on device sda, 
logical block 262143
Buffer I/O error on device sda, logical block 262143
 p1
 /dev/scsi/host0/bus0/target0/lun0:<3>Buffer I/O error on device sda, 
logical block 262143
 p1
devfs_mk_dev: could not append to parent for 
scsi/host0/bus0/target0/lun0/part1
kobject_register failed for sda1 (-17)
 [<c0107bfe>] dump_stack+0x1e/0x20
 [<c01c179b>] kobject_register+0x5b/0x70
 [<c018c433>] add_partition+0x103/0x140
 [<c018c61e>] register_disk+0x14e/0x1d0
 [<c021909b>] add_disk+0x4b/0x60
 [<e0b3f21d>] sd_probe+0x21d/0x380 [sd_mod]
 [<c021067d>] bus_match+0x3d/0x80
 [<c02107b2>] driver_attach+0x52/0xa0
 [<c0210cbf>] bus_add_driver+0x8f/0xc0
 [<c02112a1>] driver_register+0x31/0x40
 [<e0a2105a>] init_sd+0x5a/0x6f [sd_mod]
 [<c01337a2>] sys_init_module+0xd2/0x1c0
 [<c0106dcd>] sysenter_past_esp+0x52/0x71
Attached scsi removable disk sda at scsi0, channel 0, id 0, lun 0


When I disconnect the device I get

usb 4-2.1: USB disconnect, address 3
Unable to handle kernel NULL pointer dereference at virtual address 00000050
 printing eip:
c0192d61
*pde = 00000000
Oops: 0000 [#1]
Modules linked in: sd_mod usb-storage fglrx md5 ipv6 rfcomm l2cap 
bluetooth es1371 soundcore gameport ac97_codec lp parport_pc parport 
af_packet floppy 8139too mii ide-cd cdrom loop ext3 jbd nls_iso8859-15 
ntfs xfs supermount amd-k7-agp agpgart dc395x scsi_mod tsdev joydev 
evdev usbmouse ehci-hcd usbhid ohci-hcd uhci-hcd usbcore reiserfs
CPU:    0
EIP:    0060:[<c0192d61>]    Tainted: P   VLI
EFLAGS: 00010246   (2.6.8.1-12mdk)
EIP is at sysfs_remove_dir+0x21/0x110
eax: d0a79cf0   ebx: d0a79cf0   ecx: 00000000   edx: dffef360
esi: d04d6520   edi: 00000000   ebp: dedf9d90   esp: dedf9d74
ds: 007b   es: 007b   ss: 0068
Process khubd (pid: 815, threadinfo=dedf8000 task=df732c70)
Stack: d04d6520 00000001 dedf9d90 c01c1586 d0a79cf0 d04d6520 00000001 
dedf9da4
       c01c18f2 d0a79cf0 d0a79cf0 d0a79cf0 dedf9db4 c01c1912 d0a79cf0 
c1572800
       dedf9dd0 c018c929 d0a79cf0 00000001 d0569984 d04d6520 c1572200 
dedf9de4
Call Trace:
 [<c0107bbf>] show_stack+0x7f/0xa0
 [<c0107d56>] show_registers+0x156/0x1d0
 [<c0107ef6>] die+0x66/0xd0
 [<c0119b26>] do_page_fault+0x3c6/0x5b0
 [<c0107849>] error_code+0x2d/0x38
 [<c01c18f2>] kobject_del+0x22/0x30
 [<c01c1912>] kobject_unregister+0x12/0x20
 [<c018c929>] del_gendisk+0x29/0xf0
 [<e0b3f39d>] sd_remove+0x1d/0x60 [sd_mod]
 [<c0210866>] device_release_driver+0x66/0x70
 [<c0210ad2>] bus_remove_device+0x62/0xa0
 [<c020f8d9>] device_del+0x59/0xc0
 [<e0ad6196>] scsi_remove_device+0x56/0xb0 [scsi_mod]
 [<e0ad54aa>] scsi_forget_host+0x2a/0x50 [scsi_mod]
 [<e0ace228>] scsi_remove_host+0x28/0x60 [scsi_mod]
 [<e0b9109d>] storage_disconnect+0x5d/0x70 [usb-storage]
 [<e0a420fd>] usb_unbind_interface+0x6d/0x70 [usbcore]
 [<c0210866>] device_release_driver+0x66/0x70
 [<c0210ad2>] bus_remove_device+0x62/0xa0
 [<c020f8d9>] device_del+0x59/0xc0
 [<e0a496b8>] usb_disable_device+0x88/0x100 [usbcore]
 [<e0a44433>] usb_disconnect+0xb3/0x150 [usbcore]
 [<e0a45c0f>] hub_port_connect_change+0x23f/0x3d0 [usbcore]
 [<e0a45f43>] hub_events+0x1a3/0x3a0 [usbcore]
 [<e0a46175>] hub_thread+0x35/0x100 [usbcore]
 [<c01052c5>] kernel_thread_helper+0x5/0x10
Code: ff ff ff 8d b4 26 00 00 00 00 55 89 e5 57 56 53 83 ec 10 8b 45 08 
8b 78 30 85 ff 74 0c 8b 07 85 c0 0f 84 dc 00 00 00 ff 07 85 ff <8b> 57 
50 0f 84 c7 00 00 00 8b 47 08 8d 48 68 ff 48 68 0f 88 6e


