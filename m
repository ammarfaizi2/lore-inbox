Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267274AbUGNBAC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267274AbUGNBAC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 21:00:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262065AbUGNBAC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 21:00:02 -0400
Received: from fw.osdl.org ([65.172.181.6]:49303 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267274AbUGNA7s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 20:59:48 -0400
Date: Tue, 13 Jul 2004 17:58:33 -0700
From: Andrew Morton <akpm@osdl.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Ext3 vs. ReiserFS results (was Re: XRUN traces)
Message-Id: <20040713175833.6ab037ef.akpm@osdl.org>
In-Reply-To: <1089763038.3392.8.camel@mindpipe>
References: <1089758294.2747.4.camel@mindpipe>
	<20040713161004.37a4654e.akpm@osdl.org>
	<1089763038.3392.8.camel@mindpipe>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell <rlrevell@joe-job.com> wrote:
>
> Jul 13 19:51:45 mindpipe kernel: ALSA /usr/src/alsa-cvs-1.0.5/alsa-driver/alsa-kernel/core/pcm_lib.c:169: XRUN: pcmC0D0p
>  Jul 13 19:51:45 mindpipe kernel:  [dump_stack+23/32] dump_stack+0x17/0x20
>  Jul 13 19:51:45 mindpipe kernel:  [__crc_totalram_pages+562733/3558647] snd_pcm_period_elapsed+0x2c7/0x400 [snd_pcm]
>  Jul 13 19:51:45 mindpipe kernel:  [__crc_totalram_pages+631725/3558647] snd_emu10k1_interrupt+0x377/0x400 [snd_emu10k1]
>  Jul 13 19:51:45 mindpipe kernel:  [handle_IRQ_event+51/96] handle_IRQ_event+0x33/0x60
>  Jul 13 19:51:45 mindpipe kernel:  [do_IRQ+165/368] do_IRQ+0xa5/0x170
>  Jul 13 19:51:45 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
>  Jul 13 19:51:45 mindpipe kernel:  [d_callback+29/64] d_callback+0x1d/0x40
>  Jul 13 19:51:45 mindpipe kernel:  [rcu_do_batch+62/80] rcu_do_batch+0x3e/0x50
>  Jul 13 19:51:45 mindpipe kernel:  [rcu_process_callbacks+150/256] rcu_process_callbacks+0x96/0x100
>  Jul 13 19:51:45 mindpipe kernel:  [tasklet_action+68/112] tasklet_action+0x44/0x70
>  Jul 13 19:51:45 mindpipe kernel:  [__do_softirq+131/144] __do_softirq+0x83/0x90
>  Jul 13 19:51:45 mindpipe kernel:  [do_softirq+53/64] do_softirq+0x35/0x40
>  Jul 13 19:51:45 mindpipe kernel:  [do_IRQ+277/368] do_IRQ+0x115/0x170
>  Jul 13 19:51:45 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
>  Jul 13 19:51:45 mindpipe kernel:  [poll_freewait+46/80] poll_freewait+0x2e/0x50
>  Jul 13 19:51:45 mindpipe kernel:  [sys_poll+472/544] sys_poll+0x1d8/0x220

This one's going to be a problem.  It's due to RCU freeing a large number
of dentries in one hit.
