Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319083AbSHMSK4>; Tue, 13 Aug 2002 14:10:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319085AbSHMSK4>; Tue, 13 Aug 2002 14:10:56 -0400
Received: from mx2.elte.hu ([157.181.151.9]:20186 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S319083AbSHMSKz>;
	Tue, 13 Aug 2002 14:10:55 -0400
Date: Tue, 13 Aug 2002 20:14:53 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] exit_free(), 2.5.31-A0
In-Reply-To: <Pine.LNX.4.44.0208130834320.5192-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0208132009390.5990-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I was actually surprised to see how much effort it takes on the glibc side
to solve this (admittedly conceptually hard) problem without any kernel
help - it's ugly and slow, and still not completely tight. By providing
this 'exit and free stack' capability we can help tremendously.

the thing that makes it special and hard is the completely shared VM.  
There's just no way for a thread to 'get rid of itself' atomically and
also exit in the same round, without extensive locking and signal passing.
Linux actually has a very very fast clone()+exit() codepath, lets make it
possible for usespace to use it.

in essence the 'exit and send notification signal' thing now became a
simple word written into userspace. Should this be a more formal thing -
userspace mailboxes for the kernel to put events into? I think that might
be a bit overboard though.

	Ingo

