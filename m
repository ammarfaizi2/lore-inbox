Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161022AbWGOUNi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161022AbWGOUNi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jul 2006 16:13:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161024AbWGOUNi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jul 2006 16:13:38 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:51920 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1161022AbWGOUNh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jul 2006 16:13:37 -0400
Date: Sat, 15 Jul 2006 22:13:21 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: axboe@suse.de
Subject: Oops on PCMCIA eject when mounted
Message-ID: <Pine.LNX.4.61.0607152202170.22012@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello list,


on 2.6.18-rc1, this happens:

20:07 takeshi:/proc # mount /dev/hde /D
mount: block device /dev/hde is write-protected, mounting read-only
20:07 takeshi:/proc # pccardctl eject 0

Naughty, I know... but nevertheless a bug below. The same segfault happens 
when I manually remove the card by hand.

20:07 takeshi:/proc # df
Filesystem           1K-blocks      Used Available Use% Mounted on
/dev/hda2             19002624  14574828   4427796  77% /
udev                    246100       116    245984   1% /dev
/dev/hde                715146    715146         0 100% /D
20:07 takeshi:/proc # ls -l /D
total 0
20:07 takeshi:/proc # umount /D
Segmentation fault


pccard: card ejected from slot 0
BUG: unable to handle kernel NULL pointer dereference at virtual address
0000011c
 printing eip:
cf380857
*pde = 00000000
Oops: 0000 [#1]
Modules linked in: nls_utf8 isofs zlib_inflate ide_cd cdrom vfat fat nls_base
cpufreq_ondemand cpufreq_userspace longrun af_packet snd_pcm_oss snd_mixer_oss
snd_seq snd_seq_device asus_acpi sony_acpi thermal processor fan button battery
ac loop sg sd_mod evdev sonypi rtc md_mod psmouse thkd i2c_ali1535 hostap_cs
hostap ieee80211_crypt ide_cs usb_storage scsi_mod pcmcia firmware_class
i2c_ali15x3 efficeon_agp agpgart i2c_core snd_ali5451 snd_ac97_codec
snd_ac97_bus snd_pcm snd_timer snd 8139too soundcore mii snd_page_alloc
ohci1394 ieee1394 yenta_socket rsrc_nonstatic pcmcia_core ohci_hcd usbcore xfs
alim15x3 ide_disk ide_core
CPU:    0
EIP:    0060:[<cf380857>]    Not tainted VLI
EFLAGS: 00010246   (2.6.18-rc1 #1)
EIP is at cdrom_lockdoor+0x27/0x100 [ide_cd]
eax: cf043f04   ebx: 00000000   ecx: 00000000   edx: 00000000
esi: ba8d7e18   edi: cf043f04   ebp: ba8d7e64   esp: ba8d7d60
ds: 007b   es: 007b   ss: 0068
Process umount (pid: 7142, ti=ba8d6000 task=cde85030 task.ti=ba8d6000)
Stack: 0000000e ba8d7dbc 00000000 00000000 ba8d7e10 b0184cca 00000000 0000000e
       ba8d7e30 ba8d7de8 00000000 c458b618 ffffffff b1279660 00000000 00000000
       ba8d7dc0 00000216 ce6e6da0 00000000 b02e67a8 ba8d7df0 00000001 00000001
Call Trace:
 [<cf38093d>] ide_cdrom_lock_door+0xd/0x10 [ide_cd]
 [<cf377b04>] cdrom_release+0xf4/0x240 [cdrom]
 [<cf381369>] idecd_release+0x29/0x50 [ide_cd]
 [<b0169afb>] __blkdev_put+0x10b/0x140
 [<b0169b4a>] blkdev_put+0xa/0x10
 [<b0169b62>] close_bdev_excl+0x12/0x20
 [<b01689d6>] kill_block_super+0x36/0x50
 [<b0168a80>] deactivate_super+0x40/0x80
 [<b017d1e2>] mntput_no_expire+0x42/0x70
 [<b016ecf5>] path_release_on_umount+0x15/0x20
 [<b017e1e1>] sys_umount+0x41/0x230
 [<b017e3e9>] sys_oldumount+0x19/0x20
 [<b0102e3d>] sysenter_past_esp+0x56/0x79
 [<a7fe5410>] 0xa7fe5410
Code: 90 90 90 90 55 89 e5 81 ec 04 01 00 00 85 c9 89 75 f8 89 ce 89 7d fc 89
c7 89 5d f4 89 95 04 ff ff ff 0f 84 94 00 00 00 8b 4f 1c <f6> 81 1c 01 00 00 02
74 30 31 db 0f b6 95 04 ff ff ff 0f b6 81
EIP: [<cf380857>] cdrom_lockdoor+0x27/0x100 [ide_cd] SS:ESP 0068:ba8d7d60


If more info is needed, please let me know.


Jan Engelhardt
-- 
