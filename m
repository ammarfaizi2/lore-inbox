Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267540AbUJNUn0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267540AbUJNUn0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 16:43:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267401AbUJNUlS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 16:41:18 -0400
Received: from mx2.elte.hu ([157.181.151.9]:64897 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S267507AbUJNUVq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 16:21:46 -0400
Date: Thu, 14 Oct 2004 22:23:04 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Daniel Walker <dwalker@mvista.com>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U0
Message-ID: <20041014202304.GA32026@elte.hu>
References: <OF29AF5CB7.227D041F-ON86256F2A.0062D210@raytheon.com> <20041011215909.GA20686@elte.hu> <20041012091501.GA18562@elte.hu> <20041012123318.GA2102@elte.hu> <20041012195424.GA3961@elte.hu> <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu> <1097784144.5310.13.camel@dhcp153.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1097784144.5310.13.camel@dhcp153.mvista.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Daniel Walker <dwalker@mvista.com> wrote:

> I'm not sure about this one ..
> 
> ------------[ cut here ]------------
> kernel BUG at fs/buffer.c:1360!

> EIP is at __find_get_block+0xe1/0x100

> Call Trace:
>  [<c01619fe>] __getblk+0x1e/0x60
>  [<c0161a99>] __bread+0x19/0x40
>  [<c019aff0>] ext3_get_branch+0x70/0x100
>  [<c019b61a>] ext3_get_block_handle+0x7a/0x2e0
>  [<c026b1ee>] as_choose_req+0xe/0x1e0
>  [<c026bc5f>] as_update_arq+0x1f/0x60
>  [<c019b8c3>] ext3_get_block+0x43/0x80
>  [<c0163735>] generic_block_bmap+0x35/0x40
>  [<c0134c73>] __mcount+0x13/0x20
>  [<c019c26d>] ext3_bmap+0xd/0xa0
>  [<c01797c5>] bmap+0x45/0x60
>  [<c019c2dc>] ext3_bmap+0x7c/0xa0
>  [<c019b880>] ext3_get_block+0x0/0x80
>  [<c01797c5>] bmap+0x45/0x60
>  [<c01af8c2>] journal_bmap+0x42/0xa0
>  [<c0134c73>] __mcount+0x13/0x20
>  [<c0134249>] _mutex_unlock+0x9/0x60
>  [<c01af827>] journal_next_log_block+0x47/0xa0
>  [<c0113d30>] mcount+0x14/0x18
>  [<c01af832>] journal_next_log_block+0x52/0xa0
>  [<c01af939>] journal_get_descriptor_buffer+0x19/0xc0
>  [<c01ac4ec>] journal_commit_transaction+0xf6c/0x13e0
>  [<c01aedee>] kjournald+0xce/0x260
>  [<c013555c>] sub_preempt_count+0x7c/0xa0
>  [<c0133d00>] autoremove_wake_function+0x0/0x60
>  [<c03b2a33>] _spin_unlock_irq+0x13/0x40
>  [<c0133d00>] autoremove_wake_function+0x0/0x60
>  [<c0119459>] schedule_tail+0x19/0x60
>  [<c01aece0>] commit_timeout+0x0/0x20
>  [<c01aed20>] kjournald+0x0/0x260
>  [<c0103339>] kernel_thread_helper+0x5/0xc

this is a weird one. This is the first message, right? I've reviewed
bh_lru_lock/unlock and cannot spot anything that could be wrong there.

	Ingo
