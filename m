Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267189AbUGMWm0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267189AbUGMWm0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 18:42:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267191AbUGMWkl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 18:40:41 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:42969 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267189AbUGMWiR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 18:38:17 -0400
Subject: XRUN traces
From: Lee Revell <rlrevell@joe-job.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1089758294.2747.4.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 13 Jul 2004 18:38:14 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, I am starting a new thread here, as the other was getting unwieldy.

This one is 100% reproducible, happens immediately when I start JACK.  I
have set CONFIG_FRAME_POINTER=y and CONFIG_4KSTACKS=n as you requested.

Jul 13 18:30:21 mindpipe kernel: ALSA /usr/src/alsa-cvs-1.0.5/alsa-driver/alsa-kernel/core/pcm_lib.c:169: XRUN: pcmC0D0p
Jul 13 18:30:21 mindpipe kernel:  [dump_stack+23/32] dump_stack+0x17/0x20
Jul 13 18:30:21 mindpipe kernel:  [__crc_totalram_pages+1279533/3558647] snd_pcm_period_elapsed+0x2c7/0x400 [snd_pcm]
Jul 13 18:30:21 mindpipe kernel:  [__crc_totalram_pages+1463213/3558647] snd_emu10k1_interrupt+0x377/0x400 [snd_emu10k1]
Jul 13 18:30:21 mindpipe kernel:  [handle_IRQ_event+51/96] handle_IRQ_event+0x33/0x60
Jul 13 18:30:21 mindpipe kernel:  [do_IRQ+165/368] do_IRQ+0xa5/0x170
Jul 13 18:30:21 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 13 18:30:21 mindpipe kernel:  [do_anonymous_page+124/384] do_anonymous_page+0x7c/0x180
Jul 13 18:30:21 mindpipe kernel:  [do_no_page+78/784] do_no_page+0x4e/0x310
Jul 13 18:30:21 mindpipe kernel:  [handle_mm_fault+193/368] handle_mm_fault+0xc1/0x170
Jul 13 18:30:21 mindpipe kernel:  [get_user_pages+258/880] get_user_pages+0x102/0x370
Jul 13 18:30:21 mindpipe kernel:  [make_pages_present+104/144] make_pages_present+0x68/0x90
Jul 13 18:30:21 mindpipe kernel:  [do_mmap_pgoff+1000/1552] do_mmap_pgoff+0x3e8/0x610
Jul 13 18:30:21 mindpipe kernel:  [sys_mmap2+118/176] sys_mmap2+0x76/0xb0
Jul 13 18:30:21 mindpipe kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jul 13 18:30:21 mindpipe kernel:
Jul 13 18:30:56 mindpipe kernel: ALSA /usr/src/alsa-cvs-1.0.5/alsa-driver/alsa-kernel/core/pcm_lib.c:169: XRUN: pcmC0D0p
Jul 13 18:30:56 mindpipe kernel:  [dump_stack+23/32] dump_stack+0x17/0x20
Jul 13 18:30:56 mindpipe kernel:  [__crc_totalram_pages+1279533/3558647] snd_pcm_period_elapsed+0x2c7/0x400 [snd_pcm]
Jul 13 18:30:56 mindpipe kernel:  [__crc_totalram_pages+1463213/3558647] snd_emu10k1_interrupt+0x377/0x400 [snd_emu10k1]
Jul 13 18:30:56 mindpipe kernel:  [handle_IRQ_event+51/96] handle_IRQ_event+0x33/0x60
Jul 13 18:30:56 mindpipe kernel:  [do_IRQ+165/368] do_IRQ+0xa5/0x170
Jul 13 18:30:56 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 13 18:30:56 mindpipe kernel:  [handle_mm_fault+71/368] handle_mm_fault+0x47/0x170
Jul 13 18:30:56 mindpipe kernel:  [get_user_pages+258/880] get_user_pages+0x102/0x370
Jul 13 18:30:56 mindpipe kernel:  [make_pages_present+104/144] make_pages_present+0x68/0x90
Jul 13 18:30:56 mindpipe kernel:  [do_mmap_pgoff+1000/1552] do_mmap_pgoff+0x3e8/0x610
Jul 13 18:30:56 mindpipe kernel:  [sys_mmap2+118/176] sys_mmap2+0x76/0xb0
Jul 13 18:30:56 mindpipe kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jul 13 18:30:56 mindpipe kernel:
Jul 13 18:30:58 mindpipe kernel: ALSA /usr/src/alsa-cvs-1.0.5/alsa-driver/alsa-kernel/core/pcm_lib.c:169: XRUN: pcmC0D0p
Jul 13 18:30:58 mindpipe kernel:  [dump_stack+23/32] dump_stack+0x17/0x20
Jul 13 18:30:58 mindpipe kernel:  [__crc_totalram_pages+1279533/3558647] snd_pcm_period_elapsed+0x2c7/0x400 [snd_pcm]
Jul 13 18:30:58 mindpipe kernel:  [__crc_totalram_pages+1463213/3558647] snd_emu10k1_interrupt+0x377/0x400 [snd_emu10k1]
Jul 13 18:30:58 mindpipe kernel:  [handle_IRQ_event+51/96] handle_IRQ_event+0x33/0x60
Jul 13 18:30:58 mindpipe kernel:  [do_IRQ+165/368] do_IRQ+0xa5/0x170
Jul 13 18:30:58 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 13 18:30:58 mindpipe kernel:  [do_anonymous_page+124/384] do_anonymous_page+0x7c/0x180
Jul 13 18:30:58 mindpipe kernel:  [do_no_page+78/784] do_no_page+0x4e/0x310
Jul 13 18:30:58 mindpipe kernel:  [handle_mm_fault+193/368] handle_mm_fault+0xc1/0x170
Jul 13 18:30:58 mindpipe kernel:  [get_user_pages+258/880] get_user_pages+0x102/0x370
Jul 13 18:30:58 mindpipe kernel:  [make_pages_present+104/144] make_pages_present+0x68/0x90
Jul 13 18:30:58 mindpipe kernel:  [do_mmap_pgoff+1000/1552] do_mmap_pgoff+0x3e8/0x610
Jul 13 18:30:58 mindpipe kernel:  [sys_mmap2+118/176] sys_mmap2+0x76/0xb0
Jul 13 18:30:58 mindpipe kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jul 13 18:30:58 mindpipe kernel:

Lee


