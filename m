Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263979AbTJFFMN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 01:12:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263983AbTJFFMN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 01:12:13 -0400
Received: from webhosting.rdsbv.ro ([213.157.185.164]:29113 "EHLO
	hosting.rdsbv.ro") by vger.kernel.org with ESMTP id S263979AbTJFFMM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 01:12:12 -0400
Date: Mon, 6 Oct 2003 08:12:10 +0300 (EEST)
From: Catalin BOIE <util@deuroconsult.ro>
X-X-Sender: util@hosting.rdsbv.ro
To: Jamie Lokier <jamie@shareable.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: idt change in a running kernel? what locking?
In-Reply-To: <20031003170210.GA18415@mail.shareable.org>
Message-ID: <Pine.LNX.4.58.0310060810440.26313@hosting.rdsbv.ro>
References: <Pine.LNX.4.58.0310030850110.10930@hosting.rdsbv.ro>
 <20031003063411.GF15691@mail.shareable.org> <Pine.LNX.4.58.0310030945050.10930@hosting.rdsbv.ro>
 <20031003170210.GA18415@mail.shareable.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks again!

On Fri, 3 Oct 2003, Jamie Lokier wrote:

> Catalin BOIE wrote:
> > > It's more likely, you want to use get_cpu()/put_cpu() to prevent the
> > > current kernel thread from being pre-empted to a different CPU.
> > get_cpu locks the thread on a CPU until put_cpu?
>

> Yes, it disables preemption.
> Taking any spinlock will do it too.
>
> > > If you are intending to change idt on all CPUs, you'll need something
> > > more complicated.
> >
> > Hm. I realized that on a SMP it's a little hard to do it.
> > How can I change that on all cpus?
> > There is something to use that i can force my code to run on a specific
> > cpu?
>
> on_each_cpu() will call a function on each CPU.  Be careful that the
> function is safe in the contexts in which it will be called.
>
> If you just want to force you code to run on one cpu, that is
> automatic if you are holding a spinlock (but then you can't schedule,
> return to userspace etc.)
>
> In general you can fix a task to a cpu using set_cpus_allowed().
>
> -- Jamie
>

What I realy want is to reload idt on every cpu.
So, probably on_each_cpu is the way to go, right?

---
Catalin(ux) BOIE
catab@deuroconsult.ro
