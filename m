Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267440AbTAGRjJ>; Tue, 7 Jan 2003 12:39:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267441AbTAGRjJ>; Tue, 7 Jan 2003 12:39:09 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:64011 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267440AbTAGRjH>; Tue, 7 Jan 2003 12:39:07 -0500
Date: Tue, 7 Jan 2003 09:42:15 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
cc: Zack Weinberg <zack@codesourcery.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Set TIF_IRET in more places
In-Reply-To: <20030107111905.GA949@bjl1.asuk.net>
Message-ID: <Pine.LNX.4.44.0301070939310.1913-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 7 Jan 2003, Jamie Lokier wrote:
> 
> Voila!  sigreturn() can be written to avoid entering the kernel.  Note
> that this is possible _now_, with no changes to the kernel.  It only
> requires changes to libc.  I think it would work on all architectures,
> not just i386.  (It may also be possible to do it without libc help,
> in the vsyscall page).

I'd certainly prefer playing these kinds of games _without_ any libc 
involvement, since making libc play games like this is fragile as hell and 
works really badly for threaded applications, for example (delivering 
signals to threads is _hard_ to get right, that's one of the things 2.5.x 
finally does thanks to Ingo and Uli).

But moving the signal trampoline to vsyscall space to prepare for changes 
like this is a good idea. I'll remove the SA_RESTORER logic too.

		Linus

