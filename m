Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266094AbSLCF6I>; Tue, 3 Dec 2002 00:58:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266095AbSLCF6I>; Tue, 3 Dec 2002 00:58:08 -0500
Received: from samar.sasken.com ([164.164.56.2]:6096 "EHLO samar.sasken.com")
	by vger.kernel.org with ESMTP id <S266094AbSLCF6H>;
	Tue, 3 Dec 2002 00:58:07 -0500
Date: Tue, 3 Dec 2002 11:35:23 +0530 (IST)
From: Madhavi <madhavis@sasken.com>
To: <linux-kernel@vger.kernel.org>
Subject: in_irq()
Message-ID: <Pine.LNX.4.33.0212031122460.2995-100000@pcz-madhavis.sasken.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi

I am using a UP system with CONFIG_SMP=y in .config with linux 2.4.19
kernel.

I have this piece of code:

	spin_lock_irqsave(&some_lock, flags);
	in_irq();
	spin_unlock_irqrestore(&some_lock, flags);

I have read somewhere (I think its given in the Unreliable Guide to
kernel locking) that in_irq() returns true when the interrupts
are blocked. So, I was expecting in_irq() to return true here. But, it is
returning 0 here.

I have gone through the code and it seems that the __local_irq_count is
getting incremented only in irq_enter(). So, the behavior I am getting
seems to be correct.

##  Could someone tell me which is the correct behavior of in_irq()?

##  I have one more doubt. If I have a thread in which I do
spin_lock_irqsave(&some_lock, flags), can I expect the main kernel thread
also not to service any interrupts? I am getting replies to ping packets
when the thread is doing spin_lock_irqsave(), which means that all
hardware interrupts are not blocked. How can I block all hardware
interrupts?

Thanks in advance.

regards
Madhavi.

