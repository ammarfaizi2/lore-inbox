Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264639AbUGMIo4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264639AbUGMIo4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 04:44:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264656AbUGMIo4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 04:44:56 -0400
Received: from fw.osdl.org ([65.172.181.6]:19858 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264639AbUGMIow (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 04:44:52 -0400
Date: Tue, 13 Jul 2004 01:43:16 -0700
From: Andrew Morton <akpm@osdl.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-audio-dev@music.columbia.edu, mingo@elte.hu, arjanv@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel
 Preemption Patch
Message-Id: <20040713014316.2ce9181d.akpm@osdl.org>
In-Reply-To: <1089707483.20381.33.camel@mindpipe>
References: <20040709182638.GA11310@elte.hu>
	<20040710222510.0593f4a4.akpm@osdl.org>
	<1089673014.10777.42.camel@mindpipe>
	<20040712163141.31ef1ad6.akpm@osdl.org>
	<1089677823.10777.64.camel@mindpipe>
	<20040712174639.38c7cf48.akpm@osdl.org>
	<1089687168.10777.126.camel@mindpipe>
	<20040712205917.47d1d58b.akpm@osdl.org>
	<1089707483.20381.33.camel@mindpipe>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell <rlrevell@joe-job.com> wrote:
>
> Jul 13 04:27:50 mindpipe kernel: ALSA /usr/src/alsa-cvs-1.0.5/alsa-driver/alsa-kernel/core/pcm_lib.c:169: XRUN: pcmC0D0p
>  Jul 13 04:27:50 mindpipe kernel:  [__crc_totalram_pages+1387264/5353478] snd_pcm_period_elapsed+0x2ca/0x410 [snd_pcm]
>  Jul 13 04:27:50 mindpipe kernel:  [group_send_sig_info+101/144] group_send_sig_info+0x65/0x90
>  Jul 13 04:27:50 mindpipe kernel:  [__crc_totalram_pages+1455070/5353478] snd_emu10k1_interrupt+0x3c8/0x480 [snd_emu10k1]
>  Jul 13 04:27:50 mindpipe kernel:  [handle_IRQ_event+49/96] handle_IRQ_event+0x31/0x60
>  Jul 13 04:27:50 mindpipe kernel:  [do_IRQ+155/352] do_IRQ+0x9b/0x160
>  Jul 13 04:27:50 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
>  Jul 13 04:27:50 mindpipe kernel:  [_mmx_memcpy+141/384] _mmx_memcpy+0x8d/0x180
>  Jul 13 04:27:50 mindpipe kernel:  [scrup+242/320] scrup+0xf2/0x140
>  Jul 13 04:27:50 mindpipe kernel:  [lf+96/112] lf+0x60/0x70
>  Jul 13 04:27:50 mindpipe kernel:  [do_con_trol+2907/3360] do_con_trol+0xb5b/0xd20
>  Jul 13 04:27:50 mindpipe kernel:  [do_con_write+1128/1888] do_con_write+0x468/0x760
>  Jul 13 04:27:50 mindpipe kernel:  [con_put_char+51/64] con_put_char+0x33/0x40

framebuffer scrolling inside lock_kernel().  Tricky.  Suggest you use X or
vgacon.  You can try removing the lock_kernel() calls from do_tty_write(),
but make sure you're wearing ear protection.

