Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261408AbTHaMyU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 08:54:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261406AbTHaMyT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 08:54:19 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:7948 "HELO
	127.0.0.1") by vger.kernel.org with SMTP id S261408AbTHaMyN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 08:54:13 -0400
Content-Type: text/plain; charset=US-ASCII
From: insecure <insecure@mail.od.ua>
Reply-To: insecure@mail.od.ua
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Subject: Re: [2.4] gcc3 warns about type-punned pointers ?
Date: Sun, 31 Aug 2003 02:27:25 +0300
X-Mailer: KMail [version 1.4]
Cc: "J.A. Magallon" <jamagallon@able.es>,
       Lista Linux-Kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0308301427320.3338-100000@artax.karlin.mff.cuni.cz>
In-Reply-To: <Pine.LNX.4.44.0308301427320.3338-100000@artax.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200308310227.25926.insecure@mail.od.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > static inline void __set_64bit (unsigned long long * ptr,
> >                 unsigned int low, unsigned int high)
> > {
> >         __asm__ __volatile__ (
> >                 "\n1:\t"
> >                 "movl (%0), %%eax\n\t"
> >                 "movl 4(%0), %%edx\n\t"
> >                 "lock cmpxchg8b (%0)\n\t"
> >                 "jnz 1b"
> >
> >                 : /* no outputs */
> >                 :       "D"(ptr),
> >
> >                         "b"(low),
> >                         "c"(high)
> >
> >                 :       "ax","dx","memory");
> >
> > }
> >
> > This will execute expensive locked load-compare-store operation twice
> > almost always (unless previous value was already equal
> > to the value we are about to store)
>
> It doesn't double store. cmpxchg8b does:
> compare memory with edx:eax
> 	if equal, copy copy ecx:ebx into memory, set zf = 1
> 	else copy memory into edx:eax, set zf = 0
>
> > AFAIK we can safely drop that loop (jnz instruction)
>
> No. The only possible optimization would be to move 1: label directly at
> cmpxgch8b. But it won't bring much, because loop is executed only if value
> was changed after read and before cmpxchg.

You are right, I misremembered how cmpxchg8b works.
-- 
vda
