Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264298AbUGNGqH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264298AbUGNGqH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 02:46:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267313AbUGNGqG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 02:46:06 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:46526 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S264298AbUGNGpo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 02:45:44 -0400
Subject: Re: XRUN traces
From: Lee Revell <rlrevell@joe-job.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040713161004.37a4654e.akpm@osdl.org>
References: <1089758294.2747.4.camel@mindpipe>
	 <20040713161004.37a4654e.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1089787542.3360.11.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 14 Jul 2004 02:45:42 -0400
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

This is the only one I am still seeing that does not involve
get_user_pages().  I am seeing quite a lot with get_user_pages, but very
few of these:

Jul 14 02:40:56 mindpipe kernel: 
Jul 14 02:40:56 mindpipe kernel: ALSA /home/rlrevell/cvs/alsa-driver/alsa-kernel/core/pcm_lib.c:169: XRUN: pcmC0D0p
Jul 14 02:40:56 mindpipe kernel:  [dump_stack+23/32] dump_stack+0x17/0x20
Jul 14 02:40:56 mindpipe kernel:  [__crc_totalram_pages+168797/3558647] snd_pcm_period_elapsed+0x2c7/0x400 [snd_pcm]
Jul 14 02:40:56 mindpipe kernel:  [__crc_totalram_pages+344957/3558647] snd_emu10k1_interrupt+0x337/0x3c0 [snd_emu10k1]
Jul 14 02:40:56 mindpipe kernel:  [handle_IRQ_event+51/96] handle_IRQ_event+0x33/0x60
Jul 14 02:40:56 mindpipe kernel:  [do_IRQ+165/368] do_IRQ+0xa5/0x170
Jul 14 02:40:56 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 14 02:40:56 mindpipe kernel:  [pty_write+301/320] pty_write+0x12d/0x140
Jul 14 02:40:56 mindpipe kernel:  [opost_block+231/416] opost_block+0xe7/0x1a0
Jul 14 02:40:56 mindpipe kernel:  [write_chan+382/528] write_chan+0x17e/0x210
Jul 14 02:40:56 mindpipe kernel:  [tty_write+247/448] tty_write+0xf7/0x1c0
Jul 14 02:40:56 mindpipe kernel:  [vfs_write+188/272] vfs_write+0xbc/0x110
Jul 14 02:40:56 mindpipe kernel:  [sys_write+46/80] sys_write+0x2e/0x50
Jul 14 02:40:56 mindpipe kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jul 14 02:40:56 mindpipe kernel: 

Lee

