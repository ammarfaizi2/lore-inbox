Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266770AbUGUXRM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266770AbUGUXRM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 19:17:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266771AbUGUXRM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 19:17:12 -0400
Received: from rproxy.gmail.com ([64.233.170.203]:13976 "HELO mproxy.gmail.com")
	by vger.kernel.org with SMTP id S266770AbUGUXRF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 19:17:05 -0400
Message-ID: <bfdd02740407211617625788f8@mail.gmail.com>
Date: Thu, 22 Jul 2004 04:47:05 +0530
From: Shishir Verma <shiverma@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: top causing oops with preempt count=1 on 2.6.7
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

This is the dump i received when my system, running kernel 2.6.7 caused an oops.
My system was using a lot of time for compiling qt library and when i
used top to see what
was going on, i saw top exit suddenly, and a dmesg gave me the following dump.

Unable to handle kernel paging request at virtual address c4157a98
printing eip:
c01a934c
*pde = 0000f067
*pte = 04157000
Oops: 0000 [#1]
PREEMPT DEBUG_PAGEALLOC
Modules linked in: sr_mod sd_mod ntfs vfat fat binfmt_misc parport_pc parport oh
ci_hcd 8139too mii crc32 i810_audio ac97_codec soundcore intel_agp agpgart evdev
ide_scsi ide_cd cdrom usbmouse usbkbd usbhid uhci_hcd ehci_hcd usb_storage scsi
_mod usbcore
CPU:    0
EIP:    0060:[<c01a934c>]    Not tainted
EFLAGS: 00010202   (2.6.7)
EIP is at proc_pid_stat+0x36c/0x718
eax: c4157a10   ebx: c1cb0000   ecx: c7d89d4c   edx: c0122aab
esi: c81e8a10   edi: c81e8a10   ebp: c1cb1f50   esp: c1cb1edc
ds: 007b   es: 007b   ss: 0068
Process top (pid: 2302, threadinfo=c1cb0000 task=c16eca10)
Stack: c1cb1efc c0118bdd c10bdbe0 00000246 00000246 c0334b74 c10bdbe0 c0334e1c
      c7d89d4c 00000000 ffffffff ffffffff 00000163 52cb1f4c 00000000 ffffffff
      00000000 00000012 c0122aab bfffe97c 4000f69d 00205000 00000000 00000000
Call Trace:
[<c0106ea3>] show_stack+0x6f/0x84
[<c0106fca>] show_registers+0xfa/0x144
[<c01071a6>] die+0x10a/0x1e6
[<c0117d08>] do_page_fault+0x1d4/0x4f2
[<c0106b71>] error_code+0x2d/0x38
[<c01a4955>] proc_info_read+0x53/0x102
[<c01640fa>] vfs_read+0xa6/0xe2
[<c01642e8>] sys_read+0x2c/0x4a
[<c0106147>] syscall_call+0x7/0xb

Code: 8b 80 88 00 00 00 89 45 bc b8 00 e0 ff ff 21 e0 ff 48 14 8b
<6>note: top[2302] exited with preempt_count 1
Debug: sleeping function called from invalid context at include/linux/rwsem.h:43
in_atomic():1, irqs_disabled():0
[<c0106ece>] dump_stack+0x16/0x18
[<c011b7e5>] __might_sleep+0x9d/0xbe
[<c01223bc>] do_exit+0x9c/0x838
[<c0107281>] die+0x1e5/0x1e6
[<c0117d08>] do_page_fault+0x1d4/0x4f2
[<c0106b71>] error_code+0x2d/0x38
[<c01a4955>] proc_info_read+0x53/0x102
[<c01640fa>] vfs_read+0xa6/0xe2
[<c01642e8>] sys_read+0x2c/0x4a
[<c0106147>] syscall_call+0x7/0xb

bad: scheduling while atomic!
[<c0106ece>] dump_stack+0x16/0x18
[<c02da0cb>] schedule+0x69b/0x6a2
[<c014fbb1>] unmap_vmas+0x1c5/0x296
[<c0154d8a>] exit_mmap+0xac/0x226
[<c011c372>] mmput+0xa4/0xf6
[<c01225aa>] do_exit+0x28a/0x838
[<c0107281>] die+0x1e5/0x1e6
[<c0117d08>] do_page_fault+0x1d4/0x4f2
[<c0106b71>] error_code+0x2d/0x38
[<c01a4955>] proc_info_read+0x53/0x102
[<c01640fa>] vfs_read+0xa6/0xe2
[<c01642e8>] sys_read+0x2c/0x4a
[<c0106147>] syscall_call+0x7/0xb

Please see if this has been observed by anyone.
Thanks 
-shishir
