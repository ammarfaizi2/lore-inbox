Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132483AbQLHRsq>; Fri, 8 Dec 2000 12:48:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132415AbQLHRsg>; Fri, 8 Dec 2000 12:48:36 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:28433 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132483AbQLHRsZ>; Fri, 8 Dec 2000 12:48:25 -0500
Subject: Re: Pthreads, linux, gdb, oh my! (fwd)
To: peterb@telerama.com (Peter Berger)
Date: Fri, 8 Dec 2000 17:18:59 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.BSI.4.02.10012081150130.17198-100000@frogger.telerama.com> from "Peter Berger" at Dec 08, 2000 11:53:07 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E144RAj-0004BT-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have seen two failure modes:  on my machine (linux 2.2.5-22, glibc
> 2.1.1), when run under gdb 5.0, the created pthreads stick around as

glibc 2.1.1 definitely has problems with several bits of pthreads. You
want 2.1.3 or higher I believe.

> zombies until the machine runs out of resources.  On some friends'
> machines (kernel 2.2.15, glibc 2.1.94), the program creates one pthread,
> waits for it to exit, and then exits.
> 
> and happy, and look forward to finding out what it is.  If it's a kernel
> bug, I submit that this makes pthreads unusable, and want to inquire if
> anyone is working on fixing this?

Its unlikely to be remotely kernel related

>   tg->running++;
>   if (tg->running >= tg->created) {

tg->created may be out of date

>       /* Create a thread that will run and exit. */
>       rc = pthread_create(thread, attr, (void *)threads_test_count_seq_proc, tg

You can create it, count it, then up tg->created out of order



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
