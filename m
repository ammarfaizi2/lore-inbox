Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263930AbTJCRCT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 13:02:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263931AbTJCRCT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 13:02:19 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:8328 "EHLO mail.shareable.org")
	by vger.kernel.org with ESMTP id S263930AbTJCRCS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 13:02:18 -0400
Date: Fri, 3 Oct 2003 18:02:10 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Catalin BOIE <util@deuroconsult.ro>
Cc: linux-kernel@vger.kernel.org
Subject: Re: idt change in a running kernel? what locking?
Message-ID: <20031003170210.GA18415@mail.shareable.org>
References: <Pine.LNX.4.58.0310030850110.10930@hosting.rdsbv.ro> <20031003063411.GF15691@mail.shareable.org> <Pine.LNX.4.58.0310030945050.10930@hosting.rdsbv.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0310030945050.10930@hosting.rdsbv.ro>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Catalin BOIE wrote:
> > It's more likely, you want to use get_cpu()/put_cpu() to prevent the
> > current kernel thread from being pre-empted to a different CPU.
> get_cpu locks the thread on a CPU until put_cpu?

Yes, it disables preemption.
Taking any spinlock will do it too.

> > If you are intending to change idt on all CPUs, you'll need something
> > more complicated.
> 
> Hm. I realized that on a SMP it's a little hard to do it.
> How can I change that on all cpus?
> There is something to use that i can force my code to run on a specific
> cpu?

on_each_cpu() will call a function on each CPU.  Be careful that the
function is safe in the contexts in which it will be called.

If you just want to force you code to run on one cpu, that is
automatic if you are holding a spinlock (but then you can't schedule,
return to userspace etc.)

In general you can fix a task to a cpu using set_cpus_allowed().

-- Jamie
