Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311212AbSCSNqJ>; Tue, 19 Mar 2002 08:46:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311213AbSCSNp7>; Tue, 19 Mar 2002 08:45:59 -0500
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:874 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S311212AbSCSNpp>; Tue, 19 Mar 2002 08:45:45 -0500
Date: Tue, 19 Mar 2002 07:45:15 -0600 (CST)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200203191345.HAA74864@tomcat.admin.navo.hpc.mil>
To: pavel@suse.cz, Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: VFS mediator?
Cc: Alexander Viro <viro@math.psu.edu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Simon Richter <Simon.Richter@phobos.fachschaften.tu-muenchen.de>,
        Jonathan Barker <jbarker@ebi.ac.uk>, linux-kernel@vger.kernel.org
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@suse.cz>:
> Hi!
> 
> >      > Okay, take userland nfs-server. (This thread was about userland
> >      > filesystems).
> > 
> > Yech... Nobody should be seriously considering using unfsd: it does
> > not even manage to follow the NFS protocol. That inability was one of
> > the many reasons why Olaf Kirch abandoned further develpement of unfsd
> > and started work on knfsd.
> > 
> >      > Then, make memory full of dirty pages. Imagine that nfs-server
> >      > is swapped-out by some bad luck. What you have is extremely
> >      > nasty deadlock, AFAICS. [To free memory you have to write out
> >      > dirty data, but you can't do that because you don't have enough
> >      > memory for nfs-server].
> > 
> > So that is another argument for using knfsd rather than unfsd. I will
> > agree with you that NFS is not perfect, but please judge it on its
> > actual merits and not on some trumped up charge...
> 
> Sorry, this thread was about userland filesystems, and NFS is just not
> usefull there (for read/write case).

Assuming, of course, that the daemon doesn't mprotect itself...

A user mode file system is really only good at debugging a design.

All file migration style filesystems, and user mode filesystems, have this
same problem on paging based systems:

Can't write buffer until file is migrated (file system full),
Can't migrate file until buffer memory is freed....
system hung...

Although it is usually possible to detect this deadlock and abort some
process, freeing memory (and sometimes disk space at the same time).

Swapping systems can have the equivalent problem if swap space is
oversubscribed.

The problem boils down to the same solution - don't oversubscribe memory...

I know this is a bit of a troll, but memory controls are necessary to
detect, avoid, or repair the situation.
-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
