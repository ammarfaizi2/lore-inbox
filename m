Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267674AbSLSWR6>; Thu, 19 Dec 2002 17:17:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267655AbSLSWRA>; Thu, 19 Dec 2002 17:17:00 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:5129 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267674AbSLSWQR>; Thu, 19 Dec 2002 17:16:17 -0500
Date: Thu, 19 Dec 2002 14:22:12 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
cc: bart@etpmod.phys.tue.nl, <davej@codemonkey.org.uk>, <hpa@transmeta.com>,
       <terje.eggestad@scali.com>, <drepper@redhat.com>,
       <matti.aarnio@zmailer.org>, <hugh@veritas.com>, <mingo@elte.hu>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Intel P6 vs P7 system call performance
In-Reply-To: <20021219221043.GA18562@bjl1.asuk.net>
Message-ID: <Pine.LNX.4.44.0212191412180.1629-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 19 Dec 2002, Jamie Lokier wrote:
> Linus Torvalds wrote:
> > For _zero_ gain.  The jump to the library address has to be indirect 
> > anyway, and glibc has several places to put the information without any 
> > mmap's or anything like that.
> 
> This is not true, (but your overall point is still correct).

Go back and read the postings by Uli.

Uli's suggested glibc approach is to just put the magis system call 
address (which glibc gets from the AT_SYSINFO elf aux table entry) into 
the per-thread TLS area, which is alway spointed to by %gs anyway.

THIS WORKS WITH ALL DSO'S WITHOUT ANY GAMES, ANY MMAP'S, ANY RELINKING, OR
ANY EXTRA WORK AT ALL!

The system call entry becomes a simple

	call *%gs:constant-offset

Not mmap. No magic system calls. No relinking. Not _nothing_. One 
instruction, that's it. 

See for example Uli's posting in this thread from the day before
yesterday, message ID <3DFF6D4B.3060107@redhat.com>. So please stop 
arguing about any extra work, because none is needed.

		Linus

