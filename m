Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262638AbREZMY2>; Sat, 26 May 2001 08:24:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262647AbREZMYS>; Sat, 26 May 2001 08:24:18 -0400
Received: from [128.59.16.20] ([128.59.16.20]:12281 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id <S262642AbREZMYG>;
	Sat, 26 May 2001 08:24:06 -0400
Date: Sat, 26 May 2001 08:20:40 -0400 (EDT)
From: Hua Zhong <huaz@cs.columbia.edu>
To: Pavel Machek <pavel@suse.cz>
cc: Hua Zhong <huaz@cs.columbia.edu>, <linux-kernel@vger.kernel.org>
Subject: Re: CRAK: a process checkpoint/restart kernel module
In-Reply-To: <20010525234106.A4102@bug.ucw.cz>
Message-ID: <Pine.LNX.4.33.0105260645290.29935-100000@razor.cs.columbia.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 May 2001, Pavel Machek wrote:

> > Basically I took three steps to migrate a TCP  socket. Assuming A and B
> > are the two peers:
> >
> > 1. shutdown process A while keep B open
> > 2. restart A and re-establish the socket which points to B
> > 3 . change the socket on B to point to the new location of A
>
> This assumes both A and B are on same machine, right?

No.  They can be on different machines.  That's why it's called
"migration" :-)

> > The problem is, during this stage, if B sends packets to A before 3 is
> > complete, B's socket will get a RST. In the case of X, if you click or
> > move cursor on A's window when A is being migrated, it will crash.
>
> <EVIL SOLUTION>
> You might shutdown machine's networking between checkpoint and
> restart. That way, packets are silently lost, and there's no RST to be
> generated.
> </EVIL>

That's what virtual network interface could be used for.  Packets sent to
A can be queued or discarded, whatever, if we have the control at the
interface level.  Actually one PhD student in my department has been
working on it, and CRAK is just part of the project.

> I guess you can't checkpoint/restart when there's remote machine
> involved. I was not thinking online games, I was thinking about
> tuxracer (game on localhost).

localhost is much easier, but the same problem still exists.

> --
> I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
> Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
>

----------------------------------------------------------------
Hua Zhong

Central Research Facilities	Department of Computer Science
Columbia University		New York, NY 10027
Email: huaz@cs.columbia.edu	http://www.cs.columbia.edu/~huaz
----------------------------------------------------------------


