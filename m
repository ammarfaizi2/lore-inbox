Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272818AbRJHQFg>; Mon, 8 Oct 2001 12:05:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276977AbRJHQF1>; Mon, 8 Oct 2001 12:05:27 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:27406 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S272818AbRJHQFP>; Mon, 8 Oct 2001 12:05:15 -0400
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
To: hadi@cyberus.ca (jamal)
Date: Mon, 8 Oct 2001 17:11:03 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        jgarzik@mandrakesoft.com (Jeff Garzik),
        andrea@suse.de (Andrea Arcangeli), mingo@elte.hu (Ingo Molnar),
        linux-kernel@vger.kernel.org (Linux-Kernel), netdev@oss.sgi.com,
        torvalds@transmeta.com (Linus Torvalds)
In-Reply-To: <Pine.GSO.4.30.0110081146050.5473-100000@shell.cyberus.ca> from "jamal" at Oct 08, 2001 11:57:11 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15qczg-00011N-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Agreed if you add the polling cardbus bit.
> Note polling cardbus would require more changes than the above.

I don't think it does. There are two pieces to the problem

	a)	Not dying horribly
	b)	Handling it elegantly

b) is driver specific (NAPI etc) and I think well understood to the point
its being used already for performance reasons

a) is as simple as 

	if(stuck_in_irq(foo) && irq_shared(foo))
	{
		disable_real_irq(foo);
		timer_fake_irq_foo();
	}

We know spoofing a shared irq is safe.

Alan
