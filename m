Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267527AbSKQRVA>; Sun, 17 Nov 2002 12:21:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267528AbSKQRVA>; Sun, 17 Nov 2002 12:21:00 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:57873 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267527AbSKQRU7>; Sun, 17 Nov 2002 12:20:59 -0500
Date: Sun, 17 Nov 2002 09:28:05 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org, Luca Barbieri <ldb@ldb.ods.org>
Subject: Re: [patch] threading fix, tid-2.5.47-A3
In-Reply-To: <Pine.LNX.4.44.0211171314200.7001-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0211170922020.4425-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 17 Nov 2002, Ingo Molnar wrote:
> 
> the problem is the following: the 'initial thread', ie. the 'process',
> does not have any ->user_tid value set. But still it's a generic thread
> that can be pthread_join()-ed upon. (but pthread_join() does not work, the
> kernel does not do the futex wakeup because ->user_tid is NULL.)

There is no way in _hell_ that the correct way to handle this is by doing 
magic things at execve() time. Stop that NOW!

First off, a program had better be correctly startable even if the 
process that does the execve() is _not_ using the new glibc. If I have an 
old "bash" binary, and that means that I cannot start up new binaries 
correctly, that is BROKEN. It's so incredibly broken that it's scary.

Why not do it the _sane_ way, with a system call in crt0.S instead to set 
up the user_tid if you want it?

This patch is crap, or at least needs a ton more explanation about why you 
would do something that looks quite this horrible and stupid.

		Linus

