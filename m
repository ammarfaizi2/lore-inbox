Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261597AbVD0OEW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261597AbVD0OEW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 10:04:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261612AbVD0OEW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 10:04:22 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:27325 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261597AbVD0OEP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 10:04:15 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Alexander Nyberg <alexn@telia.com>
Subject: Re: [BUG] 2.6.12-rc3: unkillable java process in TASK_RUNNING on AMD64
Date: Wed, 27 Apr 2005 16:04:21 +0200
User-Agent: KMail/1.7.1
Cc: Andrew Morton <akpm@osdl.org>, ak@suse.de, linux-kernel@vger.kernel.org
References: <200504271152.15423.rjw@sisk.pl> <200504271412.51565.rjw@sisk.pl> <1114606494.868.6.camel@localhost.localdomain>
In-Reply-To: <1114606494.868.6.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504271604.22001.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, 27 of April 2005 14:54, Alexander Nyberg wrote:
> > > > >From sysrq-P, I get this:
> > > > 
> > > > Pid: 11073, comm: java Not tainted 2.6.12-rc3
> > > > RIP: 0010:[<ffffffff8010f675>] <ffffffff8010f675>{retint_signal+20}
> > > > RSP: 0018:ffff810012d6ff58  EFLAGS: 00000282
> > > > RAX: 0000000000020000 RBX: ffff810010868820 RCX: ffff810012d6e000
> > > > RDX: 0000000000020000 RSI: 0000000000000000 RDI: ffff810012d6ff58
> > > > RBP: 000000a30c153a4a R08: ffff810012d6e000 R09: ffffffff804c6068
> > > > R10: 0000000000000001 R11: 0000000000000001 R12: ffffffff804ccd40
> > > > R13: ffff810010868820 R14: ffff81002cff2cf0 R15: ffffffff8010d3a7
> > > > FS:  00002aaaae6389c0(0000) GS:ffffffff8054a600(0063) knlGS:00000000556c9080
> > > > CS:  0010 DS: 002b ES: 002b CR0: 000000008005003b
> > > > CR2: 00002aaaaabab000 CR3: 0000000012930000 CR4: 00000000000006e0
> > > > 
> > > > Call Trace:<ffffffff8010f697>{retint_signal+54}
> > > > 
> > > > all the time.
> 
> My mind tells me this might be the problem but statistics also tell me
> processes should get stuck all the time here...
> 
> In retint_signal %rdi is destroyed, need to jump to the label above
> retint_check that sets %edi back to $_TIF_WORK_MASK
> 
> Signed-off-by: Alexander Nyberg <alexn@telia.com>
> 
> Index: linux-2.6/arch/x86_64/kernel/entry.S
> ===================================================================
> --- linux-2.6.orig/arch/x86_64/kernel/entry.S	2005-04-27 13:08:50.000000000 +0200
> +++ linux-2.6/arch/x86_64/kernel/entry.S	2005-04-27 14:43:20.000000000 +0200
> @@ -491,7 +491,7 @@
>  	RESTORE_REST
>  	cli
>  	GET_THREAD_INFO(%rcx)	
> -	jmp retint_check
> +	jmp retint_with_reschedule
>  
>  #ifdef CONFIG_PREEMPT
>  	/* Returning to kernel space. Check if we need preemption */

With this patch I'm unable to reproduce the problem, though I've tried really hard.  Thanks!

Greets,
Rafael
 

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
