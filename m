Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317279AbSGVNsZ>; Mon, 22 Jul 2002 09:48:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317354AbSGVNsY>; Mon, 22 Jul 2002 09:48:24 -0400
Received: from mx2.elte.hu ([157.181.151.9]:61663 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S317279AbSGVNrh>;
	Mon, 22 Jul 2002 09:47:37 -0400
Date: Mon, 22 Jul 2002 15:49:39 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Christoph Hellwig <hch@lst.de>
Cc: Russell King <rmk@arm.linux.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>, Robert Love <rml@tech9.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch] cli()/sti() cleanup, 2.5.27-A2
In-Reply-To: <20020722154315.A18998@lst.de>
Message-ID: <Pine.LNX.4.44.0207221544090.9136-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 22 Jul 2002, Christoph Hellwig wrote:

> yupp, you're right.  could you take the prototype changes anyway?

i'm hesitant for a number of reasons. Eg. irq_save_off(flags) has to be a
macro, otherwise we move the assignment into the irqs-off section.  
Compare:

	flags = irq_save_off();

with:
	irq_flags_off(flags);

sure, it could be written as:

	flags = irq_save();
	irq_off();

but then again the macro form is more compact.

	Ingo


