Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272963AbTHKTdp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 15:33:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272997AbTHKSyf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 14:54:35 -0400
Received: from [66.212.224.118] ([66.212.224.118]:24082 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S272989AbTHKSxW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 14:53:22 -0400
Date: Mon, 11 Aug 2003 14:41:32 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: davidm@hpl.hp.com
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH][2.6] WARN_ON_STACK_VAR aka fighting variable lifetime
 bugs
In-Reply-To: <16183.58300.408086.272654@napali.hpl.hp.com>
Message-ID: <Pine.LNX.4.53.0308111440080.26153@montezuma.mastecende.com>
References: <Pine.LNX.4.53.0308091430410.32166@montezuma.mastecende.com>
 <16183.58300.408086.272654@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Aug 2003, David Mosberger wrote:

> >>>>> On Sat, 9 Aug 2003 15:29:41 -0400 (EDT), Zwane Mwaikambo <zwane@arm.linux.org.uk> said:
> 
>   Zwane> --- linux-2.6.0-test2-irq/include/asm-ia64/bug.h	30 Jul 2003 00:06:30 -0000	1.1.1.1
>   Zwane> +++ linux-2.6.0-test2-irq/include/asm-ia64/bug.h	9 Aug 2003 19:14:09 -0000
>   Zwane> +#define WARN_ON_STACK_VAR(ptr) do { \
>   Zwane> +	unsigned long __ti = (unsigned long)current_thread_info(); \
>   Zwane> +	WARN_ON((__ti & (unsigned long)(ptr)) == __ti); \
>   Zwane> +} while (0)
> 
> Note that on ia64 we don't use bit-masking to calculate the
> task-pointer.  Instead, thread-info follows the task structure.  This
> is done such that the task-structure, thread-info, and kernel stack
> can be mapped by a single (pinned) TLB entry.
> 
> The correct check for a variable being on the stack of the current
> task would be something like this:
> 
> 	((unsigned long)(ptr) - (unsigned long) current) < IA64_STK_OFFSET
> 
> (IA64_STK_OFFSET is declared by <asm/ptrace.h>).

Ah thanks =) i've modified my patch accordingly.

	Zwane

