Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262518AbSJAVGl>; Tue, 1 Oct 2002 17:06:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262514AbSJAVGk>; Tue, 1 Oct 2002 17:06:40 -0400
Received: from mx1.elte.hu ([157.181.1.137]:28617 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S262518AbSJAVGh>;
	Tue, 1 Oct 2002 17:06:37 -0400
Date: Tue, 1 Oct 2002 23:21:53 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Workqueue Abstraction, 2.5.40-H7
In-Reply-To: <Pine.LNX.4.33.0210011345260.1372-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.44.0210012300001.23315-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 1 Oct 2002, Linus Torvalds wrote:

> > Despite all the previous fuss about the problems of typedefs, i've never
> > had *any* problem with using typedefs in various code i wrote.
> 
> Big things should have big names. That's why "u8" is u8, because it's
> not just physically small, it also has very little semantics associated
> with it.
> 
> I want those variable declarations to stand out, and make people
> understand that this is not just a variable, it's a structure, and it
> may be taking up a noticeable amount of space on the stack, for example.

then lets at least have 'struct work' and 'struct work_queue' instead of
'struct work_struct', 'struct work_queue_struct'. "struct work" is already
twice as large as "work_t".

[ and eg. for 'struct list_head' i dont think the struct discrimination is
justified: the type takes up 8 bytes, twice as much as 'int', but the name
takes up 4 times as much space :-) ]

i dont think i've encountered much kernel code that tried to pass
structures along by value without a good reason - OTOH complex and
inefficient function interfaces outweigh these instances, by far. And
there's way too much code that has two screens full of local variable
declarations, where in the middle a 3K big array gets easily lost to the
eye. struct pre and postfix does not help much there.

And structure pointers are almost as simple to pass around and handle as
the basic types declared on the stack - and that is their main use. Ease
of understanding is i think by far the most important aspect of source
code - abuse and mistaken use of constructs is always possible, no matter
how long the name is.

and yet another thing - good complex structures are the ones that have not
only a compact name and compact usage, but also a compact meaning. Eg. the
work struct carries the following meaning: "call ->func(data) in process
context, at time X.". And intuition calls for a compact name for something
as compact as 'struct list_head'. For the case of task_t it's a different
matter - but nobody tries to use task_t not as a pointer anyway. Is there
really a category of structures that are commonly abused and put on the
stack, which would not happen that frequently via the 'struct *_struct'
convention?

	Ingo

