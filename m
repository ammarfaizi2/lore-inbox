Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261777AbTJ2PBJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 10:01:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261807AbTJ2PBI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 10:01:08 -0500
Received: from mailgate.zeus.co.uk ([62.254.209.70]:6162 "EHLO
	mailgate.zeus.co.uk") by vger.kernel.org with ESMTP id S261777AbTJ2PBG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 10:01:06 -0500
Date: Wed, 29 Oct 2003 15:00:58 +0000 (GMT)
From: Ben Mansell <ben@zeus.com>
X-X-Sender: ben@stones.cam.zeus.com
To: linux-kernel@vger.kernel.org
Subject: epoll gives broken results when interrupted with a signal
Message-ID: <Pine.LNX.4.58.0310291439110.2982@stones.cam.zeus.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanner: exiscan *1AErog-0002ZS-00*YUQ7YBPI7As* (Zeus Technology Ltd)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm using the epoll system interface on a 2.6.0-test9 kernel, but I hit
a problem if the process calling epoll_wait() gets interrupted. The
epoll_wait() returns with several events, but the last event of which
contains junk (e.g. typically reports that a file descriptor like
-91534560 received an event)

The epoll is being used to monitor only a handful of file descriptors.
Some of these however are TCP network sockets that were bound to a port
by a parent process, and then passed on to the process doing the epoll.
Another file descriptor is that of a socket connected to the parent
process. The epoll failure is brought about when the parent process
tries to kill off the child with a SIGTERM. The parent then exits.

The final (interrupted) epoll returns two events - the first is that of
the socket to the dead parent, receiving EPOLLIN | EPOLLHUP, which seems
reasonable. The next event is then random garbage. Perhaps epoll is just
returning one too many results?

Unfortunately, I've no simple test case code to demonstrate this -
but if there's any other information I can provide to help track this
down then let me know.


(Please CC: me on replies to the list)

Cheers,
Ben

-- 
Ben Mansell, <ben@zeus.com>                       Zeus Technology Ltd
Download the world's fastest webserver!   Universally Serving the Net
T:+44(0)1223 525000 F:+44(0)1223 525100           http://www.zeus.com
Zeus House, Cowley Road, Cambridge, CB4 0ZT, ENGLAND
