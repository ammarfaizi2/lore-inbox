Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265204AbTLKRxC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 12:53:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265208AbTLKRxC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 12:53:02 -0500
Received: from mail.eskimo.com ([204.122.16.4]:31762 "EHLO mail.eskimo.com")
	by vger.kernel.org with ESMTP id S265204AbTLKRw4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 12:52:56 -0500
Date: Thu, 11 Dec 2003 09:52:53 -0800 (PST)
From: Nanook <nanook@eskimo.com>
To: linux-kernel@vger.kernel.org
Subject: UltraSparc st driver question
Message-ID: <Pine.GSU.4.44.0312110941500.6413-100000@invisible.eskimo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


     I'd appreciate a CC to nanook@eskimo.com with any reply.  I subscribed
to the list but so far haven't received the confirmation after auth'ing.

     I'm running Linux 2.2.25 on an Ultra-2 with dual 400mhz CPU's.  I've got
one of the old combo 10-base-T/narrow SCSI cards in it that I use to connect an
Exabyte DN-8500C tape drive.

     Yes, I know the drive is antique and I know the kernel is old, long story
regarding why I haven't migrated to 2.4.x yet having to do with the fact
that I applied the RAID super block patches way back when and then the
implimentation in 2.4 ended up being incompatible...

     Anyway, with the 32k buffer as defined by default in:

	/usr/src/linux/drivers/scsi/st_options.h

     The machine will not stream the drive during backups and I get relatively
poor compression effeciency (around 20%).

     If I increase this buffer size to 256k by changing the define:

	#define ST_BUFFER_BLOCKS 32

     to:

	#define ST_BUFFER_BLOCKS 256

     And compile a new kernel, the write performance then approximately
doubles, the driver streams, the compression actually exceeds 2:1, life is
good EXCEPT...

     With the buffer set to 256 1k blocks, an attempt to read the tape results
in kernel panics, and they seem more or less random.  Something about
local_irq_count comes up frequently but I see all sorts of different ones.

     Anything larger than 64 1k blocks seems to cause this.  With 64k it
doesn't panic the kernel, but it also gives tape read errors and doesn't work.

     Looking at the code for st.c and esp.c, it appears to block/deblock so I
don't understand why a larger buffer would break the ability to read a tape,
especially when it seems to write fine.

     Is there a secret to making this buffer large enough for effecient
streaming operation without breaking the driver?

     Also, another thing I've run into, the documentation for the Exabyte drive
says it can do physical records up to 240k, but if I set the record size larger
than 64k I get weird errors relating to esp1 and it malfunctions.

     I've been thinking about either going to DLT or a Mamoth2, but if I can't
get the driver to feed the drive fast enough to stream, then a faster drive is
moot.

     I've done google searches and searches of the list archive and not seeing
anything about these problems.  I've seen messages from other people who say
they've jacked up the buffer with no problems but not running UltraSparc
hardware.  Is there something broken in the esp driver that doesn't like the
larger buffer?



