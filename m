Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266689AbUGQDPv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266689AbUGQDPv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 23:15:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266707AbUGQDPu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 23:15:50 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:21173 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S266689AbUGQDPp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 23:15:45 -0400
Subject: Re: XRUN traces
From: Lee Revell <rlrevell@joe-job.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1090026275.2852.19.camel@mindpipe>
References: <1089758294.2747.4.camel@mindpipe>
	 <20040713161004.37a4654e.akpm@osdl.org> <1089787542.3360.11.camel@mindpipe>
	 <20040713235655.263ce5f3.akpm@osdl.org> <1090026275.2852.19.camel@mindpipe>
Content-Type: text/plain
Message-Id: <1090034133.1060.3.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 16 Jul 2004 23:15:45 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-07-16 at 21:04, Lee Revell wrote:
> On Wed, 2004-07-14 at 02:56, Andrew Morton wrote:
> > Lee Revell <rlrevell@joe-job.com> wrote:
> > >
> > > This is the only one I am still seeing that does not involve
> > >  get_user_pages().  I am seeing quite a lot with get_user_pages, but very
> > >  few of these:
> > 
> > get_user_pages() shold be fixed in rc1-mm1.  But that kernel is busted, so
> > wait until I have a fix.
> > 
> > 
> 
> Otherwise this kernel seems pretty good.
> 

I am also getting this one.  This is with 2.6.8-rc1-mm1 + La Monte H.P.
Yarroll's patch to daemonize softirqs.

Jul 16 23:10:23 mindpipe kernel: ALSA /home/rlrevell/cvs/alsa-driver/alsa-kernel/core/pcm_lib.c:169: XRUN: pcmC0D2c
Jul 16 23:10:23 mindpipe kernel:  [dump_stack+23/32] dump_stack+0x17/0x20
Jul 16 23:10:23 mindpipe kernel:  [__crc_totalram_pages+115469/3518512] snd_pcm_period_elapsed+0x2c7/0x400 [snd_pcm]
Jul 16 23:10:23 mindpipe kernel:  [__crc_totalram_pages+291159/3518512] snd_emu10k1_interrupt+0xd1/0x3c0 [snd_emu10k1]
Jul 16 23:10:23 mindpipe kernel:  [handle_IRQ_event+51/96] handle_IRQ_event+0x33/0x60
Jul 16 23:10:23 mindpipe kernel:  [do_IRQ+161/320] do_IRQ+0xa1/0x140
Jul 16 23:10:23 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 16 23:10:23 mindpipe kernel:  [copy_to_user+45/64] copy_to_user+0x2d/0x40
Jul 16 23:10:23 mindpipe kernel:  [memcpy_toiovec+44/96] memcpy_toiovec+0x2c/0x60
Jul 16 23:10:23 mindpipe kernel:  [unix_stream_recvmsg+370/1024] unix_stream_recvmsg+0x172/0x400
Jul 16 23:10:23 mindpipe kernel:  [sock_aio_read+220/256] sock_aio_read+0xdc/0x100
Jul 16 23:10:23 mindpipe kernel:  [do_sync_read+106/160] do_sync_read+0x6a/0xa0
Jul 16 23:10:23 mindpipe kernel:  [vfs_read+227/272] vfs_read+0xe3/0x110
Jul 16 23:10:23 mindpipe kernel:  [sys_read+46/80] sys_read+0x2e/0x50
Jul 16 23:10:23 mindpipe kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jul 16 23:10:23 mindpipe kernel: ALSA /home/rlrevell/cvs/alsa-driver/alsa-kernel/core/pcm_lib.c:169: XRUN: pcmC0D0p
Jul 16 23:10:23 mindpipe kernel:  [dump_stack+23/32] dump_stack+0x17/0x20
Jul 16 23:10:23 mindpipe kernel:  [__crc_totalram_pages+115469/3518512] snd_pcm_period_elapsed+0x2c7/0x400 [snd_pcm]
Jul 16 23:10:23 mindpipe kernel:  [__crc_totalram_pages+291773/3518512] snd_emu10k1_interrupt+0x337/0x3c0 [snd_emu10k1]
Jul 16 23:10:23 mindpipe kernel:  [handle_IRQ_event+51/96] handle_IRQ_event+0x33/0x60
Jul 16 23:10:23 mindpipe kernel:  [do_IRQ+161/320] do_IRQ+0xa1/0x140
Jul 16 23:10:23 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 16 23:10:23 mindpipe kernel:  [copy_to_user+45/64] copy_to_user+0x2d/0x40
Jul 16 23:10:23 mindpipe kernel:  [memcpy_toiovec+44/96] memcpy_toiovec+0x2c/0x60
Jul 16 23:10:23 mindpipe kernel:  [unix_stream_recvmsg+370/1024] unix_stream_recvmsg+0x172/0x400
Jul 16 23:10:23 mindpipe kernel:  [sock_aio_read+220/256] sock_aio_read+0xdc/0x100
Jul 16 23:10:23 mindpipe kernel:  [do_sync_read+106/160] do_sync_read+0x6a/0xa0
Jul 16 23:10:23 mindpipe kernel:  [vfs_read+227/272] vfs_read+0xe3/0x110
Jul 16 23:10:23 mindpipe kernel:  [sys_read+46/80] sys_read+0x2e/0x50
Jul 16 23:10:23 mindpipe kernel:  [syscall_call+7/11] syscall_call+0x7/0xb

Lee


