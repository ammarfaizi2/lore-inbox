Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264329AbTLVGsT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 01:48:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264331AbTLVGsT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 01:48:19 -0500
Received: from fw.osdl.org ([65.172.181.6]:14995 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264329AbTLVGsS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 01:48:18 -0500
Date: Sun, 21 Dec 2003 22:47:45 -0800
From: Andrew Morton <akpm@osdl.org>
To: Paul Jackson <pj@sgi.com>
Cc: linux-kernel@vger.kernel.org, ioe-lkml@rameria.de
Subject: Re: [PATCH] another minor bit of cpumask cleanup
Message-Id: <20031221224745.268db46d.akpm@osdl.org>
In-Reply-To: <20031221180044.0f27eca1.pj@sgi.com>
References: <20031221180044.0f27eca1.pj@sgi.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson <pj@sgi.com> wrote:
>
> Ingo Oeser pointed out to me in private email that one of the cpumask
> macros was broken - the macro for for_each_online_cpu() starts its loop
> with _any_ cpu from the provided mask, and only worries about restricting
> itself to _online_ cpus when looping to the next cpu:
> 
> include/linux/cpumask.h:
> > #define for_each_online_cpu(cpu, map)                                   \
> >         for (cpu = first_cpu_const(mk_cpumask_const(map));              \
> >                 cpu < NR_CPUS;                                          \
> >                 cpu = next_online_cpu(cpu,map))
> 
> Looking further, I see this macro is never used, and its subordinate
> inline macro next_online_cpu() used no where else.  What's more, it's
> redundant.  Calling it with a map of "cpu_online_map" (which you have to
> do, given it's broken thus) is just as good as calling the macro right
> above, "for_each_cpu()", with that same "cpu_online_map". Indeed the
> only uses of "for_each_cpu()", in arch/i386/mach-voyager/voyager_smp.c,
> do pass "cpu_online_map" explicitly, in 5 of 6 calls there from.
> 
> So, having found a piece of code that is broken, redundant and unused,
> I hereby off the following patch to remove it.

Generates rejects for my tree.  I already have three patches which alter
cpumask.h.

Please, hang onto it until we get things synced up a bit more.
