Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269156AbUI2WNW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269156AbUI2WNW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 18:13:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269154AbUI2WMM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 18:12:12 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:49341 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S269079AbUI2WLu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 18:11:50 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: 2.6.9-rc2: Kernel BUG at slab:2139 on dual AMD64
Date: Thu, 30 Sep 2004 00:07:29 +0200
User-Agent: KMail/1.6.2
Cc: Andi Kleen <ak@suse.de>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200409300007.29986.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've obtained the following trace on a dual-Opteron box:

----------- [cut here ] --------- [please bite here ] ---------
Kernel BUG at slab:2139
invalid operand: 0000 [1] SMP
CPU 0
Modules linked in: isofs nls_cp437 vfat fat joydev sr_mod ide_cd cdrom sg 
usb_storage parport_pc lp parp
ort usbserial snd_seq_oss snd_seq_midi_event snd_seq snd_pcm_oss snd_mixer_oss 
snd_ioctl32 snd_intel8x0 snd_ac97_codec snd_pcm snd_timer
 snd_page_alloc gameport snd_mpu401_uart snd_rawmidi snd_seq_device snd 
soundcore ehci_hcd ohci1394 ieee1394 tg3 ohci_hcd usblp usbcore
dm_mod
Pid: 6, comm: events/0 Not tainted 2.6.9-rc2
RIP: 0010:[free_block+358/544] <ffffffff8015f476>{free_block+358}
RIP: 0010:[<ffffffff8015f476>] <ffffffff8015f476>{free_block+358}
RSP: 0000:0000010001753d98  EFLAGS: 00010016
RAX: 000000000000004a RBX: 000001001fe43000 RCX: ffffffff803c96a8
RDX: ffffffff803c96a8 RSI: 0000000000000012 RDI: ffffffff803c96a0
RBP: 000001001fe43390 R08: 000000000000000a R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000000 R12: 000001001fffea40
R13: 0000000000000003 R14: 000001001fe43028 R15: 0000000000000003
FS:  0000002a95e094c0(0000) GS:ffffffff804d43c0(0000) knlGS:0000000057a6abb0
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 0000002a982e1000 CR3: 0000000000101000 CR4: 00000000000006e0
Process events/0 (pid: 6, threadinfo 0000010001752000, task 0000010020a627e0)
Stack: 0000010020a627e0 000001001fffea58 000001001fffea78 0000000100000000
       000001001ffe7110 000001001ffe7110 000001001ffe7100 0000000000000001
       000001001fffea40 000001001fffeab8
Call Trace:<ffffffff8015f5b9>{drain_array_locked+137} 
<ffffffff8015f6be>{cache_reap+174}
       <ffffffff8015f610>{cache_reap+0} <ffffffff801464ac>{worker_thread+476}
       <ffffffff80130d50>{default_wake_function+0} 
<ffffffff80130d50>{default_wake_function+0}
       <ffffffff801462d0>{worker_thread+0} <ffffffff8014ab59>{kthread+217}
       <ffffffff8010f0df>{child_rip+8} <ffffffff8014aa80>{kthread+0}
       <ffffffff8010f0d7>{child_rip+0}
Sep 29 22:21:30 chimera kernel:
Code: 0f 0b 62 fa 36 80 ff ff ff ff 5b 08 0f b7 43 24 48 89 de 4c
RIP <ffffffff8015f476>{free_block+358} RSP <0000010001753d98>

Surprisingly, some things worked after it had occured, but I was not able to 
shut the box down cleanly (bash didn't work).

The .config is available at: http://www.sisk.pl/kernel/040929/2.6.9-rc2.config

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
