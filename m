Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273947AbRIRVpV>; Tue, 18 Sep 2001 17:45:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273945AbRIRVpM>; Tue, 18 Sep 2001 17:45:12 -0400
Received: from w032.z064001165.sjc-ca.dsl.cnc.net ([64.1.165.32]:12362 "EHLO
	nakedeye.aparity.com") by vger.kernel.org with ESMTP
	id <S273947AbRIRVpE>; Tue, 18 Sep 2001 17:45:04 -0400
Date: Tue, 18 Sep 2001 14:49:57 -0700 (PDT)
From: "Matt D. Robinson" <yakker@aparity.com>
To: <linux-kernel@vger.kernel.org>
Subject: Request for new block_device_operations function pointer
Message-ID: <Pine.LNX.4.30.0109181436110.27510-100000@nakedeye.aparity.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'd like to see if there's any issue with the inclusion of a new
function pointer for block_device_operations.

I'd like to see something like:

struct block_device_operations {
        /* ... */
        int (*dump) (kdev_t, char *, size_t, loff_t *);
};

This would allow projects such as LKCD to use a specific dump
device associated to a block device driver.  This dump driver
writes data out directly to disk at a specific offset.  The
reason for having it in the block_device_operations table is
to directly attach it to the lower-level disk driver rather
than going through the file_operations table.  In theory, I'd
also like to see something similar for character devices, but
there is no table mechanism for this currently beyond
file_operations.

Then we could add our own IDE dump function pointer into ide_fops,
for example, and inevitably put our code into the IDE disk driver
without changing the rest of the driver functionality, but allowing
direct writes to the disk.  The same would apply to SCSI disks.
Then all maintainers can approve the dump mechanisms before
including them into any driver release.

It would also mean that dumping wouldn't be allowed to devices
that don't have a dump function pointer, which is better than
trying to use the standard write() path for all devices.

The patch for the function pointer is the easy part, the dump
function pointer code is obviously more significant.  Either
way, I can get started on those.

The arguments to dump can be different, it's the purpose that
I'm concerned with.  Any other suggestion is fine ...

Thoughts?

--Matt

