Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129069AbQKMPet>; Mon, 13 Nov 2000 10:34:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129103AbQKMPei>; Mon, 13 Nov 2000 10:34:38 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:9989 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S129069AbQKMPeX>;
	Mon, 13 Nov 2000 10:34:23 -0500
Message-ID: <3A1009DB.CC98CE06@mandrakesoft.com>
Date: Mon, 13 Nov 2000 10:33:47 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
CC: torvalds@transmeta.com, dhinds@valinux.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pcmcia event thread. (fwd)
In-Reply-To: <3A10031B.79D8A9B5@mandrakesoft.com>  <3A0FF138.A510B45@mandrakesoft.com> <7572.974120930@redhat.com> <20554.974126251@redhat.com> <26373.974128444@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse wrote:
> jgarzik@mandrakesoft.com said:
> > In any case, we -really- need a wait_for_kernel_thread_to_die()
> > function.
> 
> up_and_exit() would do it. Or preferably passing the address of the
> semaphore as an extra argument to kernel_thread() in the first place.

Any solution which involves a function being called from a kernel
thread, and/or passing another arg to a kernel thread, is a non-starter
...  See the discussion about timer_exit() a while ago.  This sort of
thing should be done at a higher level.  Not only does that eliminate
any possibility of a race between thread function calling
MOD_DEC_USE_COUNT/up_and_exit and module unload, but it also allows us
to more easily implement wait_for_kernel_thread_to_die() without having
to do silly stuff like pass extra args to threads (...modifying the
thread API in the process).

IMHO it is possible to solve this in a generic way without having to
change the code for every single kernel thread.


Thanks for all the explanation, I think I now understand all the stuff
your kernel thread is doing.  Your solution sounds like a decent
solution for the problem described.  I have not looked at the socket
driver code observe parse_events() usage, so I cannot say whether your
problem description is accurate however :)

	Jeff


-- 
Jeff Garzik             |
Building 1024           | The chief enemy of creativity is "good" sense
MandrakeSoft            |          -- Picasso
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
