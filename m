Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261724AbUHJISL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbUHJISL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 04:18:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262085AbUHJISK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 04:18:10 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:14237 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261724AbUHJIR1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 04:17:27 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8-rc3-O4
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Florian Schmidt <mista.tapas@gmx.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
In-Reply-To: <20040810080933.GA26081@elte.hu>
References: <1090832436.6936.105.camel@mindpipe>
	 <20040726124059.GA14005@elte.hu> <20040726204720.GA26561@elte.hu>
	 <20040729222657.GA10449@elte.hu> <20040801193043.GA20277@elte.hu>
	 <20040809104649.GA13299@elte.hu> <20040809130558.GA17725@elte.hu>
	 <20040809190201.64dab6ea@mango.fruits.de> <1092103522.761.2.camel@mindpipe>
	 <1092117141.761.15.camel@mindpipe>  <20040810080933.GA26081@elte.hu>
Content-Type: text/plain
Message-Id: <1092125864.848.2.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 10 Aug 2004 04:17:44 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-10 at 04:09, Ingo Molnar wrote:
> * Lee Revell <rlrevell@joe-job.com> wrote:
> 
> > Here is another one I got starting jackd.  Never seen it before today.
> > 
> > (jackd/778): 14583us non-preemptible critical section violated 1100 us
> > preempt threshold starting at schedule+0x55/0x5a0 and ending at
> > schedule+0x2ed/0x5a0
> 
> just to make sure this is not a false positive - is this accompanied by
> ALSA-detected xruns as well? (i suspect it is.)

Yes, here it is:

Aug  9 22:12:48 mindpipe kernel: ALSA /home/rlrevell/cvs/alsa/alsa-driver/alsa-kernel/core/pcm_lib.c:139: XRUN: pcmC0D2c
Aug  9 22:12:48 mindpipe kernel:  [dump_stack+23/32] dump_stack+0x17/0x20
Aug  9 22:12:48 mindpipe kernel:  [__crc_totalram_pages+1425/2369476] snd_pcm_period_elapsed+0x27b/0x3e0 [snd_pcm]
Aug  9 22:12:48 mindpipe kernel:  [__crc_totalram_pages+135447/2369476] snd_emu10k1_interrupt+0xd1/0x3c0 [snd_emu10k1]
Aug  9 22:12:48 mindpipe kernel:  [generic_handle_IRQ_event+51/96] generic_handle_IRQ_event+0x33/0x60
Aug  9 22:12:48 mindpipe kernel:  [do_IRQ+178/384] do_IRQ+0xb2/0x180
Aug  9 22:12:48 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Aug  9 22:12:48 mindpipe kernel:  [schedule+727/1440] schedule+0x2d7/0x5a0
Aug  9 22:12:48 mindpipe kernel:  [schedule_timeout+158/160] schedule_timeout+0x9e/0xa0
Aug  9 22:12:48 mindpipe kernel:  [sys_rt_sigtimedwait+479/736] sys_rt_sigtimedwait+0x1df/0x2e0
Aug  9 22:12:48 mindpipe kernel:  [syscall_call+7/11] syscall_call+0x7/0xb

I do not seem to get false positives anymore, IOW, all the traces I send 
you are accompanied by an ALSA xrun.  I suspect that with a lower 
threshold (100us), the overhead from all the printks and stack dumps was 
causing one violation to lead to a domino effect.

Lee

