Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261987AbUGaUa4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261987AbUGaUa4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 16:30:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262085AbUGaUau
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 16:30:50 -0400
Received: from outmx017.isp.belgacom.be ([195.238.2.116]:39309 "EHLO
	outmx017.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S261987AbUGaUap (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 16:30:45 -0400
Message-ID: <410C016F.8050000@skynet.be>
Date: Sat, 31 Jul 2004 22:30:39 +0200
From: willy discart <willy.discart@skynet.be>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040413 Debian/1.6-5
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: using usb storage
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Ran into the following problem :


Using rsync to copy files to usb storage:

usr/X11R6/
usr/X11R6/ATI.2.TIMESTAMP
usr/X11R6/README.ati.2
usr/X11R6/bin/
usr/X11R6/bin/X
usr/X11R6/bin/XFree86
rsync: writefd_unbuffered failed to write 4 bytes: phase "unknown": 
Broken pipe
rsync error: error in rsync protocol data stream (code 12) at io.c(839)
rsync: writefd_unbuffered failed to write 69 bytes: phase "unknown": 
Broken pipe
rsync error: error in rsync protocol data stream (code 12) at io.c(839)


umount /disk
rmmod -v -f usb_storage
rmmod usb_storage, wait=no force

disconnect the usb storage, reconnect again :

usb 1-2.1: adding 1-2.1:1.0 (config #1, interface 0)
usb 1-2.1:1.0: hotplug
Initializing USB Mass Storage driver...
usb-storage 1-2.1:1.0: usb_probe_interface
usb-storage 1-2.1:1.0: usb_probe_interface - got id
kmem_cache_create: duplicate cache scsi_cmd_cache
------------[ cut here ]------------
kernel BUG at mm/slab.c:1392!
invalid operand: 0000 [#1]
PREEMPT
Modules linked in: usb_storage ds binfmt_misc thermal fan button 
processor ac        pro100 usbhid uhci_hcd usbcore yenta_socket 
pcmcia_core sd_mod battery snd_int       8x0 snd_ac97_codec snd_pcm_oss 
snd_mixer_oss snd_pcm snd_timer snd_page_alloc        d_mpu401_uart 
snd_rawmidi snd_seq_device snd
CPU:    0
EIP:    0060:[<c0135124>]    Not tainted
EFLAGS: 00010202   (2.6.7)
EIP is at kmem_cache_create+0x3f4/0x5a0
eax: 00000032   ebx: c13bea50   ecx: c03c0d8c   edx: c031e838
esi: c02f5437   edi: c02f5437   ebp: c466de0c   esp: c466ddd8
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 2423, threadinfo=c466c000 task=c95948d0)
Stack: c02e7e40 c02f5428 00000020 00002000 c466ddfc c13be99c c0000000 
ffffffe0
       c13be960 000000a0 cfe0e600 c0364440 cfe0e60c c466de38 c024e863 
c02f5428
       00000160 00000020 00002000 00000000 00000000 000001d8 cfe0e600 
d08bd820
Call Trace:
 [<c01047ef>] show_stack+0x7f/0xa0
 [<c0104996>] show_registers+0x156/0x1b0
 [<c0104b39>] die+0x89/0x100
 [<c0104f25>] do_invalid_op+0xb5/0xc0
 [<c0104475>] error_code+0x2d/0x38
 [<c024e863>] scsi_setup_command_freelist+0x83/0x110
 [<c024f934>] scsi_host_alloc+0x1b4/0x2c0
 [<d08ba957>] usb_stor_acquire_resources+0xc7/0x130 [usb_storage]
 [<d08bac71>] storage_probe+0xf1/0x190 [usb_storage]
 [<d08f20db>] usb_probe_interface+0xbb/0xc0 [usbcore]
 [<c021e9fd>] bus_match+0x3d/0x70
 [<c021eb3c>] driver_attach+0x5c/0xa0
 [<c021ee55>] bus_add_driver+0xa5/0xc0
 [<c021f301>] driver_register+0x31/0x40
 [<d08f219f>] usb_register+0x3f/0xa0 [usbcore]
 [<d0924021>] usb_stor_init+0x21/0x3c [usb_storage]
 [<c012aa05>] sys_init_module+0x135/0x280
 [<c01042cb>] syscall_call+0x7/0xb

Code: 0f 0b 70 05 8c 76 2e c0 8b 0b e9 56 ff ff ff 8b 47 34 c7 04

