Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279917AbRKBBjp>; Thu, 1 Nov 2001 20:39:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279918AbRKBBjf>; Thu, 1 Nov 2001 20:39:35 -0500
Received: from [202.135.142.195] ([202.135.142.195]:18451 "EHLO
	haven.ozlabs.ibm.com") by vger.kernel.org with ESMTP
	id <S279917AbRKBBjZ>; Thu, 1 Nov 2001 20:39:25 -0500
Date: Fri, 2 Nov 2001 12:42:52 +1100
From: Rusty Russell <rusty@rustcorp.com.au>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5 PROPOSAL: Replacement for current /proc of shit.
Message-Id: <20011102124252.1032e9b2.rusty@rustcorp.com.au>
In-Reply-To: <3BE1271C.6CDF2738@mandrakesoft.com>
In-Reply-To: <E15zF9H-0000NL-00@wagner>
	<3BE1271C.6CDF2738@mandrakesoft.com>
X-Mailer: Sylpheed version 0.5.3 (GTK+ 1.2.10; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 01 Nov 2001 05:42:36 -0500
Jeff Garzik <jgarzik@mandrakesoft.com> wrote:

> Is this designed to replace sysctl?

Well, I'd suggest replacing *all* the non-process stuff in /proc.  Yes.
 
> In general we want to support using sysctl and similar features WITHOUT
> procfs support at all (of any type).  Nice for embedded systems
> especially.

1) My example was implemented as a filesystem.  You could just as easily have
   a CONFIG_PROC_SYSCALL which implemented access as a syscall, ie. sysctl2().

2) It's not worth the hassle to save 7k of code (well, the final implementation
   will be larger than this, but OTOH, your replacement will be non-zero size).

> AFAICS your proposal, while nice and clean :), doesn't offer all the
> features that sysctl presently does.

You're right!  My code:

1) Doesn't have the feature of requiring #ifdef CONFIG_SYSCTL in every file
   that uses it properly (ie. checks error returns).
2) Doesn't have the feature that compiling without CONFIG_PROC/CONFIG_SYSCTL 
   wastes kernel memory unless surrounded by above #ifdefs.
3) Doesn't have the feature that it takes over 90 lines to implement a working
   read & write.
4) Doesn't have the feature that it's hard to create dynamic directories.
5) Doesn't have the feature that it's inherently racy against module unload.

What was I thinking????
Rusty.
