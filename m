Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263014AbUA3LXw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 06:23:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263491AbUA3LXw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 06:23:52 -0500
Received: from wallaby.dingens.org ([213.133.123.121]:15495 "EHLO
	uml3.dingens.org") by vger.kernel.org with ESMTP id S263014AbUA3LXr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 06:23:47 -0500
Date: Fri, 30 Jan 2004 12:23:24 +0100
From: Markus Schaber <schabios@logi-track.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Errors with USB Disk
Message-Id: <20040130122324.7ac7ef34.schabios@logi-track.com>
Organization: Logi-Track AG, =?ISO-8859-15?Q?Z=FCrich?=
X-Mailer: Sylpheed version 0.9.6claws (GTK+ 1.2.10; i386-pc-linux-gnu)
X-Face: Nx5T&>Nj$VrVPv}sC3IL&)TqHHOKCz/|)R$i"*r@w0{*I6w;UNU_hdl1J4NI_m{IMztq=>cmM}1gCLbAF+9\#CGkG8}Y{x%SuQ>1#t:;Z(|\qdd[i]HStki~#w1$TPF}:0w-7"S\Ev|_a$K<GcL?@F\BY,ut6tC0P<$eV&ypzvlZ~R00!A
X-PGP-Key: http://schabi.de/pubkey.asc
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Fri__30_Jan_2004_12_23_24_+0100_=7/2O8KiMIE5H6xP"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart=_Fri__30_Jan_2004_12_23_24_+0100_=7/2O8KiMIE5H6xP
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi,

I'm trying to use an USB Disk (IDE Disk in external USB Case), but
strange file system errors occurend and tools as dosfsck reproducably
hang.

kingfisher:/home/schabi# uname -a
Linux kingfisher 2.6.0 #1 Wed Dec 24 19:16:00 CET 2003 i686 GNU/Linux
=20
kingfisher:/home/schabi# cat /proc/version
Linux version 2.6.0 (root@kingfisher) (gcc-Version 3.3.2 (Debian)) #1
Wed Dec 24 19:16:00 CET 2003

I attached a kernel log excerpt, it seems as there's a bug in the slab
allocater.

As I used 2.6.0, was there some work up to now (2.6.2rc2) in this area
so I should test using this newer kernel again?

I'm willing to do some debug work and run tests if you tell me what to
do, but I have very limited kernel developer knowledge.

Thanks,
Markus
--=20
markus schaber | dipl. informatiker
logi-track ag | rennweg 14-16 | ch 8001 z=FCrich
phone +41-43-888 62 52 | fax +41-43-888 62 53
mailto:schaber@logi-track.com | www.logi-track.com

--Multipart=_Fri__30_Jan_2004_12_23_24_+0100_=7/2O8KiMIE5H6xP
Content-Type: text/plain;
 name="bulgog.txt"
Content-Disposition: attachment;
 filename="bulgog.txt"
Content-Transfer-Encoding: 7bit

kingfisher:/home/schabi# tail -f /var/log/messages
Jan 21 00:26:48 kingfisher kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jan 21 00:26:48 kingfisher kernel: end_request: I/O error, dev sda, sector 431
Jan 21 00:27:38 kingfisher kernel: usb 1-5: USB disconnect, address 2
Jan 21 00:27:38 kingfisher kernel: hub 1-0:1.0: new USB device on port 5, assigned address 3
Jan 21 00:27:38 kingfisher kernel: scsi1 : SCSI emulation for USB Mass Storage devices
Jan 21 00:27:38 kingfisher kernel:   Vendor: ST312002  Model: 6A Rev: 0811
Jan 21 00:27:38 kingfisher kernel:   Type:   Direct-Access ANSI SCSI revision: 02
Jan 21 00:27:38 kingfisher kernel: SCSI device sda: 234441648 512-byte hdwr sectors (120034 MB)
Jan 21 00:27:38 kingfisher kernel:  sda: sda1
Jan 21 00:27:38 kingfisher kernel: Attached scsi disk sda at scsi1, channel 0, id 0, lun 0
Jan 21 00:30:43 kingfisher kernel: eth0: Media Link Off
Jan 21 00:31:23 kingfisher kernel: usb 1-5: USB disconnect, address 3
Jan 21 00:31:27 kingfisher kernel: scsi: Device offlined - not ready after error recovery: host 1 channel 0 id 0 lun 0
Jan 21 00:31:27 kingfisher kernel: SCSI error : <1 0 0 0> return code = 0x6040000
Jan 21 00:31:27 kingfisher kernel: end_request: I/O error, dev sda, sector 191
Jan 21 00:31:27 kingfisher kernel: Call Trace:
Jan 21 00:31:27 kingfisher kernel:  [kmem_cache_destroy+133/243] kmem_cache_destroy+0x85/0xf3
Jan 21 00:31:27 kingfisher kernel:  [scsi_destroy_command_freelist+89/135] scsi_destroy_command_freelist+0x59/0x87
Jan 21 00:31:27 kingfisher kernel:  [scsi_host_dev_release+50/138] scsi_host_dev_release+0x32/0x8a
Jan 21 00:31:27 kingfisher kernel:  [device_release+32/120] device_release+0x20/0x78
Jan 21 00:31:27 kingfisher kernel:  [scsi_block_when_processing_errors+126/128] scsi_block_when_processing_errors+0x7e/0x80
Jan 21 00:31:27 kingfisher kernel:  [kobject_cleanup+152/154] kobject_cleanup+0x98/0x9a
Jan 21 00:31:27 kingfisher kernel:  [acqseq_lock.5+608519974/1068914328] scsi_disk_put+0x19/0x29 [sd_mod]
Jan 21 00:31:27 kingfisher kernel:  [acqseq_lock.5+608520941/1068914328] sd_open+0xfc/0x103 [sd_mod]
Jan 21 00:31:27 kingfisher kernel:  [acqseq_lock.5+608520689/1068914328] sd_open+0x0/0x103 [sd_mod]
Jan 21 00:31:27 kingfisher kernel:  [do_open+947/1048] do_open+0x3b3/0x418
Jan 21 00:31:27 kingfisher kernel:  [bdev_test+0/20] bdev_test+0x0/0x14
Jan 21 00:31:27 kingfisher kernel:  [bdev_set+0/16] bdev_set+0x0/0x10
Jan 21 00:31:27 kingfisher kernel:  [blkdev_open+60/128] blkdev_open+0x3c/0x80
Jan 21 00:31:27 kingfisher kernel:  [dentry_open+317/510] dentry_open+0x13d/0x1fe
Jan 21 00:31:27 kingfisher kernel:  [filp_open+98/100] filp_open+0x62/0x64
Jan 21 00:31:27 kingfisher kernel:  [sys_open+91/139] sys_open+0x5b/0x8b
Jan 21 00:31:27 kingfisher kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jan 21 00:31:27 kingfisher kernel:
Jan 21 00:31:29 kingfisher kernel: hub 1-0:1.0: new USB device on port 5, assigned address 4
Jan 21 00:31:29 kingfisher kernel: kmem_cache_create: duplicate cache scsi_cmd_cache
Jan 21 00:31:29 kingfisher kernel: ------------[ cut here ]------------
Jan 21 00:31:29 kingfisher kernel: kernel BUG at mm/slab.c:1268!
Jan 21 00:31:29 kingfisher kernel: invalid operand: 0000 [#1]
Jan 21 00:31:29 kingfisher kernel: CPU:    0
Jan 21 00:31:29 kingfisher kernel: EIP:    0060:[kmem_cache_create+940/1180] Tainted: P
Jan 21 00:31:29 kingfisher kernel: EFLAGS: 00010202
Jan 21 00:31:29 kingfisher kernel: EIP is at kmem_cache_create+0x3ac/0x49c
Jan 21 00:31:29 kingfisher kernel: eax: 00000032   ebx: dfddd750   ecx: c04812f8   edx: c03ca6f8
Jan 21 00:31:29 kingfisher kernel: esi: c038fc8f   edi: c038fc8f   ebp: dfcafb6c   esp: dfdcdd54
Jan 21 00:31:29 kingfisher kernel: ds: 007b   es: 007b   ss: 0068
Jan 21 00:31:29 kingfisher kernel: Process khubd (pid: 5, threadinfo=dfdcc000 task=dff8e080)
Jan 21 00:31:29 kingfisher kernel: Stack: c037bc00 c038fc80 00002000 dfdcdd70 dfcafba8 ffffffff ffffff80 00000080
Jan 21 00:31:29 kingfisher kernel:        c9403400 c0404a00 c940340c c0404a28 c026949a c038fc80 00000180 00000080
Jan 21 00:31:29 kingfisher kernel:        00002000 00000000 00000000 000001c4 c9403400 c94035c4 c0408400 c026a453
Jan 21 00:31:29 kingfisher kernel: Call Trace:
Jan 21 00:31:29 kingfisher kernel:  [scsi_setup_command_freelist+116/252] scsi_setup_command_freelist+0x74/0xfc
Jan 21 00:31:29 kingfisher kernel:  [scsi_host_alloc+403/660] scsi_host_alloc+0x193/0x294
Jan 21 00:31:29 kingfisher kernel:  [default_wake_function+0/18] default_wake_function+0x0/0x12
Jan 21 00:31:29 kingfisher kernel:  [usb_stor_acquire_resources+172/263] usb_stor_acquire_resources+0xac/0x107
Jan 21 00:31:29 kingfisher kernel:  [storage_probe+265/451] storage_probe+0x109/0x1c3
Jan 21 00:31:29 kingfisher kernel:  [dput+34/530] dput+0x22/0x212
Jan 21 00:31:29 kingfisher kernel:  [usb_probe_interface+115/147] usb_probe_interface+0x73/0x93
Jan 21 00:31:29 kingfisher kernel:  [bus_match+63/106] bus_match+0x3f/0x6a
Jan 21 00:31:29 kingfisher kernel:  [device_attach+65/145] device_attach+0x41/0x91
Jan 21 00:31:29 kingfisher kernel:  [bus_add_device+91/159] bus_add_device+0x5b/0x9f
Jan 21 00:31:29 kingfisher kernel:  [device_add+161/288] device_add+0xa1/0x120
Jan 21 00:31:29 kingfisher kernel:  [usb_set_configuration+463/569] usb_set_configuration+0x1cf/0x239
Jan 21 00:31:29 kingfisher kernel:  [usb_new_device+589/1024] usb_new_device+0x24d/0x400
Jan 21 00:31:29 kingfisher kernel:  [hub_port_connect_change+442/788] hub_port_connect_change+0x1ba/0x314
Jan 21 00:31:29 kingfisher kernel:  [hub_events+723/838] hub_events+0x2d3/0x346
Jan 21 00:31:29 kingfisher kernel:  [hub_thread+45/228] hub_thread+0x2d/0xe4
Jan 21 00:31:29 kingfisher kernel:  [ret_from_fork+6/20] ret_from_fork+0x6/0x14
Jan 21 00:31:29 kingfisher kernel:  [default_wake_function+0/18] default_wake_function+0x0/0x12
Jan 21 00:31:29 kingfisher kernel:  [hub_thread+0/228] hub_thread+0x0/0xe4
Jan 21 00:31:29 kingfisher kernel:  [kernel_thread_helper+5/11] kernel_thread_helper+0x5/0xb
Jan 21 00:31:29 kingfisher kernel:
Jan 21 00:31:29 kingfisher kernel: Code: 0f 0b f4 04 f2 b3 37 c0 8b 0b e9 76 ff ff ff 8b 47 34 c7 04
 

kingfisher:/home/schabi# uname -a
Linux kingfisher 2.6.0 #1 Wed Dec 24 19:16:00 CET 2003 i686 GNU/Linux

kingfisher:/home/schabi# cat /proc/version
Linux version 2.6.0 (root@kingfisher) (gcc-Version 3.3.2 (Debian)) #1 Wed Dec 24 19:16:00 CET 2003


--Multipart=_Fri__30_Jan_2004_12_23_24_+0100_=7/2O8KiMIE5H6xP--
