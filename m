Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318217AbSHMQOq>; Tue, 13 Aug 2002 12:14:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318215AbSHMQOq>; Tue, 13 Aug 2002 12:14:46 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:6662 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318213AbSHMQOn>; Tue, 13 Aug 2002 12:14:43 -0400
Date: Tue, 13 Aug 2002 09:20:49 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Christoph Hellwig <hch@infradead.org>
cc: Ingo Molnar <mingo@elte.hu>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] clone_startup(), 2.5.31-A0
In-Reply-To: <20020813170522.A12224@infradead.org>
Message-ID: <Pine.LNX.4.44.0208130916280.7291-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 13 Aug 2002, Christoph Hellwig wrote:
> > This one definitely isn't a pthread-specific problem. The old UNIX fork()  
> > semantics for <pid> returning really are fairly broken, since the notion
> > of returning the pid in a local register is inherently racy for _anything_
> > that wants to maintain a list of its children and needs to access the list 
> > in the SIGCHLD handler.
> 
> The TLS setting makes it pretty pthread-specific, though (or at least
> thread-specific).

That's certainly true, and potentially worth a clone() flag of its own, 
quite independently of the startup thing ("CLONE_SETTLS").

Ingo, how about breaking it down that way? 

>	  Also the fn parameter makes it very different from
> both clone and fork. 

The fn thing is a purely user-mode effect, it's not there in the system 
call. Which is true of a regular clone() too.

> What about spawn() if you dislike a thread in the name?

spawn() to me implies doing the equivalent of "vfork()+execve()", the way
most non-UNIX OS's do new process creation.

I don't dislike the "thread" name too much, but I want this to be generic, 
and seen as such. The same way the original clone() was a proper superset 
of fork(), this needs to be a proper superset, not just in name, but in 
_usage_. If it's useful for only one thing, that's not good.

			Linus

