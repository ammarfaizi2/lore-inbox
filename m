Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261188AbTJ2Ri4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 12:38:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261190AbTJ2Ri4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 12:38:56 -0500
Received: from mailgate.zeus.co.uk ([62.254.209.70]:42761 "EHLO
	mailgate.zeus.co.uk") by vger.kernel.org with ESMTP id S261188AbTJ2Riy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 12:38:54 -0500
Date: Wed, 29 Oct 2003 17:38:47 +0000 (GMT)
From: Ben Mansell <ben@zeus.com>
X-X-Sender: ben@stones.cam.zeus.com
To: Davide Libenzi <davidel@xmailserver.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: epoll gives broken results when interrupted with a signal
In-Reply-To: <Pine.LNX.4.56.0310290923100.2049@bigblue.dev.mdolabs.com>
Message-ID: <Pine.LNX.4.58.0310291729310.2982@stones.cam.zeus.com>
References: <Pine.LNX.4.58.0310291439110.2982@stones.cam.zeus.com>
 <Pine.LNX.4.56.0310290923100.2049@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanner: exiscan *1AEuHP-0007SS-00*w1HSfZhTUEk* (Zeus Technology Ltd)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Oct 2003, Davide Libenzi wrote:

> On Wed, 29 Oct 2003, Ben Mansell wrote:
>
> > I'm using the epoll system interface on a 2.6.0-test9 kernel, but I hit
> > a problem if the process calling epoll_wait() gets interrupted. The
> > epoll_wait() returns with several events, but the last event of which
> > contains junk (e.g. typically reports that a file descriptor like
> > -91534560 received an event)
> >
> > The epoll is being used to monitor only a handful of file descriptors.
> > Some of these however are TCP network sockets that were bound to a port
> > by a parent process, and then passed on to the process doing the epoll.
> > Another file descriptor is that of a socket connected to the parent
> > process. The epoll failure is brought about when the parent process
> > tries to kill off the child with a SIGTERM. The parent then exits.
> >
> > The final (interrupted) epoll returns two events - the first is that of
> > the socket to the dead parent, receiving EPOLLIN | EPOLLHUP, which seems
> > reasonable. The next event is then random garbage. Perhaps epoll is just
> > returning one too many results?
>
> Is it an UP or an SMP machine? The descriptor is passed how? fork? If I'll
> send you a debug patch for epoll will you be able to run it?

UP machine - x86_64 however, if that makes any difference (sorry, my
initial message didn't contain much information, as I wasn't sure what
was relevant and what was not). The descriptor is passed over the unix
domain socket between the two processes.

I'm willing to try any debug patch that might help track down the
problem.


Thanks,
Ben


-- 
Ben Mansell, <ben@zeus.com>                       Zeus Technology Ltd
Download the world's fastest webserver!   Universally Serving the Net
T:+44(0)1223 525000 F:+44(0)1223 525100           http://www.zeus.com
Zeus House, Cowley Road, Cambridge, CB4 0ZT, ENGLAND
