Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319623AbSH3RJj>; Fri, 30 Aug 2002 13:09:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319624AbSH3RJj>; Fri, 30 Aug 2002 13:09:39 -0400
Received: from mx1.elte.hu ([157.181.1.137]:33482 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S319623AbSH3RJi>;
	Fri, 30 Aug 2002 13:09:38 -0400
Date: Fri, 30 Aug 2002 19:16:27 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@zip.com.au>
Subject: Re: [patch] scheduler fixes, 2.5.32-BK
In-Reply-To: <Pine.LNX.4.44.0208301902570.527-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0208301910430.821-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


we used to have the global semaphore_lock - which, if used separately from
the waitqueue lock, indeed can cause the unuse of the semaphore structure
before the spin_unlock in wakeup() completes.

but since 2.5.25 or so we use the semaphore waitqueue's spinlock for
semaphore locking - this also neatly solves the semaphore-unuse problem.  
Four architectures, sparc, ia64, arm and x86-64 still use the global
semaphore_lock, but the other 13 architectures use the waitqueue spinlock
already.

(unless there's something else i missed.)

	Ingo


