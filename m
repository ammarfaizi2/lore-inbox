Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265063AbSKJSxe>; Sun, 10 Nov 2002 13:53:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265064AbSKJSxe>; Sun, 10 Nov 2002 13:53:34 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:51462 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265063AbSKJSxd>; Sun, 10 Nov 2002 13:53:33 -0500
Date: Sun, 10 Nov 2002 10:59:55 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Pavel Machek <pavel@ucw.cz>
cc: vojtech@ucw.cz, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "J.E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
       john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Voyager subarchitecture for 2.5.46
In-Reply-To: <20021110163012.GB1564@elf.ucw.cz>
Message-ID: <Pine.LNX.4.44.0211101050170.9581-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 10 Nov 2002, Pavel Machek wrote:
> 
> Unfortunately, this means "bye bye vsyscalls for gettimeofday".

Not necessarily. All of the fastpatch and the checking can be done by the
vsyscall, and if the vsyscall notices that there is a backwards jump in
time it just gives up and does a real system call. The vsyscall does need
to figure out the CPU it's running on somehow, but that should be solvable
- indexing through the thread ID or something.

That said, I suspect that the real issue with vsyscalls is that they don't
really make much sense. The only system call we've ever found that matters
at all is gettimeofday(), and the vsyscall implementation there looks like
a "cool idea, but doesn't really matter (and complicates things a lot)".

The system call overhead tends to scale up very well with CPU speed (the
one esception being the P4 which just has some internal problems with "int
0x80" and slowed down compared to a PIII).

So I would just suggest not spending a lot of effort on it, considering
the problems it already has. 

		Linus

