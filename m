Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263124AbTD1BrZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Apr 2003 21:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263140AbTD1BrZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Apr 2003 21:47:25 -0400
Received: from user72.209.42.38.dsli.com ([209.42.38.72]:34073 "EHLO
	nolab.conman.org") by vger.kernel.org with ESMTP id S263124AbTD1BrY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Apr 2003 21:47:24 -0400
Date: Sun, 27 Apr 2003 21:59:39 -0400 (EDT)
From: Mark Grosberg <mark@nolab.conman.org>
To: dean gaudet <dean-list-linux-kernel@arctic.org>
Cc: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@users.sourceforge.net>,
       Larry McVoy <lm@bitmover.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFD] Combined fork-exec syscall.
In-Reply-To: <Pine.LNX.4.53.0304271843010.8792@twinlark.arctic.org>
Message-ID: <Pine.BSO.4.44.0304272154080.23296-100000@kwalitee.nolab.conman.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 27 Apr 2003, dean gaudet wrote:

> the only time fork-exec is inefficient, given the existence of vfork, is
> when you need to fork a process which has a lot of fd.  and by "a lot" i
> mean thousands.

Depends at what level of optimization you are talking about. I consider a
syscall an expensive operation. The transition from user to kernel mode,
the setup and retrieval of parameters all cost (and some architectures are
worse at it than i386).

> but even this has a potential work-around using procfs -- use clone() to
> get the vfork semantics without also copying the fd array.  then open
> /proc/$ppid/fd/N for any file descriptors you want opened in the forked
> process.

That is still quite a few syscalls (and some path walking for each file
descriptor)... I was proposing to get around the syscall overhead which
on large multi-user systems (or webservers running lots of CGI) could be
significant.

Honestly, I'm not sure if it is necessary either. But I can think of a few
advantages (and people on the list have thought of more)... How do
MMU-less archs spawn processes? Do they always use vfork()?

L8r,
Mark G.


