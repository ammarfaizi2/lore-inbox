Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275110AbRJ2Noc>; Mon, 29 Oct 2001 08:44:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275294AbRJ2NoX>; Mon, 29 Oct 2001 08:44:23 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:18705 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S275110AbRJ2NoM>; Mon, 29 Oct 2001 08:44:12 -0500
Date: Mon, 29 Oct 2001 14:44:41 +0100
From: Jan Kara <jack@suse.cz>
To: Simon Kirby <sim@netnation.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops: Quota race in 2.4.12?
Message-ID: <20011029144441.E11994@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20011028215818.A7887@netnation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011028215818.A7887@netnation.com>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

> Some of our dual CPU web servers with 2.4.12 are Oopsing while running
> quotacheck.  They don't seem to die immediately, but oops many times and
> eventually break.  The old tools didn't warn about quotachecking on a
> live file system, so some of our servers were set up to run quotacheck
> nightly.  The new tools still allow you to do it, but warn that it may
> not be consistent.  We didn't have any problems with 2.2 kernels.
> 
> First oops, as already processed (grumble) by klogd:
> 
> Oct 28 04:22:32 pro kernel: remove_free_dquot: dquot not on the free list??
> Oct 28 04:22:32 pro last message repeated 90 times
> Oct 28 04:22:32 pro kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000004
> ...dates stripped:
> 
> Unable to handle kernel NULL pointer dereference at virtual address 00000004
>  printing eip:
> c0149edc
> *pde = 00000000
> Oops: 0002
> CPU:    1
> EIP:    0010:[dqput+148/188]    Not tainted
> EFLAGS: 00010246
> eax: d58c8830   ebx: cf330cc0   ecx: cf330cd0   edx: 00000000
> esi: cf330cc0   edi: d2847f6c   ebp: 00000000   esp: d2847f30
> ds: 0018   es: 0018   ss: 0018
> Process quotacheck (pid: 3933, stackpage=d2847000)
> Stack: 00000000 c014a93e cf330cc0 00006000 c1a58800 00000000 d2847fa4 00000000 
>        00000000 00000000 00000000 00000000 00000000 00000000 00000000 c014b8f0 
>        c1a58800 0000f465 00000000 00000004 bffffd54 d2846000 bffffd54 001e8ca0 
> Call Trace: [set_dqblk+390/404] [sys_quotactl+780/892] [sys_read+188/196] [system_call+51/56] 
> 
> Code: 89 4a 04 89 53 10 89 41 04 89 08 ff 05 e4 ab 34 c0 8d 43 24 
> 
> Perhaps there is some obviously broken locking/code in the quotactl syscall?
  I'd also blame some SMP locking (I think that on UP everything was tested well) but
everything should be protected by lock_kernel() and it seems to me that everything really
is protected. Anyway I'll try to find the problem.

								Thanks for report
										Honza

--
Jan Kara <jack@suse.cz>
SuSE CR Labs
