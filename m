Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269659AbUJGO17@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269659AbUJGO17 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 10:27:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269688AbUJGO17
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 10:27:59 -0400
Received: from chaos.analogic.com ([204.178.40.224]:8832 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S269659AbUJGO1H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 10:27:07 -0400
Date: Thu, 7 Oct 2004 10:26:41 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: linux@horizon.com
cc: aeb@cwi.nl, Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] poll(2) man page, likewise.
In-Reply-To: <20041007135110.16475.qmail@science.horizon.com>
Message-ID: <Pine.LNX.4.61.0410071005010.3331@chaos.analogic.com>
References: <20041007135110.16475.qmail@science.horizon.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It's not April 1st!  This has got to be a cruel joke.

> +In general, it is legal for
                      ^^^^^

Wrong. Software developers do not make law nor do they
interpret law. The correct word is "valid".  Also, it
is NOT valid for poll() or select() to LIE.

> +even though there is no valid reason for a program to ever do this, and it is
> +a common beginner's mistake.

Wrong. It is a Linux kernel mistake to fail to implement a common
system call properly.

Much software is not written as a simple select()...if you got it...
read()... step-by-step implementation. Complex system software
often uses the concept of a dispatcher so that function development
can be implemented using black-box, pin-for-pin-compatible, modules,
written to a testable specification.  It is a SEVERE error for
a function, called to obtain critical data, to fail to produce
that data. In fact, it might force an entire machine to be
reinitialized, if that's what the specification says. I mentioned
the other day that Air Bus Industries is using an Ethernet Bus
in their new behemoth. People all over the world are writing
software to SPECIFICATIONS. They don't have an 400 ft. long
airplane parked in the Lab for testing. The POSIX stuff MUST
meet POSIX specifications.

So wake up. This is not a hobbiest thing anymore. The software
has GOT to work as specified. We all know how to make work-
arounds. Anybody who's been writing software for a few years
remembers the high-points of many work-arounds for defective
operating systems. We needed those work-arounds because we
couldn't fix VMS, Ultix, SunOS, or Windows. We don't need
such work-arounds with Linux.


On Thu, 7 Oct 2004 linux@horizon.com wrote:

> As before, the changes are a work of original authorship, and copyright
> is abandoned to the public domain.
>
> --- man2/poll.2.old	2004-10-07 09:10:03.000000000 -0400
> +++ man2/poll.2	2004-10-07 09:22:14.000000000 -0400
> @@ -130,6 +130,12 @@
> The
> .I nfds
> value exceeds the RLIMIT_NOFILE value.
> +.SH BUGS
> +.B poll
> +permits a blocking file descritor in
> +.IR ufds ,
> +even though there is no valid reason for a program to ever do this, and it is
> +a common beginner's mistake.
> .SH "CONFORMING TO"
> XPG4-UNIX.
> .SH AVAILABILITY
> @@ -137,6 +143,42 @@
> The poll() library call was introduced in libc 5.4.28
> (and provides emulation using select if your kernel does not
> have a poll syscall).
> +.SH NOTES
> +When
> +.B poll
> +indicates that a file descriptor is ready, this is only a strong hint,
> +not a guarantee, that a read or write is possible without blocking.
> +For this reason, the associated file descriptors
> +.I must always be in non-blocking mode
> +(see
> +.BR fcntl (2))
> +in a correct program.  Reasons why the I/O could block include:
> +.TP
> +(i)
> +Another process may have performed I/O on the
> +.I fd
> +in the meantime.
> +.TP
> +(ii)
> +Some needed kernel buffer space may have been consumed for reasons
> +totally unrelated to this I/O, or
> +.TP
> +(iii)
> +Since 2.4.x, Linux has overlapped UDP checksum verification with
> +copying to user-space.  If a UDP packet arrives,
> +.B poll
> +will indicate that data is ready, but during the read, if the checksum is
> +bad, the packet will disappear and (if no subsequent packet with a
> +valid checksum is waiting) the read will indicate that no data is available.
> +.PP
> +In general, it is legal for
> +.B poll
> +to make some optimistic assumptions, subject to later verification by the
> +subsequent I/O, as long as this does not result in a busy-loop where
> +.B poll
> +is stuck thinking data is ready when it is not.
> +
> .SH "SEE ALSO"
> +.BR fcntl (2),
> .BR select (2),
> .BR select_tut (2)
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.5-1.358-noreg on an i686 machine (5537.79 BogoMips).
             Note 96.31% of all statistics are fiction.

