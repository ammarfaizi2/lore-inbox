Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932313AbWCMSP5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932313AbWCMSP5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 13:15:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932305AbWCMSPi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 13:15:38 -0500
Received: from mx1.redhat.com ([66.187.233.31]:52864 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932312AbWCMSPg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 13:15:36 -0500
Date: Mon, 13 Mar 2006 13:15:24 -0500
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: signal_cache slab corruption.
Message-ID: <20060313181524.GA26234@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got into the office today to find my workstation that was running
a kernel based on .16rc5-git9 was totally unresponsive.
After rebooting, I found this in the logs.

slab signal_cache: invalid slab found in partial list at ffff8100e3a48080 (11/11).
slab signal_cache: invalid slab found in partial list at ffff81007ecc6100 (11/11).
slab: Internal list corruption detected in cache 'signal_cache'(11), slabp ffff810037ec0998(12). Hexdump:

000: c0 60 d9 7e 00 81 ff ff 00 61 cc 7e 00 81 ff ff
010: a8 09 ec 37 00 81 ff ff a8 09 ec 37 00 81 ff ff
020: 0c 00 00 00 00 00 00 00 57 d0 1d 07 01 00 00 00
030: 00 00 00 00
----------- [cut here ] --------- [please bite here ] ---------
Kernel BUG at mm/slab.c:2598
invalid opcode: 0000 [1] SMP
last sysfs file: /block/ram0/removable
CPU 1
Modules linked in: rfcomm loop nfsd exportfs ipv6 autofs4 w83627hf hwmon_vid hwmon i2c_isa hidp l2cap bluetooth nfs lockd nfs_acl sunrpc vfat fat dm_mirror dm_mod raid0 video button battery ac lp parport_pc parport floppy nvram ehci_hcd ohci_hcd snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device snd_pcm_oss snd_mixer_oss hw_random i2c_amd756 snd_pcm i2c_amd8111 snd_timer i2c_core matroxfb_base matroxfb_DAC1064 matroxfb_accel matroxfb_Ti3026 matroxfb_g450 g450_pll matroxfb_misc tg3 snd soundcore snd_page_alloc ext3 jbd sata_sil libata sd_mod scsi_mod
Pid: 9, comm: events/1 Not tainted 2.6.15-1.2027_FC5 #1
RIP: 0010:[<ffffffff8017b072>] <ffffffff8017b072>{check_slabp+185}
RSP: 0018:ffff8100e8e47da8  EFLAGS: 00010086
RAX: 0000000000000001 RBX: ffff810037ec0998 RCX: 0000000000020000
RDX: 0000000000000000 RSI: 0000000000000046 RDI: ffffffff803c3a30
RBP: 0000000000000034 R08: 00000000ffffffff R09: ffff8100e8e47af8
R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000034
R13: ffff81008252d100 R14: ffff810080006508 R15: ffff81008252db68
FS:  00002ba8c4e25b90(0000) GS:ffff8100e8fdfc28(0000) knlGS:00000000f7f158c0
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 00002aab66b0e200 CR3: 000000006f726000 CR4: 00000000000006e0
Process events/1 (pid: 9, threadinfo ffff8100e8e46000, task ffff810037fef7a0)
Stack: ffff81007ecc6100 ffff810037ec0998 ffff81008252d100 0000000000000000
       ffff810037ec0988 ffffffff8017cd7d ffff810080006558 ffff810081a72520
       ffff810081a72528 ffff8100e8f9da48
Call Trace: <ffffffff8017cd7d>{cache_reap+391} <ffffffff8017cbf6>{cache_reap+0}
       <ffffffff801425e5>{run_workqueue+159} <ffffffff80142c7e>{worker_thread+0}
       <ffffffff80142d87>{worker_thread+265} <ffffffff801295b4>{__wake_up_common+62}
       <ffffffff8012ad8c>{default_wake_function+0} <ffffffff80145ebe>{kthread+254}
       <ffffffff80142c7e>{worker_thread+0} <ffffffff8010b8e6>{child_rip+8}
       <ffffffff80142c7e>{worker_thread+0} <ffffffff80145dc0>{kthread+0}
       <ffffffff8010b8de>{child_rip+0}

Code: 0f 0b 68 16 b0 36 80 c2 26 0a 5a 5b 5d 41 5c 41 5d c3 41 56


-- 
http://www.codemonkey.org.uk
