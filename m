Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263325AbTJQHZX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 03:25:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263327AbTJQHZX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 03:25:23 -0400
Received: from fw.osdl.org ([65.172.181.6]:49622 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263325AbTJQHZU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 03:25:20 -0400
Date: Fri, 17 Oct 2003 00:25:29 -0700
From: Andrew Morton <akpm@osdl.org>
To: Bradley Chapman <kakadu_croc@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test7-mm1
Message-Id: <20031017002529.21528bc7.akpm@osdl.org>
In-Reply-To: <20031017070348.46326.qmail@web40911.mail.yahoo.com>
References: <20031016083124.45a171a5.akpm@osdl.org>
	<20031017070348.46326.qmail@web40911.mail.yahoo.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bradley Chapman <kakadu_croc@yahoo.com> wrote:
>
> Mr. Morton,
> 
> After backing out these two patches, recompiling and rebooting, I get these
> two unrelated Oopses:
> 
> PID hash table entries: 2048 (order 11: 16384 bytes)
> Debug: sleeping function called from invalid context at include/linux/rwsem.h:66
> in_atomic():1, irqs_disabled():1
> Call Trace:
>  [<c0123fc6>] __might_sleep+0xa0/0xc2
>  [<c02e9727>] cpufreq_register_notifier+0x30/0x96
>  [<c0107000>] rest_init+0x0/0xf4
>  [<c0493af9>] init_tsc+0x54/0xf2
>  [<c0107000>] rest_init+0x0/0xf4
>  [<c011a141>] select_timer+0x26/0x55
>  [<c048f4d5>] time_init+0x38/0x49
>  [<c048c66b>] start_kernel+0x124/0x22e
>  [<c048c41b>] unknown_bootoption+0x0/0xff

It's not an oops, it's a warning.  cpufreq_register_notifier() is being
called super-early but is taking a semaphore.  I've asked the cpufreq guys
if this can be moved to an initcall but received one of those stupid "your
message is awaiting moderator approval" replies from the mailing list.  I
gave up at that point.

