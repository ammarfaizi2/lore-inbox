Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750879AbVIWKzI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750879AbVIWKzI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 06:55:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750882AbVIWKzI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 06:55:08 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:4588 "EHLO
	out3.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S1750879AbVIWKzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 06:55:06 -0400
X-Sasl-enc: y628i1a9ixF5W+dPS1Wmrh4R9c2GOFk9Pbb7SAu7l2q7 1127472901
Message-ID: <4333DF14.3030703@gmx.net>
Date: Fri, 23 Sep 2005 12:55:16 +0200
From: bytewise@gmx.net
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.14-rc1: oops
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Please cc me)

I'm experiencing kernel oopses on 2.6.14-rc1. I'm not able to notice any pattern
in when exactly they occur.

The last one happened when I tried to access my cdrom (managed by automounter).
It didn't work, so I tried to rmmod all the relevant modules.

This kernel is suspend2-patched and compiled with some debugging options.

Please ask if any other information could be helpful or interesting.

Robert

automount[4812]: mount(generic): failed to mount /dev/cdrom (type auto) on
/mnt/auto/cdrom
automount[4812]: failed to mount /mnt/auto/cdrom
attempt to access beyond end of device
sr0: rw=0, want=68, limit=4
isofs_fill_super: bread failed, dev=sr0, iso_blknum=16, block=16
attempt to access beyond end of device
sr0: rw=0, want=68, limit=4
isofs_fill_super: bread failed, dev=sr0, iso_blknum=16, block=16
attempt to access beyond end of device
sr0: rw=0, want=68, limit=4
isofs_fill_super: bread failed, dev=sr0, iso_blknum=16, block=16
attempt to access beyond end of device
sr0: rw=0, want=68, limit=4
isofs_fill_super: bread failed, dev=sr0, iso_blknum=16, block=16
attempt to access beyond end of device
sr0: rw=0, want=68, limit=4
isofs_fill_super: bread failed, dev=sr0, iso_blknum=16, block=16
sr0: scsi3-mmc drive: 0x/0x caddy
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
Unable to handle kernel NULL pointer dereference at virtual address 00000270
 printing eip:
e086b759
*pde = 00000000
Oops: 0000 [#1]
PREEMPT
Modules linked in: sr_mod uhci_hcd ehci_hcd ipw2100 fuse arc4
ieee80211_crypt_wep radeon drm eth1394 ohci1394 ieee1394 snd_intel8x0 s
oss snd_mixer_oss snd_pcm snd_timer snd snd_page_alloc intel_agp agpgart
cpufreq_performance cpufreq_powersave usbhid cpufreq_ondeman
 pcmcia firmware_class yenta_socket rsrc_nonstatic pcmcia_core video ide_cd
cdrom ide_scsi scsi_mod
CPU:    0
EIP:    0060:[pg0+540518233/1068553216]    Not tainted VLI
EFLAGS: 00210002   (2.6.14-rc1Y)
EIP is at idescsi_queue+0x149/0x410 [ide_scsi]
eax: 00000000   ebx: de92eec0   ecx: 00000000   edx: c04e3a60
esi: 000004e2   edi: de92eeca   ebp: ca019b4c   esp: ca019b18
ds: 007b   es: 007b   ss: 0068
Process rmmod (pid: 5181, threadinfo=ca018000 task=de4e3a90)
Stack: dff6f3c0 00000020 c04cd9a0 dece7cc4 00200286 c04e3a60 dfd110c0 ca019b4c
       e18e5516 00000258 00200293 def85400 dece7c80 ca019b70 e18e2665 dece7c80
       e18e28b0 e18e5550 c02fc144 dfc9537c df640c00 def85400 ca019b9c e18e88dc
Call Trace:
 [show_stack+171/240] show_stack+0xab/0xf0
 [show_registers+399/560] show_registers+0x18f/0x230
 [die+237/400] die+0xed/0x190
 [do_page_fault+826/1648] do_page_fault+0x33a/0x670
 [error_code+79/84] error_code+0x4f/0x54
 [pg0+557782629/1068553216] scsi_dispatch_cmd+0x155/0x290 [scsi_mod]
 [pg0+557807836/1068553216] scsi_request_fn+0x20c/0x3e0 [scsi_mod]
 [__generic_unplug_device+44/64] __generic_unplug_device+0x2c/0x40
 [generic_unplug_device+28/80] generic_unplug_device+0x1c/0x50
 [blk_execute_rq_nowait+76/96] blk_execute_rq_nowait+0x4c/0x60
 [blk_execute_rq+94/176] blk_execute_rq+0x5e/0xb0
 [pg0+557802281/1068553216] scsi_execute+0xd9/0xf0 [scsi_mod]
 [pg0+562246634/1068553216] sr_do_ioctl+0x8a/0x270 [sr_mod]
 [pg0+562245866/1068553216] sr_packet+0x2a/0x40 [sr_mod]
 [pg0+540556350/1068553216] cdrom_get_disc_info+0x5e/0xc0 [cdrom]
 [pg0+540538921/1068553216] cdrom_mrw_exit+0x19/0x80 [cdrom]
 [pg0+540537808/1068553216] unregister_cdrom+0x70/0x130 [cdrom]
 [pg0+562245967/1068553216] sr_kref_release+0x4f/0x80 [sr_mod]
 [kref_put+46/128] kref_put+0x2e/0x80
 [pg0+562246075/1068553216] sr_remove+0x3b/0x4b [sr_mod]
 [__device_release_driver+97/128] __device_release_driver+0x61/0x80
 [device_release_driver+30/48] device_release_driver+0x1e/0x30
 [bus_remove_device+106/128] bus_remove_device+0x6a/0x80
 [device_del+51/112] device_del+0x33/0x70
 [pg0+557822652/1068553216] __scsi_remove_device+0x4c/0x90 [scsi_mod]
 [pg0+557822749/1068553216] scsi_remove_device+0x1d/0x30 [scsi_mod]
 [pg0+557822941/1068553216] __scsi_remove_target+0xad/0x120 [scsi_mod]
 [pg0+557823142/1068553216] scsi_remove_target+0x26/0x70 [scsi_mod]
 [pg0+557818051/1068553216] scsi_forget_host+0x63/0xc0 [scsi_mod]
 [pg0+557786092/1068553216] scsi_remove_host+0x3c/0x90 [scsi_mod]
 [pg0+540517521/1068553216] ide_scsi_remove+0x61/0x80 [ide_scsi]
 [__device_release_driver+97/128] __device_release_driver+0x61/0x80
 [driver_detach+163/185] driver_detach+0xa3/0xb9
 [bus_remove_driver+85/128] bus_remove_driver+0x55/0x80
 [driver_unregister+18/32] driver_unregister+0x12/0x20
 [pg0+540520818/1068553216] exit_idescsi_module+0x12/0x14 [ide_scsi]
 [sys_delete_module+320/400] sys_delete_module+0x140/0x190
 [syscall_call+7/11] syscall_call+0x7/0xb
Code: 00 00 00 8b 55 08 8b 42 54 89 53 2c 89 43 14 89 43 0c 8b 45 0c 89 43 30 a1
00 4e 42 c0 8b 72 34 01 f0 89 43 38 8b 55 e0 8b 42 1c <8b> 80 70 02 00 00 a8 01
74 05 0f ba 6b 34 02 8b 43 1c 89 45 e8
 <6>note: rmmod[5181] exited with preempt_count 1
Unable to handle kernel NULL pointer dereference at virtual address 00000270
 printing eip:
e086b759
*pde = 00000000
Oops: 0000 [#2]
PREEMPT
Modules linked in: sr_mod uhci_hcd ehci_hcd ipw2100 fuse arc4
ieee80211_crypt_wep radeon drm eth1394 ohci1394 ieee1394 snd_intel8x0
snd_ac97_codec snd_ac97_bus snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd
snd_page_alloc intel_agp agpgart cpufreq_performance cpufreq_powersave usbhid
cpufreq_ondemand ieee80211 ieee80211_crypt usbcore pcmcia firmware_class
yenta_socket rsrc_nonstatic pcmcia_core video ide_cd cdrom ide_scsi scsi_mod
CPU:    0
EIP:    0060:[pg0+540518233/1068553216]    Not tainted VLI
EFLAGS: 00010006   (2.6.14-rc1Y)
EIP is at idescsi_queue+0x149/0x410 [ide_scsi]
eax: 00000000   ebx: c50404c0   ecx: 00000000   edx: c04e3a60
esi: 000004e2   edi: c50404c6   ebp: dfdfdef0   esp: dfdfdebc
ds: 007b   es: 007b   ss: 0068
Process scsi_eh_0 (pid: 1061, threadinfo=dfdfc000 task=dfcfaa90)
Stack: dff6f3c0 00000020 c04cd9a0 dece7cc4 00000286 c04e3a60 dfcfee80 dfdfdef0
       e18e5516 00000258 00000292 dece7c80 def85400 dfdfdf20 e18e593f dece7c80
       e18e5870 e18e5850 00000000 00000000 dfdfdf0c dfdfdf0c dece7d2c dece7c80
Call Trace:
 [show_stack+171/240] show_stack+0xab/0xf0
 [show_registers+399/560] show_registers+0x18f/0x230
 [die+237/400] die+0xed/0x190
 [do_page_fault+826/1648] do_page_fault+0x33a/0x670
 [error_code+79/84] error_code+0x4f/0x54
 [pg0+557795647/1068553216] scsi_send_eh_cmnd+0x8f/0x120 [scsi_mod]
 [pg0+557796580/1068553216] scsi_eh_tur+0x94/0xe0 [scsi_mod]
 [pg0+557796750/1068553216] scsi_eh_abort_cmds+0x5e/0xa0 [scsi_mod]
 [pg0+557799671/1068553216] scsi_unjam_host+0xa7/0xe0 [scsi_mod]
 [pg0+557799851/1068553216] scsi_error_handler+0x7b/0x90 [scsi_mod]
 [kthread+185/192] kthread+0xb9/0xc0
 [kernel_thread_helper+5/16] kernel_thread_helper+0x5/0x10
Code: 00 00 00 8b 55 08 8b 42 54 89 53 2c 89 43 14 89 43 0c 8b 45 0c 89 43 30 a1
00 4e 42 c0 8b 72 34 01 f0 89 43 38 8b 55 e0 8b 42 1c <8b> 80 70 02 00 00 a8 01
74 05 0f ba 6b 34 02 8b 43 1c 89 45 e8
 <6>note: scsi_eh_0[1061] exited with preempt_count 1
