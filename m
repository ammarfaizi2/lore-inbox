Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266266AbTGGWFj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 18:05:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266270AbTGGWFj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 18:05:39 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:55714 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S266266AbTGGWFb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 18:05:31 -0400
X-AuthUser: davidel@xmailserver.org
Date: Mon, 7 Jul 2003 15:12:27 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: Eric Varsanyi <e0216@foo21.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: epoll vs stdin/stdout
In-Reply-To: <20030707194736.GF9328@srv.foo21.com>
Message-ID: <Pine.LNX.4.55.0307071511550.4704@bigblue.dev.mcafeelabs.com>
References: <20030707154823.GA8696@srv.foo21.com>
 <Pine.LNX.4.55.0307071153270.4704@bigblue.dev.mcafeelabs.com>
 <20030707194736.GF9328@srv.foo21.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Jul 2003, Eric Varsanyi wrote:

> On Mon, Jul 07, 2003 at 11:57:02AM -0700, Davide Libenzi wrote:
> > Events caught by epoll comes from a file* since that is the abstraction
> > the kernel handles. Events really happen on the file* and there's no way
> > if you dup()ing 1000 times a single fd, to say that events are for fd = 122.
>
> It is useful/mildly common at the app level to want to get read events
> for fd0 and write avail events for fd1. An app that might want to deal
> with reads from stdin in one process and writes to stdout in another
> (something like "team" perhaps) would have trouble here too.
>
> Epoll's API/impl is great as it is IMO, not suggesting need for change, I was
> hoping there was a good standard trick someone worked up to get around
> this specifc end case of stdin/stdout usually being dups but sometimes
> not. Porting my event system over to use epoll was easy/straightforward
> except for this one minor hitch.
>
> I considered:
> 	- using a second epoll object just for one of the fd's (to inspire
> 	  delivery of the event to 2 wait queues in the kernel); a little
> 	  ugly because of need to stack another epfd under the main one
> 	  just for stdout write events
>
> 	- select() on (0, 1, epfd) and just use epoll with a timeout of 0
> 	  when select fires to gather bulk of events; morally similar to
> 	  previous but using select (which I want to just get away from)
>
> 	- make the app use stdin as its output (this is what I ended up doing);
> 	  breaks redirection of stdout but that doesn't matter to this app

Any of the above. Pls wait for an incoming patch ...



- Davide

