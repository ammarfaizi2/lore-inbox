Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266487AbUAWAWb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 19:22:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266488AbUAWAWb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 19:22:31 -0500
Received: from fw.osdl.org ([65.172.181.6]:47836 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266487AbUAWAWa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 19:22:30 -0500
Date: Thu, 22 Jan 2004 16:23:48 -0800
From: Andrew Morton <akpm@osdl.org>
To: Adam Kropelin <akropel1@rochester.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.1 oops in prune_dcache()
Message-Id: <20040122162348.46637991.akpm@osdl.org>
In-Reply-To: <20040122181751.A2101@mail.kroptech.com>
References: <20040122181751.A2101@mail.kroptech.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Kropelin <akropel1@rochester.rr.com> wrote:
>
> At 4 AM this morning (during cron run, I suppose) a box running 2.6.1
> hit the oops below. It locked solid, had to hit the reset button to
> reboot it. The machine had been running 2.6.1 for about a week prior
> with no problems.
> 
> Hardware is single Pentium Pro 200, 128 MB RAM (extensively
> memtest86'ed).

Yes, but it is old.

> Kernel is no-SMP, no-preempt, and (obviously) no-highmem.
> 
> Feel free to ask for more details if I can help. This is the first oops
> I've seen since mid 2.5.x on this machine.
> 
> --Adam
> 
> 
> Jan 21 04:06:32 print kernel: Unable to handle kernel paging request at virtual address 00008014
> Jan 21 04:06:32 print kernel:  printing eip:
> Jan 21 04:06:32 print kernel: c01570e5
> Jan 21 04:06:32 print kernel: *pde = 00000000
> Jan 21 04:06:32 print kernel: Oops: 0000 [#1]
> Jan 21 04:06:32 print kernel: CPU:    0
> Jan 21 04:06:32 print kernel: EIP:    0060:[<c01570e5>]    Not tainted
> Jan 21 04:06:32 print kernel: EFLAGS: 00010206
> Jan 21 04:06:32 print kernel: EIP is at prune_dcache+0xe5/0x130
> Jan 21 04:06:32 print kernel: eax: 00008000   ebx: c1dc83e0   ecx: c577da74   edx: c577da74

Bit 15 of %eax got flipped.  The kernel indexed off it and oopsed.

This is most likely a hardware failure.
