Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315412AbSEUSW0>; Tue, 21 May 2002 14:22:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315413AbSEUSWZ>; Tue, 21 May 2002 14:22:25 -0400
Received: from ns.suse.de ([213.95.15.193]:14608 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S315412AbSEUSWY>;
	Tue, 21 May 2002 14:22:24 -0400
To: C Hanish Menon <hanishkvc@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Seems like a race or unhandled situation with ksoftirqd scheduling/management
In-Reply-To: <3CEA8742.2040308@yahoo.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 21 May 2002 20:22:24 +0200
Message-ID: <p73hel1xswv.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

C Hanish Menon <hanishkvc@yahoo.com> writes:

>    According to the comment in cpu_raise_softirq it doesn't 
> wakeup_softirqd in irq context because on returning from a irq
> softirqd will be run,  but it doesn't seem to be valid in any
> architectures (have varified x86, mips). Because on returning
> from irq context, just the scheduler gets called, but as
> the ksoftirqd is not in the run queue, it won't get scheduled.

At least i386 runs the softirqs at the end of do_IRQ.

ksoftirqd is just supposed to be a fallback mechanism for the case
of soft irqs eating excessive runtime or one softirq triggering another
(common case is networking and serial softirq for BH). It is not
the primary way to run softirqs.

-Andi
