Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268117AbTBMWJ4>; Thu, 13 Feb 2003 17:09:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268112AbTBMWJ4>; Thu, 13 Feb 2003 17:09:56 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:33172 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S268119AbTBMWJz>; Thu, 13 Feb 2003 17:09:55 -0500
X-AuthUser: davidel@xmailserver.org
Date: Thu, 13 Feb 2003 14:26:49 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Linus Torvalds <torvalds@transmeta.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Synchronous signal delivery..
In-Reply-To: <Pine.LNX.4.44.0302131222560.2125-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.50.0302131420200.1869-100000@blue1.dev.mcafeelabs.com>
References: <Pine.LNX.4.44.0302131222560.2125-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Feb 2003, Linus Torvalds wrote:

>
> On Thu, 13 Feb 2003, Davide Libenzi wrote:
> >
> > That's really nice, I like file-based interfaces. No plan to have a way to
> > change the sig-mask ? Close and reopen ?
>
> You can have multiple fd's open at the same time, which is a lot more
> convenient.
>
> I will _not_ add a fcntl-like or ioctl interface to this. They are ugly
> _and_ there are security issues (ie if you pass on the fd to somebody
> else, they must not be able to change the signal mask _you_ specified).

It does not have necessarily to be just another ioctl/fcntl, it can be a
write. About security, chages might be allowed only to the task that
created the fd, if you're concerned. It's not that someone will starve
w/out such functionality though.



> > What do you think about having timers through a file interface ?
>
> One of the reasons for the "flags" field (which is not unused) was because
> I thought it might have extensions for things like alarms etc.

I was thinking more like :

int timerfd(int timeout, int oneshot);

that returns a pollable fd.




- Davide

