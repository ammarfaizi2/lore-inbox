Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131408AbRAVBb1>; Sun, 21 Jan 2001 20:31:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131533AbRAVBbS>; Sun, 21 Jan 2001 20:31:18 -0500
Received: from hera.cwi.nl ([192.16.191.1]:16792 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S131408AbRAVBbH>;
	Sun, 21 Jan 2001 20:31:07 -0500
Date: Mon, 22 Jan 2001 02:31:04 +0100 (MET)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200101220131.CAA176461.aeb@vlet.cwi.nl>
To: aia21@cam.ac.uk
Subject: Re: Getting the number of 512-byte sectors?
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From: Anton Altaparmakov <aia21@cam.ac.uk>
    Subject: Getting the number of 512-byte sectors?

    My question is how to get the _real_ number of sectors of a partition from 
    within a file system. I.e. we are starting only with the knowledge of the 
    struct super_block for the partition.

As you conjectured already, you find this info in the gendisk->part[] array,
in the start_sect and nr_sects fields.

    Locate the correct gendisk structure by performing a walk of gendisk_head 
    as done in drivers/block/blkpg.c::get_gendisk(kdev_t), (Could we make this 
    function to not be private to blkpg.c?), then get the hd_struct for the 
    partition and obtain the values from that. In code:

    struct gendisk *g = get_gendisk(my_super_block->s_dev)
    struct hd_struct *hd = &g->part[MINOR(my_super_block->s_dev)];

    wanted "subtracted" values:
             hd->start_sect
             hd->nr_sects

    Am I missing something?

No, I agree completely.

    Note: I know I can normally get the number of sectors from the boot sector 
    of the partition

Not necessarily. The partition table need not be of DOS type.
Or, even if it is, the kernel's tables may be set up dynamically.

> Could we make this function to not be private to blkpg.c?

I think this area will change rather drastically in 2.5.*.

Andries
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
