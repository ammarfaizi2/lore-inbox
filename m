Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262691AbVDYRvn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262691AbVDYRvn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 13:51:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262668AbVDYRvn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 13:51:43 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:48305 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S262666AbVDYRvj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 13:51:39 -0400
Message-Id: <200504251751.j3PHpE7T004422@laptop11.inf.utfsm.cl>
To: Matthias-Christian Ott <matthias.christian@tiscali.de>
cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH GIT 0.6] make use of register variables & size_t 
In-Reply-To: Message from Matthias-Christian Ott <matthias.christian@tiscali.de> 
   of "Mon, 25 Apr 2005 13:18:09 +0200." <426CD1F1.2010101@tiscali.de> 
Date: Mon, 25 Apr 2005 13:51:14 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.21.155]); Mon, 25 Apr 2005 13:50:05 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias-Christian Ott <matthias.christian@tiscali.de> said:
> [Proposed patch adding "register" snipped]

Somebody a long while ago told me there are 3 kinds of C compilers with
respect "register": Dumb ones (they don't even consider it, just do
business as usual, as they don't know any better), normal ones (they
consider "register" and honor it if they can), and bright ones (they don't
even consider it, as they do a much better job using registers than any
programmer could direct them to by wiring a value into a register). GCC
definitely falls on the brighter side, at least if you tell it to
optimize. I think "register" should be marked deprecated in C (and there
are few good texts that even mention the word today, so it is deprecated in
practice).

Better compare the code produced (with -S instead of -c you'll get
assembler output in .s, not object code in .o) before any optimization
proposal. But also consider that large real gains come from higher-level
changes (better data structures, more efficient algorithms) and not from
low-level changes (In any case, today's compilers are usually smart enough
to make low-level changes on their own, so you can (thankfully) concentrate
on writing clear, correct code; and let the compiler make it fast. Sure,
where it is in a stretch of hot code, executed hundereds of times a second
on millions of machines worldwide, extra loving care is warranted, but that
is another kettle of fish.).
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
