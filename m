Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262756AbTIQVEk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 17:04:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262726AbTIQVEk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 17:04:40 -0400
Received: from proxy.ovh.net ([213.244.20.42]:8978 "EHLO proxy.ovh.net")
	by vger.kernel.org with ESMTP id S262779AbTIQVEg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 17:04:36 -0400
Date: Wed, 17 Sep 2003 23:05:45 +0200
To: kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.0-test5 oops at boot
Message-ID: <20030917210545.GS1758@ovh.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: bert@ovh.net (bertrand)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I tried several times to boot a 2.6 on my athlon .
The 2.5 series looked to be fined, but i cannot boot the 2.6 one .

First, i tried a full kernel (all my options), but it froze after the
line :
>> mice: PS/2 mouse device common for all mice

Today, i'm trying an 2.6.0-test5 with less options and I caught an oops .

In attached files, you will find the kernel config and the output of the
boot.

If this can help .

    Bert.

---------------------------------
Call Trace:
 [<c015e835>] kobject_get+0x35/0x3c
 [<c0184f24>] class_get+0x18/0x30
 [<c01851dc>] class_device_add+0x44/0x118
 [<c018e5f4>] scsi_add_host+0x80/0xec
 [<c01a8aaf>] ahc_linux_register_host+0x1f7/0x258
 [<c0158bf2>] sysfs_add_file+0x72/0x7c
 [<c0163962>] pci_populate_driver_dir+0x1e/0x24
 [<c0163a0e>] pci_register_driver+0x5e/0x70
 [<c01a7b9b>] ahc_linux_detect+0x37/0x60
 [<c023b4da>] ahc_linux_init+0xa/0x18
 [<c023262c>] do_initcalls+0x28/0x88
 [<c0105047>] init+0x23/0x160
 [<c0105024>] init+0x0/0x160
 [<c0106d65>] kernel_thread_helper+0x5/0xc
Unable to handle kernel NULL pointer dereference at virtual address
00000008
c0158d12
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c0158d12>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: 00000000   ebx: dfe76b38   ecx: dfe845f0   edx: dfe76b54
esi: 00000000   edi: c0213e60   ebp: dfe76b30   esp: dff99ec0
ds: 007b   es: 007b   ss: 0068
Stack: dfe76b38 00000000 c0158dbc dfe76b38 00000000 dfe76b3c 00000000
dfe76b38
       c015e28c dfe76b38 dfe76b38 c0213e74 c015e5fd dfe76b38 dfe76b38
dfe76b30
       c0185203 dfe76b38 00000000 dfe76aa0 00000000 dfe76a00 dfe76aa0
dfe76b30
Call Trace:
 [<c0158dbc>] sysfs_create_dir+0x24/0x5c
 [<c015e28c>] create_dir+0x14/0x38
 [<c015e5fd>] kobject_add+0x3d/0xe4
 [<c0185203>] class_device_add+0x6b/0x118
 [<c018e5f4>] scsi_add_host+0x80/0xec
 [<c01a8aaf>] ahc_linux_register_host+0x1f7/0x258
 [<c0158bf2>] sysfs_add_file+0x72/0x7c
 [<c0163962>] pci_populate_driver_dir+0x1e/0x24
 [<c0163a0e>] pci_register_driver+0x5e/0x70
 [<c01a7b9b>] ahc_linux_detect+0x37/0x60
 [<c023b4da>] ahc_linux_init+0xa/0x18
 [<c023262c>] do_initcalls+0x28/0x88
 [<c0105047>] init+0x23/0x160
 [<c0105024>] init+0x0/0x160
 [<c0106d65>] kernel_thread_helper+0x5/0xc
Code: 8b 46 08 8d 48 68 ff 48 68 0f 88 56 02 00 00 ff 74 24 14 56



Trace; c015e835 <kobject_get+35/3c>
Trace; c0184f24 <class_get+18/30>
Trace; c01851dc <class_device_add+44/118>
Trace; c018e5f4 <scsi_add_host+80/ec>
Trace; c01a8aaf <ahc_linux_register_host+1f7/258>
Trace; c0158bf2 <sysfs_add_file+72/7c>
Trace; c0163962 <pci_populate_driver_dir+1e/24>
Trace; c0163a0e <pci_register_driver+5e/70>
Trace; c01a7b9b <ahc_linux_detect+37/60>
Trace; c023b4da <ahc_linux_init+a/18>
Trace; c023262c <do_initcalls+28/88>
Trace; c0105047 <init+23/160>
Trace; c0105024 <init+0/160>
Trace; c0106d65 <kernel_thread_helper+5/c>

>>EIP; c0158d12 <create_dir+6/74>   <=====

>>ebx; dfe76b38 <_end+1fc22d5c/3fdaa224>
>>ecx; dfe845f0 <_end+1fc30814/3fdaa224>
>>edx; dfe76b54 <_end+1fc22d78/3fdaa224>
>>edi; c0213e60 <shost_class+0/80>
>>ebp; dfe76b30 <_end+1fc22d54/3fdaa224>
>>esp; dff99ec0 <_end+1fd460e4/3fdaa224>

Trace; c0158dbc <sysfs_create_dir+24/5c>
Trace; c015e28c <create_dir+14/38>
Trace; c015e5fd <kobject_add+3d/e4>
Trace; c0185203 <class_device_add+6b/118>
Trace; c018e5f4 <scsi_add_host+80/ec>
Trace; c01a8aaf <ahc_linux_register_host+1f7/258>
Trace; c0158bf2 <sysfs_add_file+72/7c>
Trace; c0163962 <pci_populate_driver_dir+1e/24>
Trace; c0163a0e <pci_register_driver+5e/70>
Trace; c01a7b9b <ahc_linux_detect+37/60>
Trace; c023b4da <ahc_linux_init+a/18>
Trace; c023262c <do_initcalls+28/88>
Trace; c0105047 <init+23/160>
Trace; c0105024 <init+0/160>
Trace; c0106d65 <kernel_thread_helper+5/c>

Code;  c0158d12 <create_dir+6/74>
00000000 <_EIP>:
Code;  c0158d12 <create_dir+6/74>   <=====
   0:   8b 46 08                  mov    0x8(%esi),%eax   <=====
Code;  c0158d15 <create_dir+9/74>
   3:   8d 48 68                  lea    0x68(%eax),%ecx
Code;  c0158d18 <create_dir+c/74>
   6:   ff 48 68                  decl   0x68(%eax)
Code;  c0158d1b <create_dir+f/74>
   9:   0f 88 56 02 00 00         js     265 <_EIP+0x265>
Code;  c0158d21 <create_dir+15/74>
   f:   ff 74 24 14               pushl  0x14(%esp,1)
Code;  c0158d25 <create_dir+19/74>
  13:   56                        push   %esi

 <0>Kernel panic: Attempted to kill init!

--------------------------------------------


