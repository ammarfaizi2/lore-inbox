Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131390AbQK2NN6>; Wed, 29 Nov 2000 08:13:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131415AbQK2NNs>; Wed, 29 Nov 2000 08:13:48 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:54757 "EHLO math.psu.edu")
        by vger.kernel.org with ESMTP id <S131390AbQK2NNb>;
        Wed, 29 Nov 2000 08:13:31 -0500
Date: Wed, 29 Nov 2000 07:43:04 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: schwidefsky@de.ibm.com
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-test11 ext2 fs corruption
In-Reply-To: <C12569A6.00448FBB.00@d12mta07.de.ibm.com>
Message-ID: <Pine.GSO.4.21.0011290740100.14112-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 29 Nov 2000 schwidefsky@de.ibm.com wrote:

> 
> 
> >--- drivers/block/ll_rw_blk.c~  Wed Nov 29 01:30:22 2000
> >+++ drivers/block/ll_rw_blk.c   Wed Nov 29 01:33:00 2000
> >@@ -684,7 +684,7 @@
> >        int max_segments = MAX_SEGMENTS;
> >        struct request * req = NULL, *freereq = NULL;
> >        int rw_ahead, max_sectors, el_ret;
> >-       struct list_head *head = &q->queue_head;
> >+       struct list_head *head;
> >        int latency;
> >        elevator_t *elevator = &q->elevator;
> 
> head = &q->queue_head is a simple offset calculation in the request
> queue structure. Moving this into the spinlock won't change anything,
> since q->queue_head isn't a pointer that can change.

That's fine, but head is _re_assigned later. Grep for 'head =' and 'again'
in __make_request().

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
