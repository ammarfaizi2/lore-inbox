Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318117AbSHPEMa>; Fri, 16 Aug 2002 00:12:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318118AbSHPEMa>; Fri, 16 Aug 2002 00:12:30 -0400
Received: from cpe-24-221-172-100.ca.sprintbbd.net ([24.221.172.100]:2488 "EHLO
	spratly.nominum.com") by vger.kernel.org with ESMTP
	id <S318117AbSHPEM3>; Fri, 16 Aug 2002 00:12:29 -0400
Date: Thu, 15 Aug 2002 21:15:59 -0700 (PDT)
From: Brian Wellington <bwelling@xbill.org>
X-X-Sender: bwelling@spratly.nominum.com
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: ptrace/select/signal errno weirdness
In-Reply-To: <ajhtj8$ns6$1@cesium.transmeta.com>
Message-ID: <Pine.LNX.4.44.0208152112090.9595-100000@spratly.nominum.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 Aug 2002, Linus Torvalds wrote:

> In article <Pine.LNX.4.44.0208151508060.21876-100000@spratly.nominum.com>,
> Brian Wellington  <bwelling@xbill.org> wrote:
> >When sending a SIGINT to a ptraced process (run under gdb), an interrupted 
> >select() call returns with errno==514.  linux/include/linux/errno.h says:
> >
> >/* Should never be seen by user programs */
> >#define ERESTARTSYS     512
> >#define ERESTARTNOINTR  513
> >#define ERESTARTNOHAND  514     /* restart if no handler.. */
> >#define ENOIOCTLCMD     515     /* No ioctl command */
> >
> >As gdb is a user program, and the printf is printing it, there's something
> >wrong.
> 
> No, there's nothing wrong.
> 
> The process _itself_ never sees these magic error numbers, because they
> are internal to the kernel, and the only time they are seen is by a
> tracer that sees them - at the same time as the kernel backed up the
> instruction pointer so that the traced process will not actually return
> from the system call, it will re-do the system call.

If that's the case, then how does
	fprintf(stderr, "select: %s\n", strerror(errno));
print
	select: Unknown error 514
?

That's the traced process printing the error, not the tracing process.

Brian

