Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130355AbRAKN0d>; Thu, 11 Jan 2001 08:26:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131993AbRAKN0Y>; Thu, 11 Jan 2001 08:26:24 -0500
Received: from [172.16.18.67] ([172.16.18.67]:1153 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S130614AbRAKN0R>; Thu, 11 Jan 2001 08:26:17 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <17071.979217174@ocs3.ocs-net> 
In-Reply-To: <17071.979217174@ocs3.ocs-net> 
To: Keith Owens <kaos@ocs.com.au>
Cc: List Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Where did vm_operations_struct->unmap in 2.4.0 go? 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 11 Jan 2001 13:25:53 +0000
Message-ID: <17460.979219553@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



kaos@ocs.com.au said:
> So you want two services, one static for code that does not do any
> initialisation and one dynamic for code that does do initialisation.
> Can you imagine the fun when somebody adds startup code to a routine
> that was using static registration? 

Oh come on. If you change a module from being 'self-contained' and 
registered at compile time to requiring initialisation it's hardly 
unreasonable to expect you switch the registration too.

Besides, I'm not going to allow any link order dependencies into code I
maintain without them being impossible to avoid - and if anyone's thought
about the problem hard enough to convince me to accept such a change,
they'll have noticed the need to change the registration.

> Oh dear, I added init code so I have to remember to change from static 
> to dynamic registration, and that affects the link order so now I have 
> to tweak the Makefile.

cf. "Oh dear, I added init code but put it _after_ the registration instead
of before, so stuff blows up."

Neither of these two programmers will get their code into anything I 
maintain.

cf. "Oh dear, I need registration, but I have to remember that
inter_module_xxx can't do static registration so now I have to tweak the
Makefile."

kaos@ocs.com.au said:
> Stick to one method that works for all routines, dynamic registration.

It doesn't work for all routines. It introduces unnecessary brokenness - 
link order dependencies - where previously there were none.

> If that imposes the occasional need for a couple of extra calls in
> some routines and for people to think about initialisation order right
> from the start then so be it, it is a small price to pay for long term
> stability and ease of maintenance.

I'm thinking about link order. If I _wasn't_ thinking about link order, 
then I'd just put the lines in the 'right' order in the Makefile and put up 
with it. But I'm thinking about it, and I object to it. It is absolutely 
unnecessary in this case.

As far as I'm concerned, fixing the registration problems introduced by the
dynamic inter_module_register is a small price to pay for long term
stability and ease of maintenance :)

--
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
