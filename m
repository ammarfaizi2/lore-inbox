Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129307AbRBSURw>; Mon, 19 Feb 2001 15:17:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129479AbRBSURl>; Mon, 19 Feb 2001 15:17:41 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:62471 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S129307AbRBSUR1>;
	Mon, 19 Feb 2001 15:17:27 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200102192017.f1JKHO952286@saturn.cs.uml.edu>
Subject: Re: The lack of specification (was Re: [LONG RANT] Re: Linux stifles innovation... )
To: mikulas@artax.karlin.mff.cuni.cz (Mikulas Patocka)
Date: Mon, 19 Feb 2001 15:17:24 -0500 (EST)
Cc: jgarzik@mandrakesoft.com (Jeff Garzik),
        linux-kernel@vger.kernel.org (Linux-Kernel)
In-Reply-To: <Pine.LNX.3.96.1010219191533.6201A-100000@artax.karlin.mff.cuni.cz> from "Mikulas Patocka" at Feb 19, 2001 08:11:14 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikulas Patocka writes:

> Imagine that there is specification of mark_buffer_dirty. That
> specification says that
> 	1. it may not block
> 	2. it may block
> 
> In case 1. implementators wouldn't change it to block in stable kernel
> 	relese because they don't want to violate the specification.

One of these things must happen:

a. follow the specification, even if that makes code slow and contorted
b. change the specification
c. ignore the specification
d. get rid of the specification

Option "a" will not be accepted around here. Sorry. The best you can
hope for is option "b". Since that is hard work (want to help?) we
often end up not using a specification... hopefully by just not
having one, instead of by ignoring one.

Not saying it doesn't suck to have things undocumented, but at least
you don't have to reverse-engineer a multi-megabyte binary kernel to
find out what is going on.

>> Anytime you change implementation, you gotta check all drivers that use
>> them.  I know, I'm one of the grunts that does such reviews and changes.
>
> Anytime you change implementation of syscalls, you gotta check all
> applications that use them ;-) Luckily not - because there is
> specification and you can check that syscalls conform to the
> specification, not apps. 

Syscalls are more stable, but they may be changed after many years
of a transition period. The C library hides some of this from users.

> Now implementators of TCP will say: that driver is buggy. Everybody should
> set state=TASK_RUNNING before calling schedule to yield the process. 
> 
> Implementators of driver will say: TCP is buggy - no one should call my
> driver in TASK_[UN]INTERRUPTIBLE state.
> 
> Who is right? If there is no specification....

The driver is buggy, unless the TCP maintainer can be convinced
that TCP is buggy. TCP is a big chunk of code that most people use,
while the driver is not so huge or critical.

The TCP maintainers do not seem to be sadistic bastards hell-bent on
breaking your drivers. API changes usually have a good reason.
