Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314458AbSE2SHX>; Wed, 29 May 2002 14:07:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314483AbSE2SHW>; Wed, 29 May 2002 14:07:22 -0400
Received: from hera.cwi.nl ([192.16.191.8]:49287 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S314458AbSE2SHV>;
	Wed, 29 May 2002 14:07:21 -0400
From: Andries.Brouwer@cwi.nl
Date: Wed, 29 May 2002 20:07:13 +0200 (MEST)
Message-Id: <UTC200205291807.g4TI7DN15827.aeb@smtp.cwi.nl>
To: dalecki@evision-ventures.com, torvalds@transmeta.com
Subject: Re: [PATCH] 2.5.18 IDE 73
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    - Don't allow check_partition to be more clever then the writer of a driver.
       It was interfering with drivers which check partitions as they go and
       finally if we want to spew something about it - we can do it ourself.

    - Eliminate ide_geninit(). We scan for partitions now inside the recently
       introduced attach method. register_disk() is broken by the way and 90% of
       places where it's used it is doing literally nothing. Either some one didn't
       finish some code or the code is basically just junk from the past.

       Anyway we grok the partitions now one by one as we detect the channels.

Pity you send this gzipped, otherwise I would have looked at the code.

Yes, 90% of the uses of register_disk() are empty. I submitted a patch
to remove this cruft last year, but Al was attached to it - wanted to
make them nonempty.

About scanning for partitions I say the same thing I said to Al a few
days ago:
Several partitioning schemes exist, and reading partition tables is not
something a driver should do without getting explicit requests.
For all we know the disk contents may be completely random.

You should offer the list of disks seen to user space, and user space
should decide which disks have to be investigated, and tell the kernel
about the partitions it wants to have on these disks.
That way all knowledge about partitioning, dynamic disks, disk managers
and the like is removed from the kernel, and moved into partx-type code.


Andries
