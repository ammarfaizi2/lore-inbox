Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265086AbUHJOQt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265086AbUHJOQt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 10:16:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265022AbUHJOQt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 10:16:49 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:9447 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S265099AbUHJOQi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 10:16:38 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8-rc3-O4
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Florian Schmidt <mista.tapas@gmx.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
In-Reply-To: <20040810075331.GB25238@elte.hu>
References: <1090832436.6936.105.camel@mindpipe>
	 <20040726124059.GA14005@elte.hu> <20040726204720.GA26561@elte.hu>
	 <20040729222657.GA10449@elte.hu> <20040801193043.GA20277@elte.hu>
	 <20040809104649.GA13299@elte.hu> <20040809130558.GA17725@elte.hu>
	 <20040809190201.64dab6ea@mango.fruits.de> <1092103522.761.2.camel@mindpipe>
	 <1092117141.761.15.camel@mindpipe>  <20040810075331.GB25238@elte.hu>
Content-Type: text/plain
Message-Id: <1092147415.5818.2.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 10 Aug 2004 10:16:55 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-10 at 03:53, Ingo Molnar wrote:
> can you trigger similar latencies via the attached mlock testcode?
> (written by Florian. Run it as root.)
> 

Yup, using only 100000 bytes, I get a bunch of these:

(mlockall-test/6561): 10353us non-preemptible critical section violated 1100 us preempt threshold starting at get_user_pages+0xa6/0x3b0 and ending at get_user_pages+0x2c5/0x3b0
 [<c0106717>] dump_stack+0x17/0x20
 [<c0113eec>] dec_preempt_count+0x3c/0x50
 [<c013d435>] get_user_pages+0x2c5/0x3b0
 [<c013ea28>] make_pages_present+0x68/0x90
 [<c013ee8d>] mlock_fixup+0x8d/0xb0
 [<c013f170>] do_mlockall+0x70/0x90
 [<c013f229>] sys_mlockall+0x99/0xa0
 [<c01060b7>] syscall_call+0x7/0xb
ALSA /home/rlrevell/cvs/alsa/alsa-driver/alsa-kernel/core/pcm_lib.c:139: XRUN: pcmC0D2c
 [<c0106717>] dump_stack+0x17/0x20
 [<de93d64b>] snd_pcm_period_elapsed+0x27b/0x3e0 [snd_pcm]
 [<de9791d1>] snd_emu10k1_interrupt+0xd1/0x3c0 [snd_emu10k1]
 [<c011a7d3>] generic_handle_IRQ_event+0x33/0x60
 [<c01079c2>] do_IRQ+0xb2/0x180
 [<c01062d8>] common_interrupt+0x18/0x20
 [<c0113d31>] check_preempt_timing+0x11/0xf0
 [<c0113e62>] touch_preempt_timing+0x32/0x40
 [<c013d216>] get_user_pages+0xa6/0x3b0
 [<c013ea28>] make_pages_present+0x68/0x90
 [<c013ee8d>] mlock_fixup+0x8d/0xb0
(mlockall-test/6561): 9168us non-preemptible critical section violated 1100 us preempt threshold starting at get_user_pages+0x2cf/0x3b0 and ending at get_user_pages+0xa6/0x3b0
 [<c0106717>] dump_stack+0x17/0x20
 [<c0113e62>] touch_preempt_timing+0x32/0x40
 [<c013d216>] get_user_pages+0xa6/0x3b0
 [<c013ea28>] make_pages_present+0x68/0x90
 [<c013ee8d>] mlock_fixup+0x8d/0xb0
 [<c013f170>] do_mlockall+0x70/0x90
 [<c013f229>] sys_mlockall+0x99/0xa0
 [<c01060b7>] syscall_call+0x7/0xb

Lee

