Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262683AbUAIQct (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 11:32:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262758AbUAIQcq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 11:32:46 -0500
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:17539
	"EHLO animx.eu.org") by vger.kernel.org with ESMTP id S262683AbUAIQcf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 11:32:35 -0500
Date: Fri, 9 Jan 2004 11:45:19 -0500
From: Wakko Warner <wakko@animx.eu.org>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Strange lockup with 2.6.0
Message-ID: <20040109114519.A7074@animx.eu.org>
References: <20040109104955.B6840@animx.eu.org> <Pine.LNX.4.44.0401091653340.19686-100000@poirot.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <Pine.LNX.4.44.0401091653340.19686-100000@poirot.grange>; from Guennadi Liakhovetski on Fri, Jan 09, 2004 at 05:02:02PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > I usually do a backup of each filesystem simply using tar.  I attempted to
> > > > backup a machine I had that's running 2.6.0 and it hard locked.
> > >
> > > Are sysrq-keys enabled? If so, could you catch the tar backtrace during
> > > the lock-up (ALT-SysRq-t)? What was the latest kernel-version that worked?
> >
> > Yes, but the machine hard locks.  sysrq does not work.  I have a small
> 
> __THAT__ hard...:-)

Yup.  That hard.

> > utility I wrote that will set the state of the parport (I used this to tell
> > if it locks up) using outb to the port (This does not effect it in anyway,
> > it will lockup w/o it running)
> 
> You mean it just toggles a bit periodically?

I have a set of LEDs attached to the parport (12) and this program writes to
it in a way that makes it bounce the 'on' led every .25 seconds  I'll send
you the program if you're interested.

> > > Can you just try to write some data over NFS? Would it lock if you write 1
> >
> > I am constantly accessing NFS with this machine.  Read and write.  It was
> 
> How much data at one go (max)?

Dunno.  I've never given   it that much thought.  I have the completed
backup on the jaz.  I can attempt to dump it to the server to see if that
makes a difference.

> > only when I backed it up with tar.  In the event it doesn't lock, tar
> > crashes w/o error/warning (over NFS).
> 
> So, it locks not always?

Most of the time, yes it does.  I'd say 90% of the time it hard locks.  If
it doesn't and I attempt it again it always hard locks (except one time I
did it).  I've done the tests numberous times.

> > > byte or 1K or 1M? Does it lock immediately as you start the backup or
> >
> > It locks up usually at one point, but not always.
> 
> Since you could backup to Jazz, looks like your filesystem is ok, NFS also
> works in principle...

Before one test, I did: cp /dev/sda /dev/null
to see if it has any problems with the disk.  It was fine.

> > > after some time (you could start some process in the background
> > > periodically printing some info on the terminal, like vmstat, cat
> > > /proc/interrupts, free, tcpdump on both ends to a file...) Can you try NFS
> >
> > I can do this I think.  It's fun when running with init being bash.  It will
> > take some time to do since I can't scroll backwards.
> 
> You could also attach a serial console and direct the output there (then
> you also can scroll).

I thought about this.  Hopefully compiling in serial doesn't add another
variable to this.  I currently have serial compiled as a module.

> > > over TCP? Are other machines, where backup works, also running 2.6,
> >
> > I can try TCP, but I'm not sure about the server accepting TCP (was there a
> > compile time option for NFSD to use TCP?)  These 2 machines are the only
> 
> Yes.

I did not compile the server with TCP support.

> > ones I have on 2.6.
> >
> > > 10/100mbps?
> >
> > 100 FD always.
> 
> Why I am interested in your experiences is that I also have a problem
> transferring large (several M) files over NFS when the server is 2.6 and
> both ends have 100 FD. (You can see my posts this week about 2.6 NFS.) And
> in my case it TCP fixed it. But I never had hard-locks, just cp hanged in
> D, and tcpdump showed timed out reassembly on the receiving side. But I
> was reading from the server.

That's interesting.  I hope it doesn't matter if the server is a diskless
machine.  Interesting you mention the server being 2.6.  The NFS I did above
was to a different (also diskless) server.  The 2.6 one I threw a hard disk
on so I could do backups of all my machines (and w/o shutting another down). 
Out of the 5 machines on this network, only 2 have usable IDE ports (one has
none, one's a laptop, one is full of cdroms which is the machine that's
hanging on me)

On a side note, I have a 2.4.x (x>=20) using knfsd and nohide on directories.
A 2.4.x client can see those contents, a 2.6.x client can't w/o mounting each
individually.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
