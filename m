Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266763AbUG1B5e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266763AbUG1B5e (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 21:57:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266764AbUG1B5e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 21:57:34 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:39054 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S266763AbUG1B4t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 21:56:49 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8-rc2-L2, preemptable hardirqs
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Lenar L?hmus <lenar@vision.ee>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>
In-Reply-To: <20040727162759.GA32548@elte.hu>
References: <40F3F0A0.9080100@vision.ee>
	 <20040713143947.GG21066@holomorphy.com> <1090732537.738.2.camel@mindpipe>
	 <1090795742.719.4.camel@mindpipe> <20040726082330.GA22764@elte.hu>
	 <1090830574.6936.96.camel@mindpipe> <20040726083537.GA24948@elte.hu>
	 <1090832436.6936.105.camel@mindpipe> <20040726124059.GA14005@elte.hu>
	 <20040726204720.GA26561@elte.hu>  <20040727162759.GA32548@elte.hu>
Content-Type: text/plain
Message-Id: <1090979823.743.39.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 27 Jul 2004 21:57:05 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-07-27 at 12:27, Ingo Molnar wrote:
> i've uploaded -L2:
>  
>   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8-rc2-L2
> 
Some more results:


I can no longer trigger XRUNs with bonnie, so I switched to iozone.  Here is 
what I got:

 ALSA /home/rlrevell/cvs/alsa/alsa-driver/alsa-kernel/core/pcm_lib.c:139: XRUN: pcmC0D2c
 [<c01066a7>] dump_stack+0x17/0x20
 [<de93654b>] snd_pcm_period_elapsed+0x27b/0x3e0 [snd_pcm]
 [<de956211>] snd_emu10k1_interrupt+0xd1/0x3c0 [snd_emu10k1]
 [<c01078c8>] handle_IRQ_event+0x38/0x80
 [<c0107e5d>] do_IRQ+0xbd/0x1a0
 [<c0106268>] common_interrupt+0x18/0x20
 [<c0146751>] add_to_swap+0x21/0xc0
 [<c0139426>] shrink_list+0x156/0x4b0
 [<c01398cd>] shrink_cache+0x14d/0x370
 [<c013a0f8>] shrink_zone+0xa8/0xf0
 [<c013a4ce>] balance_pgdat+0x1be/0x220
 [<c013a5d9>] kswapd+0xa9/0xb0
 [<c0104395>] kernel_thread_helper+0x5/0x10
ALSA /home/rlrevell/cvs/alsa/alsa-driver/alsa-kernel/core/pcm_lib.c:139: XRUN: pcmC0D2c
 [<c01066a7>] dump_stack+0x17/0x20
 [<de93654b>] snd_pcm_period_elapsed+0x27b/0x3e0 [snd_pcm]
 [<de956211>] snd_emu10k1_interrupt+0xd1/0x3c0 [snd_emu10k1]
 [<c01078c8>] handle_IRQ_event+0x38/0x80
 [<c0107e5d>] do_IRQ+0xbd/0x1a0
 [<c0106268>] common_interrupt+0x18/0x20
 [<c015deff>] do_poll+0x5f/0xc0
 [<c015e091>] sys_poll+0x131/0x220
 [<c0106047>] syscall_call+0x7/0xb
ALSA /home/rlrevell/cvs/alsa/alsa-driver/alsa-kernel/core/pcm_lib.c:139: XRUN: pcmC0D2c
 [<c01066a7>] dump_stack+0x17/0x20
 [<de93654b>] snd_pcm_period_elapsed+0x27b/0x3e0 [snd_pcm]
 [<de956211>] snd_emu10k1_interrupt+0xd1/0x3c0 [snd_emu10k1]
 [<c01078c8>] handle_IRQ_event+0x38/0x80
 [<c0107e5d>] do_IRQ+0xbd/0x1a0
 [<c0106268>] common_interrupt+0x18/0x20
 [<c0146751>] add_to_swap+0x21/0xc0
 [<c0139426>] shrink_list+0x156/0x4b0
 [<c01398cd>] shrink_cache+0x14d/0x370
 [<c013a0f8>] shrink_zone+0xa8/0xf0
 [<c013a197>] shrink_caches+0x57/0x60
 [<c013a238>] try_to_free_pages+0x98/0x170
 [<c0132707>] __alloc_pages+0x137/0x340
 [<c01302c5>] generic_file_aio_write_nolock+0x355/0xb80
 [<c0130bd2>] generic_file_aio_write+0x62/0x90
 [<c01a9458>] ext3_file_write+0x28/0xc0
 [<c014b01a>] do_sync_write+0x6a/0xa0
 [<c014b10c>] vfs_write+0xbc/0x110
 [<c014b1de>] sys_write+0x2e/0x50
 [<c0106047>] syscall_call+0x7/0xb
ALSA /home/rlrevell/cvs/alsa/alsa-driver/alsa-kernel/core/pcm_lib.c:139: XRUN: pcmC0D2c
 [<c01066a7>] dump_stack+0x17/0x20
 [<de93654b>] snd_pcm_period_elapsed+0x27b/0x3e0 [snd_pcm]
 [<de956211>] snd_emu10k1_interrupt+0xd1/0x3c0 [snd_emu10k1]
 [<c01078c8>] handle_IRQ_event+0x38/0x80
 [<c0107e5d>] do_IRQ+0xbd/0x1a0
 [<c0106268>] common_interrupt+0x18/0x20
 [<c0146751>] add_to_swap+0x21/0xc0
 [<c0139426>] shrink_list+0x156/0x4b0
 [<c01398cd>] shrink_cache+0x14d/0x370
 [<c013a0f8>] shrink_zone+0xa8/0xf0
 [<c013a4ce>] balance_pgdat+0x1be/0x220
 [<c013a5d9>] kswapd+0xa9/0xb0
 [<c0104395>] kernel_thread_helper+0x5/0x10
ALSA /home/rlrevell/cvs/alsa/alsa-driver/alsa-kernel/core/pcm_lib.c:139: XRUN: pcmC0D2c
 [<c01066a7>] dump_stack+0x17/0x20
 [<de93654b>] snd_pcm_period_elapsed+0x27b/0x3e0 [snd_pcm]
 [<de956211>] snd_emu10k1_interrupt+0xd1/0x3c0 [snd_emu10k1]
 [<c01078c8>] handle_IRQ_event+0x38/0x80
 [<c0107e5d>] do_IRQ+0xbd/0x1a0
 [<c0106268>] common_interrupt+0x18/0x20
 [<c0146751>] add_to_swap+0x21/0xc0
 [<c0139426>] shrink_list+0x156/0x4b0
 [<c01398cd>] shrink_cache+0x14d/0x370
 [<c013a0f8>] shrink_zone+0xa8/0xf0
 [<c013a4ce>] balance_pgdat+0x1be/0x220
 [<c013a5d9>] kswapd+0xa9/0xb0
 [<c0104395>] kernel_thread_helper+0x5/0x10
ALSA /home/rlrevell/cvs/alsa/alsa-driver/alsa-kernel/core/pcm_lib.c:139: XRUN: pcmC0D2c
 [<c01066a7>] dump_stack+0x17/0x20
 [<de93654b>] snd_pcm_period_elapsed+0x27b/0x3e0 [snd_pcm]
 [<de956211>] snd_emu10k1_interrupt+0xd1/0x3c0 [snd_emu10k1]
 [<c01078c8>] handle_IRQ_event+0x38/0x80
 [<c0107e5d>] do_IRQ+0xbd/0x1a0
 [<c0106268>] common_interrupt+0x18/0x20
 [<c0146751>] add_to_swap+0x21/0xc0
 [<c0139426>] shrink_list+0x156/0x4b0
 [<c01398cd>] shrink_cache+0x14d/0x370
 [<c013a0f8>] shrink_zone+0xa8/0xf0
 [<c013a4ce>] balance_pgdat+0x1be/0x220
 [<c013a5d9>] kswapd+0xa9/0xb0
 [<c0104395>] kernel_thread_helper+0x5/0x10
ALSA /home/rlrevell/cvs/alsa/alsa-driver/alsa-kernel/core/pcm_lib.c:139: XRUN: pcmC0D2c
 [<c01066a7>] dump_stack+0x17/0x20
 [<de93654b>] snd_pcm_period_elapsed+0x27b/0x3e0 [snd_pcm]
 [<de956211>] snd_emu10k1_interrupt+0xd1/0x3c0 [snd_emu10k1]
 [<c01078c8>] handle_IRQ_event+0x38/0x80
 [<c0107e5d>] do_IRQ+0xbd/0x1a0
 [<c0106268>] common_interrupt+0x18/0x20
 [<c0146751>] add_to_swap+0x21/0xc0
 [<c0139426>] shrink_list+0x156/0x4b0
 [<c01398cd>] shrink_cache+0x14d/0x370
 [<c013a0f8>] shrink_zone+0xa8/0xf0
 [<c013a197>] shrink_caches+0x57/0x60
 [<c013a238>] try_to_free_pages+0x98/0x170
 [<c0132707>] __alloc_pages+0x137/0x340
 [<c01302c5>] generic_file_aio_write_nolock+0x355/0xb80
 [<c0130bd2>] generic_file_aio_write+0x62/0x90
 [<c01a9458>] ext3_file_write+0x28/0xc0
 [<c014b01a>] do_sync_write+0x6a/0xa0
 [<c014b10c>] vfs_write+0xbc/0x110
 [<c014b1de>] sys_write+0x2e/0x50
 [<c0106047>] syscall_call+0x7/0xb
ALSA /home/rlrevell/cvs/alsa/alsa-driver/alsa-kernel/core/pcm_lib.c:139: XRUN: pcmC0D2c
 [<c01066a7>] dump_stack+0x17/0x20
 [<de93654b>] snd_pcm_period_elapsed+0x27b/0x3e0 [snd_pcm]
 [<de956211>] snd_emu10k1_interrupt+0xd1/0x3c0 [snd_emu10k1]
 [<c01078c8>] handle_IRQ_event+0x38/0x80
 [<c0107e5d>] do_IRQ+0xbd/0x1a0
 [<c0106268>] common_interrupt+0x18/0x20
 [<c0146751>] add_to_swap+0x21/0xc0
 [<c0139426>] shrink_list+0x156/0x4b0
 [<c01398cd>] shrink_cache+0x14d/0x370
 [<c013a0f8>] shrink_zone+0xa8/0xf0
 [<c013a4ce>] balance_pgdat+0x1be/0x220
 [<c013a5d9>] kswapd+0xa9/0xb0
 [<c0104395>] kernel_thread_helper+0x5/0x10
ALSA /home/rlrevell/cvs/alsa/alsa-driver/alsa-kernel/core/pcm_lib.c:139: XRUN: pcmC0D2c
 [<c01066a7>] dump_stack+0x17/0x20
 [<de93654b>] snd_pcm_period_elapsed+0x27b/0x3e0 [snd_pcm]
 [<de956211>] snd_emu10k1_interrupt+0xd1/0x3c0 [snd_emu10k1]
 [<c01078c8>] handle_IRQ_event+0x38/0x80
 [<c0107e5d>] do_IRQ+0xbd/0x1a0
 [<c0106268>] common_interrupt+0x18/0x20
 [<c0146751>] add_to_swap+0x21/0xc0
 [<c0139426>] shrink_list+0x156/0x4b0
 [<c01398cd>] shrink_cache+0x14d/0x370
 [<c013a0f8>] shrink_zone+0xa8/0xf0
 [<c013a197>] shrink_caches+0x57/0x60
 [<c013a238>] try_to_free_pages+0x98/0x170
 [<c0132707>] __alloc_pages+0x137/0x340
 [<c01302c5>] generic_file_aio_write_nolock+0x355/0xb80
 [<c0130bd2>] generic_file_aio_write+0x62/0x90
 [<c01a9458>] ext3_file_write+0x28/0xc0
 [<c014b01a>] do_sync_write+0x6a/0xa0
 [<c014b10c>] vfs_write+0xbc/0x110
 [<c014b1de>] sys_write+0x2e/0x50
 [<c0106047>] syscall_call+0x7/0xb
ALSA /home/rlrevell/cvs/alsa/alsa-driver/alsa-kernel/core/pcm_lib.c:139: XRUN: pcmC0D2c
 [<c01066a7>] dump_stack+0x17/0x20
 [<de93654b>] snd_pcm_period_elapsed+0x27b/0x3e0 [snd_pcm]
 [<de956211>] snd_emu10k1_interrupt+0xd1/0x3c0 [snd_emu10k1]
 [<c01078c8>] handle_IRQ_event+0x38/0x80
 [<c0107e5d>] do_IRQ+0xbd/0x1a0
 [<c0106268>] common_interrupt+0x18/0x20
 [<c0146751>] add_to_swap+0x21/0xc0
 [<c0139426>] shrink_list+0x156/0x4b0
 [<c01398cd>] shrink_cache+0x14d/0x370
 [<c013a0f8>] shrink_zone+0xa8/0xf0
 [<c013a4ce>] balance_pgdat+0x1be/0x220
 [<c013a5d9>] kswapd+0xa9/0xb0
 [<c0104395>] kernel_thread_helper+0x5/0x10
ALSA /home/rlrevell/cvs/alsa/alsa-driver/alsa-kernel/core/pcm_lib.c:139: XRUN: pcmC0D2c
 [<c01066a7>] dump_stack+0x17/0x20
 [<de93654b>] snd_pcm_period_elapsed+0x27b/0x3e0 [snd_pcm]
 [<de956211>] snd_emu10k1_interrupt+0xd1/0x3c0 [snd_emu10k1]
 [<c01078c8>] handle_IRQ_event+0x38/0x80
 [<c0107e5d>] do_IRQ+0xbd/0x1a0
 [<c0106268>] common_interrupt+0x18/0x20
 [<c0146751>] add_to_swap+0x21/0xc0
 [<c0139426>] shrink_list+0x156/0x4b0
 [<c01398cd>] shrink_cache+0x14d/0x370
 [<c013a0f8>] shrink_zone+0xa8/0xf0
 [<c013a4ce>] balance_pgdat+0x1be/0x220
 [<c013a5d9>] kswapd+0xa9/0xb0
 [<c0104395>] kernel_thread_helper+0x5/0x10
ALSA /home/rlrevell/cvs/alsa/alsa-driver/alsa-kernel/core/pcm_lib.c:139: XRUN: pcmC0D2c
 [<c01066a7>] dump_stack+0x17/0x20
 [<de93654b>] snd_pcm_period_elapsed+0x27b/0x3e0 [snd_pcm]
 [<de956211>] snd_emu10k1_interrupt+0xd1/0x3c0 [snd_emu10k1]
 [<c01078c8>] handle_IRQ_event+0x38/0x80
 [<c0107e5d>] do_IRQ+0xbd/0x1a0
 [<c0106268>] common_interrupt+0x18/0x20
 [<c0146751>] add_to_swap+0x21/0xc0
 [<c0139426>] shrink_list+0x156/0x4b0
 [<c01398cd>] shrink_cache+0x14d/0x370
 [<c013a0f8>] shrink_zone+0xa8/0xf0
 [<c013a4ce>] balance_pgdat+0x1be/0x220
 [<c013a5d9>] kswapd+0xa9/0xb0
 [<c0104395>] kernel_thread_helper+0x5/0x10

Lee

