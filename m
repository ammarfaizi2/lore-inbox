Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268501AbTBOBwi>; Fri, 14 Feb 2003 20:52:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268503AbTBOBwh>; Fri, 14 Feb 2003 20:52:37 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:23944 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S268501AbTBOBwg>; Fri, 14 Feb 2003 20:52:36 -0500
X-AuthUser: davidel@xmailserver.org
Date: Fri, 14 Feb 2003 18:09:30 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Linus Torvalds <torvalds@transmeta.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Synchronous signal delivery..
In-Reply-To: <Pine.LNX.4.44.0302141554120.1296-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.50.0302141751220.988-100000@blue1.dev.mcafeelabs.com>
References: <Pine.LNX.4.44.0302141554120.1296-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Feb 2003, Linus Torvalds wrote:

>
> On Fri, 14 Feb 2003, Davide Libenzi wrote:
> >
> > I would personally like it a lot to have timer events available on
> > pollable fds. Am I alone in this ?
>
> I don't know.
>
> HOWEVER, judging from the discussion following, I do know that there are a
> lot of people who want to have just "random things" available.
>
> That's not what this patch was about. I'm not in the least interested in
> some "generic event" mechanism, and it's not where I think this should
> even go. This was very much about signals, and while I can see the
> potential to extend the notion of signals to things like timers, I don't
> think it's necessarily a good idea to extend it too far.
>
> For example, you _can_, with the existing patch, already get timers. You
> won't get any _new_ timers, but all the normal itimer signal stuff would
> come down the sigfd() pipe the same way any other signal does.

You're right, I had not thought about something like POSIX timers plus
sigfd().



> > About that, I think we should make an utility function to be shared among
> > all the code that need to create "fake" inodes to expose fds. Right now
> > many component ( pipes, futexes, epoll, ... ) uses the basic code, sharing
> > the same needs, and duplicating basically the same code.
>
> Some of it can be pulled in. However, the way the dynamic inode allocation
> works, different kinds of inodes _have_ to have different superblocks,
> since that's the level where the inode allocation and caching works. So
> the fake inodes for a pipe, for example, are _not_ the same as the fake
> inodes for the sigfd's. So not all of it is shared.

Superblocks will be different, but their "fake" functionality can be
shared. A few parameters like file system name, file system magic number,
root name, ... will be able to do the trick :

fakefs_t fakefs_create(chat const *root, char const *name, unsigned long magic);
struct inode *fakefs_new_inode(fakefs_t fkfs);
void fakefs_close(fakefs_t fkfs);




- Davide

