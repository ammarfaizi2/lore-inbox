Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131858AbQLVNvT>; Fri, 22 Dec 2000 08:51:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131944AbQLVNvJ>; Fri, 22 Dec 2000 08:51:09 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:8209 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S131858AbQLVNvA>; Fri, 22 Dec 2000 08:51:00 -0500
Date: Fri, 22 Dec 2000 14:19:29 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <andrewm@uow.edu.au>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@redhat.com>
Subject: Re: Linux 2.2.19pre2
Message-ID: <20001222141929.A13032@athlon.random>
In-Reply-To: <E147MkJ-00036t-00@the-village.bc.nu>, <E147MkJ-00036t-00@the-village.bc.nu>; <20001220142858.A7381@athlon.random> <3A40C8CB.D063E337@uow.edu.au>, <3A40C8CB.D063E337@uow.edu.au>; <20001220162456.G7381@athlon.random> <3A41DDB3.7E38AC7@uow.edu.au>, <3A41DDB3.7E38AC7@uow.edu.au>; <20001221161952.B20843@athlon.random> <3A4303AC.C635F671@uow.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3A4303AC.C635F671@uow.edu.au>; from andrewm@uow.edu.au on Fri, Dec 22, 2000 at 06:33:00PM +1100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 22, 2000 at 06:33:00PM +1100, Andrew Morton wrote:
> add_waitqueue_exclusive() and TASK_EXCLUSIVE, add a

There's no add_waitqueue_exclusive in my patch.

> Except for this bit, which looks slightly fatal:
> 
> 	/*
>          * We can drop the read-lock early if this
>          * is the only/last process.
>          */
>         if (next == head) {
>                  read_unlock(&waitqueue_lock);
>                  wake_up_process(p);
>                  goto out;
>         }
> 
> Once the waitqueue_lock has been dropped, the task at `p'
> is free to remove itself from the waitqueue and exit.  This
> CPU can then try to wake up a non-existent task, no?

Yes, that was an unlikely-to-happen SMP race I inerith from 2.2.18 and all
previous 2.2.x vanilla kernels. Thanks.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
