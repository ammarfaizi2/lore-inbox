Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261969AbRF0N5e>; Wed, 27 Jun 2001 09:57:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261942AbRF0N5Y>; Wed, 27 Jun 2001 09:57:24 -0400
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:5702 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S261881AbRF0N5Q>; Wed, 27 Jun 2001 09:57:16 -0400
Date: Wed, 27 Jun 2001 08:57:13 -0500 (CDT)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200106271357.IAA27308@tomcat.admin.navo.hpc.mil>
To: daw@mozart.cs.berkeley.edu (David Wagner), linux-kernel@vger.kernel.org
Subject: Re: [PATCH] User chroot
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

daw@mozart.cs.berkeley.edu (David Wagner):
> H. Peter Anvin wrote:
> >By author:    Jorgen Cederlof <jc@lysator.liu.se>
> >> If we only allow user chroots for processes that have never been
> >> chrooted before, and if the suid/sgid bits won't have any effect under
> >> the new root, it should be perfectly safe to allow any user to chroot.
> >
> >Safe, perhaps, but also completely useless: there is no way the user
> >can set up a functional environment inside the chroot.
> 
> Why is it useless?  It sounds useful to me, on first glance.  If I want
> to run a user-level network daemon I don't trust (for instance, fingerd),
> isolating it in a chroot area sounds pretty nice: If there is a buffer
> overrun in the daemon, you can get some protection [*] against the rest
> of your system being trashed.  Am I missing something obvious?

1. The libraries are already protected by ownership (root usually).
2. Any penetration is limited to what the user can access.
3. (non-deskop or server) Does the administrator really want users
   giving out access to the system to unknown persons? (I know, it's not
   prevented in either case.. yet)
4. inetd already does this. Spawned processes do not have to run as root...
5. A chroot environment (to be usefull) must have libraries/executables for any
   subprocesses that may do an exec. It doesn't matter whether it is done
   by a user or by root, but with root, at least the administrator KNOWS
   that the daemon process is untrusted, and how many are there, and what
   accounts they are in... And can be assured that each gets a separate
   UID, does/does not share files (and which files)...
6. There is no difference in the interpretation of setuid files between a
   chroot environment, and  outside a chroot environment.

Wait for the Linux Security Module - you may have a better way to define
access controls that DO allow what you want.

> [*] Yes, I know chroot is not sufficient on its own to completely
>     protect against this, but it is a useful part of the puzzle, and
>     there are other things we can do to deal with the remaining holes.


-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
