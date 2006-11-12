Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932923AbWKLPGq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932923AbWKLPGq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 10:06:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932925AbWKLPGq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 10:06:46 -0500
Received: from mailgw1.uni-kl.de ([131.246.120.220]:31107 "EHLO
	mailgw1.uni-kl.de") by vger.kernel.org with ESMTP id S932923AbWKLPGp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 10:06:45 -0500
Date: Sun, 12 Nov 2006 16:06:42 +0100
From: Eduard Bloch <edi@gmx.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.19-rc5, USB/scsi, scsi_execute_async -> invalid opcode: 0000
Message-ID: <20061112150642.GA5664@rotes76.wohnheim.uni-kl.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

#include <hallo.h>

I try to burn audio CDs with wodim (modified cdrecord) or cdrskin
(libburn frontend), via a USB- or a IDE-attached drive. With wodim, it
does work with 2.6.18.x and 2.6.19-rc5 with both drives. With cdrskin,
weird things happen: First, it works with the IDE drive. With SCSI, it
looks like it writtes the data to the drive very quickly but nothing
is put onto the disk. The resulting CD is reported as written but the
first audio track seems to be finished after few seconds and the CD
index looks weird (incomplete).

With 2.6.19-rc5, it looks a bit better. The recording with cdrskin seems
to work, but at the end of the second track, I get a kernel exception. I
have no idea how to continue now, cdrskin (symlinked as cdrecord) is
frozen, but not in D-state.

------------[ cut here ]------------
kernel BUG at mm/slab.c:594!
invalid opcode: 0000 [#1]
Modules linked in: binfmt_misc ppdev lp thermal fan button processor ac battery autofs4 sg sr_mod snd_via82xx sk98lin nls_iso8859_1 nls_cp437 vfat fat snd_mixer_oss tsdev usbhid tuner usb_storage saa7134 snd_emu10k1 snd_mpu401 snd_mpu401_uart i2c_viapro snd_via82xx_modem video_buf compat_ioctl32 ir_kbd_i2c ir_common psmouse snd_rawmidi snd_ac97_codec snd_ac97_bus snd_seq_device snd_util_mem analog ehci_hcd 3c59x mii sky2 i2c_core snd_pcm snd_timer snd_page_alloc evdev videodev v4l1_compat v4l2_common serio_raw snd_hwdep snd parport_pc parport emu10k1_gp gameport uhci_hcd sata_via k8temp pcspkr usbcore soundcore 8250_pnp 8250 serial_core rtc
CPU:    0
EIP:    0060:[<c015ac86>]    Not tainted VLI
EFLAGS: 00210246   (2.6.19-rc5 #2)
EIP is at kmem_cache_free+0x76/0x80
eax: 80080000   ebx: c2104fc0   ecx: c2163ec0   edx: c1800000
esi: c21041e0   edi: 00000000   ebp: 00001000   esp: f7139df8
ds: 007b   es: 007b   ss: 0068
Process cdrecord (pid: 4097, ti=f7138000 task=c2119a70 task.ti=f7138000)
Stack: c2104fc0 c21041e0 ffffffea c0144bba 00001000 f7233ac0 c21041e0 c0180295 
       c21e9298 00000000 c01800d1 c0294990 00001000 00000000 0000000a f7139f0c 
       f71f70b0 00000000 00000001 f7233ac0 c16e49e0 00008000 00000000 f7d8002c 
Call Trace:
 [<c0144bba>] mempool_free+0x2a/0x70
 [<c0180295>] bio_free+0x25/0x50
 [<c01800d1>] bio_put+0x21/0x30
 [<c0294990>] scsi_execute_async+0x310/0x390
 [<f915a20f>] sg_common_write+0x32f/0x810 [sg]
 [<f915b7e0>] sg_cmd_done+0x0/0x2d0 [sg]
 [<c015e2c5>] do_sync_read+0xd5/0x120
 [<f915a872>] sg_new_write+0x182/0x250 [sg]
 [<f915ce50>] sg_ioctl+0x810/0xa40 [sg]
 [<f8dcf7b2>] ehci_irq+0xf2/0x160 [ehci_hcd]
 [<f915c640>] sg_ioctl+0x0/0xa40 [sg]
 [<c01699f9>] do_ioctl+0x69/0x70
 [<c0169a5c>] vfs_ioctl+0x5c/0x270
 [<c015e1f0>] do_sync_read+0x0/0x120
 [<c0169ce2>] sys_ioctl+0x72/0x90
 [<c0102ec7>] syscall_call+0x7/0xb
 =======================
Code: 8b 1c 24 8b 74 24 04 8b 7c 24 08 83 c4 0c c3 8b 52 0c eb cc 89 c8 89 da e8 68 fe ff ff 8b 03 eb d6 0f 0b cd 0d c7 a3 34 c0 eb c0 <0f> 0b 52 02 c7 a3 34 c0 eb b1 83 ec 08 89 74 24 04 89 1c 24 89 
EIP: [<c015ac86>] kmem_cache_free+0x76/0x80 SS:ESP 0068:f7139df8


-- 
Niemand heilt durch Jammern seinen Harm.
		-- William Shakespeare
