Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267852AbRINTOZ>; Fri, 14 Sep 2001 15:14:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268702AbRINTOP>; Fri, 14 Sep 2001 15:14:15 -0400
Received: from winds.org ([209.115.81.9]:46345 "EHLO winds.org")
	by vger.kernel.org with ESMTP id <S267852AbRINTOF>;
	Fri, 14 Sep 2001 15:14:05 -0400
Date: Fri, 14 Sep 2001 15:14:27 -0400 (EDT)
From: Byron Stanoszek <gandalf@winds.org>
To: <linux-kernel@vger.kernel.org>
Subject: Strange /dev/loop behavior
Message-ID: <Pine.LNX.4.33.0109141505530.29038-100000@winds.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Over the months using kernels 2.2 and 2.4, I've seen some inconsistencies with
the behavior of syncing data to filesystems mounted via loopback.

Say I mounted a 32MB 'diskimage' file as ext2fs. My goal is to be able to make
changes to this filesystem, 'sync' these changes, and then copy a compressed
version of the filesystem via the network for a diskless machine to boot. This
has to take place without unmounting the filesystem.

When we started with Linux 2.2 in June 1999, I was able to use this script to
accomplish the task:

# cat diskimage | gzip > diskimage.gz

Starting with 2.2.17, it became evident that the file 'diskimage' in cache was
not equivalent to the filesystem mounted loopback. The script was changed to
the following to reflect that it was the device data itself that needed to be
compressed:

# cat /dev/loop0 | gzip > diskimage.gz

Now last week we've upgraded these servers to 2.4 (2.4.9-ac7 specifically) and
it appears that /dev/loop0 is inconsistent with the actual loopback filesystem
contents (even after a 'sync'). The inconsistency is intermittent. Sometimes
the script works, sometimes the data in the modified files on the diskless
machine is corrupt, and it requires a second cat|gzip to fix.

I've changed the script to use 'cat diskimage' again for the meantime, but I
don't know if it's the absolute fix.


Is there any known method of copying/compressing the loopback-mounted file-
system that always guarantees consistency after a sync, without requiring the
fs to be unmounted first?

Thanks,
 Byron

-- 
Byron Stanoszek                         Ph: (330) 644-3059
Systems Programmer                      Fax: (330) 644-8110
Commercial Timesharing Inc.             Email: byron@comtime.com

