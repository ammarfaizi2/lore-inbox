Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130750AbRBAQDz>; Thu, 1 Feb 2001 11:03:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130734AbRBAQDp>; Thu, 1 Feb 2001 11:03:45 -0500
Received: from ferret.lmh.ox.ac.uk ([163.1.138.204]:26896 "HELO
	ferret.lmh.ox.ac.uk") by vger.kernel.org with SMTP
	id <S130750AbRBAQDf>; Thu, 1 Feb 2001 11:03:35 -0500
Date: Thu, 1 Feb 2001 16:03:24 +0000 (GMT)
From: Chris Evans <chris@scary.beasts.org>
To: Malcolm Beattie <mbeattie@sable.ox.ac.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Serious reproducible 2.4.x kernel hang
In-Reply-To: <20010201153000.C27009@sable.ox.ac.uk>
Message-ID: <Pine.LNX.4.30.0102011556010.4030-100000@ferret.lmh.ox.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 1 Feb 2001, Malcolm Beattie wrote:

> Mapping the addresses from whichever ScrollLock combination produced
> the task list to symbols produces the call trace
>  do_exit <- do_signal <- tcp_destroy_sock <- inet_ioctl <- signal_return
>
> The inet_ioctl is odd there--vsftpd doesn't explicitly call ioctl
> anywhere at all and the next function before it in memory is
> inet_shutdown which looks more believable. I have checked I'm looking

Probably, the empty SIGPIPE handler triggered. The response to this is a
lot of shutdown() close() and finally an exit().

The trace you give above looks like the child process trace. I always see
the parent process go nuts. The parent process is almost always blocking
on read() of a unix dgram socket, which it shares with the child. The
child does a shutdown() on this socket just before exit().

Cheers
Chris

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
