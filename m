Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131169AbQK2NAF>; Wed, 29 Nov 2000 08:00:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131224AbQK2M7q>; Wed, 29 Nov 2000 07:59:46 -0500
Received: from d12lmsgate-3.de.ibm.com ([195.212.91.201]:29944 "EHLO
        d12lmsgate-3.de.ibm.com") by vger.kernel.org with ESMTP
        id <S131169AbQK2M7h> convert rfc822-to-8bit; Wed, 29 Nov 2000 07:59:37 -0500
From: schwidefsky@de.ibm.com
X-Lotus-FromDomain: IBMDE
To: linux-kernel@vger.kernel.org
Message-ID: <C12569A6.00448FBB.00@d12mta07.de.ibm.com>
Date: Wed, 29 Nov 2000 13:21:17 +0100
Subject: Re: 2.4.0-test11 ext2 fs corruption
Mime-Version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>--- drivers/block/ll_rw_blk.c~  Wed Nov 29 01:30:22 2000
>+++ drivers/block/ll_rw_blk.c   Wed Nov 29 01:33:00 2000
>@@ -684,7 +684,7 @@
>        int max_segments = MAX_SEGMENTS;
>        struct request * req = NULL, *freereq = NULL;
>        int rw_ahead, max_sectors, el_ret;
>-       struct list_head *head = &q->queue_head;
>+       struct list_head *head;
>        int latency;
>        elevator_t *elevator = &q->elevator;

head = &q->queue_head is a simple offset calculation in the request
queue structure. Moving this into the spinlock won't change anything,
since q->queue_head isn't a pointer that can change.

Independent of that I can second the observation that test11 can corrupt
ext2 in memory. I think that this is related to the memory management
problems I see but I can't prove it yet.

blue skies,
   Martin

Linux/390 Design & Development, IBM Deutschland Entwicklung GmbH
Schönaicherstr. 220, D-71032 Böblingen, Telefon: 49 - (0)7031 - 16-2247
E-Mail: schwidefsky@de.ibm.com


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
