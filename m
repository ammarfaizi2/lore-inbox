Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269168AbUIHWTq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269168AbUIHWTq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 18:19:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269169AbUIHWTq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 18:19:46 -0400
Received: from postfix4-1.free.fr ([213.228.0.62]:46777 "EHLO
	postfix4-1.free.fr") by vger.kernel.org with ESMTP id S269168AbUIHWTk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 18:19:40 -0400
Message-ID: <413F857A.8020406@free.fr>
Date: Thu, 09 Sep 2004 00:19:38 +0200
From: Laurent Riffard <laurent.riffard@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.6) Gecko/20040115
X-Accept-Language: fr-fr, fr, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: slab error when mounting CD-ROM
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------030605000502040303070101"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030605000502040303070101
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

I experience a slab error when I mount a cd-rom. dmesg output 
attached below. It seems to happen only on ISO9660 data CD with
*rockridge* extension, for example the Mandrake 10.0 Install CDs.

I'm running kernel 2.6.9-rc1-mm4. The problem appeared on kernel
2.6.9-rc1-mm3. Kernel 2.6.9-rc1-mm2 runs fine.

/proc/version:
Linux version 2.6.9-rc1-mm4 (laurent@antares.localdomain) (gcc
version 3.3.2 (Mandrake Linux 10.0 3.3.2-6mdk)) #15 Wed Sep 8
20:54:19 CEST 2004

/etc/fstab:
/dev/hdc /mnt/cdrom iso9660 ro,nosuid,noauto,exec,user,nodev 0 0

/proc/ide/hdc/model:
CD-950E/AKU

cat /proc/ide/hdc/driver:
ide-cdrom version 4.61

Feel free to ask for more details.
please cc me for any reply
-- 
laurent




--------------030605000502040303070101
Content-Type: text/plain;
 name="isofs.bug2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="isofs.bug2"

kobject isofs: registering. parent: <NULL>, set: module
kobject sections: registering. parent: isofs, set: <NULL>
ISO 9660 Extensions: Microsoft Joliet Level 3
ISO 9660 Extensions: RRIP_1991A
slab error in cache_free_debugcheck(): cache `size-256': double free, or memory outside object was overwritten
 [<c0105dc7>] dump_stack+0x17/0x20
 [<c013f6a7>] cache_free_debugcheck+0x157/0x250
 [<c01403ba>] kfree+0x4a/0x90
 [<d0cdee84>] parse_rock_ridge_inode_internal+0x5a4/0x620 [isofs]
 [<d0cdf0a8>] parse_rock_ridge_inode+0x18/0x50 [isofs]
 [<d0cddb99>] isofs_read_inode+0x329/0x420 [isofs]
 [<d0cddd46>] isofs_iget+0x56/0x70 [isofs]
 [<d0cdd0b4>] isofs_fill_super+0x4e4/0x660 [isofs]
 [<c015b772>] get_sb_bdev+0xd2/0x150
 [<d0cddd7a>] isofs_get_sb+0x1a/0x20 [isofs]
 [<c015b9f9>] do_kern_mount+0x49/0xd0
 [<c017193c>] do_new_mount+0x7c/0xc0
 [<c017206f>] do_mount+0x14f/0x180
 [<c0172428>] sys_mount+0x88/0xf0
 [<c0104f29>] sysenter_past_esp+0x52/0x71
cefbf898: redzone 1: 0x5a2cf071, redzone 2: 0x5a2cf071.
fill_kobj_path: path = '/block/hdc'
Slab corruption: start=cefbf89c, len=256
Redzone: 0x170fc2a5/0x170fc2a5.
Last user: [<c0255f9f>](alloc_skb+0x3f/0xe0)
000: 3c 37 3e 53 65 70 20 20 38 20 32 31 3a 35 30 3a
010: 32 36 20 6b 65 72 6e 65 6c 3a 20 49 53 4f 20 39
020: 36 36 30 20 45 78 74 65 6e 73 69 6f 6e 73 3a 20
030: 52 52 49 50 5f 31 39 39 31 41 00 5a 5a 5a 5a 5a
040: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
050: 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a
Prev obj: start=cefbf790, len=256
Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [<c025615b>](kfree_skbmem+0xb/0x20)
000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
Next obj: start=cefbf9a8, len=256
Redzone: 0x170fc2a5/0x170fc2a5.
Last user: [<c0140336>](kcalloc+0x36/0x70)
000: 70 c6 8e cc 00 00 00 00 07 00 00 00 45 53 31 33
010: 37 30 2f 31 00 00 00 00 00 00 00 00 00 00 00 00
slab error in cache_alloc_debugcheck_after(): cache `size-256': double free, or memory outside object was overwritten
 [<c0105dc7>] dump_stack+0x17/0x20
 [<c013fbf8>] cache_alloc_debugcheck_after+0x98/0x140
 [<c0140249>] __kmalloc+0x89/0xd0
 [<c0255f9f>] alloc_skb+0x3f/0xe0
 [<c02552cf>] sock_alloc_send_pskb+0xaf/0x1c0
 [<c02553f8>] sock_alloc_send_skb+0x18/0x20
 [<c02a4eb7>] unix_dgram_sendmsg+0x107/0x4f0
 [<c02527c7>] sock_aio_write+0xe7/0x100
 [<c01547c7>] do_sync_write+0x97/0xf0
 [<c01548f4>] vfs_write+0xd4/0xf0
 [<c01549bd>] sys_write+0x3d/0x70
 [<c0104f29>] sysenter_past_esp+0x52/0x71
cefbf898: redzone 1: 0x170fc2a5, redzone 2: 0x170fc2a5.
Unable to handle kernel paging request at virtual address 6b6b6b6b
 printing eip:
c02560e5
*pde = 00000000
Oops: 0000 [#1]
PREEMPT 
Modules linked in: isofs ppp_async crc_ccitt ppp_generic slhc lp parport_pc parport snd_pcm_oss snd_mixer_oss snd_ens1371 snd_rawmidi snd_seq_device snd_pcm snd_timer snd_page_alloc snd_ac97_codec gameport snd soundcore af_packet ide_cd cdrom sd_mod usb_storage scsi_mod floppy ne2k_pci 8390 crc32 ohci1394 ieee1394 nls_iso8859_1 nls_cp850 vfat fat reiser4 reiserfs via_agp agpgart eagle_usb dm_mod joydev usbhid ub uhci_hcd usbcore rtc
CPU:    0
EIP:    0060:[<c02560e5>]    Not tainted VLI
EFLAGS: 00010297   (2.6.9-rc1-mm4) 
EIP is at skb_release_data+0x45/0xb0
eax: cefbf8dc   ebx: 00000000   ecx: cefbf8dc   edx: 6b6b6b6b
esi: c1336678   edi: cc955d7c   ebp: cc955d2c   esp: cc955d24
ds: 007b   es: 007b   ss: 0068
Process syslogd (pid: 2831, threadinfo=cc954000 task=cc8e6000)
Stack: c1336678 c1336678 cc955d38 c025615b 00000000 cc955d58 c02561ec cc955ea0 
       00000000 c1336678 00000000 c1336678 cc955d7c cc955da8 c02a5801 00000000 
       c0217913 cf4c01c8 cc955db8 cc955f2c cfbfc450 0000003e 00000b31 00000000 
Call Trace:
 [<c0105da6>] show_stack+0xa6/0xb0
 [<c0105f1d>] show_registers+0x14d/0x1c0
 [<c0106104>] die+0xe4/0x170
 [<c0116852>] do_page_fault+0x492/0x5c7
 [<c0105985>] error_code+0x2d/0x38
 [<c025615b>] kfree_skbmem+0xb/0x20
 [<c02561ec>] __kfree_skb+0x7c/0x100
 [<c02a5801>] unix_dgram_recvmsg+0x141/0x1f0
 [<c025255d>] sock_recvmsg+0xbd/0xf0
 [<c0253a11>] sys_recvfrom+0x81/0xe0
 [<c0253aa6>] sys_recv+0x36/0x40
 [<c02540f9>] sys_socketcall+0x149/0x230
 [<c0104f29>] sysenter_past_esp+0x52/0x71
Code: 74 64 8b 8e a0 00 00 00 8b 51 04 89 c8 85 d2 74 3b 31 db 39 d3 72 10 eb 33 8b 8e a0 00 00 00 43 89 c8 3b 59 04 73 25 8b 54 d8 10 <8b> 02 f6 c4 08 75 ed 8b 42 04 40 74 47 83 42 04 ff 0f 98 c0 84 




--------------030605000502040303070101--
