Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275693AbRKMQoD>; Tue, 13 Nov 2001 11:44:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276344AbRKMQn7>; Tue, 13 Nov 2001 11:43:59 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:28938 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S275693AbRKMQnq>; Tue, 13 Nov 2001 11:43:46 -0500
Subject: Re: Tuning Linux for high-speed disk subsystems
To: roy@karlsbakk.net (Roy Sigurd Karlsbakk)
Date: Tue, 13 Nov 2001 16:51:21 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, lars.nakkerud@compaq.com
In-Reply-To: <Pine.LNX.4.30.0111131519440.933-100000@mustard.heime.net> from "Roy Sigurd Karlsbakk" at Nov 13, 2001 03:29:13 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E163gmP-0001eI-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> After some testing at Compaq's lab in Oslo, I've come to the conclusion
> that Linux cannot scale higher than about 30-40MB/sec in or out of a
> hardware or software RAID-0 set with several stripe/chunk sizes tried out.
> The set is based on 5 18GB 10k disks running SCSI-3 (160MBps) alone on a
> 32bit/33MHz PCI bus.

I'm beating that with IDE 8)

> After speking to the storage guys here, I was told the problem generally
> was that the OS should send the data requests at 256kB block sizes, as the
> drives (10k) could handle 100 I/O operations per second, and thereby could

Right now we tend to queue 128 blocks per write. That can be tuned if you
want to play with it. 

> Does anyone know this stuff good enough to help me how to tune the system?
> PS: The CPUs were almost idle during the test. Tested file system was
> ext2.

Im not sure the best way to get big linear blocks in the ext2 layout or
if perhaps XFS would do that job better, but the physical layer comes
down the the block limit, scsi max sectors per I/O set by the controller
and to an extent the vm readahead (tunable in -ac kernels - the patch
to md.c should tell you how to hack md for that)

