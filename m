Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264479AbUGMJBz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264479AbUGMJBz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 05:01:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264650AbUGMJBz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 05:01:55 -0400
Received: from fw.osdl.org ([65.172.181.6]:53137 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264479AbUGMJBx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 05:01:53 -0400
Date: Tue, 13 Jul 2004 02:00:25 -0700
From: Andrew Morton <akpm@osdl.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-audio-dev@music.columbia.edu, mingo@elte.hu, arjanv@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel
 Preemption Patch
Message-Id: <20040713020025.7400c648.akpm@osdl.org>
In-Reply-To: <1089708818.20381.36.camel@mindpipe>
References: <20040709182638.GA11310@elte.hu>
	<20040710222510.0593f4a4.akpm@osdl.org>
	<1089673014.10777.42.camel@mindpipe>
	<20040712163141.31ef1ad6.akpm@osdl.org>
	<1089677823.10777.64.camel@mindpipe>
	<20040712174639.38c7cf48.akpm@osdl.org>
	<1089687168.10777.126.camel@mindpipe>
	<20040712205917.47d1d58b.akpm@osdl.org>
	<1089707483.20381.33.camel@mindpipe>
	<20040713014316.2ce9181d.akpm@osdl.org>
	<1089708818.20381.36.camel@mindpipe>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell <rlrevell@joe-job.com> wrote:
>
> > framebuffer scrolling inside lock_kernel().  Tricky.  Suggest you use X or
>  > vgacon.  You can try removing the lock_kernel() calls from do_tty_write(),
>  > but make sure you're wearing ear protection.
>  > 
> 
>  OK, I figured this was not an easy one.  I can just not do that.

Why not?  You can certainly try removing those [un]lock_kernel() calls.

>  Here are some more.  These result from using mplayer with ALSA OSS
>  emulation:
> 
>  Jul 13 04:31:49 mindpipe kernel:
>  Jul 13 04:31:49 mindpipe kernel: ALSA /usr/src/alsa-cvs-1.0.5/alsa-driver/alsa-kernel/core/pcm_lib.c:169: XRUN: pcmC0D0p
>  Jul 13 04:31:49 mindpipe kernel:  [__crc_totalram_pages+1387264/5353478] snd_pcm_period_elapsed+0x2ca/0x410 [snd_pcm]
>  Jul 13 04:31:49 mindpipe kernel:  [__crc_totalram_pages+1455070/5353478] snd_emu10k1_interrupt+0x3c8/0x480 [snd_emu10k1]
>  Jul 13 04:31:49 mindpipe kernel:  [handle_IRQ_event+49/96] handle_IRQ_event+0x31/0x60
>  Jul 13 04:31:49 mindpipe kernel:  [do_IRQ+155/352] do_IRQ+0x9b/0x160
>  Jul 13 04:31:49 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
>  Jul 13 04:31:49 mindpipe kernel:  [__crc_totalram_pages+1394929/5353478] snd_pcm_format_set_silence+0x4b/0x1d0 [snd_pcm]
>  Jul 13 04:31:49 mindpipe kernel:  [__crc_totalram_pages+2165815/5353478] snd_pcm_oss_change_params+0x5a1/0x850 [snd_pcm_oss]
>  Jul 13 04:31:49 mindpipe kernel:  [__crc_totalram_pages+2166620/5353478] snd_pcm_oss_get_active_substream+0x76/0x90 [snd_pcm_oss]
>  Jul 13 04:31:49 mindpipe kernel:  [__crc_totalram_pages+2170556/5353478] snd_pcm_oss_get_formats+0x26/0x100 [snd_pcm_oss]

Looks like those memcpys in snd_pcm_format_set_silence() are hurting.
