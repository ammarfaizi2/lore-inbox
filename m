Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268516AbTBOBHo>; Fri, 14 Feb 2003 20:07:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268521AbTBOBHn>; Fri, 14 Feb 2003 20:07:43 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:55173 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S268516AbTBOBGw>; Fri, 14 Feb 2003 20:06:52 -0500
X-AuthUser: davidel@xmailserver.org
Date: Fri, 14 Feb 2003 17:23:54 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Matti Aarnio <matti.aarnio@zmailer.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Synchronous signal delivery..
In-Reply-To: <20030215000628.GB1073@mea-ext.zmailer.org>
Message-ID: <Pine.LNX.4.50.0302141712100.988-100000@blue1.dev.mcafeelabs.com>
References: <Pine.LNX.4.44.0302131452450.4232-100000@penguin.transmeta.com>
 <Pine.LNX.4.50.0302141553020.988-100000@blue1.dev.mcafeelabs.com>
 <20030215000628.GB1073@mea-ext.zmailer.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Feb 2003, Matti Aarnio wrote:

> On Fri, Feb 14, 2003 at 04:00:03PM -0800, Davide Libenzi wrote:
> > On Thu, 13 Feb 2003, Linus Torvalds wrote:
> ....
> > > > > One of the reasons for the "flags" field (which is not unused) was because
> > > > > I thought it might have extensions for things like alarms etc.
> > > > I was thinking more like :
> > > >
> > > > int timerfd(int timeout, int oneshot);
> > >
> > > It could be a separate system call, ...
> >
> > I would personally like it a lot to have timer events available on
> > pollable fds. Am I alone in this ?
>
> Somehow all this idea has a feeling of long established
> Linux kernel facility called:  netlink
>
> It can send varying messages to userspace via a file-handle, and is
> pollable.  Originally that is for network codes, and therefore it
> already has protocol capable to handle multiple different formats,
> handle queue saturation, etc.
>
> Do we need new syscall(s) ?  Could it all be done with netlink ?

The ( evntually ) new syscall do not have to implement anything special
about queue and message delivery, the f_op->poll() support will be
sufficent to have them working with select/poll/epoll. About netlink, I
personally find it quite confusing with respect of simple syscalls like :

int sigfd(...);
int timerfd(...);

Netlink is quite powerfull because of its generic message passing
infrastructure, that is IMHO overkilling when you simply have to receive
one timer/signal event. I personally do not like the idea of multiplexing
APIs, expecially ones that did not born with that purposes.



- Davide

