Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261987AbVGEV73@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261987AbVGEV73 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 17:59:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261990AbVGEVqY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 17:46:24 -0400
Received: from smtp.osdl.org ([65.172.181.4]:5294 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261962AbVGEVeh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 17:34:37 -0400
Date: Tue, 5 Jul 2005 14:33:48 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] Fix printk format vs argument warning
Message-Id: <20050705143348.29348633.akpm@osdl.org>
In-Reply-To: <1284.1120593819@warthog.cambridge.redhat.com>
References: <1284.1120593819@warthog.cambridge.redhat.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:
>
> The attached patch makes the argument to this printk in
>  calibrate_migration_costs() always long to match the format string.

That darn printk again.  You wouldn't believe...

calibrate_migration_costs() causes a storm of boot-time output and I think
all those printks should be removed before this code goes up to Linus. 
Maybe split out into a separate -mm-only patch?

>  Signed-Off-By: David Howells <dhowells@redhat.com>
>  ---
>  warthog>diffstat -p1 format-arg-size-2612mm1-10.diff 
>   kernel/sched.c |    2 +-
>   1 files changed, 1 insertion(+), 1 deletion(-)
> 
>  diff -uNrp linux-2.6.12-mm1/kernel/sched.c linux-2.6.12-mm1-cachefs-wander/kernel/sched.c
>  --- linux-2.6.12-mm1/kernel/sched.c	2005-06-22 13:54:08.000000000 +0100
>  +++ linux-2.6.12-mm1-cachefs-wander/kernel/sched.c	2005-06-22 14:10:57.000000000 +0100
>  @@ -5572,7 +5572,7 @@ void __devinit calibrate_migration_costs
>   	printk("| migration cost matrix (max_cache_size: %d, cpu: %ld MHz):\n",
>   			max_cache_size,
>   #ifdef CONFIG_X86
>  -			cpu_khz/1000
>  +			cpu_khz/1000L
>   #else

It's currently %d in my tree.  This is why I converted x86's cpu_khz from
unsigned long to unsigned, to match x86_64's.
