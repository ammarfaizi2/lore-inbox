Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275859AbRJBJLQ>; Tue, 2 Oct 2001 05:11:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275963AbRJBJLG>; Tue, 2 Oct 2001 05:11:06 -0400
Received: from artemis.rus.uni-stuttgart.de ([129.69.1.28]:49822 "EHLO
	artemis.rus.uni-stuttgart.de") by vger.kernel.org with ESMTP
	id <S275859AbRJBJKw>; Tue, 2 Oct 2001 05:10:52 -0400
Date: Tue, 2 Oct 2001 11:16:12 +0200 (MEST)
From: Erich Focht <focht@ess.nec.de>
Reply-To: efocht@ess.nec.de
To: Manfred Spraul <manfred@colorfullife.com>
cc: linux-kernel@vger.kernel.org, linux-ia64@linuxia64.org
Subject: Re: deadlock in crashed multithreaded job
In-Reply-To: <3BB8C2E4.D6B0581C@colorfullife.com>
Message-ID: <Pine.LNX.4.21.0110021052430.26281-100000@sx6.ess.nec.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Oct 2001, Manfred Spraul wrote:

> > The symptoms: running the tests (make check) sometimes ends up
> > with hanging processes.
> 
> Does it _only_ hang during coredumping, or also during normal usage?
> 
> Could you remove
> 	down_read(&mmap_sem);
> 	binfmt->coredump();
> 	up_read(&mmap_sem);
> from fs/exec.c and rerun your tests?

Setting the coredumpsize limit to 0 already solves the problem.

The question that remains is how to deal with nested locks on the same
resource that can lead to deadlocks. Is there any (un)written rule that
one should avoid them in the Linux Kernel? Or are there any approaches to
deal with them (which are not yet included in the Kernel)?

> The hang during coredumping is known, there are 2 fixes [I have one, not
> yet released, Andrea wrote one, IIRC included in his -aa kernels].

Do these solutions deal only with the coredump problem or with nested
critical sections?

Thanks,
Erich

