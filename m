Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293302AbSBYDQL>; Sun, 24 Feb 2002 22:16:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291619AbSBYDQB>; Sun, 24 Feb 2002 22:16:01 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:24068 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S293302AbSBYDPv>; Sun, 24 Feb 2002 22:15:51 -0500
X-AuthUser: davidel@xmailserver.org
Date: Sun, 24 Feb 2002 19:18:23 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Alexander Viro <viro@math.psu.edu>,
        Linus Torvalds <torvalds@transmeta.com>, <mingo@elte.hu>,
        Matthew Kirkwood <matthew@hairy.beasts.org>,
        Benjamin LaHaise <bcrl@redhat.com>, David Axmark <david@mysql.com>,
        William Lee Irwin III <wli@holomorphy.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: your mail 
In-Reply-To: <E16fAer-0000vA-00@wagner.rustcorp.com.au>
Message-ID: <Pine.LNX.4.44.0202241906230.7321-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Feb 2002, Rusty Russell wrote:

> In message <Pine.GSO.4.21.0202242054410.1329-100000@weyl.math.psu.edu> you writ
> e:
> >
> >
> > On Mon, 25 Feb 2002, Rusty Russell wrote:
> > > First, fd passing sucks: you can't leave an fd somewhere and wait for
> > > someone to pick it up, and they vanish when you exit.  Secondly, you
> >
> > Yes, you can.  Please, RTFS - what is passed is not a descriptor, it's
> > struct file *.  As soon as datagram is sent, descriptors are resolved and
> > after that point descriptor table of sender (or, for that matter, survival
> > of sender) doesn't matter.
>
> Please explain how I leave a fd somewhere for other processes to grab
> it.
>
> And then please explain how they get the fd after I've exited.
>
> Al, you are one of the most unpleasant people to deal with on this
> list.  This is *not* an honor, and I beg you to consider a different
> approach in future correspondence.

Actually, this is one of Al's nicest posts :-)
You obviously can't share fd# but you can share file*
I don't know how you're going to have these semaphores 'externally visible',
if with numbers like IPC sems or if with pathnames like unix sockets ( or
something else ). But you can have internally a number/path/else -> file*
mapping and when a task attaches the sem you map the file* onto an fd# in
the task's file table. If you keep this mapping persistent ( until
explicit deletion ) the file* remain alive event with zero attached
processes. I think it's this what Al was trying to say.




- Davide



