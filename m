Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267271AbUGNAvU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267271AbUGNAvU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 20:51:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267273AbUGNAvU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 20:51:20 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:50077 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267271AbUGNAvG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 20:51:06 -0400
Subject: Ext3 vs. ReiserFS results (was Re: XRUN traces)
From: Lee Revell <rlrevell@joe-job.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040713161004.37a4654e.akpm@osdl.org>
References: <1089758294.2747.4.camel@mindpipe>
	 <20040713161004.37a4654e.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1089763038.3392.8.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 13 Jul 2004 20:51:06 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-07-13 at 19:10, Andrew Morton wrote:
> Lee Revell <rlrevell@joe-job.com> wrote:
> >
> > This one is 100% reproducible, happens immediately when I start JACK.  I
> > have set CONFIG_FRAME_POINTER=y and CONFIG_4KSTACKS=n as you requested.
> > 
> > Jul 13 18:30:21 mindpipe kernel: ALSA /usr/src/alsa-cvs-1.0.5/alsa-driver/alsa-kernel/core/pcm_lib.c:169: XRUN: pcmC0D0p
> > Jul 13 18:30:21 mindpipe kernel:  [dump_stack+23/32] dump_stack+0x17/0x20
> > Jul 13 18:30:21 mindpipe kernel:  [__crc_totalram_pages+1279533/3558647] snd_pcm_period_elapsed+0x2c7/0x400 [snd_pcm]
> > Jul 13 18:30:21 mindpipe kernel:  [__crc_totalram_pages+1463213/3558647] snd_emu10k1_interrupt+0x377/0x400 [snd_emu10k1]
> > Jul 13 18:30:21 mindpipe kernel:  [handle_IRQ_event+51/96] handle_IRQ_event+0x33/0x60
> > Jul 13 18:30:21 mindpipe kernel:  [do_IRQ+165/368] do_IRQ+0xa5/0x170
> > Jul 13 18:30:21 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
> > Jul 13 18:30:21 mindpipe kernel:  [do_anonymous_page+124/384] do_anonymous_page+0x7c/0x180
> > Jul 13 18:30:21 mindpipe kernel:  [do_no_page+78/784] do_no_page+0x4e/0x310
> > Jul 13 18:30:21 mindpipe kernel:  [handle_mm_fault+193/368] handle_mm_fault+0xc1/0x170
> > Jul 13 18:30:21 mindpipe kernel:  [get_user_pages+258/880] get_user_pages+0x102/0x370
> 
> OK, I'll fix get_user_pages().
> -

I have copied my system onto an ext3 filesystem and ran the same test. 
It seems to be much better.  These are all the XRUNs from running my
JACK test while untarring a kernel tree in /tmp while doing `find /
-ls'.  There are not too many.  Previously I had to send excerpts, this
is the entire log.  With reiserfs, I was not having to artificially
stress the filesystem at all to produce WAY more XRUN traces than this.

Jul 13 19:47:53 mindpipe kernel: ALSA /usr/src/alsa-cvs-1.0.5/alsa-driver/alsa-kernel/core/pcm_lib.c:169: XRUN: pcmC0D0p
Jul 13 19:47:53 mindpipe kernel:  [dump_stack+23/32] dump_stack+0x17/0x20
Jul 13 19:47:53 mindpipe kernel:  [__crc_totalram_pages+562733/3558647] snd_pcm_period_elapsed+0x2c7/0x400 [snd_pcm]
Jul 13 19:47:53 mindpipe kernel:  [__crc_totalram_pages+631725/3558647] snd_emu10k1_interrupt+0x377/0x400 [snd_emu10k1]
Jul 13 19:47:53 mindpipe kernel:  [handle_IRQ_event+51/96] handle_IRQ_event+0x33/0x60
Jul 13 19:47:53 mindpipe kernel:  [do_IRQ+165/368] do_IRQ+0xa5/0x170
Jul 13 19:47:53 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 13 19:47:53 mindpipe kernel:
Jul 13 19:48:04 mindpipe kernel: ALSA /usr/src/alsa-cvs-1.0.5/alsa-driver/alsa-kernel/core/pcm_lib.c:169: XRUN: pcmC0D0p
Jul 13 19:48:04 mindpipe kernel:  [dump_stack+23/32] dump_stack+0x17/0x20
Jul 13 19:48:04 mindpipe kernel:  [__crc_totalram_pages+562733/3558647] snd_pcm_period_elapsed+0x2c7/0x400 [snd_pcm]
Jul 13 19:48:04 mindpipe kernel:  [__crc_totalram_pages+631725/3558647] snd_emu10k1_interrupt+0x377/0x400 [snd_emu10k1]
Jul 13 19:48:04 mindpipe kernel:  [handle_IRQ_event+51/96] handle_IRQ_event+0x33/0x60
Jul 13 19:48:04 mindpipe kernel:  [do_IRQ+165/368] do_IRQ+0xa5/0x170
Jul 13 19:48:04 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 13 19:48:04 mindpipe kernel:
Jul 13 19:48:05 mindpipe kernel: ALSA /usr/src/alsa-cvs-1.0.5/alsa-driver/alsa-kernel/core/pcm_lib.c:169: XRUN: pcmC0D0p
Jul 13 19:48:05 mindpipe kernel:  [dump_stack+23/32] dump_stack+0x17/0x20
Jul 13 19:48:05 mindpipe kernel:  [__crc_totalram_pages+562733/3558647] snd_pcm_period_elapsed+0x2c7/0x400 [snd_pcm]
Jul 13 19:48:05 mindpipe kernel:  [__crc_totalram_pages+631725/3558647] snd_emu10k1_interrupt+0x377/0x400 [snd_emu10k1]
Jul 13 19:48:05 mindpipe kernel:  [handle_IRQ_event+51/96] handle_IRQ_event+0x33/0x60
Jul 13 19:48:05 mindpipe kernel:  [do_IRQ+165/368] do_IRQ+0xa5/0x170
Jul 13 19:48:05 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 13 19:48:05 mindpipe kernel:
Jul 13 19:48:06 mindpipe kernel: ALSA /usr/src/alsa-cvs-1.0.5/alsa-driver/alsa-kernel/core/pcm_lib.c:169: XRUN: pcmC0D0p
Jul 13 19:48:06 mindpipe kernel:  [dump_stack+23/32] dump_stack+0x17/0x20
Jul 13 19:48:06 mindpipe kernel:  [__crc_totalram_pages+562733/3558647] snd_pcm_period_elapsed+0x2c7/0x400 [snd_pcm]
Jul 13 19:48:06 mindpipe kernel:  [__crc_totalram_pages+631725/3558647] snd_emu10k1_interrupt+0x377/0x400 [snd_emu10k1]
Jul 13 19:48:06 mindpipe kernel:  [handle_IRQ_event+51/96] handle_IRQ_event+0x33/0x60
Jul 13 19:48:06 mindpipe kernel:  [do_IRQ+165/368] do_IRQ+0xa5/0x170
Jul 13 19:48:06 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 13 19:48:06 mindpipe kernel:
Jul 13 19:48:11 mindpipe kernel: ALSA /usr/src/alsa-cvs-1.0.5/alsa-driver/alsa-kernel/core/pcm_lib.c:169: XRUN: pcmC0D0p
Jul 13 19:48:11 mindpipe kernel:  [dump_stack+23/32] dump_stack+0x17/0x20
Jul 13 19:48:11 mindpipe kernel:  [__crc_totalram_pages+562733/3558647] snd_pcm_period_elapsed+0x2c7/0x400 [snd_pcm]
Jul 13 19:48:11 mindpipe kernel:  [__crc_totalram_pages+631725/3558647] snd_emu10k1_interrupt+0x377/0x400 [snd_emu10k1]
Jul 13 19:48:11 mindpipe kernel:  [handle_IRQ_event+51/96] handle_IRQ_event+0x33/0x60
Jul 13 19:48:11 mindpipe kernel:  [do_IRQ+165/368] do_IRQ+0xa5/0x170
Jul 13 19:48:11 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 13 19:48:11 mindpipe kernel:  [generic_file_aio_write_nolock+1044/2944] generic_file_aio_write_nolock+0x414/0xb80
Jul 13 19:48:11 mindpipe kernel:  [generic_file_aio_write+98/144] generic_file_aio_write+0x62/0x90
Jul 13 19:48:11 mindpipe kernel:  [ext3_file_write+40/192] ext3_file_write+0x28/0xc0
Jul 13 19:48:11 mindpipe kernel:  [do_sync_write+123/176] do_sync_write+0x7b/0xb0
Jul 13 19:48:11 mindpipe kernel:  [vfs_write+188/272] vfs_write+0xbc/0x110
Jul 13 19:48:11 mindpipe kernel:  [sys_write+46/80] sys_write+0x2e/0x50
Jul 13 19:48:11 mindpipe kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jul 13 19:48:11 mindpipe kernel:
Jul 13 19:48:32 mindpipe kernel: ALSA /usr/src/alsa-cvs-1.0.5/alsa-driver/alsa-kernel/core/pcm_lib.c:169: XRUN: pcmC0D0p
Jul 13 19:48:32 mindpipe kernel:  [dump_stack+23/32] dump_stack+0x17/0x20
Jul 13 19:48:32 mindpipe kernel:  [__crc_totalram_pages+562733/3558647] snd_pcm_period_elapsed+0x2c7/0x400 [snd_pcm]
Jul 13 19:48:32 mindpipe kernel:  [__crc_totalram_pages+631725/3558647] snd_emu10k1_interrupt+0x377/0x400 [snd_emu10k1]
Jul 13 19:48:32 mindpipe kernel:  [handle_IRQ_event+51/96] handle_IRQ_event+0x33/0x60
Jul 13 19:48:32 mindpipe kernel:  [do_IRQ+165/368] do_IRQ+0xa5/0x170
Jul 13 19:48:32 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 13 19:48:32 mindpipe kernel:
Jul 13 19:48:34 mindpipe kernel: ALSA /usr/src/alsa-cvs-1.0.5/alsa-driver/alsa-kernel/core/pcm_lib.c:169: XRUN: pcmC0D0p
Jul 13 19:48:34 mindpipe kernel:  [dump_stack+23/32] dump_stack+0x17/0x20
Jul 13 19:48:34 mindpipe kernel:  [__crc_totalram_pages+562733/3558647] snd_pcm_period_elapsed+0x2c7/0x400 [snd_pcm]
Jul 13 19:48:34 mindpipe kernel:  [__crc_totalram_pages+631725/3558647] snd_emu10k1_interrupt+0x377/0x400 [snd_emu10k1]
Jul 13 19:48:34 mindpipe kernel:  [handle_IRQ_event+51/96] handle_IRQ_event+0x33/0x60
Jul 13 19:48:34 mindpipe kernel:  [do_IRQ+165/368] do_IRQ+0xa5/0x170
Jul 13 19:48:34 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 13 19:48:34 mindpipe kernel:
Jul 13 19:49:04 mindpipe kernel: ALSA /usr/src/alsa-cvs-1.0.5/alsa-driver/alsa-kernel/core/pcm_lib.c:169: XRUN: pcmC0D0p
Jul 13 19:49:04 mindpipe kernel:  [dump_stack+23/32] dump_stack+0x17/0x20
Jul 13 19:49:04 mindpipe kernel:  [__crc_totalram_pages+562733/3558647] snd_pcm_period_elapsed+0x2c7/0x400 [snd_pcm]
Jul 13 19:49:04 mindpipe kernel:  [__crc_totalram_pages+631725/3558647] snd_emu10k1_interrupt+0x377/0x400 [snd_emu10k1]
Jul 13 19:49:04 mindpipe kernel:  [handle_IRQ_event+51/96] handle_IRQ_event+0x33/0x60
Jul 13 19:49:04 mindpipe kernel:  [do_IRQ+165/368] do_IRQ+0xa5/0x170
Jul 13 19:49:04 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 13 19:49:04 mindpipe kernel:  [schedule_timeout+87/160] schedule_timeout+0x57/0xa0
Jul 13 19:49:04 mindpipe kernel:  [do_poll+161/192] do_poll+0xa1/0xc0
Jul 13 19:49:04 mindpipe kernel:  [sys_poll+305/544] sys_poll+0x131/0x220
Jul 13 19:49:04 mindpipe kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jul 13 19:49:04 mindpipe kernel:
Jul 13 19:49:05 mindpipe kernel: ALSA /usr/src/alsa-cvs-1.0.5/alsa-driver/alsa-kernel/core/pcm_lib.c:169: XRUN: pcmC0D0p
Jul 13 19:49:05 mindpipe kernel:  [dump_stack+23/32] dump_stack+0x17/0x20
Jul 13 19:49:05 mindpipe kernel:  [__crc_totalram_pages+562733/3558647] snd_pcm_period_elapsed+0x2c7/0x400 [snd_pcm]
Jul 13 19:49:05 mindpipe kernel:  [__crc_totalram_pages+631725/3558647] snd_emu10k1_interrupt+0x377/0x400 [snd_emu10k1]
Jul 13 19:49:05 mindpipe kernel:  [handle_IRQ_event+51/96] handle_IRQ_event+0x33/0x60
Jul 13 19:49:05 mindpipe kernel:  [do_IRQ+165/368] do_IRQ+0xa5/0x170
Jul 13 19:49:05 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 13 19:49:05 mindpipe kernel:  [schedule+731/1424] schedule+0x2db/0x590
Jul 13 19:49:05 mindpipe kernel:  [work_resched+5/22] work_resched+0x5/0x16
Jul 13 19:49:05 mindpipe kernel:
Jul 13 19:49:26 mindpipe kernel: ALSA /usr/src/alsa-cvs-1.0.5/alsa-driver/alsa-kernel/core/pcm_lib.c:169: XRUN: pcmC0D0p
Jul 13 19:49:26 mindpipe kernel:  [dump_stack+23/32] dump_stack+0x17/0x20
Jul 13 19:49:26 mindpipe kernel:  [__crc_totalram_pages+562733/3558647] snd_pcm_period_elapsed+0x2c7/0x400 [snd_pcm]
Jul 13 19:49:26 mindpipe kernel:  [__crc_totalram_pages+631725/3558647] snd_emu10k1_interrupt+0x377/0x400 [snd_emu10k1]
Jul 13 19:49:26 mindpipe kernel:  [handle_IRQ_event+51/96] handle_IRQ_event+0x33/0x60
Jul 13 19:49:26 mindpipe kernel:  [do_IRQ+165/368] do_IRQ+0xa5/0x170
Jul 13 19:49:26 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 13 19:49:26 mindpipe kernel:
Jul 13 19:49:54 mindpipe kernel: ALSA /usr/src/alsa-cvs-1.0.5/alsa-driver/alsa-kernel/core/pcm_lib.c:169: XRUN: pcmC0D0p
Jul 13 19:49:54 mindpipe kernel:  [dump_stack+23/32] dump_stack+0x17/0x20
Jul 13 19:49:54 mindpipe kernel:  [__crc_totalram_pages+562733/3558647] snd_pcm_period_elapsed+0x2c7/0x400 [snd_pcm]
Jul 13 19:49:54 mindpipe kernel:  [__crc_totalram_pages+631725/3558647] snd_emu10k1_interrupt+0x377/0x400 [snd_emu10k1]
Jul 13 19:49:54 mindpipe kernel:  [handle_IRQ_event+51/96] handle_IRQ_event+0x33/0x60
Jul 13 19:49:54 mindpipe kernel:  [do_IRQ+165/368] do_IRQ+0xa5/0x170
Jul 13 19:49:54 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 13 19:49:54 mindpipe kernel:
Jul 13 19:50:05 mindpipe kernel: ALSA /usr/src/alsa-cvs-1.0.5/alsa-driver/alsa-kernel/core/pcm_lib.c:169: XRUN: pcmC0D0p
Jul 13 19:50:05 mindpipe kernel:  [dump_stack+23/32] dump_stack+0x17/0x20
Jul 13 19:50:05 mindpipe kernel:  [__crc_totalram_pages+562733/3558647] snd_pcm_period_elapsed+0x2c7/0x400 [snd_pcm]
Jul 13 19:50:05 mindpipe kernel:  [__crc_totalram_pages+631725/3558647] snd_emu10k1_interrupt+0x377/0x400 [snd_emu10k1]
Jul 13 19:50:05 mindpipe kernel:  [handle_IRQ_event+51/96] handle_IRQ_event+0x33/0x60
Jul 13 19:50:05 mindpipe kernel:  [do_IRQ+165/368] do_IRQ+0xa5/0x170
Jul 13 19:50:05 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 13 19:50:05 mindpipe kernel:
Jul 13 19:50:46 mindpipe kernel: ALSA /usr/src/alsa-cvs-1.0.5/alsa-driver/alsa-kernel/core/pcm_lib.c:169: XRUN: pcmC0D0p
Jul 13 19:50:46 mindpipe kernel:  [dump_stack+23/32] dump_stack+0x17/0x20
Jul 13 19:50:46 mindpipe kernel:  [__crc_totalram_pages+562733/3558647] snd_pcm_period_elapsed+0x2c7/0x400 [snd_pcm]
Jul 13 19:50:46 mindpipe kernel:  [__crc_totalram_pages+631725/3558647] snd_emu10k1_interrupt+0x377/0x400 [snd_emu10k1]
Jul 13 19:50:46 mindpipe kernel:  [handle_IRQ_event+51/96] handle_IRQ_event+0x33/0x60
Jul 13 19:50:46 mindpipe kernel:  [do_IRQ+165/368] do_IRQ+0xa5/0x170
Jul 13 19:50:46 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 13 19:50:46 mindpipe kernel:  [rcu_process_callbacks+150/256] rcu_process_callbacks+0x96/0x100
Jul 13 19:50:46 mindpipe kernel:  [tasklet_action+68/112] tasklet_action+0x44/0x70
Jul 13 19:50:46 mindpipe kernel:  [__do_softirq+131/144] __do_softirq+0x83/0x90
Jul 13 19:50:46 mindpipe kernel:  [do_softirq+53/64] do_softirq+0x35/0x40
Jul 13 19:50:46 mindpipe kernel:  [do_IRQ+277/368] do_IRQ+0x115/0x170
Jul 13 19:50:46 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 13 19:50:46 mindpipe kernel:
Jul 13 19:51:41 mindpipe kernel: ALSA /usr/src/alsa-cvs-1.0.5/alsa-driver/alsa-kernel/core/pcm_lib.c:169: XRUN: pcmC0D0p
Jul 13 19:51:41 mindpipe kernel:  [dump_stack+23/32] dump_stack+0x17/0x20
Jul 13 19:51:41 mindpipe kernel:  [__crc_totalram_pages+562733/3558647] snd_pcm_period_elapsed+0x2c7/0x400 [snd_pcm]
Jul 13 19:51:41 mindpipe kernel:  [__crc_totalram_pages+631725/3558647] snd_emu10k1_interrupt+0x377/0x400 [snd_emu10k1]
Jul 13 19:51:41 mindpipe kernel:  [handle_IRQ_event+51/96] handle_IRQ_event+0x33/0x60
Jul 13 19:51:41 mindpipe kernel:  [do_IRQ+165/368] do_IRQ+0xa5/0x170
Jul 13 19:51:41 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 13 19:51:41 mindpipe kernel:  [do_softirq+53/64] do_softirq+0x35/0x40
Jul 13 19:51:41 mindpipe kernel:  [do_IRQ+277/368] do_IRQ+0x115/0x170
Jul 13 19:51:41 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 13 19:51:41 mindpipe kernel:
Jul 13 19:51:42 mindpipe kernel: ALSA /usr/src/alsa-cvs-1.0.5/alsa-driver/alsa-kernel/core/pcm_lib.c XRUN: pcmC0D0p
Jul 13 19:51:42 mindpipe kernel:  [dump_stack+23/32] dump_stack+0x17/0x20
Jul 13 19:51:42 mindpipe kernel:  [__crc_totalram_pages+562733/3558647] snd_pcm_period_elapsed+0x2c7/0x400 [snd_pcm]
Jul 13 19:51:42 mindpipe kernel:  [__crc_totalram_pages+631725/3558647] snd_emu10k1_interrupt+0x377/0x400 [snd_emu10k1]
Jul 13 19:51:42 mindpipe kernel:  [handle_IRQ_event+51/96] handle_IRQ_event+0x33/0x60
Jul 13 19:51:42 mindpipe kernel:  [do_IRQ+165/368] do_IRQ+0xa5/0x170
Jul 13 19:51:42 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 13 19:51:42 mindpipe kernel:  [scrup+243/320] scrup+0xf3/0x140
Jul 13 19:51:42 mindpipe kernel:  [lf+96/112] lf+0x60/0x70
Jul 13 19:51:42 mindpipe kernel:  [do_con_trol+2955/3408] do_con_trol+0xb8b/0xd50
Jul 13 19:51:42 mindpipe kernel:  [do_con_write+1071/1792] do_con_write+0x42f/0x700
Jul 13 19:51:42 mindpipe kernel:  [con_put_char+49/64] con_put_char+0x31/0x40
Jul 13 19:51:42 mindpipe kernel:  [opost+178/464] opost+0xb2/0x1d0
Jul 13 19:51:42 mindpipe kernel:  [write_chan+424/528] write_chan+0x1a8/0x210
Jul 13 19:51:42 mindpipe kernel:  [tty_write+247/448] tty_write+0xf7/0x1c0
Jul 13 19:51:42 mindpipe kernel:  [vfs_write+188/272] vfs_write+0xbc/0x110
Jul 13 19:51:42 mindpipe kernel:  [sys_write+46/80] sys_write+0x2e/0x50
Jul 13 19:51:42 mindpipe kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jul 13 19:51:42 mindpipe kernel:
Jul 13 19:51:45 mindpipe kernel: ALSA /usr/src/alsa-cvs-1.0.5/alsa-driver/alsa-kernel/core/pcm_lib.c:169: XRUN: pcmC0D0p
Jul 13 19:51:45 mindpipe kernel:  [dump_stack+23/32] dump_stack+0x17/0x20
Jul 13 19:51:45 mindpipe kernel:  [__crc_totalram_pages+562733/3558647] snd_pcm_period_elapsed+0x2c7/0x400 [snd_pcm]
Jul 13 19:51:45 mindpipe kernel:  [__crc_totalram_pages+631725/3558647] snd_emu10k1_interrupt+0x377/0x400 [snd_emu10k1]
Jul 13 19:51:45 mindpipe kernel:  [handle_IRQ_event+51/96] handle_IRQ_event+0x33/0x60
Jul 13 19:51:45 mindpipe kernel:  [do_IRQ+165/368] do_IRQ+0xa5/0x170
Jul 13 19:51:45 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 13 19:51:45 mindpipe kernel:  [d_callback+29/64] d_callback+0x1d/0x40
Jul 13 19:51:45 mindpipe kernel:  [rcu_do_batch+62/80] rcu_do_batch+0x3e/0x50
Jul 13 19:51:45 mindpipe kernel:  [rcu_process_callbacks+150/256] rcu_process_callbacks+0x96/0x100
Jul 13 19:51:45 mindpipe kernel:  [tasklet_action+68/112] tasklet_action+0x44/0x70
Jul 13 19:51:45 mindpipe kernel:  [__do_softirq+131/144] __do_softirq+0x83/0x90
Jul 13 19:51:45 mindpipe kernel:  [do_softirq+53/64] do_softirq+0x35/0x40
Jul 13 19:51:45 mindpipe kernel:  [do_IRQ+277/368] do_IRQ+0x115/0x170
Jul 13 19:51:45 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 13 19:51:45 mindpipe kernel:  [poll_freewait+46/80] poll_freewait+0x2e/0x50
Jul 13 19:51:45 mindpipe kernel:  [sys_poll+472/544] sys_poll+0x1d8/0x220
Jul 13 19:51:45 mindpipe kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jul 13 19:51:45 mindpipe kernel:

Lee

