Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264658AbUGMIxc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264658AbUGMIxc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 04:53:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264660AbUGMIxc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 04:53:32 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:59544 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S264658AbUGMIx3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 04:53:29 -0400
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel
	Preemption Patch
From: Lee Revell <rlrevell@joe-job.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-audio-dev@music.columbia.edu, mingo@elte.hu, arjanv@redhat.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040713014316.2ce9181d.akpm@osdl.org>
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
Content-Type: text/plain
Message-Id: <1089708818.20381.36.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 13 Jul 2004 04:53:39 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-07-13 at 04:43, Andrew Morton wrote:
> Lee Revell <rlrevell@joe-job.com> wrote:
> >
> > Jul 13 04:27:50 mindpipe kernel: ALSA /usr/src/alsa-cvs-1.0.5/alsa-driver/alsa-kernel/core/pcm_lib.c:169: XRUN: pcmC0D0p
> >  Jul 13 04:27:50 mindpipe kernel:  [__crc_totalram_pages+1387264/5353478] snd_pcm_period_elapsed+0x2ca/0x410 [snd_pcm]
> >  Jul 13 04:27:50 mindpipe kernel:  [group_send_sig_info+101/144] group_send_sig_info+0x65/0x90
> >  Jul 13 04:27:50 mindpipe kernel:  [__crc_totalram_pages+1455070/5353478] snd_emu10k1_interrupt+0x3c8/0x480 [snd_emu10k1]
> >  Jul 13 04:27:50 mindpipe kernel:  [handle_IRQ_event+49/96] handle_IRQ_event+0x31/0x60
> >  Jul 13 04:27:50 mindpipe kernel:  [do_IRQ+155/352] do_IRQ+0x9b/0x160
> >  Jul 13 04:27:50 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
> >  Jul 13 04:27:50 mindpipe kernel:  [_mmx_memcpy+141/384] _mmx_memcpy+0x8d/0x180
> >  Jul 13 04:27:50 mindpipe kernel:  [scrup+242/320] scrup+0xf2/0x140
> >  Jul 13 04:27:50 mindpipe kernel:  [lf+96/112] lf+0x60/0x70
> >  Jul 13 04:27:50 mindpipe kernel:  [do_con_trol+2907/3360] do_con_trol+0xb5b/0xd20
> >  Jul 13 04:27:50 mindpipe kernel:  [do_con_write+1128/1888] do_con_write+0x468/0x760
> >  Jul 13 04:27:50 mindpipe kernel:  [con_put_char+51/64] con_put_char+0x33/0x40
> 
> framebuffer scrolling inside lock_kernel().  Tricky.  Suggest you use X or
> vgacon.  You can try removing the lock_kernel() calls from do_tty_write(),
> but make sure you're wearing ear protection.
> 

OK, I figured this was not an easy one.  I can just not do that.

Here are some more.  These result from using mplayer with ALSA OSS
emulation:

Jul 13 04:31:49 mindpipe kernel:
Jul 13 04:31:49 mindpipe kernel: ALSA /usr/src/alsa-cvs-1.0.5/alsa-driver/alsa-kernel/core/pcm_lib.c:169: XRUN: pcmC0D0p
Jul 13 04:31:49 mindpipe kernel:  [__crc_totalram_pages+1387264/5353478] snd_pcm_period_elapsed+0x2ca/0x410 [snd_pcm]
Jul 13 04:31:49 mindpipe kernel:  [__crc_totalram_pages+1455070/5353478] snd_emu10k1_interrupt+0x3c8/0x480 [snd_emu10k1]
Jul 13 04:31:49 mindpipe kernel:  [handle_IRQ_event+49/96] handle_IRQ_event+0x31/0x60
Jul 13 04:31:49 mindpipe kernel:  [do_IRQ+155/352] do_IRQ+0x9b/0x160
Jul 13 04:31:49 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 13 04:31:49 mindpipe kernel:  [__crc_totalram_pages+1394929/5353478] snd_pcm_format_set_silence+0x4b/0x1d0 [snd_pcm]
Jul 13 04:31:49 mindpipe kernel:  [__crc_totalram_pages+2165815/5353478] snd_pcm_oss_change_params+0x5a1/0x850 [snd_pcm_oss]
Jul 13 04:31:49 mindpipe kernel:  [__crc_totalram_pages+2166620/5353478] snd_pcm_oss_get_active_substream+0x76/0x90 [snd_pcm_oss]
Jul 13 04:31:49 mindpipe kernel:  [__crc_totalram_pages+2170556/5353478] snd_pcm_oss_get_formats+0x26/0x100 [snd_pcm_oss]
Jul 13 04:31:49 mindpipe kernel:  [kfree_skbmem+23/32] kfree_skbmem+0x17/0x20
Jul 13 04:31:49 mindpipe kernel:  [__kfree_skb+101/240] __kfree_skb+0x65/0xf0
Jul 13 04:31:49 mindpipe kernel:  [packet_rcv_spkt+380/544] packet_rcv_spkt+0x17c/0x220
Jul 13 04:31:49 mindpipe kernel:  [dev_queue_xmit_nit+179/288] dev_queue_xmit_nit+0xb3/0x120
Jul 13 04:31:49 mindpipe kernel:  [avc_has_perm_noaudit+104/512] avc_has_perm_noaudit+0x68/0x200
Jul 13 04:31:49 mindpipe kernel:  [avc_has_perm+72/96] avc_has_perm+0x48/0x60
Jul 13 04:31:49 mindpipe kernel:  [inode_has_perm+73/144] inode_has_perm+0x49/0x90
Jul 13 04:31:49 mindpipe kernel:  [__crc_totalram_pages+1377866/5353478] snd_pcm_hw_constraint_minmax+0x34/0x40 [snd_pcm]
Jul 13 04:31:49 mindpipe kernel:  [__crc_totalram_pages+1359876/5353478] snd_pcm_hw_constraints_complete+0x17e/0x290 [snd_pcm]
Jul 13 04:31:49 mindpipe kernel:  [selinux_file_ioctl+213/784] selinux_file_ioctl+0xd5/0x310
Jul 13 04:31:49 mindpipe kernel:  [__crc_totalram_pages+2174928/5353478] snd_pcm_oss_open+0x1aa/0x350 [snd_pcm_oss]
Jul 13 04:31:49 mindpipe kernel:  [soundcore_open+328/768] soundcore_open+0x148/0x300
Jul 13 04:31:49 mindpipe kernel:  [chrdev_open+233/528] chrdev_open+0xe9/0x210
Jul 13 04:31:49 mindpipe kernel:  [dentry_open+260/560] dentry_open+0x104/0x230
Jul 13 04:31:49 mindpipe kernel:  [__crc_totalram_pages+2170812/5353478] snd_pcm_oss_set_format+0x26/0x60 [snd_pcm_oss]
Jul 13 04:31:49 mindpipe kernel:  [__crc_totalram_pages+2176960/5353478] snd_pcm_oss_ioctl+0x51a/0x850 [snd_pcm_oss]
Jul 13 04:31:49 mindpipe kernel:  [sys_ioctl+256/608] sys_ioctl+0x100/0x260
Jul 13 04:31:49 mindpipe kernel:  [sys_fcntl64+87/144] sys_fcntl64+0x57/0x90
Jul 13 04:31:49 mindpipe kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jul 13 04:31:49 mindpipe kernel:
Jul 13 04:31:49 mindpipe kernel: ALSA /usr/src/alsa-cvs-1.0.5/alsa-driver/alsa-kernel/core/pcm_lib.c:169: XRUN: pcmC0D0p
Jul 13 04:31:49 mindpipe kernel:  [__crc_totalram_pages+1387264/5353478] snd_pcm_period_elapsed+0x2ca/0x410 [snd_pcm]
Jul 13 04:31:49 mindpipe kernel:  [__crc_totalram_pages+1455070/5353478] snd_emu10k1_interrupt+0x3c8/0x480 [snd_emu10k1]
Jul 13 04:31:49 mindpipe kernel:  [handle_IRQ_event+49/96] handle_IRQ_event+0x31/0x60
Jul 13 04:31:49 mindpipe kernel:  [do_IRQ+155/352] do_IRQ+0x9b/0x160
Jul 13 04:31:49 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 13 04:31:49 mindpipe kernel:  [__crc_totalram_pages+1373142/5353478] snd_interval_refine+0xa0/0x1c0 [snd_pcm]
Jul 13 04:31:49 mindpipe kernel:  [__crc_totalram_pages+1357711/5353478] snd_pcm_hw_rule_div+0x49/0x50 [snd_pcm]
Jul 13 04:31:49 mindpipe kernel:  [__crc_totalram_pages+1347991/5353478] snd_pcm_hw_refine+0x371/0x4a0 [snd_pcm]
Jul 13 04:31:49 mindpipe kernel:  [__crc_totalram_pages+1383137/5353478] snd_pcm_hw_param_mask+0x3b/0x50 [snd_pcm]
Jul 13 04:31:49 mindpipe kernel:  [__crc_totalram_pages+2164618/5353478] snd_pcm_oss_change_params+0xf4/0x850 [snd_pcm_oss]
Jul 13 04:31:49 mindpipe kernel:  [chrdev_open+233/528] chrdev_open+0xe9/0x210
Jul 13 04:31:49 mindpipe kernel:  [__crc_totalram_pages+2166620/5353478] snd_pcm_oss_get_active_substream+0x76/0x90 [snd_pcm_oss]
Jul 13 04:31:49 mindpipe kernel:  [__crc_totalram_pages+2170887/5353478] snd_pcm_oss_get_format+0x11/0x30 [snd_pcm_oss]
Jul 13 04:31:49 mindpipe kernel:  [__crc_totalram_pages+2176960/5353478] snd_pcm_oss_ioctl+0x51a/0x850 [snd_pcm_oss]
Jul 13 04:31:49 mindpipe kernel:  [sys_ioctl+256/608] sys_ioctl+0x100/0x260
Jul 13 04:31:49 mindpipe kernel:  [sys_fcntl64+87/144] sys_fcntl64+0x57/0x90
Jul 13 04:31:49 mindpipe kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jul 13 04:31:49 mindpipe kernel:

Lee

