Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262737AbTD1DZS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Apr 2003 23:25:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263407AbTD1DZS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Apr 2003 23:25:18 -0400
Received: from findaloan-online.cc ([216.209.85.42]:7688 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id S262737AbTD1DZR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Apr 2003 23:25:17 -0400
Date: Sun, 27 Apr 2003 23:44:15 -0400
From: Mark Mielke <mark@mark.mielke.cc>
To: Mark Grosberg <mark@nolab.conman.org>
Cc: dean gaudet <dean-list-linux-kernel@arctic.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFD] Combined fork-exec syscall.
Message-ID: <20030428034415.GC32043@mark.mielke.cc>
References: <Pine.LNX.4.53.0304271831250.8792@twinlark.arctic.org> <Pine.BSO.4.44.0304272140340.23296-100000@kwalitee.nolab.conman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.BSO.4.44.0304272140340.23296-100000@kwalitee.nolab.conman.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 27, 2003 at 09:43:38PM -0400, Mark Grosberg wrote:
> The idea would be that the file mapping array would be easier to scan
> (kind of like how poll() is a lot easier than select()).

This brings up the whole poll() vs select() vs /dev/poll vs ... discussion.

poll() is not necessarily faster than select(). If FD_CLOEXEC is not fast
enough, then perhaps efforts should be put into improving FD_CLOEXEC in the
kernel, rather than implementing a new system call that nobody will use
because it isn't defined by POSIX. If the argument is that vfork(), exec()
must scan the file descriptors to determine which ones have FD_CLOEXEC set,
then perhaps the answer is to index the FD_CLOEXEC bits of file descriptors?

> > if you look at such webservers they tend to have a separate process just
> > for the purpose of spawning cgi/etc. and use some IPC to pass the data to
> > the cgi spawner.
> Yup. I suppose for Apache this could be an alternate interface of the APR
> spawn process function.

The Apache 2.0 documentation refers to mod_cgid as a method of
avoiding the scenario that involves fork() copying all threads, not
fork() scanning all file descriptors. Other than complexity of having
a separate 'spawning daemon', I'm not sure that providing a spawn()
system call would make things any faster. A CGI is going to take a
fair amount of time to complete regardless of where it is spawned
from. If you need speed, write your own mod_feature.c, or use an
alternative such as mod_perl.

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

