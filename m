Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261716AbVBAJW1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261716AbVBAJW1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 04:22:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261890AbVBAJW1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 04:22:27 -0500
Received: from smtp207.mail.sc5.yahoo.com ([216.136.129.97]:40293 "HELO
	smtp207.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261716AbVBAJRk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 04:17:40 -0500
Message-ID: <41FF492D.8000700@yahoo.com.au>
Date: Tue, 01 Feb 2005 20:17:33 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, Anton Blanchard <anton@samba.org>
Subject: Re: 2.6.11-rc2-mm2
References: <20050129131134.75dacb41.akpm@osdl.org>
In-Reply-To: <20050129131134.75dacb41.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11-rc2/2.6.11-rc2-mm2/
> 
> 
> 
> 
> Changes since 2.6.11-rc2-mm1:
> 

Just a couple of things:

> +task_size-is-variable.patch
> +use-mm_vm_size-in-exit_mmap.patch
> 

I didn't hear back about my comments on this patch. I don't see
why MM_VM_SIZE should round up to the next PGDIR? This means
architecture implementations need to do the same thing, yes?

If MM_VM_SIZE means "the total address span of all top level page
tables an mm can contain", then OK. Otherwise it should probably
be left in the caller.

>  Fixes for recent TASK_SIZE changes (these are still in flux)
> 
                                               ^^^
Oh, I see :P

> 
> -sched-isochronous-class-for-unprivileged-soft-rt-scheduling.patch
> -sched-account-rt_tasks-as-iso_ticks.patch
> +rlimit_rt_cpu.patch
> +rlimit_rt_cpu-fix.patch
> +rlimit_rt_cpu-sparc64-fix.patch
> 
>  Drop SCHED_ISO, add the rlimit which allows non-privileged users to gain
>  limited RT scheduling policy.
> 

At the risk of sounding like a luddite who doesn't want to see a
complex new userspace API introduced that we're forced to support
for the next 10 years... I have some valid concerns with the rt
limit patches.

A simple rlimit of RT priorities (a very well definied quantity,
in contrast the vague "CPU usage"), is easy, a patch exists, it
doesn't touch a single fastpath or add complexity, it immediately
addresses the concerns of the RT audio guys who started all this,
and can be used meaningfully by userspace systems that want to
control and limit *real* RT scheduling, and without breaking
defined userspace RT scheduling APIs, IMO would be a better place
to start.

If someone later comes along and wants the extra features and
quirks that these patches provide, then I'd be all for further work
and discussion.

And this isn't meant to be an attack on anyone - I'm aware that
the -mm tree is for testing and discussion and further progression
of patches.

