Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129667AbQK2BOJ>; Tue, 28 Nov 2000 20:14:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129764AbQK2BN7>; Tue, 28 Nov 2000 20:13:59 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:19727 "EHLO virtualhost.dk")
        by vger.kernel.org with ESMTP id <S129667AbQK2BNq>;
        Tue, 28 Nov 2000 20:13:46 -0500
Date: Wed, 29 Nov 2000 01:43:29 +0100
From: Jens Axboe <axboe@suse.de>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: "David S. Miller" <davem@redhat.com>, viro@math.psu.edu,
        linux-kernel@vger.kernel.org, tytso@valinux.com
Subject: Re: 2.4.0-test11 ext2 fs corruption
Message-ID: <20001129014329.C23771@suse.de>
In-Reply-To: <E2C40AB5D29@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E2C40AB5D29@vcnet.vc.cvut.cz>; from VANDROVE@vc.cvut.cz on Tue, Nov 28, 2000 at 09:46:56PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28 2000, Petr Vandrovec wrote:
> On 28 Nov 00 at 12:04, David S. Miller wrote:
> > 
> >    Yes, it is identical copy. But I do not think that hdd can write same
> >    data into two places with one command...
> > 
> > Petr, did the af_inet.c assertions get triggered on this
> > same machine?
> 
> No, ext2fs is at home, and af_inet is at work... At work I'm using
> vmware, at home I do not use it... But kernel sources are same
> (g450 patch for matroxfb, ncpfs supporting device nodes, threaded ipx;
> but neither ncpfs nor ipx is compiled at home).
>                                                    Petr Vandrovec
>                                                    vandrove@vc.cvut.cz

Petr,

Could you try and reproduce with attached patch? If this would trigger
I would assume fs corruption as well (which doesn't seem to be the
case for you), but it's worth a shot.

--- drivers/block/ll_rw_blk.c~	Wed Nov 29 01:30:22 2000
+++ drivers/block/ll_rw_blk.c	Wed Nov 29 01:33:00 2000
@@ -684,7 +684,7 @@
 	int max_segments = MAX_SEGMENTS;
 	struct request * req = NULL, *freereq = NULL;
 	int rw_ahead, max_sectors, el_ret;
-	struct list_head *head = &q->queue_head;
+	struct list_head *head;
 	int latency;
 	elevator_t *elevator = &q->elevator;
 
@@ -734,6 +734,7 @@
 	 */
 again:
 	spin_lock_irq(&io_request_lock);
+	head = &q->queue_head;
 
 	/*
 	 * skip first entry, for devices with active queue head

-- 
* Jens Axboe <axboe@suse.de>
* SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
