Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261868AbUAAXh7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 18:37:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261872AbUAAXh6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 18:37:58 -0500
Received: from obsidian.spiritone.com ([216.99.193.137]:62629 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S261868AbUAAXhy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 18:37:54 -0500
Date: Thu, 01 Jan 2004 15:37:50 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 1769] New: Oops whilst using USB to connect to	Sony Clie 
Message-ID: <2120000.1073000270@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=1769

           Summary: Oops whilst using USB to connect to Sony Clie
    Kernel Version: 2.6.0
            Status: NEW
          Severity: normal
             Owner: greg@kroah.com
         Submitter: mbligh@aracnet.com


I'm unclear as to whether this is the fault of USB or sysfs.

Steps to reproduce:
Jan  1 15:26:11 titus kernel: hub 2-0:1.0: new USB device on port 1, assigned
address 2
Jan  1 15:26:11 titus kernel: visor 2-1:1.0: Handspring Visor / Palm OS
converter detected
Jan  1 15:26:11 titus kernel: usb 2-1: Handspring Visor / Palm OS converter now
attached to ttyUSB0 (or usb/tts/0 for devfs)
Jan  1 15:26:11 titus kernel: usb 2-1: Handspring Visor / Palm OS converter now
attached to ttyUSB1 (or usb/tts/1 for devfs)
Jan  1 15:27:11 titus kernel: usb 2-1: USB disconnect, address 2
Jan  1 15:27:11 titus kernel: visor 2-1:1.0: device disconnected
Jan  1 15:27:27 titus kernel: hub 2-0:1.0: new USB device on port 1, assigned
address 3
Jan  1 15:27:27 titus kernel: visor 2-1:1.0: Handspring Visor / Palm OS
converter detected
Jan  1 15:27:27 titus kernel: usb 2-1: Handspring Visor / Palm OS converter now
attached to ttyUSB2 (or usb/tts/2 for devfs)
Jan  1 15:27:27 titus kernel: usb 2-1: Handspring Visor / Palm OS converter now
attached to ttyUSB3 (or usb/tts/3 for devfs)
Jan  1 15:27:45 titus kernel: visor ttyUSB0: Handspring Visor / Palm OS
converter now disconnected from ttyUSB0
Jan  1 15:27:45 titus kernel:  printing eip:
Jan  1 15:27:45 titus kernel: c0159d8e
Jan  1 15:27:45 titus kernel: Oops: 0002 [#1]
Jan  1 15:27:45 titus kernel: CPU:    0
Jan  1 15:27:45 titus kernel: EIP:    0060:[simple_rmdir+26/56]    Not tainted VLI
Jan  1 15:27:45 titus kernel: EFLAGS: 00010202
Jan  1 15:27:45 titus kernel: EIP is at simple_rmdir+0x1a/0x38
Jan  1 15:27:45 titus kernel: eax: 00000000   ebx: d4bd8480   ecx: d4bd8488  
edx: d4bd84a0
Jan  1 15:27:45 titus kernel: esi: d3f26b80   edi: d4bd8480   ebp: d4bd84a0  
esp: d3673e5c
Jan  1 15:27:45 titus kernel: ds: 007b   es: 007b   ss: 0068
Jan  1 15:27:45 titus kernel: Process addresses (pid: 14543, threadinfo=d3672000
task=d3806040)
Jan  1 15:27:45 titus kernel: Stack: d4bd8340 d4bd8480 c016aa50 d3f26b80
d4bd8480 d4bd8480 d4bd8520 d4bd84a0 
Jan  1 15:27:45 titus kernel:        c016ab05 d4bd8480 d459d8a8 dfd83474
df68ace0 00000000 c01ba673 d459d8a8 
Jan  1 15:27:45 titus kernel:        d459d880 c01e3af1 d459d8a8 d459d880
00000000 c01e3b0f d459d880 00000000 
Jan  1 15:27:45 titus kernel:        c0276c57 d459d880 c0402548 df68ad1c
00000000 c01ba723 df68ad1c d459d800 
Jan  1 15:27:45 titus kernel: Call Trace:
Jan  1 15:27:45 titus kernel:  [remove_dir+60/92] remove_dir+0x3c/0x5c
Jan  1 15:27:45 titus kernel:  [sysfs_remove_dir+133/152] sysfs_remove_dir+0x85/0x98
Jan  1 15:27:45 titus kernel:  [kobject_del+75/88] kobject_del+0x4b/0x58
Jan  1 15:27:45 titus kernel:  [device_del+105/124] device_del+0x69/0x7c
Jan  1 15:27:45 titus kernel:  [device_unregister+11/24] device_unregister+0xb/0x18
Jan  1 15:27:45 titus kernel:  [destroy_serial+135/324] destroy_serial+0x87/0x144
Jan  1 15:27:45 titus kernel:  [kobject_cleanup+75/112] kobject_cleanup+0x4b/0x70
Jan  1 15:27:45 titus kernel:  [kobject_put+20/24] kobject_put+0x14/0x18
Jan  1 15:27:45 titus kernel:  [serial_close+230/236] serial_close+0xe6/0xec
Jan  1 15:27:45 titus kernel:  [release_dev+514/1332] release_dev+0x202/0x534
Jan  1 15:27:45 titus kernel:  [n_tty_ioctl+177/952] n_tty_ioctl+0xb1/0x3b8
Jan  1 15:27:45 titus kernel:  [tty_release+10/16] tty_release+0xa/0x10
Jan  1 15:27:45 titus kernel:  [__fput+59/176] __fput+0x3b/0xb0
Jan  1 15:27:45 titus kernel:  [fput+19/20] fput+0x13/0x14
Jan  1 15:27:45 titus kernel:  [filp_close+99/108] filp_close+0x63/0x6c
Jan  1 15:27:45 titus kernel:  [sys_close+69/84] sys_close+0x45/0x54
Jan  1 15:27:45 titus kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jan  1 15:27:45 titus kernel: 
Jan  1 15:27:45 titus kernel: Code: ff 48 24 52 e8 b0 99 ff ff 31 c0 83 c4 04 c3
89 f6 56 53 8b 74 24 0c 8b 5c 24 10 53 e8 80 ff ff ff 83 c4 04 85 c0 74 17 8b 43
0c <ff> 48 24 53 56 e8 c4 ff ff ff
 31 c0 ff 4e 24 83 c4 08 eb 05 b8

