Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288977AbSBDNnH>; Mon, 4 Feb 2002 08:43:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288981AbSBDNnB>; Mon, 4 Feb 2002 08:43:01 -0500
Received: from wep10a-3.wep.tudelft.nl ([130.161.65.38]:7439 "EHLO
	wep10a-3.wep.tudelft.nl") by vger.kernel.org with ESMTP
	id <S288977AbSBDNl5>; Mon, 4 Feb 2002 08:41:57 -0500
Date: Mon, 4 Feb 2002 14:41:46 +0100 (CET)
From: Taco IJsselmuiden <taco@wep.tudelft.nl>
Reply-To: Taco IJsselmuiden <taco@wep.tudelft.nl>
To: Jens Axboe <axboe@suse.de>
cc: Paul Bristow <paul@paulbristow.net>, linux-kernel@vger.kernel.org
Subject: Re: [OOPS] Oops with ide-floppy in 2.5.2 / 2.5.3
In-Reply-To: <20020204091509.Q29553@suse.de>
Message-ID: <Pine.LNX.4.21.0202041440390.23695-100000@banaan.taco.dhs.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens, Paul,

> If the driver knows what it is doing, then this patch should cure your
> problem.
> 
> --- drivers/ide/ide.c~        Mon Feb  4 09:12:10 2002
> +++ drivers/ide/ide.c Mon Feb  4 09:14:39 2002
> @@ -1784,6 +1784,8 @@
>       if (blk_queue_empty(&drive->queue) || action == ide_preempt) {
>               if (action == ide_preempt)
>                       hwgroup->rq = NULL;
> +             if (!blk_queue_empty(&drive->queue))
> +                     list_entry_rq(queue_head)->flags &= ~REQ_STARTED;
>       } else {
>               if (action == ide_wait || action == ide_end) {
>                       queue_head = queue_head->prev;
> 

when using this in vanilla 2.5.3 it continues to oops.
But, when using Ingo's K0 on top of 2.5.3 it 'works' with this patch.
That is: it doesn't oops.
it now just goes:
brood:~# insmod ide-floppy
using /lib/modules/2.5.3-K0/kernel/drivers/ide/ide-floppy.o
ide-floppy driver 0.98a
hdd: 98304kB, 196608 blocks, 512 sector size


and doesn't return to the prompt

and /proc/modules has
ide-floppy             11744 (initializing)
(even after waiting a _LONG_ time....)



Cheers,
Taco.


