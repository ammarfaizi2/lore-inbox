Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265630AbSJSRL7>; Sat, 19 Oct 2002 13:11:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265631AbSJSRL7>; Sat, 19 Oct 2002 13:11:59 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:59523 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S265630AbSJSRL6>; Sat, 19 Oct 2002 13:11:58 -0400
X-AuthUser: davidel@xmailserver.org
Date: Sat, 19 Oct 2002 10:26:28 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Mark Mielke <mark@mark.mielke.cc>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>
Subject: Re: epoll (was Re: [PATCH] async poll for 2.5)
In-Reply-To: <20021019065916.GB17553@mark.mielke.cc>
Message-ID: <Pine.LNX.4.44.0210191020240.1434-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Oct 2002, Mark Mielke wrote:

> On Fri, Oct 18, 2002 at 05:55:21PM -0700, John Myers wrote:
> > So whether or not a proposed set of epoll semantics is consistent with
> > your Platonic ideal of "use the fd until EAGAIN" is simply not an issue.
> > What matters is what works best in practice.
>
> >From this side of the fence: One vote for "use the fd until EAGAIN" being
> flawed. If I wanted a method of monopolizing the event loop with real time
> priorities, I would implement real time priorities within the event loop.

You don't need to "use the fd until EAGAIN", you can consume even only
byte out of 10000 and stop using the fd. As long as you keep such fd in
your ready-list. As soon as you receive an EAGAIN from that fd, you remove
it from your ready-list and the next time you'll go to fish for events it
will reemerge as soon as it'll have something for you. The concept is very
simple, "you don't have to go waiting for events for a given fd before
having consumed its I/O space".



- Davide


