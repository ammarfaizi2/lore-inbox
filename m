Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267952AbTGSJoa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jul 2003 05:44:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268390AbTGSJoa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jul 2003 05:44:30 -0400
Received: from uucp.cistron.nl ([62.216.30.38]:7942 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id S267952AbTGSJo2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jul 2003 05:44:28 -0400
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: Suggestion for a new system call: convert file handle to a
 cookie for transfering file handles between processes.
Date: Sat, 19 Jul 2003 09:59:26 +0000 (UTC)
Organization: Cistron Group
Message-ID: <bfb4pu$hae$4@news.cistron.nl>
References: <fb7ddfab3b.fab3bfb7dd@teleline.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: ncc1701.cistron.net 1058608766 17742 62.216.29.200 (19 Jul 2003 09:59:26 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <fb7ddfab3b.fab3bfb7dd@teleline.es>,
RAMON_GARCIA_F  <RAMON_GARCIA_F@terra.es> wrote:
>I suggest to add a new system call for transfering a file handle between
>two processes.
>
>In Linux, transfer of file handles can be done through a Unix domain
>socket. This mechanism is quite unflexible. It requires that the two
>applications connect by this kind of socket, and it is difficult to
>use from shell scripts.

Why, write a small program 'passfd /var/run/socket fd1 fd2' which
does the work for you.

>Let cdwritter be a program for writting CDs. Unlike other programs,
>cdwritter is rationally designed. It is a server process that listens
>through a named pipe, thus making it easy to write either command line
>or graphical interfaces that use its functionality. The named pipe
>is called /var/run/cdwritter
>
>An alternative would be that cdwritter accepts a file name instead of
>a cookie. But then, the author of cdwritter would have to check if the
>user has permission to access the file. This makes cdwritter more error
>prone.

You can get the uid/gid on the other side of a unix socket easily,
so you just setfsuid() / open(). But again you do need to use
a Unix socket, not a pipe, so you need a small client program.

There have been patches to the kernel to treat an open() on a
unix socket as a bind() + connect(), but unfortunately that has
never been integrated in mainline.

Now that we have getsockopt(SO_PEERCRED, &ucred) the above would
be very useful.

Mike.

