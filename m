Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261282AbVDJCsF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261282AbVDJCsF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 22:48:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261286AbVDJCsF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 22:48:05 -0400
Received: from fire.osdl.org ([65.172.181.4]:47015 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261282AbVDJCsB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 22:48:01 -0400
Date: Sat, 9 Apr 2005 19:47:46 -0700
From: Andrew Morton <akpm@osdl.org>
To: Claudio Martins <ctpm@rnl.ist.utl.pt>
Cc: linux-kernel@vger.kernel.org, Neil Brown <neilb@cse.unsw.edu.au>
Subject: Re: Processes stuck on D state on Dual Opteron
Message-Id: <20050409194746.69cfa230.akpm@osdl.org>
In-Reply-To: <200504100328.53762.ctpm@rnl.ist.utl.pt>
References: <200504050316.20644.ctpm@rnl.ist.utl.pt>
	<20050404191246.24b11158.akpm@osdl.org>
	<200504100328.53762.ctpm@rnl.ist.utl.pt>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Claudio Martins <ctpm@rnl.ist.utl.pt> wrote:
>
>   I repeated the test to try to get more output from alt-sysreq-T, but it 
>  oopsed again with even less output. 
>    By the way, I have also tested 2.6.11.6 and I get stuck processes in the 
>  same way. With 2.6.9 I get a hard lockup with no working alt-sysrq, after 
>  about 30 to 60mins of stress.

It could be an md deadlock, or it could be an out-of-memory deadlock.  md
trying to allocate memory on the swapout path.

>    This is with preempt enabled (as well as BKL preempt). I want to test also 
>  without preempt and also without using MD Raid1, but I'll have to reach the 
>  machine and hit the power button, so not possible until tomorrow :-(
> 
>   The original original message in this thread containing the details of the 
>  setup and a .config is at:
> 
>  http://marc.theaimsgroup.com/?l=linux-kernel&m=111266784320156&w=2
> 
>    I am happy to test any patches and also wonder if enabling any of the 
>  options in the kernel debugging section could help in trying to find where 
>  the deadlock is.

Suggest you boot with `nmi_watchdog=0' to prevent the nmi watchdog from
cutting in during long sysrq traces.

Also, capture the `sysrq-m' output so we can see if the thing is out of
memory.
