Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263236AbTJBE04 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 00:26:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263237AbTJBE04
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 00:26:56 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:38334 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S263236AbTJBE0y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 00:26:54 -0400
Subject: Re: Who changed /proc/<pid>/ in 2.6.0-test5-bk9?
From: Albert Cahalan <albert@users.sf.net>
To: Ulrich Drepper <drepper@redhat.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Mikael Pettersson <mikpe@csd.uu.se>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Albert Cahalan <albert@users.sourceforge.net>
In-Reply-To: <3F7B9CF9.4040706@redhat.com>
References: <Pine.LNX.4.44.0310010803530.23860-100000@home.osdl.org>
	 <3F7B9CF9.4040706@redhat.com>
Content-Type: text/plain
Organization: 
Message-Id: <1065067968.741.75.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 02 Oct 2003 00:12:49 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-10-01 at 23:35, Ulrich Drepper wrote:
> Linus Torvalds wrote:
> 
> > I think /proc/self most likely _should_ point into the thread, not the 
> > task. 
> 
> As much as I want to not see this, I fear I have to agree.
> 
> There is, for instance, no guarantee that all CLONE_THREAD clones also
> have CLONE_FILES set.  Then using /proc/self/%d for some thread-local
> file descriptor will return the process group leaders file descriptor,
> not the own.

[meaning /proc/self/fd/%s instead]

In that case, don't you already have a severe mess?
For example, some kind of fd-related signal needs to
be delivered to the shared queue. So that happens,
but who can tell which "fd 42" it belongs with?

IMHO, if you want separate files, CLONE_THREAD should
not be in your clone() flags. (and then users call the
resulting thing a group of processes that share stuff,
instead of calling it a single process)

Also consider what the "fuser" and "lsof" programs must
do if threads don't share file descriptors. Ow, ow, ow!!!
These programs must scan /proc/*/task/*/fd/* to find all
open files. If threads share files, then "only" the tgid
level must be scanned.




