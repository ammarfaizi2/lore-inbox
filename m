Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262185AbTEENXA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 09:23:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262189AbTEENXA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 09:23:00 -0400
Received: from 34.mufa.noln.chcgil24.dsl.att.net ([12.100.181.34]:65518 "EHLO
	tabby.cats.internal") by vger.kernel.org with ESMTP id S262185AbTEENW7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 09:22:59 -0400
Content-Type: text/plain; charset=US-ASCII
From: Jesse Pollard <jesse@cats-chateau.net>
To: "Calin A. Culianu" <calin@ajvar.org>, <Valdis.Kletnieks@vt.edu>
Subject: Re: [Announcement] "Exec Shield", new Linux security feature
Date: Mon, 5 May 2003 08:35:02 -0500
X-Mailer: KMail [version 1.2]
Cc: <linux@horizon.com>, <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.33L2.0305040301001.6490-100000@rtlab.med.cornell.edu>
In-Reply-To: <Pine.LNX.4.33L2.0305040301001.6490-100000@rtlab.med.cornell.edu>
MIME-Version: 1.0
Message-Id: <03050508350200.01029@tabby>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 04 May 2003 02:03, Calin A. Culianu wrote:
> On Sat, 3 May 2003 Valdis.Kletnieks@vt.edu wrote:
> > On Sat, 03 May 2003 13:19:52 -0000, linux@horizon.com  said:
> > > An interesting question arises: is the number of useful interpreter
> > > functions (system, popen, exec*) sufficiently low that they could be
> > > removed from libc.so entirely and only staticly linked, so processes
> > > that didn't use them wouldn't even have them in their address space,
> > > and ones that did would have them at less predictible addresses?
> > >
> > > Right now, I'm thinking only of functions that end up calling execve();
> > > are there any other sufficiently powerful interpreters hiding in common
> > > system libraries?  regexec()?
> >
> > This does absolutely nothing to stop an exploit from providing its own
> > inline version of execve().  There's nothing in libc that a process can't
> > do itself, inline.
> >
> > A better bet is using an LSM module that prohibits exec() calls from any
> > unauthorized combinations of running program/user/etc.
>
> Is that practical?  I can see how with some daemons it would definitely be
> useful to prohibit exec calls (maybe things like BIND don't need to exec
> anything).. but some daemons do need to exec.  An SMTPD may need to exec()
> some helper processes (postfix for instance has a whole slew of helper
> programs it uses).. and things like sshd need to exec a shell, etc..

What you actually would do is have the LSM module turn exec into MAY_EXEC_IF
where the IF is done to match security context information to the binary being
execed. ssh shouldn't exec (well most of the time anyway) a root shell. 
Instead it should switch security context, (including a security id and 
uid's/gids) first, then exec if the new security context is valid for what is 
being execed. (and the new securid is not necessarily selected from kernel 
mode - it may depend on network connection + user id/gids requested + 
security level permitted)

More complicated, but the full security context being switched to cannot be
selected by the application itself.

> It's still a good idea though, since some daemons don't need to exec,
> ever.  I guess this is one extra layer of protection.  As Ingo said in his
> announcement, the more layers of protection you have, the better.. and the
> more difficult a cracker's job is.

true.
