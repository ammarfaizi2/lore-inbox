Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264635AbUGMIbs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264635AbUGMIbs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 04:31:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264655AbUGMIbi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 04:31:38 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:6637 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S264635AbUGMIbO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 04:31:14 -0400
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel
	Preemption Patch
From: Lee Revell <rlrevell@joe-job.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-audio-dev@music.columbia.edu, mingo@elte.hu, arjanv@redhat.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040712205917.47d1d58b.akpm@osdl.org>
References: <20040709182638.GA11310@elte.hu>
	 <20040710222510.0593f4a4.akpm@osdl.org>
	 <1089673014.10777.42.camel@mindpipe>
	 <20040712163141.31ef1ad6.akpm@osdl.org>
	 <1089677823.10777.64.camel@mindpipe>
	 <20040712174639.38c7cf48.akpm@osdl.org>
	 <1089687168.10777.126.camel@mindpipe>
	 <20040712205917.47d1d58b.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1089707483.20381.33.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 13 Jul 2004 04:31:24 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-07-12 at 23:59, Andrew Morton wrote:
> Oh dear, these don't make much sense.
> 
> You'll have the best chance of getting decent traces with
> CONFIG_FRAME_POINTER=y and CONFIG_4KSTACKS=n, but I'm not sure that this
> will help a lot.  Are you sure that CONFIG_PREEMPT is enabled on that
> kernel?
> 

Here are some more.  These happen when I switch from X to a text console
and back:


Jul 13 04:27:50 mindpipe kernel:
Jul 13 04:27:50 mindpipe kernel: ALSA /usr/src/alsa-cvs-1.0.5/alsa-driver/alsa-kernel/core/pcm_lib.c:169: XRUN: pcmC0D0p
Jul 13 04:27:50 mindpipe kernel:  [__crc_totalram_pages+1387264/5353478] snd_pcm_period_elapsed+0x2ca/0x410 [snd_pcm]
Jul 13 04:27:50 mindpipe kernel:  [__crc_totalram_pages+1455070/5353478] snd_emu10k1_interrupt+0x3c8/0x480 [snd_emu10k1]
Jul 13 04:27:50 mindpipe kernel:  [handle_IRQ_event+49/96] handle_IRQ_event+0x31/0x60
Jul 13 04:27:50 mindpipe kernel:  [do_IRQ+155/352] do_IRQ+0x9b/0x160
Jul 13 04:27:50 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 13 04:27:50 mindpipe kernel:  [do_con_write+397/1888] do_con_write+0x18d/0x760
Jul 13 04:27:50 mindpipe kernel:  [con_write+27/48] con_write+0x1b/0x30
Jul 13 04:27:50 mindpipe kernel:  [opost_block+210/400] opost_block+0xd2/0x190
Jul 13 04:27:50 mindpipe kernel:  [__alloc_pages+458/864] __alloc_pages+0x1ca/0x360
Jul 13 04:27:50 mindpipe kernel:  [write_chan+396/544] write_chan+0x18c/0x220
Jul 13 04:27:50 mindpipe kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
Jul 13 04:27:50 mindpipe kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
Jul 13 04:27:50 mindpipe kernel:  [tty_write+434/608] tty_write+0x1b2/0x260
Jul 13 04:27:50 mindpipe kernel:  [write_chan+0/544] write_chan+0x0/0x220
Jul 13 04:27:50 mindpipe kernel:  [vfs_write+186/256] vfs_write+0xba/0x100
Jul 13 04:27:50 mindpipe kernel:  [sys_write+45/80] sys_write+0x2d/0x50
Jul 13 04:27:50 mindpipe kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jul 13 04:27:50 mindpipe kernel:
Jul 13 04:27:50 mindpipe kernel: ALSA /usr/src/alsa-cvs-1.0.5/alsa-driver/alsa-kernel/core/pcm_lib.c:169: XRUN: pcmC0D0p
Jul 13 04:27:50 mindpipe kernel:  [__crc_totalram_pages+1387264/5353478] snd_pcm_period_elapsed+0x2ca/0x410 [snd_pcm]
Jul 13 04:27:50 mindpipe kernel:  [group_send_sig_info+101/144] group_send_sig_info+0x65/0x90
Jul 13 04:27:50 mindpipe kernel:  [__crc_totalram_pages+1455070/5353478] snd_emu10k1_interrupt+0x3c8/0x480 [snd_emu10k1]
Jul 13 04:27:50 mindpipe kernel:  [handle_IRQ_event+49/96] handle_IRQ_event+0x31/0x60
Jul 13 04:27:50 mindpipe kernel:  [do_IRQ+155/352] do_IRQ+0x9b/0x160
Jul 13 04:27:50 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 13 04:27:50 mindpipe kernel:  [_mmx_memcpy+141/384] _mmx_memcpy+0x8d/0x180
Jul 13 04:27:50 mindpipe kernel:  [scrup+242/320] scrup+0xf2/0x140
Jul 13 04:27:50 mindpipe kernel:  [lf+96/112] lf+0x60/0x70
Jul 13 04:27:50 mindpipe kernel:  [do_con_trol+2907/3360] do_con_trol+0xb5b/0xd20
Jul 13 04:27:50 mindpipe kernel:  [do_con_write+1128/1888] do_con_write+0x468/0x760
Jul 13 04:27:50 mindpipe kernel:  [con_put_char+51/64] con_put_char+0x33/0x40
Jul 13 04:27:50 mindpipe kernel:  [opost+162/464] opost+0xa2/0x1d0
Jul 13 04:27:50 mindpipe kernel:  [write_chan+437/544] write_chan+0x1b5/0x220
Jul 13 04:27:50 mindpipe kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
Jul 13 04:27:50 mindpipe kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
Jul 13 04:27:50 mindpipe kernel:  [tty_write+434/608] tty_write+0x1b2/0x260
Jul 13 04:27:50 mindpipe kernel:  [write_chan+0/544] write_chan+0x0/0x220
Jul 13 04:27:50 mindpipe kernel:  [vfs_write+186/256] vfs_write+0xba/0x100
Jul 13 04:27:50 mindpipe kernel:  [sys_write+45/80] sys_write+0x2d/0x50
Jul 13 04:27:50 mindpipe kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jul 13 04:27:50 mindpipe kernel:
Jul 13 04:27:50 mindpipe kernel: ALSA /usr/src/alsa-cvs-1.0.5/alsa-driver/alsa-kernel/core/pcm_lib.c:169: XRUN: pcmC0D0p
Jul 13 04:27:50 mindpipe kernel:  [__crc_totalram_pages+1387264/5353478] snd_pcm_period_elapsed+0x2ca/0x410 [snd_pcm]
Jul 13 04:27:50 mindpipe kernel:  [__crc_totalram_pages+1455070/5353478] snd_emu10k1_interrupt+0x3c8/0x480 [snd_emu10k1]
Jul 13 04:27:50 mindpipe kernel:  [handle_IRQ_event+49/96] handle_IRQ_event+0x31/0x60
Jul 13 04:27:50 mindpipe kernel:  [do_IRQ+155/352] do_IRQ+0x9b/0x160
Jul 13 04:27:50 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 13 04:27:50 mindpipe kernel:  [__do_softirq+48/144] __do_softirq+0x30/0x90
Jul 13 04:27:50 mindpipe kernel:  [do_softirq+53/64] do_softirq+0x35/0x40
Jul 13 04:27:50 mindpipe kernel:  [do_IRQ+261/352] do_IRQ+0x105/0x160
Jul 13 04:27:50 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 13 04:27:50 mindpipe kernel:
Jul 13 04:27:50 mindpipe kernel: ALSA /usr/src/alsa-cvs-1.0.5/alsa-driver/alsa-kernel/core/pcm_lib.c:169: XRUN: pcmC0D0p
Jul 13 04:27:50 mindpipe kernel:  [__crc_totalram_pages+1387264/5353478] snd_pcm_period_elapsed+0x2ca/0x410 [snd_pcm]
Jul 13 04:27:50 mindpipe kernel:  [__crc_totalram_pages+1455070/5353478] snd_emu10k1_interrupt+0x3c8/0x480 [snd_emu10k1]
Jul 13 04:27:50 mindpipe kernel:  [handle_IRQ_event+49/96] handle_IRQ_event+0x31/0x60
Jul 13 04:27:50 mindpipe kernel:  [do_IRQ+155/352] do_IRQ+0x9b/0x160
Jul 13 04:27:50 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 13 04:27:50 mindpipe kernel:  [do_con_write+1035/1888] do_con_write+0x40b/0x760
Jul 13 04:27:50 mindpipe kernel:  [con_write+27/48] con_write+0x1b/0x30
Jul 13 04:27:50 mindpipe kernel:  [opost_block+210/400] opost_block+0xd2/0x190
Jul 13 04:27:50 mindpipe kernel:  [__alloc_pages+458/864] __alloc_pages+0x1ca/0x360
Jul 13 04:27:50 mindpipe kernel:  [write_chan+396/544] write_chan+0x18c/0x220
Jul 13 04:27:50 mindpipe kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
Jul 13 04:27:50 mindpipe kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
Jul 13 04:27:50 mindpipe kernel:  [tty_write+434/608] tty_write+0x1b2/0x260
Jul 13 04:27:50 mindpipe kernel:  [write_chan+0/544] write_chan+0x0/0x220
Jul 13 04:27:50 mindpipe kernel:  [vfs_write+186/256] vfs_write+0xba/0x100
Jul 13 04:27:50 mindpipe kernel:  [sys_write+45/80] sys_write+0x2d/0x50
Jul 13 04:27:50 mindpipe kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jul 13 04:27:50 mindpipe kernel:
Jul 13 04:27:50 mindpipe kernel: ALSA /usr/src/alsa-cvs-1.0.5/alsa-driver/alsa-kernel/core/pcm_lib.c:169: XRUN: pcmC0D0p
Jul 13 04:27:50 mindpipe kernel:  [__crc_totalram_pages+1387264/5353478] snd_pcm_period_elapsed+0x2ca/0x410 [snd_pcm]
Jul 13 04:27:50 mindpipe kernel:  [__crc_totalram_pages+1455070/5353478] snd_emu10k1_interrupt+0x3c8/0x480 [snd_emu10k1]
Jul 13 04:27:50 mindpipe kernel:  [handle_IRQ_event+49/96] handle_IRQ_event+0x31/0x60
Jul 13 04:27:50 mindpipe kernel:  [do_IRQ+155/352] do_IRQ+0x9b/0x160
Jul 13 04:27:50 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 13 04:27:50 mindpipe kernel:  [do_con_write+974/1888] do_con_write+0x3ce/0x760
Jul 13 04:27:50 mindpipe kernel:  [con_put_char+51/64] con_put_char+0x33/0x40
Jul 13 04:27:50 mindpipe kernel:  [opost+327/464] opost+0x147/0x1d0
Jul 13 04:27:50 mindpipe kernel:  [write_chan+437/544] write_chan+0x1b5/0x220
Jul 13 04:27:50 mindpipe kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
Jul 13 04:27:50 mindpipe kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
Jul 13 04:27:50 mindpipe kernel:  [tty_write+434/608] tty_write+0x1b2/0x260
Jul 13 04:27:50 mindpipe kernel:  [write_chan+0/544] write_chan+0x0/0x220
Jul 13 04:27:50 mindpipe kernel:  [vfs_write+186/256] vfs_write+0xba/0x100
Jul 13 04:27:50 mindpipe kernel:  [sys_write+45/80] sys_write+0x2d/0x50
Jul 13 04:27:50 mindpipe kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jul 13 04:27:50 mindpipe kernel:
Jul 13 04:27:50 mindpipe kernel: ALSA /usr/src/alsa-cvs-1.0.5/alsa-driver/alsa-kernel/core/pcm_lib.c:169: XRUN: pcmC0D0p
Jul 13 04:27:50 mindpipe kernel:  [__crc_totalram_pages+1387264/5353478] snd_pcm_period_elapsed+0x2ca/0x410 [snd_pcm]
Jul 13 04:27:50 mindpipe kernel:  [__crc_totalram_pages+1455070/5353478] snd_emu10k1_interrupt+0x3c8/0x480 [snd_emu10k1]
Jul 13 04:27:50 mindpipe kernel:  [handle_IRQ_event+49/96] handle_IRQ_event+0x31/0x60
Jul 13 04:27:50 mindpipe kernel:  [do_IRQ+155/352] do_IRQ+0x9b/0x160
Jul 13 04:27:50 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 13 04:27:50 mindpipe kernel:  [do_con_write+1448/1888] do_con_write+0x5a8/0x760
Jul 13 04:27:50 mindpipe kernel:  [con_write+27/48] con_write+0x1b/0x30
Jul 13 04:27:50 mindpipe kernel:  [opost_block+210/400] opost_block+0xd2/0x190
Jul 13 04:27:50 mindpipe kernel:  [__alloc_pages+458/864] __alloc_pages+0x1ca/0x360
Jul 13 04:27:50 mindpipe kernel:  [write_chan+396/544] write_chan+0x18c/0x220
Jul 13 04:27:50 mindpipe kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
Jul 13 04:27:50 mindpipe kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
Jul 13 04:27:50 mindpipe kernel:  [tty_write+434/608] tty_write+0x1b2/0x260
Jul 13 04:27:50 mindpipe kernel:  [write_chan+0/544] write_chan+0x0/0x220
Jul 13 04:27:50 mindpipe kernel:  [vfs_write+186/256] vfs_write+0xba/0x100
Jul 13 04:27:50 mindpipe kernel:  [sys_write+45/80] sys_write+0x2d/0x50
Jul 13 04:27:50 mindpipe kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jul 13 04:27:50 mindpipe kernel:

Lee

