Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290856AbSARW32>; Fri, 18 Jan 2002 17:29:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290855AbSARW3T>; Fri, 18 Jan 2002 17:29:19 -0500
Received: from cti06.citenet.net ([206.123.38.70]:37131 "EHLO
	cti06.citenet.net") by vger.kernel.org with ESMTP
	id <S290815AbSARW3R>; Fri, 18 Jan 2002 17:29:17 -0500
From: Jacques Gelinas <jack@solucorp.qc.ca>
Date: Fri, 18 Jan 2002 14:23:47 -0500
To: linux-kernel@vger.kernel.org
Subject: re: new virtualization syscall to improve uml performance?
X-mailer: tlmpmail 0.1
Message-ID: <20020118142347.04f988370c19@remtk.solucorp.qc.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jan 2002 13:12:59 -0500, baccala@freesoft.org wrote

> First, kudos to everyone who worked on user mode linux.  I need to
> build distribution RPMs for a couple of pieces of free software I help
> maintain, and have this absurd dilemma about running recent RedHat
> releases (to get the latest code) or running older releases (to
> compile RPMs that will install on both older and newer systems).  I've
> been trying to accommodate both needs by selectively picking and
> choosing older and newer RPMs to install on my system, and the result
> is a mess that won't compile anything!  Anyway, I installed UML with
> the distributed RedHat 6.2 filesystem, fired it up, installed a few
> missing RPMs like make, and the software built fine.  I think I've
> solved my dilemma...

The vservers (see my sig) are pretty good to solve that. You can run any linux i386
distro and version all at once on the same box.

> would be replaced with:
>
> 	syscall trap
>
> Would this be just more kernel bloat to support one application?
> Perhaps not.  I have other utilities (a user-space HTTP file system,
> and code to do Plan 9-ish directory overlays) that need to intercept
> system calls.  I currently do this using the LD_PRELOAD function of
> the shared library.  This has the following disadvantages:
>
> 	1. a specially compiled glibc must be installed, because
> 	   the standard one doesn't export all the needed symbols,
> 	2. newer versions of the OS/glibc cause problems if they
> 	   introduce new syscalls (like open64) that don't get
> 	   caught until you add more code just for them, and

I solved this in virtualfs (http://www.solucorp.qc.ca/virtualfs) by introducing
new weak symbol.

> 	3. it's impossible to have any security, because the user
> 	   code could just bypass glibc and make the syscalls directly

Yes but the reverse is true. With the trap, you end up in your own code
with full privilege. Does it opens worst problem.

For privilege stuff, the virtualfs dispatcher connects to special server. Using
unix domain socket, credential passing and file handle passing, you can do
a lot of privileged stuff this way.

---------------------------------------------------------
Jacques Gelinas <jack@solucorp.qc.ca>
vserver: run general purpose virtual servers on one box, full speed!
http://www.solucorp.qc.ca/miscprj/s_context.hc
