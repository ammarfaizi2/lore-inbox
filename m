Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261254AbTD1Syq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 14:54:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261256AbTD1Syq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 14:54:46 -0400
Received: from twinlark.arctic.org ([168.75.98.6]:8064 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP id S261254AbTD1Syo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 14:54:44 -0400
Date: Mon, 28 Apr 2003 12:07:01 -0700 (PDT)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Mark Grosberg <mark@nolab.conman.org>
cc: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@users.sourceforge.net>,
       Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFD] Combined fork-exec syscall.
In-Reply-To: <Pine.BSO.4.44.0304272154080.23296-100000@kwalitee.nolab.conman.org>
Message-ID: <Pine.LNX.4.53.0304281203200.8792@twinlark.arctic.org>
References: <Pine.BSO.4.44.0304272154080.23296-100000@kwalitee.nolab.conman.org>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Apr 2003, Mark Grosberg wrote:

> On Sun, 27 Apr 2003, dean gaudet wrote:
>
> > the only time fork-exec is inefficient, given the existence of vfork, is
> > when you need to fork a process which has a lot of fd.  and by "a lot" i
> > mean thousands.
>
> Depends at what level of optimization you are talking about. I consider a
> syscall an expensive operation.

"expensive syscalls" are a mistake of non-linux unixes :)

> The transition from user to kernel mode,
> the setup and retrieval of parameters all cost (and some architectures are
> worse at it than i386).
>
> > but even this has a potential work-around using procfs -- use clone() to
> > get the vfork semantics without also copying the fd array.  then open
> > /proc/$ppid/fd/N for any file descriptors you want opened in the forked
> > process.
>
> That is still quite a few syscalls (and some path walking for each file
> descriptor)... I was proposing to get around the syscall overhead which
> on large multi-user systems (or webservers running lots of CGI) could be
> significant.

it's no more syscalls than are already required to set up stdin, out, and
error... the open() calls replace dup2() calls.

if the path walking is a problem then create a openparent(int parent_fd)
syscall... which would have to do all the same permissions checking that
using an open("/proc/ppid/...") would.

note that for this to be generically useful for CGI you also need to be
able to setuid(), and chdir().  this is why NT CreateProcess has a zillion
arguments -- and why it's really suspect...

-dean
