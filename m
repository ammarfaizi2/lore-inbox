Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267511AbUG2W6l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267511AbUG2W6l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 18:58:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262906AbUG2WzS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 18:55:18 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:30436 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267517AbUG2Wya (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 18:54:30 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8-rc2-M5
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Scott Wood <scott@timesys.com>
In-Reply-To: <20040729222657.GA10449@elte.hu>
References: <40F3F0A0.9080100@vision.ee>
	 <20040713143947.GG21066@holomorphy.com> <1090732537.738.2.camel@mindpipe>
	 <1090795742.719.4.camel@mindpipe> <20040726082330.GA22764@elte.hu>
	 <1090830574.6936.96.camel@mindpipe> <20040726083537.GA24948@elte.hu>
	 <1090832436.6936.105.camel@mindpipe> <20040726124059.GA14005@elte.hu>
	 <20040726204720.GA26561@elte.hu>  <20040729222657.GA10449@elte.hu>
Content-Type: text/plain
Message-Id: <1091141622.30033.3.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 29 Jul 2004 18:53:42 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-07-29 at 18:26, Ingo Molnar wrote:
> i've uploaded the latest version of the voluntary-preempt patch:
>  
>    http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8-rc2-M5
> 

After running jackd with L2 all night, the only repeated XRUN was this one:

ALSA /home/rlrevell/cvs/alsa/alsa-driver/alsa-kernel/core/pcm_lib.c:139: XRUN: pcmC0D2c
 [<c01066a7>] dump_stack+0x17/0x20
 [<de93d54b>] snd_pcm_period_elapsed+0x27b/0x3e0 [snd_pcm]
 [<de979211>] snd_emu10k1_interrupt+0xd1/0x3c0 [snd_emu10k1]
 [<c01078d7>] handle_IRQ_event+0x47/0x90
 [<c0107e93>] do_IRQ+0xe3/0x1b0
 [<c0106268>] common_interrupt+0x18/0x20
 [<c0146771>] add_to_swap+0x21/0xc0
 [<c0139446>] shrink_list+0x156/0x4b0
 [<c01398ed>] shrink_cache+0x14d/0x370
 [<c013a118>] shrink_zone+0xa8/0xf0
 [<c013a4ee>] balance_pgdat+0x1be/0x220
 [<c013a5f9>] kswapd+0xa9/0xb0
 [<c0104395>] kernel_thread_helper+0x5/0x10

This produced a few ~2ms XRUNs.  The shrink_zone -> shrink_cache -> shrink_list 
is a recurring motif.

Is this addressed in M2?

Lee

