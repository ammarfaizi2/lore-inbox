Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270787AbRIBMnQ>; Sun, 2 Sep 2001 08:43:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271612AbRIBMnG>; Sun, 2 Sep 2001 08:43:06 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:42247 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S270787AbRIBMmu>; Sun, 2 Sep 2001 08:42:50 -0400
Subject: Re: buffer_head slab memory leak, Linux bug?
To: eli7@cs.huji.ac.il
Date: Sun, 2 Sep 2001 13:46:13 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010902140126.E28228@checkpoint.com> from "Elisheva Alexander" at Sep 02, 2001 02:01:26 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15dWdh-00080u-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> on an SMP machine i get:
> "stuck on TLB IPI wait (CPU#1)"
> the driver that i am debugging uses a spin lock, and sometimes we take the
> lock for a pretty long time.

Basically you can't hold a spinlock too long or the kernel wil conclude the
other processor has hung. Anything which is going to take a spinlock long
enough to trigger that event is so non-scalable its not funny

It could also be that you have a locking error and are leaving the lock
held in some obscure case - and genuinely deadlocking the box.


> this happens during heavy load, which is why i think that the problem
> is that in smp_flush_tlb() in ./arch/i386/kernel/smp.c, one of the CPUs gets 
> all upset that the other CPU is stuck in the lock for too long, and releases 
> it before it was ment to be released.

Probably

Alan
