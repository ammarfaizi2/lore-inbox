Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265637AbSL3BZG>; Sun, 29 Dec 2002 20:25:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265806AbSL3BZG>; Sun, 29 Dec 2002 20:25:06 -0500
Received: from almesberger.net ([63.105.73.239]:37904 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S265637AbSL3BZF>; Sun, 29 Dec 2002 20:25:05 -0500
Date: Sun, 29 Dec 2002 22:32:47 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Rik van Riel <riel@conectiva.com.br>,
       Anomalous Force <anomalous_force@yahoo.com>, ebiederm@xmission.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: holy grail
Message-ID: <20021229223247.C1363@almesberger.net>
References: <20021228163517.66372.qmail@web13207.mail.yahoo.com> <Pine.LNX.4.50L.0212281842020.26879-100000@imladris.surriel.com> <1041210304.1172.16.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1041210304.1172.16.camel@irongate.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Mon, Dec 30, 2002 at 01:05:04AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> If you care about uptime to the point of live kernel updates

Yes, but there are more applications than improving overall uptime.
E.g. during development or other testing, it would be convenient to
be able to switch back and forth between distinct kernels, without
necessarily taking down the entire machine. Likewise for trivial
hardware changes.

Also, I don't think the instrumentation required would be all that
horrible: things can be done incrementally, and I'd expect a lot
of the functionality to be useful for other purposes, too.

I see a certain trend towards mechanisms that can be useful for
process migration. E.g. the address space manipulations discussed
for UML seem to allow almost perfect reconstruction of processes.
PIDs, signals, anything with externally visible changes in kernel
state that aren't immediately seen by the application (networking,
tty editing, etc.), and such, would need extra instrumentation, of
course.

With this in place, we'd need a set of mechanisms that allow to
find out what the process state actually is like, e.g. determining
what hangs off a certain fd, and what its state is. A lot of this
is already available via /proc, so that may be a starting point.
Programs that talk directly to hardware (e.g. X11) would need a
bit more work.

Then add a bit of synchronization, and we can migrate individual
processes. Add more synchronization, and we can migrate full user
space. Add some really fast disks, and this will be quick enough
for "on the fly" kernel swapping. Add a means for preserving user
memory and swap, and you may not even need fast disks.

Uh, sounds almost too easy ;-)

Of course, as a first step, it would make sense to have a good
look at what projects like (open)Mosix have already done in this
area. After all, they've already solved most aspects of process
migration.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
