Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261680AbUCBPiJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 10:38:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261683AbUCBPiI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 10:38:08 -0500
Received: from mta01-svc.ntlworld.com ([62.253.162.41]:33377 "EHLO
	mta01-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id S261680AbUCBPiF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 10:38:05 -0500
Date: Tue, 2 Mar 2004 15:38:04 +0000 (GMT)
From: Ben <linux-kernel-junk-email@slimyhorror.com>
X-X-Sender: ben@baphomet.bogo.bogus
To: Davide Libenzi <davidel@xmailserver.org>
cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Fw: epoll and fork()
In-Reply-To: <Pine.LNX.4.44.0403020654080.24044-100000@bigblue.dev.mdolabs.com>
Message-ID: <Pine.LNX.4.58.0403021527360.20736@baphomet.bogo.bogus>
References: <Pine.LNX.4.44.0403020654080.24044-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Mar 2004, Davide Libenzi wrote:

> >
> > Is there a defined behaviour for what happens when a process with an epoll
> > fd forks?
> >
> > I've an app that inherits an epoll fd from its parent, and then
> > unregisters some file descriptors from the epoll set. This seems to have
> > the nasty side effect of unregistering the same file descriptors from the
> > parent process as well. Surely this can't be right?
>
> epoll does register the underlying file* not the fd, so this is the
> expected behaviour. Inheriting an fd, and epoll is no exception, simply
> bumps a counter, so both parent and child epoll fd shares the same context.
> Sorry but what behaviour do you expect by unregistering an fd pushed by
> the parent from inside a child? Events work exactly the same. Since the
> context is shared, events are delivered only once.

It seems unintuitive, although having heard the arguments, I can
understand why it works this way.

I was thinking that epoll should behave like a file descriptor (i.e. a
child can close an inherited fd without affecting the parent), simply
because the only connection a process has with epoll is the file
descriptor. I suppose if you think of epoll_ctl() and epoll_wait() as
write()s and read()s on the file descriptor, then it makes sense that
these operations would affect both processes.

It still feels 'wrong' though :)


Ben
