Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262822AbUJ1HCa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262822AbUJ1HCa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 03:02:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262815AbUJ1HCU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 03:02:20 -0400
Received: from mail-gateway-0-1.landonet.net ([196.25.111.196]:747 "EHLO
	mail-gateway-0-1.landonet.net") by vger.kernel.org with ESMTP
	id S262822AbUJ1HA7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 03:00:59 -0400
Message-ID: <41809921.10200@lbsd.net>
Date: Thu, 28 Oct 2004 07:00:49 +0000
From: Nigel Kukard <nkukard@lbsd.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041012
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.9bk6 msdos fs OOPS
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just got the below oops when i mounted a usb camera's SD-Card.

Could anyone share some light on the issue?

-Nigel


------------[ cut here ]------------
kernel BUG at fs/fat/cache.c:150!
invalid operand: 0000 [#1]
PREEMPT SMP
Modules linked in: smbfs autofs4 nls_cp437 msdos fat nfsd exportfs lockd 
sunrpc tsdev uhci_hcd parport_pc parport eth1394 nvidia ohci1394 
ieee1394 usbmouse usbkbd usbhid ehci_hcd ub ohci_hcd usbcore i2c_sis96x 
i2c_core pci_hotplug sis_agp agpgart evdev sis900 crc32 snd_als4000 
snd_sb_common snd_pcm snd_page_alloc snd_opl3_lib snd_timer snd_hwdep 
snd_mpu401_uart snd_rawmidi snd_seq_device snd
CPU:    0
EIP:    0060:[<f8cec268>]    Tainted: P      VLI
EFLAGS: 00010202   (2.6.9-bk6)
EIP is at fat_cache_add+0x108/0x130 [fat]
eax: 00000001   ebx: cc2672b8   ecx: cc2672b8   edx: d0bfdc01
esi: d0bfdc1c   edi: d8129798   ebp: d81297d4   esp: d0bfdbf8
ds: 007b   es: 007b   ss: 0068
Process eog (pid: 16973, threadinfo=d0bfd000 task=cd4eb540)
Stack: 00000001 d81297d4 f77af400 d8129798 d0bfdc54 f8cec902 d81297d4 
d0bfdc1c
        0001ffff 00000000 00000000 00000001 00000112 d8129798 f77af400 
00000028
        00000000 f8cec9d6 d81297d4 00000001 d0bfdc50 d0bfdc54 00000001 
00000112
Call Trace:
  [<f8cec902>] fat_get_cluster+0x112/0x1b0 [fat]
  [<f8cec9d6>] fat_bmap_cluster+0x36/0x80 [fat]
  [<f8cecb00>] fat_bmap+0xe0/0x1f0 [fat]
  [<c0119e12>] recalc_task_prio+0xd2/0x200
  [<f8ceeede>] fat_get_block+0x2e/0x160 [fat]
  [<c015e2e6>] block_read_full_page+0x166/0x330
  [<c013d7a6>] add_to_page_cache+0x46/0xe0
  [<c013d80c>] add_to_page_cache+0xac/0xe0
  [<f8cf093f>] fat_readpage+0xf/0x20 [fat]
  [<f8ceeeb0>] fat_get_block+0x0/0x160 [fat]
  [<c0144634>] read_pages+0x84/0x120
  [<c0141be3>] __alloc_pages+0x93/0x310
  [<c02896de>] avc_has_perm_noaudit+0xbe/0x1a0
  [<c0144a29>] do_page_cache_readahead+0x169/0x190
  [<c0144b9f>] page_cache_readahead+0x14f/0x1f0
  [<c013deec>] do_generic_mapping_read+0xfc/0x420
  [<c013e492>] __generic_file_aio_read+0x1a2/0x220
  [<c013e210>] file_read_actor+0x0/0xe0
  [<c013e61e>] generic_file_read+0xae/0xd0
  [<c0133610>] autoremove_wake_function+0x0/0x40
  [<c015aecb>] vfs_read+0x9b/0xf0
  [<c015b13d>] sys_read+0x3d/0x70
  [<c0105f47>] syscall_call+0x7/0xb
Code: 58 85 db 5a 74 32 8b 47 0c 48 89 47 0c 8b 04 24 39 00 75 2c 8b 34 
24 8b 0d 94 4d cf f8 56 51 e8 9f a0 45 c7 58 5a e9 54 ff ff ff <0f> 0b 
96 00 de 1b cf f8 e9 43 ff ff ff 8b 1c 24 e9 7c ff ff ff
