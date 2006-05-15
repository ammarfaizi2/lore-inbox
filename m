Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964801AbWEOIZO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964801AbWEOIZO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 04:25:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964809AbWEOIZO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 04:25:14 -0400
Received: from addr-213-139-163-144.baananet.fi ([213.139.163.144]:22489 "EHLO
	asalmela.iki.fi") by vger.kernel.org with ESMTP id S964801AbWEOIZM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 04:25:12 -0400
Date: Mon, 15 May 2006 11:25:08 +0300
From: Antti Salmela <asalmela@iki.fi>
To: linux-kernel@vger.kernel.org
Subject: Kernel BUG at mm/vmscan.c:428 (2.6.17-rc4-git2, Dualcore AMD x86-64)
Message-ID: <20060515082508.GA6950@asalmela.iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My Dualcore AMD x86-64 desktop has been a little bit unstable as long as I
remember, but at last I had enough willpower to enable netconsole to see
if anything was reported after a lockup. For some reason these
BUG messages made now their way to local log file too.

May 15 06:51:43 enigma kernel: ----------- [cut here ] --------- [please bite here ] ---------
May 15 06:51:43 enigma kernel: Kernel BUG at mm/vmscan.c:428
May 15 06:51:43 enigma kernel: invalid opcode: 0000 [1] PREEMPT SMP 
May 15 06:51:43 enigma kernel: CPU 0 
May 15 06:51:43 enigma kernel: Modules linked in: button ac battery ipv6 af_packet it87 hwmon_vid i2c_isa sr_mod sbp2 ide_generic ide_disk evdev usbhid ide_cd cdrom eth1394 snd_intel8x0 snd_ac97_codec snd_ac97_bus analog snd_pcm_oss snd_mixer_oss snd_mpu401 snd_mpu401_uart snd_rawmidi snd_seq_device gameport snd_pcm amd74xx pcspkr snd_timer generic parport_pc parport psmouse serio_raw snd ohci1394 ieee1394 ide_core ehci_hcd ohci_hcd soundcore snd_page_alloc i2c_nforce2 i2c_core unix
May 15 06:51:43 enigma kernel: Pid: 208, comm: kswapd0 Not tainted 2.6.17-rc4-git2 #1
May 15 06:51:43 enigma kernel: RIP: 0010:[shrink_zone+1672/3087] <ffffffff80211dc2>{shrink_zone+1672}
May 15 06:51:43 enigma kernel: RSP: 0018:ffff81003fe69ca8  EFLAGS: 00010202
May 15 06:51:43 enigma kernel: RAX: 0000000000000849 RBX: ffff81000199a8b8 RCX: ffff81000199a8e0
May 15 06:51:43 enigma kernel: RDX: ffff81003fe69e08 RSI: ffff8100012c1780 RDI: ffff810001e01318
May 15 06:51:43 enigma kernel: RBP: ffffffff804b4480 R08: ffff81003fe69c39 R09: 0000000000000010
May 15 06:51:43 enigma kernel: R10: 0000000000000000 R11: ffff810017b821f0 R12: ffff81000c4f54f8
May 15 06:51:43 enigma kernel: R13: 0000000000000001 R14: ffff81003fe69e98 R15: 0000000000000000
May 15 06:51:43 enigma kernel: FS:  00002b798df3a7a0(0000) GS:ffffffff8057a000(0000) knlGS:00000000f7e016b0
May 15 06:51:43 enigma kernel: CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
May 15 06:51:43 enigma kernel: CR2: 00002b7990cd9000 CR3: 000000001d499000 CR4: 00000000000006e0
May 15 06:51:43 enigma kernel: Process kswapd0 (pid: 208, threadinfo ffff81003fe68000, task ffff81003ff31660)
May 15 06:51:43 enigma kernel: Stack: 000000000000001d 0000000000000050 0000000000000000 0000000000000018 
May 15 06:51:43 enigma kernel:        0000000000000020 0000000000000020 0000000000000000 0000000000000020 
May 15 06:51:43 enigma kernel:        0000000000000014 000000003f4b0b40 
May 15 06:51:43 enigma kernel: Call Trace: <ffffffff80296ab8>{balance_pgdat+536} <ffffffff80255f68>{kswapd+257}
May 15 06:51:43 enigma kernel:        <ffffffff8028a4a7>{autoremove_wake_function+0} <ffffffff802261d5>{schedule_tail+67}
May 15 06:51:43 enigma kernel:        <ffffffff8025b61e>{child_rip+8} <ffffffff8026d531>{flat_send_IPI_mask+0}
May 15 06:51:43 enigma kernel:        <ffffffff80255e67>{kswapd+0} <ffffffff8025b616>{child_rip+0}
May 15 06:51:43 enigma kernel: 
May 15 06:51:43 enigma kernel: Code: 0f 0b 68 dc 35 45 80 c2 ac 01 49 8b 16 41 83 7e 18 00 48 8d 
May 15 06:51:43 enigma kernel: RIP <ffffffff80211dc2>{shrink_zone+1672} RSP <ffff81003fe69ca8>
May 15 06:51:43 enigma kernel:  ----------- [cut here ] --------- [please bite here ] ---------
May 15 06:51:43 enigma kernel: Kernel BUG at mm/vmscan.c:428
May 15 06:51:43 enigma kernel: invalid opcode: 0000 [2] PREEMPT SMP 
May 15 06:51:43 enigma kernel: CPU 0 
May 15 06:51:43 enigma kernel: Modules linked in: button ac battery ipv6 af_packet it87 hwmon_vid i2c_isa sr_mod sbp2 ide_generic ide_disk evdev usbhid ide_cd cdrom eth1394 snd_intel8x0 snd_ac97_codec snd_ac97_bus analog snd_pcm_oss snd_mixer_oss snd_mpu401 snd_mpu401_uart snd_rawmidi snd_seq_device gameport snd_pcm amd74xx pcspkr snd_timer generic parport_pc parport psmouse serio_raw snd ohci1394 ieee1394 ide_core ehci_hcd ohci_hcd soundcore snd_page_alloc i2c_nforce2 i2c_core unix
May 15 06:51:43 enigma kernel: Pid: 5939, comm: prelink.bin Not tainted 2.6.17-rc4-git2 #1
May 15 06:51:43 enigma kernel: RIP: 0010:[shrink_zone+1672/3087] <ffffffff80211dc2>{shrink_zone+1672}
May 15 06:51:43 enigma kernel: RSP: 0000:ffff8100362d3b48  EFLAGS: 00010202
May 15 06:51:43 enigma kernel: RAX: 0000000000000849 RBX: ffff8100019a71f8 RCX: ffff8100019a7220
May 15 06:51:43 enigma kernel: RDX: ffff8100362d3ca8 RSI: ffff8100362d2010 RDI: 0000000000000003
May 15 06:51:43 enigma kernel: RBP: ffffffff804b4480 R08: ffff8100362d3ca8 R09: ffff81000166d1c0
May 15 06:51:43 enigma kernel: R10: 0000000000000020 R11: 0000000000000020 R12: 0000000000000020
May 15 06:51:43 enigma kernel: R13: 000000000000001c R14: ffff8100362d3d28 R15: ffff8100362d3d98
May 15 06:51:43 enigma kernel: FS:  00002b49edb20e40(0000) GS:ffffffff8057a000(0000) knlGS:00000000f7e016b0
May 15 06:51:43 enigma kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
May 15 06:51:43 enigma kernel: CR2: 00002b49f0f91000 CR3: 000000002545f000 CR4: 00000000000006e0
May 15 06:51:43 enigma kernel: Process prelink.bin (pid: 5939, threadinfo ffff8100362d2000, task ffff81003f4707e0)
May 15 06:51:43 enigma kernel: Stack: 000000000000001d 0000000000000029 0000000000000001 0000000000000020 
May 15 06:51:43 enigma kernel:        0000000000000000 0000000000000020 0000000000000000 0000000000000020 
May 15 06:51:43 enigma kernel:        0000000000000000 000000003f7d9d88 
May 15 06:51:43 enigma kernel: Call Trace: <ffffffff802e04ca>{journal_stop+542} <ffffffff80296dce>{try_to_free_pages+300}
May 15 06:51:43 enigma kernel:        <ffffffff8020e5ea>{__alloc_pages+424} <ffffffff80208558>{__handle_mm_fault+449}
May 15 06:51:43 enigma kernel:        <ffffffff8025fc5c>{_spin_lock_irqsave+28} <ffffffff8020a6d5>{do_page_fault+1106}
May 15 06:51:43 enigma kernel:        <ffffffff8020da3b>{do_mmap_pgoff+1533} <ffffffff8025fc5c>{_spin_lock_irqsave+28}
May 15 06:51:43 enigma kernel:        <ffffffff8025b465>{error_exit+0}
May 15 06:51:43 enigma kernel: 
May 15 06:51:43 enigma kernel: Code: 0f 0b 68 dc 35 45 80 c2 ac 01 49 8b 16 41 83 7e 18 00 48 8d 
May 15 06:51:43 enigma kernel: RIP <ffffffff80211dc2>{shrink_zone+1672} RSP <ffff8100362d3b48>
May 15 06:57:43 enigma kernel:  ----------- [cut here ] --------- [please bite here ] ---------
May 15 06:57:43 enigma kernel: Kernel BUG at mm/vmscan.c:428
May 15 06:57:43 enigma kernel: invalid opcode: 0000 [3] PREEMPT SMP 

-- 
Antti Salmela
