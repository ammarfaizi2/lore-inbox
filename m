Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262988AbRFFGyp>; Wed, 6 Jun 2001 02:54:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262997AbRFFGyg>; Wed, 6 Jun 2001 02:54:36 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:30470 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S262988AbRFFGyU>;
	Wed, 6 Jun 2001 02:54:20 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200106060651.f566pUP172752@saturn.cs.uml.edu>
Subject: Re: Inconsistent "#ifdef __KERNEL__" on different architectures
To: paulus@samba.org
Date: Wed, 6 Jun 2001 02:51:30 -0400 (EDT)
Cc: bunk@fs.tum.de (Adrian Bunk), linux-kernel@vger.kernel.org
In-Reply-To: <15132.23395.553496.50934@argo.ozlabs.ibm.com> from "Paul Mackerras" at Jun 05, 2001 02:09:07 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Mackerras writes:

> The only valid reason for userspace programs to be including kernel
> headers is to get definitions that are part of the kernel API.  (And
> in fact others here will go further and assert that there are *no*
> valid reasons for userspace programs to include kernel headers.)
>
> If you want some atomic functions or whatever for your userspace
> program and the ones in the kernel look like they would be useful,
> then take a copy of the relevant kernel code if you like, but don't
> include the kernel headers directly.

Sure. That copy belongs in /usr/include/asm for all programs
to use, and it should match the libc that will be linked against.
(note: "copy", not a symlink)

Red Hat 7 gets this right:

$ ls -ldog /usr/include/asm /usr/include/linux            
drwxr-xr-x    2 root         2048 Sep 28  2000 /usr/include/asm
drwxr-xr-x   10 root        10240 Sep 28  2000 /usr/include/linux

Debian's "unstable" is correct too:

$ ls -ldog /usr/include/asm /usr/include/linux
drwxr-xr-x    2 root         6144 Mar 12 15:57 /usr/include/asm
drwxr-xr-x   10 root        23552 Mar 12 15:57 /usr/include/linux

> This is why I added #ifdef __KERNEL__ around most of the contents
> of include/asm-ppc/*.h.  It was done deliberately to flush out those
> programs which are depending on kernel headers when they shouldn't.

What, is </usr/src/linux/asm/foo.h> being used? I doubt it.

If /usr/include/asm is a link into /usr/src/linux, then you
have a problem with your Linux distribution. Don't blame the
apps for this problem.

Adding "#ifdef __KERNEL__" causes extra busywork for someone
trying to adapt kernel headers for userspace use. At least do
something easy to rip out. Three lines, all together at the top:

#ifndef __KERNEL__
#error Raw kernel headers may not be compatible with user code.
#endif
