Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290715AbSA3W6K>; Wed, 30 Jan 2002 17:58:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290716AbSA3W6B>; Wed, 30 Jan 2002 17:58:01 -0500
Received: from www.transvirtual.com ([206.14.214.140]:36360 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S290715AbSA3W5u>; Wed, 30 Jan 2002 17:57:50 -0500
Date: Wed, 30 Jan 2002 14:57:26 -0800 (PST)
From: James Simmons <jsimmons@transvirtual.com>
To: Robert Love <rml@tech9.net>
cc: Alex Khripin <akhripin@mit.edu>, linux-kernel@vger.kernel.org
Subject: Re: BKL in tty code?
In-Reply-To: <1012418760.3219.43.camel@phantasy>
Message-ID: <Pine.LNX.4.10.10201301454160.7609-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > I'm very much a newbie, and I'm wondering about the big kernel locks
> > in tty_io.c. What exactly are the locks in the read and write for? Is the
> > tty device that contested? Couldn't a finer grained lock be used?
> 
> It has less to do with lock contention and much more to do with the
> design of the tty / console layer.  It isn't the kernel's prettiest
> code.
> 
> There is probably some cleanup that is possible, but really getting the
> thing in gear (which means no BKL, which is probably the hardest part to
> rip out) require some level of rewrite.

I'm working on it in the DJ tree. I'm going from the lowest level up to
the tty layer. I agree with about the BKL. I plan to move
acquire_console_lock into the tty lock shortly. No reason that only the VT
system should be able to take advantage of it. I also plan to implement
that lock on a per hardware device level instead of a general global lock. 
This will solve alot of problems. Plus their is no reason why serial
devices or VT tty system have to reimplement the wheel. 

