Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263586AbTJCGxC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 02:53:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263701AbTJCGxC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 02:53:02 -0400
Received: from webhosting.rdsbv.ro ([213.157.185.164]:54476 "EHLO
	hosting.rdsbv.ro") by vger.kernel.org with ESMTP id S263586AbTJCGw7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 02:52:59 -0400
Date: Fri, 3 Oct 2003 09:52:58 +0300 (EEST)
From: Catalin BOIE <util@deuroconsult.ro>
X-X-Sender: util@hosting.rdsbv.ro
To: Jamie Lokier <jamie@shareable.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: idt change in a running kernel? what locking?
In-Reply-To: <20031003063411.GF15691@mail.shareable.org>
Message-ID: <Pine.LNX.4.58.0310030945050.10930@hosting.rdsbv.ro>
References: <Pine.LNX.4.58.0310030850110.10930@hosting.rdsbv.ro>
 <20031003063411.GF15691@mail.shareable.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Oct 2003, Jamie Lokier wrote:

> Catalin BOIE wrote:
> > What may happen if I modify idt on a running kernel?
> > It's lock_kernel enough?
>
> lock_kernel won't help at all.  It doesn't disable interrupts.
>
> It's more likely, you want to use get_cpu()/put_cpu() to prevent the
> current kernel thread from being pre-empted to a different CPU.
get_cpu locks the thread on a CPU until put_cpu?

> > Of course that the new location contain a valid idt table.
>
> If the new table has the same entries as the old one for all
> interrupts which are enabled it should be fine.  "lidt" is an atomic
> operation with respect to interrupts.
Great.

> If you are intending to change idt on all CPUs, you'll need something
> more complicated.

Hm. I realized that on a SMP it's a little hard to do it.
How can I change that on all cpus?
There is something to use that i can force my code to run on a specific
cpu?

>
> -- Jamie

Thank you very much, Jamie!

---
Catalin(ux) BOIE
catab@deuroconsult.ro
