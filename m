Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313087AbSEYAZH>; Fri, 24 May 2002 20:25:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313113AbSEYAZG>; Fri, 24 May 2002 20:25:06 -0400
Received: from hera.cwi.nl ([192.16.191.8]:57037 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S313087AbSEYAZF>;
	Fri, 24 May 2002 20:25:05 -0400
From: Andries.Brouwer@cwi.nl
Date: Sat, 25 May 2002 02:24:22 +0200 (MEST)
Message-Id: <UTC200205250024.g4P0OM005850.aeb@smtp.cwi.nl>
To: torvalds@transmeta.com, viro@math.psu.edu
Subject: Re: [RFC] change of ->bd_op->open() semantics
Cc: axboe@suse.de, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al writes:

    4) moving the call of partition-reading code into do_open() (for cases when
    ->bd_contains is non-NULL), killing the "set block_device fields by hand"
    mess in check_partitions()

Hmm. I probably misunderstand some things.

There must be a data structure with the information that belongs
to a disk, opened or not. The size, the sectorsize, the partitions, ...
The structure that I made kdev_t point at.

What are you working towards? There is a struct block_device.
But it is not permanent. It is created when the device is opened
and disappears when it is closed.
So it doesnt help in replacing kdev_t - the permanent data must still
be somewhere. There is a struct gendisk. That is better.
It is not difficult to make sure that all devices that have array data
also get a struct gendisk.
Then there is struct request_queue. I see that it got hardsect_size,
but it seems a less suitable place for general disk info.

[So, let me repeat: Question: where do you plan to put permanent
disk data?]

Now about this partition-reading code. It requires a partitiontable type,
just like mounting requires a filesystem type. Now mount() has a
parameter that specifies the filesystem type. But open() does not
have a parameter that specifies a partitiontable type.
It seems to me that doing partitiontable reading in do_open()
is a really bad idea.

Maybe you have a "do it only once" kludge in mind?
To get something ugly, equivalent to the present situation?

Andries
