Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267548AbUHTBRz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267548AbUHTBRz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 21:17:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267553AbUHTBRz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 21:17:55 -0400
Received: from fw.osdl.org ([65.172.181.6]:4830 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267548AbUHTBRx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 21:17:53 -0400
Date: Thu, 19 Aug 2004 18:16:03 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nathan Lynch <nathanl@austin.ibm.com>
Cc: linux-kernel@vger.kernel.org, vatsa@in.ibm.com, rusty@rustcorp.com.au,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.8.1-mm2
Message-Id: <20040819181603.700a9a0e.akpm@osdl.org>
In-Reply-To: <1092964083.4946.7.camel@biclops.private.network>
References: <20040819014204.2d412e9b.akpm@osdl.org>
	<1092964083.4946.7.camel@biclops.private.network>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan Lynch <nathanl@austin.ibm.com> wrote:
>
> > +dont-sleep-after-were-out-of-task-list.patch
> > 
> >  CPU hotplug race fix
> 
> I don't mean to be a pain, but this patch does not fix the bug I
> reported.

OK.

>  It is still occurring on i386 and ppc64 (and proc_pid_flush
> now generates lots of might_sleep warnings).
> ...
> Hopefully, I should have time to perform a bisection search this
> weekend.

The might_sleep() warnings are due to our adding a might_sleep() check to a
place where we've _always_ been illegally sleeping.  So a bisection search
won't tell you anything on that front.

The "kernel BUG in migration_call at kernel/sched.c:4044!" is due to one of
the scheduler patches.  I thought Ingo and Rusty had a handle on that one.

