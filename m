Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279922AbRKFSNQ>; Tue, 6 Nov 2001 13:13:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279925AbRKFSNG>; Tue, 6 Nov 2001 13:13:06 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:14603 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S279922AbRKFSMp>; Tue, 6 Nov 2001 13:12:45 -0500
Subject: Re: Using %cr2 to reference "current"
To: torvalds@transmeta.com (Linus Torvalds)
Date: Tue, 6 Nov 2001 18:19:46 +0000 (GMT)
Cc: bcrl@redhat.com (Benjamin LaHaise), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0111060918380.2194-100000@penguin.transmeta.com> from "Linus Torvalds" at Nov 06, 2001 09:49:15 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E161Ap8-0001Gf-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> That said, how expensive is loading %cr2 anyway? We can do all the same
> tricks with a 16kB stack and just playing games with using the higher bits
> as the "offset", ie things like

So thats another 600K on my box vanished. I suspect the page faults will
outweigh it

> the stack larger (we steal 2kB for the coloring, but we'd use an order-2
> allocation that at least SGI wants to do regardless).

16K stack is serious "people who cant program" country.

> I would not be surprised if "mov %cr2,%reg" will break a netburst trace
> cache entity, or even cause microcode to be executed. While I _guarantee_
> that all future Intel CPU's will continue to be fast at mixtures of simple
> arithmetic operations like "add" and "and".

True enough, but then we can go to

	andl %%esp, %0
	movl (%%eax), %%eax

which doesnt really change the cost much, lets us colour the task structs
nicely, and lets us colour the stack somewhat by offseting esp from the base
- and all in standard instructions

Alan




