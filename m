Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130884AbQL2VxI>; Fri, 29 Dec 2000 16:53:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132450AbQL2Vw6>; Fri, 29 Dec 2000 16:52:58 -0500
Received: from squeaker.ratbox.org ([63.216.218.7]:38346 "HELO
	squeaker.ratbox.org") by vger.kernel.org with SMTP
	id <S132422AbQL2Vw4>; Fri, 29 Dec 2000 16:52:56 -0500
Date: Fri, 29 Dec 2000 16:23:28 -0500 (EST)
From: Aaron Sethman <androsyn@ratbox.org>
To: "Daniel R. Kegel" <dank@alumni.caltech.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux 2.2.19pre and thttpd (VM-global problem?)
In-Reply-To: <200012291638.IAA28137@alumnus.caltech.edu>
Message-ID: <Pine.LNX.4.21.0012291620060.16773-100000@squeaker.ratbox.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Dec 2000, Daniel R. Kegel wrote:

> Andrea Arcangeli wrote:
> > Petru Paler wrote: 
> > > This is one of the main thttpd design points: run in a select() loop. Since 
> > > it is intended for mainly static workloads, it performs quite well... 
> > 
> > It can't scale in SMP. 
> 
> thttpd is i/o bound, not CPU bound, so there's no need for SMP scaling.
> It's an effective little server as long as the active document
> tree fits in RAM.  
> 
> If it ain't broke, don't tell people how to fix it :-)
> 
> (If for some reason SMP scaling was desirable, the thttpd
> way to do it would be to introduce one thread for each
> CPU, and have each thread run the same select() loop.)

One could possibly cheat and use fork() instead of using threads. 
Do your listen() before forking..then both get the listener socket..
Threads aren't always the answer, in this case it wouldn't probably gain
you anything over just doing a fork() on SMP. Especially if you got not 
good reason to be sharing data that closely, which I don't think thttpd
would.

Aaron

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
