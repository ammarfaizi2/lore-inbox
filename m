Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267218AbUGMXQU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267218AbUGMXQU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 19:16:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267219AbUGMXQU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 19:16:20 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:63709 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267218AbUGMXQL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 19:16:11 -0400
Subject: Re: XRUN traces
From: Lee Revell <rlrevell@joe-job.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1089758294.2747.4.camel@mindpipe>
References: <1089758294.2747.4.camel@mindpipe>
Content-Type: text/plain
Message-Id: <1089760570.2747.18.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 13 Jul 2004 19:16:10 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-07-13 at 18:38, Lee Revell wrote:
> OK, I am starting a new thread here, as the other was getting unwieldy.
> 
> This one is 100% reproducible, happens immediately when I start JACK.  I
> have set CONFIG_FRAME_POINTER=y and CONFIG_4KSTACKS=n as you requested.
> 

After removing (un)lock_kernel from do_tty_write, I can still cause an
XRUN by switching consoles, but it it much less common that before.  I
have not seen any display problems at all.

Jul 13 19:09:04 mindpipe kernel: ALSA /usr/src/alsa-cvs-1.0.5/alsa-driver/alsa-kernel/core/pcm_lib.c:169: XRUN: pcmC0D0p
Jul 13 19:09:04 mindpipe kernel:  [dump_stack+23/32] dump_stack+0x17/0x20
Jul 13 19:09:04 mindpipe kernel:  [__crc_totalram_pages+1279533/3558647] snd_pcm_period_elapsed+0x2c7/0x400 [snd_pcm]
Jul 13 19:09:04 mindpipe kernel:  [__crc_totalram_pages+1463213/3558647] snd_emu10k1_interrupt+0x377/0x400 [snd_emu10k1]
Jul 13 19:09:04 mindpipe kernel:  [handle_IRQ_event+51/96] handle_IRQ_event+0x33/0x60
Jul 13 19:09:04 mindpipe kernel:  [do_IRQ+165/368] do_IRQ+0xa5/0x170
Jul 13 19:09:04 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 13 19:09:04 mindpipe kernel:
Jul 13 19:09:05 mindpipe kernel: ALSA /usr/src/alsa-cvs-1.0.5/alsa-driver/alsa-kernel/core/pcm_lib.c:169: XRUN: pcmC0D0p
Jul 13 19:09:05 mindpipe kernel:  [dump_stack+23/32] dump_stack+0x17/0x20
Jul 13 19:09:05 mindpipe kernel:  [__crc_totalram_pages+1279533/3558647] snd_pcm_period_elapsed+0x2c7/0x400 [snd_pcm]
Jul 13 19:09:05 mindpipe kernel:  [__crc_totalram_pages+1463213/3558647] snd_emu10k1_interrupt+0x377/0x400 [snd_emu10k1]
Jul 13 19:09:05 mindpipe kernel:  [handle_IRQ_event+51/96] handle_IRQ_event+0x33/0x60
Jul 13 19:09:05 mindpipe kernel:  [do_IRQ+165/368] do_IRQ+0xa5/0x170
Jul 13 19:09:05 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 13 19:09:05 mindpipe kernel:
Jul 13 19:09:05 mindpipe kernel: ALSA /usr/src/alsa-cvs-1.0.5/alsa-driver/alsa-kernel/core/pcm_lib.c:169: XRUN: pcmC0D0p
Jul 13 19:09:05 mindpipe kernel:  [dump_stack+23/32] dump_stack+0x17/0x20
Jul 13 19:09:05 mindpipe kernel:  [__crc_totalram_pages+1279533/3558647] snd_pcm_period_elapsed+0x2c7/0x400 [snd_pcm]
Jul 13 19:09:05 mindpipe kernel:  [__crc_totalram_pages+1463213/3558647] snd_emu10k1_interrupt+0x377/0x400 [snd_emu10k1]
Jul 13 19:09:05 mindpipe kernel:  [handle_IRQ_event+51/96] handle_IRQ_event+0x33/0x60
Jul 13 19:09:05 mindpipe kernel:  [do_IRQ+165/368] do_IRQ+0xa5/0x170
Jul 13 19:09:05 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 13 19:09:05 mindpipe kernel:  [con_put_char+49/64] con_put_char+0x31/0x40
Jul 13 19:09:05 mindpipe kernel:  [opost+178/464] opost+0xb2/0x1d0
Jul 13 19:09:05 mindpipe kernel:  [write_chan+424/528] write_chan+0x1a8/0x210
Jul 13 19:09:05 mindpipe kernel:  [tty_write+247/448] tty_write+0xf7/0x1c0
Jul 13 19:09:05 mindpipe kernel:  [vfs_write+188/272] vfs_write+0xbc/0x110
Jul 13 19:09:05 mindpipe kernel:  [sys_write+46/80] sys_write+0x2e/0x50
Jul 13 19:09:05 mindpipe kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jul 13 19:09:05 mindpipe kernel:
Jul 13 19:09:05 mindpipe kernel: ALSA /usr/src/alsa-cvs-1.0.5/alsa-driver/alsa-kernel/core/pcm_lib.c:169: XRUN: pcmC0D0p
Jul 13 19:09:05 mindpipe kernel:  [dump_stack+23/32] dump_stack+0x17/0x20
Jul 13 19:09:05 mindpipe kernel:  [__crc_totalram_pages+1279533/3558647] snd_pcm_period_elapsed+0x2c7/0x400 [snd_pcm]
Jul 13 19:09:05 mindpipe kernel:  [__crc_totalram_pages+1463213/3558647] snd_emu10k1_interrupt+0x377/0x400 [snd_emu10k1]
Jul 13 19:09:05 mindpipe kernel:  [handle_IRQ_event+51/96] handle_IRQ_event+0x33/0x60
Jul 13 19:09:05 mindpipe kernel:  [do_IRQ+165/368] do_IRQ+0xa5/0x170
Jul 13 19:09:05 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 13 19:09:05 mindpipe kernel:  [scrup+243/320] scrup+0xf3/0x140
Jul 13 19:09:05 mindpipe kernel:  [lf+96/112] lf+0x60/0x70
Jul 13 19:09:05 mindpipe kernel:  [do_con_trol+2955/3408] do_con_trol+0xb8b/0xd50
Jul 13 19:09:05 mindpipe kernel:  [do_con_write+1071/1792] do_con_write+0x42f/0x700
Jul 13 19:09:05 mindpipe kernel:  [con_put_char+49/64] con_put_char+0x31/0x40
Jul 13 19:09:05 mindpipe kernel:  [opost+178/464] opost+0xb2/0x1d0
Jul 13 19:09:05 mindpipe kernel:  [write_chan+424/528] write_chan+0x1a8/0x210
Jul 13 19:09:05 mindpipe kernel:  [tty_write+247/448] tty_write+0xf7/0x1c0
Jul 13 19:09:05 mindpipe kernel:  [vfs_write+188/272] vfs_write+0xbc/0x110
Jul 13 19:09:05 mindpipe kernel:  [sys_write+46/80] sys_write+0x2e/0x50
Jul 13 19:09:05 mindpipe kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jul 13 19:09:05 mindpipe kernel:
Jul 13 19:09:05 mindpipe kernel:
Jul 13 19:09:05 mindpipe kernel: ALSA /usr/src/alsa-cvs-1.0.5/alsa-driver/alsa-kernel/core/pcm_lib.c:169: XRUN: pcmC0D0p
Jul 13 19:09:05 mindpipe kernel:  [dump_stack+23/32] dump_stack+0x17/0x20
Jul 13 19:09:05 mindpipe kernel:  [__crc_totalram_pages+1279533/3558647] snd_pcm_period_elapsed+0x2c7/0x400 [snd_pcm]
Jul 13 19:09:05 mindpipe kernel:  [__crc_totalram_pages+1463213/3558647] snd_emu10k1_interrupt+0x377/0x400 [snd_emu10k1]
Jul 13 19:09:05 mindpipe kernel:  [handle_IRQ_event+51/96] handle_IRQ_event+0x33/0x60
Jul 13 19:09:05 mindpipe kernel:  [do_IRQ+165/368] do_IRQ+0xa5/0x170
Jul 13 19:09:05 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 13 19:09:05 mindpipe kernel:  [write_chan+382/528] write_chan+0x17e/0x210
Jul 13 19:09:05 mindpipe kernel:  [tty_write+247/448] tty_write+0xf7/0x1c0
Jul 13 19:09:05 mindpipe kernel:  [vfs_write+188/272] vfs_write+0xbc/0x110
Jul 13 19:09:05 mindpipe kernel:  [sys_write+46/80] sys_write+0x2e/0x50
Jul 13 19:09:05 mindpipe kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jul 13 19:09:05 mindpipe kernel:
Jul 13 19:09:06 mindpipe kernel: ALSA /usr/src/alsa-cvs-1.0.5/alsa-driver/alsa-kernel/core/pcm_lib.c:169: XRUN: pcmC0D0p
Jul 13 19:09:06 mindpipe kernel:  [dump_stack+23/32] dump_stack+0x17/0x20
Jul 13 19:09:06 mindpipe kernel:  [__crc_totalram_pages+1279533/3558647] snd_pcm_period_elapsed+0x2c7/0x400 [snd_pcm]
Jul 13 19:09:06 mindpipe kernel:  [__crc_totalram_pages+1463213/3558647] snd_emu10k1_interrupt+0x377/0x400 [snd_emu10k1]
Jul 13 19:09:06 mindpipe kernel:  [handle_IRQ_event+51/96] handle_IRQ_event+0x33/0x60
Jul 13 19:09:06 mindpipe kernel:  [do_IRQ+165/368] do_IRQ+0xa5/0x170
Jul 13 19:09:06 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 13 19:09:06 mindpipe kernel:  [con_write+26/48] con_write+0x1a/0x30
Jul 13 19:09:06 mindpipe kernel:  [opost_block+231/416] opost_block+0xe7/0x1a0
Jul 13 19:09:06 mindpipe kernel:  [write_chan+382/528] write_chan+0x17e/0x210
Jul 13 19:09:06 mindpipe kernel:  [tty_write+247/448] tty_write+0xf7/0x1c0
Jul 13 19:09:06 mindpipe kernel:  [vfs_write+188/272] vfs_write+0xbc/0x110
Jul 13 19:09:06 mindpipe kernel:  [sys_write+46/80] sys_write+0x2e/0x50
Jul 13 19:09:06 mindpipe kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jul 13 19:09:06 mindpipe kernel:

The following XRUNS occurred during:

cp -ax /reiserfs-filesystem /ext3-filesystem



Jul 13 18:45:25 mindpipe kernel:
Jul 13 18:45:25 mindpipe kernel: ALSA /usr/src/alsa-cvs-1.0.5/alsa-driver/alsa-kernel/core/pcm_lib.c:169: XRUN: pcmC0D0p
Jul 13 18:45:25 mindpipe kernel:  [dump_stack+23/32] dump_stack+0x17/0x20
Jul 13 18:45:25 mindpipe kernel:  [__crc_totalram_pages+1279533/3558647] snd_pcm_period_elapsed+0x2c7/0x400 [snd_pcm]
Jul 13 18:45:25 mindpipe kernel:  [__crc_totalram_pages+1463213/3558647] snd_emu10k1_interrupt+0x377/0x400 [snd_emu10k1]
Jul 13 18:45:25 mindpipe kernel:  [handle_IRQ_event+51/96] handle_IRQ_event+0x33/0x60
Jul 13 18:45:25 mindpipe kernel:  [do_IRQ+165/368] do_IRQ+0xa5/0x170
Jul 13 18:45:25 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 13 18:45:26 mindpipe kernel:  [ide_build_sglist+50/160] ide_build_sglist+0x32/0xa0
Jul 13 18:45:26 mindpipe kernel:  [ide_build_dmatable+372/400] ide_build_dmatable+0x174/0x190
Jul 13 18:45:26 mindpipe kernel:  [ide_start_dma+27/144] ide_start_dma+0x1b/0x90
Jul 13 18:45:26 mindpipe kernel:  [__ide_dma_write+39/176] __ide_dma_write+0x27/0xb0
Jul 13 18:45:26 mindpipe kernel:  [__ide_do_rw_disk+858/1408] __ide_do_rw_disk+0x35a/0x580
Jul 13 18:45:26 mindpipe kernel:  [start_request+313/544] start_request+0x139/0x220
Jul 13 18:45:26 mindpipe kernel:  [ide_do_request+494/880] ide_do_request+0x1ee/0x370
Jul 13 18:45:26 mindpipe kernel:  [ide_intr+302/416] ide_intr+0x12e/0x1a0
Jul 13 18:45:26 mindpipe kernel:  [handle_IRQ_event+51/96] handle_IRQ_event+0x33/0x60
Jul 13 18:45:26 mindpipe kernel:  [do_IRQ+165/368] do_IRQ+0xa5/0x170
Jul 13 18:45:26 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 13 18:45:26 mindpipe kernel:  [cache_init_objs+104/128] cache_init_objs+0x68/0x80
Jul 13 18:45:26 mindpipe kernel:  [cache_grow+230/512] cache_grow+0xe6/0x200
Jul 13 18:45:26 mindpipe kernel:  [cache_alloc_refill+358/576] cache_alloc_refill+0x166/0x240
Jul 13 18:45:26 mindpipe kernel:  [kmem_cache_alloc+62/80] kmem_cache_alloc+0x3e/0x50
Jul 13 18:45:26 mindpipe kernel:  [alloc_buffer_head+20/80] alloc_buffer_head+0x14/0x50
Jul 13 18:45:26 mindpipe kernel:  [create_buffers+39/176] create_buffers+0x27/0xb0
Jul 13 18:45:26 mindpipe kernel:  [create_empty_buffers+23/160] create_empty_buffers+0x17/0xa0
Jul 13 18:45:26 mindpipe kernel:  [__block_prepare_write+817/896] __block_prepare_write+0x331/0x380
Jul 13 18:45:26 mindpipe kernel:  [block_prepare_write+31/64] block_prepare_write+0x1f/0x40
Jul 13 18:45:26 mindpipe kernel:  [generic_file_aio_write_nolock+976/2944] generic_file_aio_write_nolock+0x3d0/0xb80
Jul 13 18:45:26 mindpipe kernel:  [generic_file_write_nolock+109/144] generic_file_write_nolock+0x6d/0x90
Jul 13 18:45:26 mindpipe kernel:  [blkdev_file_write+37/48] blkdev_file_write+0x25/0x30
Jul 13 18:45:26 mindpipe kernel:  [vfs_write+188/272] vfs_write+0xbc/0x110
Jul 13 18:45:26 mindpipe kernel:  [sys_write+46/80] sys_write+0x2e/0x50
Jul 13 18:45:26 mindpipe kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jul 13 18:45:26 mindpipe kernel:
Jul 13 18:45:26 mindpipe kernel: ALSA /usr/src/alsa-cvs-1.0.5/alsa-driver/alsa-kernel/core/pcm_lib.c:169: XRUN: pcmC0D0p
Jul 13 18:45:26 mindpipe kernel:  [dump_stack+23/32] dump_stack+0x17/0x20
Jul 13 18:45:26 mindpipe kernel:  [__crc_totalram_pages+1279533/3558647] snd_pcm_period_elapsed+0x2c7/0x400 [snd_pcm]
Jul 13 18:45:26 mindpipe kernel:  [__crc_totalram_pages+1463213/3558647] snd_emu10k1_interrupt+0x377/0x400 [snd_emu10k1]
Jul 13 18:45:26 mindpipe kernel:  [handle_IRQ_event+51/96] handle_IRQ_event+0x33/0x60
Jul 13 18:45:26 mindpipe kernel:  [do_IRQ+165/368] do_IRQ+0xa5/0x170
Jul 13 18:45:26 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 13 18:45:26 mindpipe kernel:  [ide_start_dma+27/144] ide_start_dma+0x1b/0x90
Jul 13 18:45:26 mindpipe kernel:  [__ide_dma_write+39/176] __ide_dma_write+0x27/0xb0
Jul 13 18:45:26 mindpipe kernel:  [__ide_do_rw_disk+858/1408] __ide_do_rw_disk+0x35a/0x580
Jul 13 18:45:26 mindpipe kernel:  [start_request+313/544] start_request+0x139/0x220
Jul 13 18:45:26 mindpipe kernel:  [ide_do_request+494/880] ide_do_request+0x1ee/0x370
Jul 13 18:45:26 mindpipe kernel:  [ide_intr+302/416] ide_intr+0x12e/0x1a0
Jul 13 18:45:26 mindpipe kernel:  [handle_IRQ_event+51/96] handle_IRQ_event+0x33/0x60
Jul 13 18:45:26 mindpipe kernel:  [do_IRQ+165/368] do_IRQ+0xa5/0x170
Jul 13 18:45:26 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 13 18:45:26 mindpipe kernel:
Jul 13 18:45:26 mindpipe kernel: ALSA /usr/src/alsa-cvs-1.0.5/alsa-driver/alsa-kernel/core/pcm_lib.c:169: XRUN: pcmC0D0p
Jul 13 18:45:26 mindpipe kernel:  [dump_stack+23/32] dump_stack+0x17/0x20
Jul 13 18:45:26 mindpipe kernel:  [__crc_totalram_pages+1279533/3558647] snd_pcm_period_elapsed+0x2c7/0x400 [snd_pcm]
Jul 13 18:45:26 mindpipe kernel:  [__crc_totalram_pages+1463213/3558647] snd_emu10k1_interrupt+0x377/0x400 [snd_emu10k1]
Jul 13 18:45:26 mindpipe kernel:  [handle_IRQ_event+51/96] handle_IRQ_event+0x33/0x60
Jul 13 18:45:26 mindpipe kernel:  [do_IRQ+165/368] do_IRQ+0xa5/0x170
Jul 13 18:45:26 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 13 18:45:26 mindpipe kernel:  [ide_build_sglist+50/160] ide_build_sglist+0x32/0xa0
Jul 13 18:45:26 mindpipe kernel:  [ide_build_dmatable+372/400] ide_build_dmatable+0x174/0x190
Jul 13 18:45:26 mindpipe kernel:  [ide_start_dma+27/144] ide_start_dma+0x1b/0x90
Jul 13 18:45:26 mindpipe kernel:  [__ide_dma_write+39/176] __ide_dma_write+0x27/0xb0
Jul 13 18:45:26 mindpipe kernel:  [__ide_do_rw_disk+858/1408] __ide_do_rw_disk+0x35a/0x580
Jul 13 18:45:26 mindpipe kernel:  [start_request+313/544] start_request+0x139/0x220
Jul 13 18:45:26 mindpipe kernel:  [ide_do_request+494/880] ide_do_request+0x1ee/0x370
Jul 13 18:45:26 mindpipe kernel:  [ide_intr+302/416] ide_intr+0x12e/0x1a0
Jul 13 18:45:26 mindpipe kernel:  [handle_IRQ_event+51/96] handle_IRQ_event+0x33/0x60
Jul 13 18:45:26 mindpipe kernel:  [do_IRQ+165/368] do_IRQ+0xa5/0x170
Jul 13 18:45:26 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 13 18:45:26 mindpipe kernel:
Jul 13 18:45:26 mindpipe kernel: ALSA /usr/src/alsa-cvs-1.0.5/alsa-driver/alsa-kernel/core/pcm_lib.c:169: XRUN: pcmC0D0p
Jul 13 18:45:26 mindpipe kernel:  [dump_stack+23/32] dump_stack+0x17/0x20
Jul 13 18:45:26 mindpipe kernel:  [__crc_totalram_pages+1279533/3558647] snd_pcm_period_elapsed+0x2c7/0x400 [snd_pcm]
Jul 13 18:45:26 mindpipe kernel:  [__crc_totalram_pages+1463213/3558647] snd_emu10k1_interrupt+0x377/0x400 [snd_emu10k1]
Jul 13 18:45:26 mindpipe kernel:  [handle_IRQ_event+51/96] handle_IRQ_event+0x33/0x60
Jul 13 18:45:26 mindpipe kernel:  [do_IRQ+165/368] do_IRQ+0xa5/0x170
Jul 13 18:45:26 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 13 18:45:26 mindpipe kernel:  [ide_build_sglist+50/160] ide_build_sglist+0x32/0xa0
Jul 13 18:45:26 mindpipe kernel:  [ide_build_dmatable+372/400] ide_build_dmatable+0x174/0x190
Jul 13 18:45:26 mindpipe kernel:  [ide_start_dma+27/144] ide_start_dma+0x1b/0x90
Jul 13 18:45:26 mindpipe kernel:  [__ide_dma_write+39/176] __ide_dma_write+0x27/0xb0
Jul 13 18:45:26 mindpipe kernel:  [__ide_do_rw_disk+858/1408] __ide_do_rw_disk+0x35a/0x580
Jul 13 18:45:26 mindpipe kernel:  [start_request+313/544] start_request+0x139/0x220
Jul 13 18:45:26 mindpipe kernel:  [ide_do_request+494/880] ide_do_request+0x1ee/0x370
Jul 13 18:45:26 mindpipe kernel:  [ide_intr+302/416] ide_intr+0x12e/0x1a0
Jul 13 18:45:26 mindpipe kernel:  [handle_IRQ_event+51/96] handle_IRQ_event+0x33/0x60
Jul 13 18:45:26 mindpipe kernel:  [do_IRQ+165/368] do_IRQ+0xa5/0x170
Jul 13 18:45:26 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 13 18:45:26 mindpipe kernel:  [reiserfs_update_sd_size+105/416] reiserfs_update_sd_size+0x69/0x1a0
Jul 13 18:45:26 mindpipe kernel:  [reiserfs_dirty_inode+87/192] reiserfs_dirty_inode+0x57/0xc0
Jul 13 18:45:26 mindpipe kernel:  [reiserfs_submit_file_region_for_write+667/784] reiserfs_submit_file_region_for_write+0x29b/0x310
Jul 13 18:45:26 mindpipe kernel:  [reiserfs_file_write+1543/2032] reiserfs_file_write+0x607/0x7f0
Jul 13 18:45:26 mindpipe kernel:  [do_readv_writev+363/592] do_readv_writev+0x16b/0x250
Jul 13 18:45:26 mindpipe kernel:  [vfs_writev+68/80] vfs_writev+0x44/0x50
Jul 13 18:45:26 mindpipe kernel:  [sys_writev+46/80] sys_writev+0x2e/0x50
Jul 13 18:45:26 mindpipe kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jul 13 18:45:26 mindpipe kernel:

Lee

