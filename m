Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136021AbRDVKlo>; Sun, 22 Apr 2001 06:41:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136022AbRDVKle>; Sun, 22 Apr 2001 06:41:34 -0400
Received: from [212.150.182.35] ([212.150.182.35]:27144 "EHLO
	exchange.guidelet.com") by vger.kernel.org with ESMTP
	id <S136021AbRDVKlZ>; Sun, 22 Apr 2001 06:41:25 -0400
Message-ID: <041c01c0cb21$1dd520c0$910201c0@zapper>
From: "Alon Ziv" <alonz@nolaviz.org>
To: <linux-kernel@vger.kernel.org>
In-Reply-To: <E14qHRp-0007Yc-00@the-village.bc.nu> <Pine.LNX.4.31.0104190944090.4074-100000@penguin.transmeta.com> <E14qXEU-0005xo-00@g212.hadiko.de> <9bqgvi$63q$1@penguin.transmeta.com> <3AE10741.FA4E40BD@gmx.de> <E14rGU8-0003zk-00@g212.hadiko.de>
Subject: Re: light weight user level semaphores
Date: Sun, 22 Apr 2001 13:41:04 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All of this FD allocation stuff is truly distrurbing.
This appears to be the one place where Win32 got it (almost) right---
quite about every kernel object looks to userland just like an opaque
handle, and the same operations apply to all of them.
So (e.g.) a mixed wait for socket operation or a semaphore or a timer
is very simple.
The only abstraction we have that is even remotely similar is the FD,
yet its semantics are far too strict to use this way.
The only remotely-feasible idea I've had, so far, was to allow
"negative" FDs (i.e., numbered 0x80000000+) to be used for semaphores;
this sidesteps the POSIX requirements (= we can just claim we don't
support more than 2G FDs per process), but still leaves us with the
problems of managing a split (or extremely large) FD table _and_ with
the issue of allocation policy...
Besides, as Linus already said, FDs are likely not the right abstraction
for objects without file behavior, like semaphores or timers.

[BTW, another solution is to truly support opaque "handles" to kernel
objects; I believe David Howells is already working on something like
this for Wine? The poll interface can be trivially extended to support
waiting on those...]

    -az

