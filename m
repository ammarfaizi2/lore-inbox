Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266591AbUGPU0A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266591AbUGPU0A (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 16:26:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266592AbUGPU0A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 16:26:00 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:3987 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S266591AbUGPUZ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 16:25:56 -0400
Subject: Re: [linux-audio-user] 2.6.8-rc1-mm1 [and alsa xrun debugging]
From: Lee Revell <rlrevell@joe-job.com>
To: A list for linux audio users <linux-audio-user@music.columbia.edu>
Cc: Andrew Morton <akpm@osdl.org>, tiwai@suse.de,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-audio-dev@music.columbia.edu
In-Reply-To: <20040716185123.2e3899bf@mango.fruits.de>
References: <20040716162510.7bac6a7c@mango.fruits.de>
	 <200407161654.28004.eseol@tiscali.co.uk>
	 <20040716185123.2e3899bf@mango.fruits.de>
Content-Type: text/plain
Message-Id: <1090009565.27995.26.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 16 Jul 2004 16:26:05 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-07-16 at 12:51, Florian Schmidt wrote:
> On Fri, 16 Jul 2004 16:54:28 +0100
> David M <eseol@tiscali.co.uk> wrote:
> 
> > I think you have to echo 2 > /proc/asound/card0/etc 
> > 
> > On debian they are in /var/log/messages,var/log/syslog , and a few other 
> > places.
> 
> oh ok, that works.. i'll also enable frame pointers in the kernel. but for now, here's some of the xruns i can provoke by rapid desktop wheeling [though kernel still w/o rame pointers]:
> 
> 
> Jul 16 18:47:31 mango kernel:  [<c0107761>] do_IRQ+0x91/0x130
> Jul 16 18:47:31 mango kernel:  [<c0105be4>] common_interrupt+0x18/0x20
> Jul 16 18:47:32 mango kernel: ALSA sound/core/pcm_lib.c:169: XRUN: pcmC0D0c
> Jul 16 18:47:32 mango kernel:  [<f08c0357>] snd_pcm_period_elapsed+0x2e7/0x460 [snd_pcm]
> Jul 16 18:47:32 mango kernel:  [<f0bc232e>] _nv000897rm+0x4e/0x70 [nvidia]
> Jul 16 18:47:32 mango kernel:  [<f08edb8e>] snd_cs46xx_interrupt+0x1be/0x1f0 [snd_cs46xx]
> Jul 16 18:47:32 mango kernel:  [<f0d28962>] nv_kern_isr+0x26/0x59 [nvidia]
> Jul 16 18:47:32 mango kernel:  [<c01073fa>] handle_IRQ_event+0x3a/0x70
> Jul 16 18:47:32 mango kernel:  [<c0107761>] do_IRQ+0x91/0x130
> Jul 16 18:47:32 mango kernel:  [<c0105be4>] common_interrupt+0x18/0x20

Are you using the binary-only NVIDIA module?  If your kernel is tainted
(by having a binary-only module loaded), then you cannot get valid data.
> Jul 16 18:49:04 mango kernel: ALSA sound/core/pcm_lib.c:169: XRUN: pcmC0D0c
> Jul 16 18:49:04 mango kernel:  [<f08c0357>] snd_pcm_period_elapsed+0x2e7/0x460 [snd_pcm]
> Jul 16 18:49:04 mango kernel:  [<f08edb8e>] snd_cs46xx_interrupt+0x1be/0x1f0 [snd_cs46xx]
> Jul 16 18:49:04 mango kernel:  [<c0105737>] handle_signal+0xb7/0x120
> Jul 16 18:49:04 mango kernel:  [<c01073fa>] handle_IRQ_event+0x3a/0x70
> Jul 16 18:49:04 mango kernel:  [<c0107761>] do_IRQ+0x91/0x130
> Jul 16 18:49:04 mango kernel:  [<c0105be4>] common_interrupt+0x18/0x20
> Jul 16 18:49:04 mango kernel:  [<c011a2f0>] __do_softirq+0x30/0x80
> Jul 16 18:49:04 mango kernel:  [<c011a366>] do_softirq+0x26/0x30
> Jul 16 18:49:04 mango kernel:  [<c01077cd>] do_IRQ+0xfd/0x130
> Jul 16 18:49:04 mango kernel:  [<c0105be4>] common_interrupt+0x18/0x20
> Jul 16 18:49:04 mango kernel: ALSA sound/core/pcm_lib.c:169: XRUN: pcmC0D0p
> Jul 16 18:49:04 mango kernel:  [<f08c0357>] snd_pcm_period_elapsed+0x2e7/0x460 [snd_pcm]
> Jul 16 18:49:04 mango kernel:  [<c011e1c6>] update_process_times+0x46/0x60
> Jul 16 18:49:04 mango kernel:  [<f08edb8e>] snd_cs46xx_interrupt+0x1be/0x1f0 [snd_cs46xx]
> Jul 16 18:49:04 mango kernel:  [<c011e4bf>] do_timer+0xdf/0xf0
> Jul 16 18:49:04 mango kernel:  [<c010b378>] timer_interrupt+0xb8/0x140
> Jul 16 18:49:04 mango kernel:  [<c01073fa>] handle_IRQ_event+0x3a/0x70
> Jul 16 18:49:04 mango kernel:  [<c0107761>] do_IRQ+0x91/0x130
> Jul 16 18:49:04 mango kernel:  [<c0105be4>] common_interrupt+0x18/0x20
> Jul 16 18:49:04 mango kernel:  [<c011a2f0>] __do_softirq+0x30/0x80
> Jul 16 18:49:04 mango kernel:  [<c011a366>] do_softirq+0x26/0x30
> Jul 16 18:49:04 mango kernel:  [<c01077cd>] do_IRQ+0xfd/0x130
> Jul 16 18:49:04 mango kernel:  [<c0105be4>] common_interrupt+0x18/0x20

Takashi Iwai mentioned there were some patches available to daemonize
softirq processing, and that these might help.  Takashi, can you provide
some details on this?

> Jul 16 18:49:05 mango kernel: ALSA sound/core/pcm_lib.c:169: XRUN: pcmC0D0c
> Jul 16 18:49:05 mango kernel:  [<f08c0357>] snd_pcm_period_elapsed+0x2e7/0x460 [snd_pcm]
> Jul 16 18:49:05 mango kernel:  [<c028d579>] unix_stream_sendmsg+0x269/0x3e0
> Jul 16 18:49:05 mango kernel:  [<f08edb8e>] snd_cs46xx_interrupt+0x1be/0x1f0 [snd_cs46xx]
> Jul 16 18:49:05 mango kernel:  [<c01073fa>] handle_IRQ_event+0x3a/0x70
> Jul 16 18:49:05 mango kernel:  [<c0107761>] do_IRQ+0x91/0x130
> Jul 16 18:49:05 mango kernel:  [<c0105be4>] common_interrupt+0x18/0x20
> Jul 16 18:49:05 mango kernel:  [<c0112cab>] finish_task_switch+0x2b/0x90
> Jul 16 18:49:05 mango kernel:  [<c0290e4f>] schedule+0x2cf/0x560
> Jul 16 18:49:05 mango kernel:  [<c02915e3>] schedule_timeout+0x63/0xc0
> Jul 16 18:49:05 mango kernel:  [<c011e5b0>] process_timeout+0x0/0x10
> Jul 16 18:49:05 mango kernel:  [<c015faaf>] do_select+0x18f/0x2d0
> Jul 16 18:49:05 mango kernel:  [<c015f770>] __pollwait+0x0/0xd0
> Jul 16 18:49:05 mango kernel:  [<c015fedf>] sys_select+0x2bf/0x4c0
> Jul 16 18:49:05 mango kernel:  [<c014c30b>] vfs_read+0x10b/0x140
> Jul 16 18:49:05 mango kernel:  [<c0105a77>] syscall_call+0x7/0xb

This one I am seeing too.  I do not have a good explanation for it yet.

Lee



