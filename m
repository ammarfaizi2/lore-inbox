Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264337AbTLESwp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 13:52:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264339AbTLESwp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 13:52:45 -0500
Received: from 34.mufa.noln.chcgil24.dsl.att.net ([12.100.181.34]:50671 "EHLO
	tabby.cats.internal") by vger.kernel.org with ESMTP id S264337AbTLESvg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 13:51:36 -0500
Content-Type: text/plain;
  charset="CP 1252"
From: Jesse Pollard <jesse@cats-chateau.net>
To: David Dyck <david.dyck@fluke.com>
Subject: Re: Linux GPL and binary module exception clause?
Date: Fri, 5 Dec 2003 12:51:11 -0600
X-Mailer: KMail [version 1.2]
Cc: David Schwartz <davids@webmaster.com>, linux-kernel@vger.kernel.org
References: <732BE51FE9901143AE04411A11CC465602F155F3@evtexc02.tc.fluke.com> <Pine.LNX.4.51.0312050824270.9496@dd.tc.fluke.com>
In-Reply-To: <Pine.LNX.4.51.0312050824270.9496@dd.tc.fluke.com>
MIME-Version: 1.0
Message-Id: <03120512511100.22291@tabby>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 05 December 2003 11:05, David Dyck wrote:
> On Fri, 5 Dec 2003 at 07:06 -0800, Jesse Pollard <jesse@cats-chateau.net>
>
> wrote:
> > Quite simple. If you include the Linux kernel include files you get a
> > derived program that must be released under GPL if you distribute that
> > program.
>
> When I first read this out out of context, I wondered if you were saying
> that any executable that I write on my libc5 linux system (and those that
> were compiled on libc5 systems long ago - like my copy of Adobe acrobat,
> and RealNetworks real audio) must have been distributed under GPL?
>
>     [ Please recall that the kernel header files were included in users
>     programs (since /usr/include/asm and /usr/include/linux were symlinks
>     into the kernel sources) and common include files like dirent.h,
>     errno.h, and signal.h.  This still works with libc5 and todays
>     Linux 2.4.23. ]
>
> You must not be saying that, since Linus said:
>
>     "There's a clarification that user-space programs that use the standard
>     system call interfaces aren't considered derived works, but even that
>     isn't an "exception" - it's just a statement of a border of what is
>     clearly considered a "derived work". User programs are _clearly_
>     not derived works of the kernel, and as such whatever the kernel
>     license is just doesn't matter."
>
> And after re-reading more of the thread, you must be refering to modules
> that include kernel include files, right?

Mostly. Primarily. That is because the only executable that results IS the
kernel.

There is the fuzzy area where you write a user mode application that uses
some Kernel headers for the purpose of doing things like an ext2fs debugger.
The kernel headers are NOT released under LGPL, but all of the libc functions
and include files are. The syscall interfaces were explicitly excluded as
requiring GPL because the Linus quote.

Personally, I think it would be a good idea to have these specific ones under
the LGPL instead of GPL, and then use them in both kernel and user space
(which the LGPL also allows).

If the header is not LGPL (which allows propriatary programs to include
them), then you run a severe risk of forcing the user mode application into 
GPL if it is distributed. I think this is more likely if the header includes
inline functions, and not in the case of those just defining the syscall data 
structures/interface.

One area this would clarify would be if someone tried to write a propriatary
kernel debugger... It would run in user mode, but look at/poke at kernel 
structures and functions in such detail that it SHOULD be a GPL program.
