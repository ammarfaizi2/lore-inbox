Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265002AbSLVLAg>; Sun, 22 Dec 2002 06:00:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265058AbSLVLAg>; Sun, 22 Dec 2002 06:00:36 -0500
Received: from ore.jhcloos.com ([64.240.156.239]:20996 "EHLO ore.jhcloos.com")
	by vger.kernel.org with ESMTP id <S265002AbSLVLAe>;
	Sun, 22 Dec 2002 06:00:34 -0500
To: <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Ulrich Drepper <drepper@redhat.com>
Subject: Re: Intel P6 vs P7 system call performance
References: <Pine.LNX.4.44.0212191412180.1629-100000@penguin.transmeta.com>
From: "James H. Cloos Jr." <cloos@jhcloos.com>
In-Reply-To: <Pine.LNX.4.44.0212191412180.1629-100000@penguin.transmeta.com>
Date: 22 Dec 2002 06:08:24 -0500
Message-ID: <m3el8awbtj.fsf@lugabout.jhcloos.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus> The system call entry becomes a simple

Linus> 	call *%gs:constant-offset

Linus> Not mmap. No magic system calls. No relinking. Not
Linus> _nothing_. One instruction, that's it.

I presume *%gs:0x18 is only for shared objects?

A naïve:

-               asm volatile("call 0xffffe000"
+               asm volatile("call *%%gs:0x18"

in the trivial getppid benchmark code gives a SEGV, since
(according to gdb's info all-registers) %gs == 0 when it runs.

Is it just that my glibc is too old, or is there a shared vs static difference?

-JimC

P.S.    On a (1 Gig) mobile p3 the getppid bench gives ~333 cycles for
        int $0x80 and ~215 for call 0xffffe000, before yesterday's push.

