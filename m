Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281691AbRKUKSg>; Wed, 21 Nov 2001 05:18:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281565AbRKUKS1>; Wed, 21 Nov 2001 05:18:27 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:10256 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S281563AbRKUKST>; Wed, 21 Nov 2001 05:18:19 -0500
Message-ID: <3BFB7F2E.D45CB95C@idb.hist.no>
Date: Wed, 21 Nov 2001 11:17:18 +0100
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.4.15-pre7 i686)
X-Accept-Language: no, en
MIME-Version: 1.0
To: Nick LeRoy <nleroy@cs.wisc.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: Swap
In-Reply-To: <Pine.LNX.3.95.1011120123312.8047A-100000@chaos.analogic.com> <200111201815.fAKIFat31613@schroeder.cs.wisc.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick LeRoy wrote:

> > Alan explained a few years ago that NFS was "stateless". Nevertheless
> > it is still a bug.
> 
> Correct me if I'm wrong, but I think that it's more a bug in the NFS protocol
> than in the Linux (or Solaris, etc) NFS implementation.  The problem is that
> NFS itself just doesn't pass that information along.  The NFS server has no
> idea that the 'text' file is being executed, so it doesn't know that it
> should "return" ETXTBSY.
> 
> Now, this might be different in NFS v3, but I'm pretty sure that this applies
> for v2, at least.

Consider the above mentioned statelessness.  You can't get what you
want as long as you want a stateless server - it is simply impossible.

Your client can be tweaked so that you can't write via NFS to a
file executing on the same host - but nothing can prevent another
client from writing to that file - because the server is stateless.

A stateless server means it don't actually know if a file is
opened by anyone.  The good part of this is that the server
may crash and reboot, and the client will only see a delay.
Open files will still work as soon as the server comes back up.
No state were lost in the crash - because there were no
state at all.  But then you can't block writes because
you don't know that someone is executing the file.

It is not a design bug - it is a design tradeoff.  A stateful
server might work if you have years of uptime or at least
no unplanned downtime.  But such implementations tend to force
clients to remount if the server ever go down.  That may
be really annoying if you're accessing lots of servers.

Helge Hafting
