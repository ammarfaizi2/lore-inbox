Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131164AbQLILuw>; Sat, 9 Dec 2000 06:50:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131313AbQLILum>; Sat, 9 Dec 2000 06:50:42 -0500
Received: from www.wen-online.de ([212.223.88.39]:5384 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S131164AbQLILu3>;
	Sat, 9 Dec 2000 06:50:29 -0500
Date: Sat, 9 Dec 2000 12:19:44 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: Rik van Riel <riel@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: HowTo: 2.4.0-test12 repeatable OOM-death
Message-ID: <Pine.Linu.4.10.10012091054560.349-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I found a way to reliably OOM test12-pre7 to death. (not my goal;)

1. Start a make -jN bzImage where N is large enough to swap ~hard.
2. Let it ramp up such that oh, say 50mb is in swap and then ^C.

... repeat a few times to verify that all jobs terminate properly,
and that you can do this until blue in the face.  (don't be suprised
if you start seeing occasional SIGSEGV [yes, even on UP boxen] after
doing this for a while, but what comes next is nasty)

3. swapoff -a; swapon -a
4. goto 1

You should now see is the box go swap NUTS, and run all the way into
OOM as soon as you interrupt the build.  I just finished repeating
this in virgin test12-pre7 enough times to call it fully repeatable.

If you SysRq-E before it kills bash and leaves zillion zombies lying
around, it'll seem to recover.  You'll likely decide to reboot pretty
shortly thereafter ;-)

	-Mike

-- Versions installed: (if some fields are empty or look
-- unusual then possibly you have very old versions)
Linux el-kaboom 2.4.0-test12 #1 Sat Dec 9 08:29:23 CET 2000 i686 unknown
Kernel modules         2.3.21
Gnu C                  gcc-2.95.2
Binutils               2.10.1.0.2
Linux C Library        > libc.2.2
Dynamic linker         ldd (GNU libc) 2.2
Procps                 2.0.6
Mount                  2.10o
Net-tools              1.53
Kbd                    0.99
Sh-utils               2.0
Modules Loaded         nls_iso8859-1 nls_cp437 vfat fat

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
