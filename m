Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267439AbUHJFwL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267439AbUHJFwL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 01:52:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267442AbUHJFwL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 01:52:11 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:20875 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267439AbUHJFwG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 01:52:06 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8-rc3-O4
From: Lee Revell <rlrevell@joe-job.com>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
In-Reply-To: <1092103522.761.2.camel@mindpipe>
References: <1090795742.719.4.camel@mindpipe>
	 <20040726082330.GA22764@elte.hu> <1090830574.6936.96.camel@mindpipe>
	 <20040726083537.GA24948@elte.hu> <1090832436.6936.105.camel@mindpipe>
	 <20040726124059.GA14005@elte.hu> <20040726204720.GA26561@elte.hu>
	 <20040729222657.GA10449@elte.hu> <20040801193043.GA20277@elte.hu>
	 <20040809104649.GA13299@elte.hu> <20040809130558.GA17725@elte.hu>
	 <20040809190201.64dab6ea@mango.fruits.de> <1092103522.761.2.camel@mindpipe>
Content-Type: text/plain
Message-Id: <1092117141.761.15.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 10 Aug 2004 01:52:22 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-08-09 at 22:06, Lee Revell wrote:

> Same results here, the mlockall problem is not fixed by -O4:

Correction, those traces did not involve mlockall at all, but
kmap_atomic and get_user_pages.

Here is another one I got starting jackd.  Never seen it before today.

(jackd/778): 14583us non-preemptible critical section violated 1100 us preempt threshold starting at schedule+0x55/0x5a0 and ending at schedule+0x2ed/0x5a0
 [<c0106717>] dump_stack+0x17/0x20
 [<c0113eec>] dec_preempt_count+0x3c/0x50
 [<c0264d4d>] schedule+0x2ed/0x5a0
 [<c026554e>] schedule_timeout+0x9e/0xa0
 [<c0121dcf>] sys_rt_sigtimedwait+0x1df/0x2e0
 [<c01060b7>] syscall_call+0x7/0xb
ALSA /home/rlrevell/cvs/alsa/alsa-driver/alsa-kernel/core/pcm_lib.c:139: XRUN: pcmC0D2c
 [<c0106717>] dump_stack+0x17/0x20
 [<de93664b>] snd_pcm_period_elapsed+0x27b/0x3e0 [snd_pcm]
 [<de9571d1>] snd_emu10k1_interrupt+0xd1/0x3c0 [snd_emu10k1]
 [<c011a7d3>] generic_handle_IRQ_event+0x33/0x60
 [<c01079c2>] do_IRQ+0xb2/0x180
 [<c01062d8>] common_interrupt+0x18/0x20

Lee

