Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267623AbTBYFKu>; Tue, 25 Feb 2003 00:10:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267645AbTBYFKt>; Tue, 25 Feb 2003 00:10:49 -0500
Received: from sycorax.lbl.gov ([128.3.5.196]:49809 "EHLO sycorax.lbl.gov")
	by vger.kernel.org with ESMTP id <S267623AbTBYFKp>;
	Tue, 25 Feb 2003 00:10:45 -0500
To: linux-kernel@vger.kernel.org
Subject: oops in 2.5.63: kernel BUG at drivers/usb/storage/usb.c:972
From: Alex Romosan <romosan@sycorax.lbl.gov>
Date: Mon, 24 Feb 2003 21:20:58 -0800
Message-ID: <87vfz9kkat.fsf@sycorax.lbl.gov>
User-Agent: Gnus/5.090015 (Oort Gnus v0.15) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

while trying (unsuccessfully) to connect my sony dsc-f717 digital
camera to my sony vayo laptop (pcg-xcg19, piii at 650 MHz) i got the
following oops when i turned off the camera (the memory stick was
recognized as a scsi device, but when i tried to mount it, the mount
command hung):

ksymoops 2.4.8 on i686 2.5.63.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.63/ (default)
     -m /boot/System.map-2.5.63 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Feb 24 20:22:40 trinculo kernel: kernel BUG at drivers/usb/storage/usb.c:972!
Feb 24 20:22:40 trinculo kernel: invalid operand: 0000
Feb 24 20:22:40 trinculo kernel: CPU:    0
Feb 24 20:22:40 trinculo kernel: EIP:    0060:[<d129efec>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Feb 24 20:22:40 trinculo kernel: EFLAGS: 00010202
Feb 24 20:22:40 trinculo kernel: eax: 00000001   ebx: c133f8a4   ecx: 00000001   edx: 00000001
Feb 24 20:22:40 trinculo kernel: esi: cd197200   edi: c133f394   ebp: cf1d3e84   esp: cf1d3e60
Feb 24 20:22:40 trinculo kernel: ds: 007b   es: 007b   ss: 0068
Feb 24 20:22:40 trinculo kernel: Stack: c133f8a4 cbd41800 cf1d3e94 c0189d80 cbaa6a44 c034ae10 cf2eadcc d12a3a98 
Feb 24 20:22:40 trinculo kernel:        d12a3a80 cf1d3eac d127c1b1 c133f37c cbaa6a44 cf1d3eac c01ad586 c133f37c 
Feb 24 20:22:40 trinculo kernel:        c133f394 d12a3a98 cbd41800 cf1d3ec4 c0210406 c133f394 c133f3c8 c133f394 
Feb 24 20:22:40 trinculo kernel: Call Trace:
Feb 24 20:22:40 trinculo kernel:  [<c0189d80>] dput+0x30/0x4b0
Feb 24 20:22:40 trinculo kernel:  [<d12a3a98>] usb_storage_driver+0x18/0xe0 [usb_storage]
Feb 24 20:22:40 trinculo kernel:  [<d12a3a80>] usb_storage_driver+0x0/0xe0 [usb_storage]
Feb 24 20:22:40 trinculo kernel:  [<d127c1b1>] usb_device_remove+0xa1/0x110 [usbcore]
Feb 24 20:22:40 trinculo kernel:  [<c01ad586>] hash_and_remove+0x56/0xa0
Feb 24 20:22:40 trinculo kernel:  [<d12a3a98>] usb_storage_driver+0x18/0xe0 [usb_storage]
Feb 24 20:22:40 trinculo kernel:  [<c0210406>] device_release_driver+0x66/0x70
Feb 24 20:22:40 trinculo kernel:  [<c021055c>] bus_remove_device+0x5c/0xa0
Feb 24 20:22:40 trinculo kernel:  [<c020f763>] device_del+0x63/0xa0
Feb 24 20:22:40 trinculo kernel:  [<c020f7b4>] device_unregister+0x14/0x22
Feb 24 20:22:40 trinculo kernel:  [<d127cce7>] usb_disconnect+0x97/0x100 [usbcore]
Feb 24 20:22:40 trinculo kernel:  [<d128d998>] +0x0/0x9e8 [usbcore]
Feb 24 20:22:40 trinculo kernel:  [<d1280007>] usb_hub_port_connect_change+0x317/0x320 [usbcore]
Feb 24 20:22:40 trinculo kernel:  [<d127f8f8>] usb_hub_port_status+0x68/0xb0 [usbcore]
Feb 24 20:22:40 trinculo kernel:  [<d12803d8>] usb_hub_events+0x3c8/0x560 [usbcore]
Feb 24 20:22:40 trinculo kernel:  [<d12805a5>] usb_hub_thread+0x35/0xf0 [usbcore]
Feb 24 20:22:40 trinculo kernel:  [<c0120f80>] default_wake_function+0x0/0x20
Feb 24 20:22:40 trinculo kernel:  [<d12988b8>] khubd_wait+0x18/0x20 [usbcore]
Feb 24 20:22:40 trinculo kernel:  [<d12988b8>] khubd_wait+0x18/0x20 [usbcore]
Feb 24 20:22:40 trinculo kernel:  [<d1280570>] usb_hub_thread+0x0/0xf0 [usbcore]
Feb 24 20:22:40 trinculo kernel:  [<c010763d>] kernel_thread_helper+0x5/0x18
Feb 24 20:22:40 trinculo kernel: Code: 0f 0b cc 03 d9 02 2a d1 83 c4 1c 5b 5e 5d c3 8b 86 c0 00 00 


>>EIP; d129efec <__crc_ide_raw_taskfile+7e3a8/174ad3>   <=====

>>ebx; c133f8a4 <__crc_memcpy_tokerneliovec+e181c/59b6f6>
>>esi; cd197200 <__crc_generic_commit_write+587ef/1af937>
>>edi; c133f394 <__crc_memcpy_tokerneliovec+e130c/59b6f6>
>>ebp; cf1d3e84 <__crc_driver_register+2641b1/429a61>
>>esp; cf1d3e60 <__crc_driver_register+26418d/429a61>

Trace; c0189d80 <dput+30/4b0>
Trace; d12a3a98 <__crc_ide_raw_taskfile+82e54/174ad3>
Trace; d12a3a80 <__crc_ide_raw_taskfile+82e3c/174ad3>
Trace; d127c1b1 <__crc_ide_raw_taskfile+5b56d/174ad3>
Trace; c01ad586 <hash_and_remove+56/a0>
Trace; d12a3a98 <__crc_ide_raw_taskfile+82e54/174ad3>
Trace; c0210406 <device_release_driver+66/70>
Trace; c021055c <bus_remove_device+5c/a0>
Trace; c020f763 <device_del+63/a0>
Trace; c020f7b4 <device_unregister+14/22>
Trace; d127cce7 <__crc_ide_raw_taskfile+5c0a3/174ad3>
Trace; d128d998 <__crc_ide_raw_taskfile+6cd54/174ad3>
Trace; d1280007 <__crc_ide_raw_taskfile+5f3c3/174ad3>
Trace; d127f8f8 <__crc_ide_raw_taskfile+5ecb4/174ad3>
Trace; d12803d8 <__crc_ide_raw_taskfile+5f794/174ad3>
Trace; d12805a5 <__crc_ide_raw_taskfile+5f961/174ad3>
Trace; c0120f80 <default_wake_function+0/20>
Trace; d12988b8 <__crc_ide_raw_taskfile+77c74/174ad3>
Trace; d12988b8 <__crc_ide_raw_taskfile+77c74/174ad3>
Trace; d1280570 <__crc_ide_raw_taskfile+5f92c/174ad3>
Trace; c010763d <kernel_thread_helper+5/18>

Code;  d129efec <__crc_ide_raw_taskfile+7e3a8/174ad3>
00000000 <_EIP>:
Code;  d129efec <__crc_ide_raw_taskfile+7e3a8/174ad3>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  d129efee <__crc_ide_raw_taskfile+7e3aa/174ad3>
   2:   cc                        int3   
Code;  d129efef <__crc_ide_raw_taskfile+7e3ab/174ad3>
   3:   03 d9                     add    %ecx,%ebx
Code;  d129eff1 <__crc_ide_raw_taskfile+7e3ad/174ad3>
   5:   02 2a                     add    (%edx),%ch
Code;  d129eff3 <__crc_ide_raw_taskfile+7e3af/174ad3>
   7:   d1 83 c4 1c 5b 5e         roll   0x5e5b1cc4(%ebx)
Code;  d129eff9 <__crc_ide_raw_taskfile+7e3b5/174ad3>
   d:   5d                        pop    %ebp
Code;  d129effa <__crc_ide_raw_taskfile+7e3b6/174ad3>
   e:   c3                        ret    
Code;  d129effb <__crc_ide_raw_taskfile+7e3b7/174ad3>
   f:   8b 86 c0 00 00 00         mov    0xc0(%esi),%eax


1 warning and 1 error issued.  Results may not be reliable.

let me know if you need more information.

--alex--

-- 
| I believe the moment is at hand when, by a paranoiac and active |
|  advance of the mind, it will be possible (simultaneously with  |
|  automatism and other passive states) to systematize confusion  |
|  and thus to help to discredit completely the world of reality. |
