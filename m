Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317355AbSHZUAW>; Mon, 26 Aug 2002 16:00:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318225AbSHZUAW>; Mon, 26 Aug 2002 16:00:22 -0400
Received: from chaos.analogic.com ([204.178.40.224]:36480 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S317355AbSHZUAV>; Mon, 26 Aug 2002 16:00:21 -0400
Date: Mon, 26 Aug 2002 16:05:39 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: george anzinger <george@mvista.com>
cc: Aleksandar Kacanski <kacanski@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Memory leak
In-Reply-To: <3D6A8536.83B30C18@mvista.com>
Message-ID: <Pine.LNX.3.95.1020826155614.6481A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Aug 2002, george anzinger wrote:

> "Richard B. Johnson" wrote:
> > 
> > On Mon, 26 Aug 2002, Aleksandar Kacanski wrote:
> > 
> > > Hello,
> > > I am running 2.4.18-3 version of the kernel on smp dual
> > > processor and 1GB of RAM. My memory usage is increasing and
> > > I can't find what exactly is eating memory. Top and proc
> > > are reporting increases, but I would like to know of a
> > > better way of tracing usage of memory and possible leak in
> > > application(s).
> > >
> > > Please reply to kacanski@yahoo.com
> > > thanks                Sasha
> > >
> > >
> > 
> > Applications that use malloc() and friends, get more memory from
> > the kernel by resetting the break address. It's called "morecore()".
> > You can put a procedure, perhaps off SIGALRM, that periodically
> > checks the break address and writes it to a log. Applications
> > that end up with an ever-increasing break address have memory
> > leaks. Note that the break address is almost never set back.
> > This is not an error; malloc() assumes that if you used a lot
> > of memory once, you'll probably use it again. Check out sbrk()
> > and brk() in the man pages.
> 
> But this all comes back when the application ends.  You
> should be able to see the memory reappear when the app
> terminates.
> 

Not by looking at /proc/meminfo. The fact that Linux redistributes
buffers, etc., during normal operation has often been misconceived
as a memory leak. Linux will try to use all available memory. This
is because unused memory is wasted memory. When Linux first starts
up, there is little to do, and very little history, so it hasn't
gotten a chance to use much memory. If you run a few apps, compile
the kernel, etc., you get to use all the memory. Then when the
system is quiescent, often persons look at /proc/meminfo, note that
a lot of memory is being used, and declare that there must be some
kind of memory leak.

There just might be some kind of memory leak, but, you can't tell
it from looking at /proc/meminfo. You would need to instrument each
procedure that allocates memory and verify that all execution paths,
including exceptions, result in that memory being freed. This would
be a good project for one of the college students that is looking
to get his/her hands dirty. It's a lot more useful than 'inventing'
some new file-system that never gets used, etc.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
The US military has given us many words, FUBAR, SNAFU, now ENRON.
Yes, top management were graduates of West Point and Annapolis.

