Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261185AbVE2Lir@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261185AbVE2Lir (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 07:38:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261196AbVE2Lir
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 07:38:47 -0400
Received: from smtp.andrew.cmu.edu ([128.2.10.81]:37036 "EHLO
	smtp.andrew.cmu.edu") by vger.kernel.org with ESMTP id S261185AbVE2Lio
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 07:38:44 -0400
Message-ID: <4299A98D.1080805@andrew.cmu.edu>
Date: Sun, 29 May 2005 07:37:49 -0400
From: James Bruce <bruce@andrew.cmu.edu>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: "Bill Huey (hui)" <bhuey@lnxw.com>, Andi Kleen <ak@muc.de>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>,
       Ingo Molnar <mingo@elte.hu>, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
References: <m1br6zxm1b.fsf@muc.de> <1117044019.5840.32.camel@sdietrich-xp.vilm.net> <20050526193230.GY86087@muc.de> <1117138270.1583.44.camel@sdietrich-xp.vilm.net> <20050526202747.GB86087@muc.de> <4296ADE9.50805@yahoo.com.au> <20050527120812.GA375@nietzsche.lynx.com> <429715DE.6030008@yahoo.com.au> <20050527233645.GA2283@nietzsche.lynx.com> <4297EB57.5090902@yahoo.com.au> <20050528054503.GA2958@nietzsche.lynx.com> <42981467.6020409@yahoo.com.au>
In-Reply-To: <42981467.6020409@yahoo.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> But nobody has been able to say why a single kernel is better than a
> nanokernel.

I think it's a bit more like you haven't realized the answer when people 
gave it, so let me try to be more clear.  It's purely a matter of effort 
- in general it's far easier to write one process than two communicating 
processes.  As far as APIs, with a single-kernel approach, an RT 
programmer just has to restrict the program to calling APIs known to be 
RT-safe (compare with MT-safe programming).  In a split-kernel approach, 
the programmer has to write RT-kernel support for the APIs he wants to 
use (or beg for them to be written).  Most programmers would much rather 
limit API usage than implement new kernel support themselves.

A very common RT app pattern is to do a bunch of non-RT stuff, then 
enter an RT loop.  For an example from my work, a robot control program 
starts by reading a bunch of configuration files before it starts doing 
anything requiring deadlines, then enters the RT control loop.  Having 
to read all the configuration in a separate program and then marshall 
the data over to an RT-only process via file descriptors is quite a bit 
more effort.  I guess some free RT-nanokernels might/could support 
non-RT to RT process migration, or better messaging, but there's 
additional programming effort (and overhead) that wasn't there before. 
In general an app may enter and exit RT sections several times, which 
really makes a split-kernel approach less than ideal.

An easy way to visualize the difference in programming effort for the 
two approaches is to take your favorite threaded program and turn it 
into one with separate processes that only communicate via pipes.  You 
can *always* do this, its just very much more painful to develop and 
maintain.  Your stance of "nobody can prove why a split-kernel won't 
work" is equivalent to saying "we don't ever really need threads, since 
processes suffice".  That's true, but only in the same way that I don't 
need a compilier or a pre-existing operating system to write an application.

  - Jim Bruce
