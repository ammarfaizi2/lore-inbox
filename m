Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289752AbSAJWlu>; Thu, 10 Jan 2002 17:41:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289756AbSAJWln>; Thu, 10 Jan 2002 17:41:43 -0500
Received: from mx2.elte.hu ([157.181.151.9]:38606 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S289752AbSAJWl2>;
	Thu, 10 Jan 2002 17:41:28 -0500
Date: Fri, 11 Jan 2002 01:38:51 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: [patch] O(1) scheduler, -H5
Message-ID: <Pine.LNX.4.33.0201110130290.11478-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the -H5 patch adds a debugging check:

    http://redhat.com/~mingo/O(1)-scheduler/sched-O1-2.5.2-pre11-H5.patch

it adds code to catch places that call schedule() from global-cli()
sections. Right now release_kernel_lock() doesnt automatically release the
IRQ lock if there is no kernel lock held. A fair amount of code does this
still, and i think we should fix them in 2.5.

(Such code, while of questionable quality, is safe if it also holds the
big kernel lock, but it's definitely SMP-unsafe it doesnt hold the bkl -
the BUG() assert only catches the later case.)

(Andi Kleen noticed this on the first day the patch was released, and
Andrew Morton reminded me today that i forgot to fix it ... :-| )

my systems do not trigger the BUG(), so there cannot be all that much
broken code left.

	Ingo

