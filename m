Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263535AbTEDGvQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 02:51:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263539AbTEDGvQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 02:51:16 -0400
Received: from rtlab.med.cornell.edu ([140.251.145.175]:5279 "HELO
	openlab.rtlab.org") by vger.kernel.org with SMTP id S263535AbTEDGvP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 02:51:15 -0400
Date: Sun, 4 May 2003 03:03:43 -0400 (EDT)
From: "Calin A. Culianu" <calin@ajvar.org>
X-X-Sender: <calin@rtlab.med.cornell.edu>
To: <Valdis.Kletnieks@vt.edu>
Cc: <linux@horizon.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [Announcement] "Exec Shield", new Linux security feature 
In-Reply-To: <200305032300.h43N0UX9006675@turing-police.cc.vt.edu>
Message-ID: <Pine.LNX.4.33L2.0305040301001.6490-100000@rtlab.med.cornell.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 May 2003 Valdis.Kletnieks@vt.edu wrote:

> On Sat, 03 May 2003 13:19:52 -0000, linux@horizon.com  said:
>
> > An interesting question arises: is the number of useful interpreter
> > functions (system, popen, exec*) sufficiently low that they could be
> > removed from libc.so entirely and only staticly linked, so processes
> > that didn't use them wouldn't even have them in their address space,
> > and ones that did would have them at less predictible addresses?
> >
> > Right now, I'm thinking only of functions that end up calling execve();
> > are there any other sufficiently powerful interpreters hiding in common
> > system libraries?  regexec()?
>
> This does absolutely nothing to stop an exploit from providing its own
> inline version of execve().  There's nothing in libc that a process can't
> do itself, inline.
>
> A better bet is using an LSM module that prohibits exec() calls from any
> unauthorized combinations of running program/user/etc.

Is that practical?  I can see how with some daemons it would definitely be
useful to prohibit exec calls (maybe things like BIND don't need to exec
anything).. but some daemons do need to exec.  An SMTPD may need to exec()
some helper processes (postfix for instance has a whole slew of helper
programs it uses).. and things like sshd need to exec a shell, etc..

It's still a good idea though, since some daemons don't need to exec,
ever.  I guess this is one extra layer of protection.  As Ingo said in his
announcement, the more layers of protection you have, the better.. and the
more difficult a cracker's job is.

-Calin

