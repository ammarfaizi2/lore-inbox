Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131029AbQKQTrU>; Fri, 17 Nov 2000 14:47:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131084AbQKQTrK>; Fri, 17 Nov 2000 14:47:10 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:29941 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S130441AbQKQTrE>; Fri, 17 Nov 2000 14:47:04 -0500
Date: Fri, 17 Nov 2000 17:15:52 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Andrea Arcangeli <andrea@suse.de>
cc: schwidefsky@de.ibm.com, Linus Torvalds <torvalds@transmeta.com>,
        mingo@chiara.elte.hu, linux-kernel@vger.kernel.org
Subject: Re: Memory management bug
In-Reply-To: <20001117191125.B27834@athlon.random>
Message-ID: <Pine.LNX.4.21.0011171713350.371-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Nov 2000, Andrea Arcangeli wrote:

> Plus I add that the "if (!order) goto try_again" is an obvious
> deadlock prone bug introduce in test9 that should be removed.

1) how would this cause deadlocks?
2) how would this somehow be worse than the
   unconditional 'goto try_again' we had before?

This goto is ok because we have the OOM killer, which will select
a process to kill when we run out of memory. Also, the goto will
make sure that OTHER processes will survive while the "guilty"
process will be killed.

The guilty process will never get to the goto because it will
have PF_MEMALLOC set.

regards,

Rik
--
"What you're running that piece of shit Gnome?!?!"
       -- Miguel de Icaza, UKUUG 2000

http://www.conectiva.com/		http://www.surriel.com/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
