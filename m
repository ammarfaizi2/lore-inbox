Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315940AbSEJM6k>; Fri, 10 May 2002 08:58:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315953AbSEJM6k>; Fri, 10 May 2002 08:58:40 -0400
Received: from chaos.analogic.com ([204.178.40.224]:1664 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S315940AbSEJM6j>; Fri, 10 May 2002 08:58:39 -0400
Date: Fri, 10 May 2002 08:58:47 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: spin-locks
Message-ID: <Pine.LNX.3.95.1020510084519.1902A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings lock wizards

I have discovered some things that I don't understand.

First, if I create a spin-lock in the ".data" segment it
doesn't work on a SMP machine with two CPUs. I know I am
supposed to use the macros, but I have some high-speed stuff
written in assembly that needs a spin-lock. The 'doesn't work'
is that the spin-lock seems to dead-lock, i.e., they loop
forever with the interrupts disabled. I think what's really
happening is that .data was paged and can't be paged back in
with the interrupts off. I don't know. This stuff used to
work....

In earlier versions of Linux, the locks were in .text_lock.
Now they are in : _text_lock_KBUILD_BASENAME

So, what is special about this area that allows locks to work?
And, what is special about .data that prevents them from working?

Also, there is a potential bug (ducks and hides under the desk) in
the existing spin-lock unlocking. To unlock, the lock is simply
set to 1. This works if you have two CPUs, but what about more?

Shouldn't the lock/unlock just be incremented/decremented so 'N' CPUs
can pound on it?

Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

