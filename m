Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131794AbRCOTbN>; Thu, 15 Mar 2001 14:31:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131796AbRCOTaz>; Thu, 15 Mar 2001 14:30:55 -0500
Received: from fep02-0.kolumbus.fi ([193.229.0.44]:25032 "EHLO
	fep02-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id <S131794AbRCOTan>; Thu, 15 Mar 2001 14:30:43 -0500
Date: Thu, 15 Mar 2001 21:30:03 +0200 (EET)
From: Kai Makisara <Kai.Makisara@kolumbus.fi>
X-X-Sender: <makisara@kai.makisara.local>
To: Byron Stanoszek <gandalf@skylab.winds.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Need help with allocating a 2M buffer size
In-Reply-To: <Pine.LNX.4.31.0103151040280.2983-100000@skylab.winds.org>
Message-ID: <Pine.LNX.4.33.0103152121170.638-100000@kai.makisara.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Mar 2001, Byron Stanoszek wrote:

> I have a real picky tape drive (DLT series) that likes to be fed large chunks
> of data at once, otherwise after every 2-4KB of data it halts and rewinds
> itself because its cache for writing to the tape is empty.
>
> My best solution to this problem was to use 'tar -b 4096', which sends 4096 x
> 512-byte blocks at once for a total of a 2MB buffer size. This worked fine for
> several weeks, until 2 days ago I got this message (and the backup fails):
>
> st: failed to enlarge buffer to 2097152 bytes.
>
The default maximum number of scatter/gather segments in the tape driver
is 16. This means that big chunks of memory are needed to allocate a 2 MB
buffer. You can increase the number of segments up to, e.g., 128. This
means that only 16 kB chunks are needed to make up a 2 MB buffer. The
number of scatter/gather segments is also limited by your SCSI adapter
driver. Note that even with 16 kB segments you may find problems at
some time because multi-page allocations are needed.

You can increase the number of scatter/gather segments at system
startup/module loading or when compiling the driver. See the file
linux/drivers/scsi/README.st for the syntax and st_options.h for the
compile-time definition.

	Kai


