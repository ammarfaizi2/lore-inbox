Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265091AbUHHEVU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265091AbUHHEVU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Aug 2004 00:21:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265093AbUHHEVU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Aug 2004 00:21:20 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:19605 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S265091AbUHHEVK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Aug 2004 00:21:10 -0400
Subject: Re: [patch] preempt-timing-on-2.6.8-rc2-O2
From: Lee Revell <rlrevell@joe-job.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040808024852.GS17188@holomorphy.com>
References: <20040802092855.GA15894@elte.hu>
	 <20040802100815.GA18349@elte.hu> <20040802101840.GB2334@holomorphy.com>
	 <20040802103516.GA20584@elte.hu> <20040802105100.GA22855@elte.hu>
	 <1091932214.1150.3.camel@mindpipe> <20040808023306.GP17188@holomorphy.com>
	 <1091932615.1150.6.camel@mindpipe> <20040808023941.GQ17188@holomorphy.com>
	 <1091933229.1150.15.camel@mindpipe> <20040808024852.GS17188@holomorphy.com>
Content-Type: text/plain
Message-Id: <1091938876.1183.19.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 08 Aug 2004 00:21:16 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-08-07 at 22:48, William Lee Irwin III wrote:

> It's probably actually a false positive. What I was explaining was why,
> if it were in fact a non-preemptible critical section, it wouldn't cause
> xruns.
> 

These two seem to be real.  It looks like get_user_pages is still
problematic in 2.6.8-rc2.

(jackd/6219): 10943us non-preemptible critical section violated 1000 us preempt threshold starting at kmap_atomic+0x10/0x60 and ending at kunmap_atomic+0x8/0x20
 [<c0106717>] dump_stack+0x17/0x20
 [<c0113eec>] dec_preempt_count+0x3c/0x50
 [<c0111ce8>] kunmap_atomic+0x8/0x20
 [<c013e2cb>] do_anonymous_page+0x8b/0x190
 [<c013e41e>] do_no_page+0x4e/0x310
 [<c013e8a1>] handle_mm_fault+0xc1/0x170
 [<c013d280>] get_user_pages+0x110/0x380
 [<c013e9f8>] make_pages_present+0x68/0x90
 [<c0140196>] do_mmap_pgoff+0x3e6/0x620
 [<c010b656>] sys_mmap2+0x76/0xb0
 [<c01060b7>] syscall_call+0x7/0xb
ALSA /home/rlrevell/cvs/alsa/alsa-driver/alsa-kernel/core/pcm_lib.c:139: XRUN: pcmC0D2c
 [<c0106717>] dump_stack+0x17/0x20
 [<de93d64b>] snd_pcm_period_elapsed+0x27b/0x3e0 [snd_pcm]
 [<de9791d1>] snd_emu10k1_interrupt+0xd1/0x3c0 [snd_emu10k1]
 [<c011a7d3>] generic_handle_IRQ_event+0x33/0x60
 [<c01079c2>] do_IRQ+0xb2/0x180
 [<c01062d8>] common_interrupt+0x18/0x20
 [<c0113e18>] __touch_preempt_timing+0x8/0x20
 [<c0113ea2>] inc_preempt_count+0x32/0x40
 [<c014cb8e>] fget+0x1e/0x60
 [<c015ecdd>] do_pollfd+0x2d/0xa0
 [<c015edaf>] do_poll+0x5f/0xc0
 [<c015ef41>] sys_poll+0x131/0x220
 [<c01060b7>] syscall_call+0x7/0xb
(gnome-terminal/914): 10738us non-preemptible critical section violated 1000 us preempt threshold starting at fget+0x1e/0x60 and ending at fget+0x3d/0x60
 [<c0106717>] dump_stack+0x17/0x20
 [<c0113eec>] dec_preempt_count+0x3c/0x50
 [<c014cbad>] fget+0x3d/0x60
 [<c015ecdd>] do_pollfd+0x2d/0xa0
 [<c015edaf>] do_poll+0x5f/0xc0
 [<c015ef41>] sys_poll+0x131/0x220
 [<c01060b7>] syscall_call+0x7/0xb

Lee

