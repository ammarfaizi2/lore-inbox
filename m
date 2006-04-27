Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964972AbWD0ISq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964972AbWD0ISq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 04:18:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964975AbWD0ISq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 04:18:46 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:11706 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964972AbWD0ISp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 04:18:45 -0400
Date: Thu, 27 Apr 2006 10:23:57 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Simon Derr <Simon.Derr@bull.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.16-rt17 on IA64
Message-ID: <20060427082357.GA1874@elte.hu>
References: <Pine.LNX.4.61.0604201446470.15050@openx3.frec.bull.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0604201446470.15050@openx3.frec.bull.fr>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Simon Derr <Simon.Derr@bull.net> wrote:

> Hi,
> 
> This is a first version of my port of Ingo's -rt kernel to the IA64 
> arch.

nice! I've added this to the -rt tree and have released -rt18.

> So far the kernel boots with PREEMPT_RT enabled (on a 4-cpu tiger), 
> and that's about it. I've not done extensive tests (only 
> scripts/rt-tester), nor any measurements of any kind.
> 
> There's very probably many bugs I'm not aware of.
> 
> But there is already one thing I know should be fixed : I've changed 
> the declaration of (struct zone).lock (in include/linux/mmzone.h) from 
> spinlock_t to raw_spinlock_t.
> 
> I did this because on IA64, cpu_idle(), which is not allowed to call 
> schedule(), calls check_pgt_cache(). I guess this could be fixed by 
> moving this call to another kernel thread... ideas are welcome.

this should definitely be cleaned up. There are a couple of periodic VM 
threads you could do this from - but none is really per-CPU. So my 
suggestion would be to do the check_pgt_cache() from desched_thread() - 
which is an rt-specific cleanup thread. You dont even have to make it 
ia64-specific i think.

	Ingo
