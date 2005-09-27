Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964982AbVI0Pp1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964982AbVI0Pp1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 11:45:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964983AbVI0Pp1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 11:45:27 -0400
Received: from okcforum.org ([66.224.116.102]:37518 "EHLO mail.okcforum.org")
	by vger.kernel.org with ESMTP id S964982AbVI0Pp0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 11:45:26 -0400
Message-ID: <433968FF.8070504@cygnusx-1.org>
Date: Tue, 27 Sep 2005 08:45:03 -0700
From: Nathan Grennan <linux-kernel@cygnusx-1.org>
Organization: Cygnus X-1
User-Agent: Thunderbird 1.4 (X11/20050908)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.14-rc2: USB storage-related #GP on x86-64 again
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  I just purchased a new digital camera and was playing with it last
night. In
the process I connected my camera to the computer with a usb cable. The
system sees it as a usb flash drive. After unmounting the camera I turned it
off and received a general protection fault. The system is a x86_64 system
running 2.6.13-1.1578_FC5, which the changelog says is really
2.6.14-rc2-git6.

  I noticed the other message about this same topic. The thread said it
was fixed, but I am seeing the same situation with a version that was
said to be fixed.


* Mon Sep 26 2005 Dave Jones <davej@redhat.com>
- 2.6.14-rc2-git6


Sep 27 07:43:11 proton udevd[686]: get_netlink_msg: no ACTION in payload
found, skip event 'umount'
Sep 27 07:43:13 proton kernel: usb 1-3: USB disconnect, address 2
Sep 27 07:43:13 proton kernel: general protection fault: 0000 [1] SMP
Sep 27 07:43:13 proton kernel: CPU 0
Sep 27 07:43:13 proton kernel: Modules linked in: vfat fat usb_storage
ipv6 dm_mod video button battery ac pcspkr ohci1394 ieee1394 ohci_hcd
ehci_hcd i2c_nforce2 i2c_core shpchp snd_intel8x0 snd_emu10k1_synth
snd_emux_synth snd_seq_virmidi snd_seq_midi_emul snd_emu10k1 snd_rawmidi
snd_ac97_codec snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq
snd_seq_device snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd_ac97_bus
snd_page_alloc snd_util_mem snd_hwdep snd soundcore 8139too mii r8169
forcedeth floppy ext3 jbd raid1 raid0 sata_nv libata sd_mod scsi_mod
Sep 27 07:43:13 proton kernel: Pid: 140, comm: khubd Not tainted
2.6.13-1.1578_FC5 #1
Sep 27 07:43:13 proton kernel: RIP: 0010:[<ffffffff8800b808>]
<ffffffff8800b808>{:scsi_mod:scsi_remove_device+75}
Sep 27 07:43:13 proton kernel: RSP: 0018:ffff810037c03c98  EFLAGS: 00010292
Sep 27 07:43:13 proton kernel: RAX: 6b6b6b6b6b6b6b6b RBX:
ffff81003ce00388 RCX: 0000000000000011
Sep 27 07:43:13 proton kernel: RDX: ffff81003ce00380 RSI:
ffffffff8020186f RDI: 6b6b6b6b6b6b6beb
Sep 27 07:43:13 proton kernel: RBP: ffff81003cdaf4a8 R08:
0000000000000000 R09: ffff81003ce00388
Sep 27 07:43:13 proton kernel: R10: 0000000000000000 R11:
ffffffff8800be6c R12: ffff81003cdaf538
Sep 27 07:43:13 proton kernel: R13: ffff81003cdaf4b8 R14:
ffff81003e59cd60 R15: 0000000000000100
Sep 27 07:43:13 proton kernel: FS:  00002aaaaaf0fce0(0000)
GS:ffffffff80554800(0000) knlGS:0000000000000000
Sep 27 07:43:13 proton fstab-sync[3824]: removed mount point
/media/usbdisk for /dev/sdd1
Sep 27 07:43:13 proton kernel: CS:  0010 DS: 0018 ES: 0018 CR0:
000000008005003b
Sep 27 07:43:13 proton kernel: CR2: 00002aaaaad69c10 CR3:
0000000000101000 CR4: 00000000000006e0
Sep 27 07:43:13 proton kernel: Process khubd (pid: 140, threadinfo
ffff810037c02000, task ffff81003fd758a0)
Sep 27 07:43:13 proton kernel: Stack: ffff81003ce00388 ffff81003cdaf4b8
ffff81002eaf1790 ffffffff8800baf5
Sep 27 07:43:13 proton kernel:        0000000000000296 ffff81002eaf1790
ffff81003cdaf4c0 ffff81003cdaf4b8
Sep 27 07:43:13 proton kernel:        ffff81003cdaf4c8 ffffffff8800923c
Sep 27 07:43:13 proton kernel: Call
Trace:<ffffffff8800baf5>{:scsi_mod:__scsi_remove_target+147}
Sep 27 07:43:13 proton kernel:       
<ffffffff8800923c>{:scsi_mod:scsi_forget_host+71}
<ffffffff8800354f>{:scsi_mod:scsi_remove_host+92}
Sep 27 07:43:13 proton kernel:       
<ffffffff80352254>{klist_release+0}
<ffffffff8832b1f1>{:usb_storage:storage_disconnect+16}
Sep 27 07:43:13 proton kernel:       
<ffffffff802ba36a>{usb_unbind_interface+69}
<ffffffff802704c8>{__device_release_driver+96}
Sep 27 07:43:13 proton kernel:       
<ffffffff802707b9>{device_release_driver+61}
<ffffffff8026ffb7>{bus_remove_device+146}
Sep 27 07:43:13 proton kernel:        <ffffffff8026f0cc>{device_del+55}
<ffffffff802bff4f>{usb_disable_device+150}
Sep 27 07:43:13 proton kernel:       
<ffffffff802ba8ec>{usb_disconnect+241} <ffffffff802bcdac>{hub_thread+900}
Sep 27 07:43:13 proton kernel:       
<ffffffff8014a110>{autoremove_wake_function+0}
<ffffffff802bca28>{hub_thread+0}
Sep 27 07:43:13 proton kernel:       
<ffffffff80149cb0>{keventd_create_kthread+0} <ffffffff80149f0e>{kthread+205}
Sep 27 07:43:13 proton kernel:       
<ffffffff80131326>{schedule_tail+70} <ffffffff8010ea22>{child_rip+8}
Sep 27 07:43:13 proton kernel:       
<ffffffff80149cb0>{keventd_create_kthread+0} <ffffffff80149e41>{kthread+0}
Sep 27 07:43:13 proton kernel:        <ffffffff8010ea1a>{child_rip+0}
Sep 27 07:43:13 proton kernel:
Sep 27 07:43:13 proton kernel: Code: f0 ff 80 80 00 00 00 0f 8e f7 07 00
00 5b 41 5c 41 5d c3 53
Sep 27 07:43:13 proton kernel: RIP
<ffffffff8800b808>{:scsi_mod:scsi_remove_device+75} RSP <ffff810037c03c98>

