Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261898AbUAIQCo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 11:02:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261950AbUAIQCo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 11:02:44 -0500
Received: from mail.gmx.de ([213.165.64.20]:22181 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261898AbUAIQCm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 11:02:42 -0500
X-Authenticated: #20450766
Date: Fri, 9 Jan 2004 17:02:02 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Wakko Warner <wakko@animx.eu.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Strange lockup with 2.6.0
In-Reply-To: <20040109104955.B6840@animx.eu.org>
Message-ID: <Pine.LNX.4.44.0401091653340.19686-100000@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Jan 2004, Wakko Warner wrote:

> Guennadi Liakhovetski wrote:
> > On Fri, 9 Jan 2004, Wakko Warner wrote:
> >
> > > I usually do a backup of each filesystem simply using tar.  I attempted to
> > > backup a machine I had that's running 2.6.0 and it hard locked.
> >
> > Are sysrq-keys enabled? If so, could you catch the tar backtrace during
> > the lock-up (ALT-SysRq-t)? What was the latest kernel-version that worked?
>
> Yes, but the machine hard locks.  sysrq does not work.  I have a small

__THAT__ hard...:-)

> utility I wrote that will set the state of the parport (I used this to tell
> if it locks up) using outb to the port (This does not effect it in anyway,
> it will lockup w/o it running)

You mean it just toggles a bit periodically?

> > Can you just try to write some data over NFS? Would it lock if you write 1
>
> I am constantly accessing NFS with this machine.  Read and write.  It was

How much data at one go (max)?

> only when I backed it up with tar.  In the event it doesn't lock, tar
> crashes w/o error/warning (over NFS).

So, it locks not always?

> > byte or 1K or 1M? Does it lock immediately as you start the backup or
>
> It locks up usually at one point, but not always.

Since you could backup to Jazz, looks like your filesystem is ok, NFS also
works in principle...

> > after some time (you could start some process in the background
> > periodically printing some info on the terminal, like vmstat, cat
> > /proc/interrupts, free, tcpdump on both ends to a file...) Can you try NFS
>
> I can do this I think.  It's fun when running with init being bash.  It will
> take some time to do since I can't scroll backwards.

You could also attach a serial console and direct the output there (then
you also can scroll).

> > over TCP? Are other machines, where backup works, also running 2.6,
>
> I can try TCP, but I'm not sure about the server accepting TCP (was there a
> compile time option for NFSD to use TCP?)  These 2 machines are the only

Yes.

> ones I have on 2.6.
>
> > 10/100mbps?
>
> 100 FD always.

Why I am interested in your experiences is that I also have a problem
transferring large (several M) files over NFS when the server is 2.6 and
both ends have 100 FD. (You can see my posts this week about 2.6 NFS.) And
in my case it TCP fixed it. But I never had hard-locks, just cp hanged in
D, and tcpdump showed timed out reassembly on the receiving side. But I
was reading from the server.

Guennadi
---
Guennadi Liakhovetski


