Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264018AbTKLSUS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 13:20:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264055AbTKLSUS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 13:20:18 -0500
Received: from mail3-126.ewetel.de ([212.6.122.126]:23681 "EHLO
	mail3.ewetel.de") by vger.kernel.org with ESMTP id S264018AbTKLSUP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 13:20:15 -0500
Date: Wed, 12 Nov 2003 19:20:05 +0100 (CET)
From: Pascal Schmidt <der.eremit@email.de>
To: Linus Torvalds <torvalds@osdl.org>
cc: Jens Axboe <axboe@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.9test9-mm1 and DAO ATAPI cd-burning corrupt
In-Reply-To: <Pine.LNX.4.44.0311111706530.1694-100000@home.osdl.org>
Message-ID: <Pine.LNX.4.44.0311121910010.983-100000@neptune.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Nov 2003, Linus Torvalds wrote:

> Does it work if you change the order of those two things in ide-cd.c (or
> just remove the call to "cdrom_get_last_written()" entirely, so that it
> always just does the sane thing).

I've moved the cdrom_read_capacity() to the top of cdrom_read_toc and
now the capacity gets set correctly and everything seems to work just 
fine.

dd to and from the raw device works, as do mke2fs and e2fsck. I could
also mount the disk read-write, write a 10MB file to it, and umount
again without problems. Then I rebooted into 2.4 and verified that the
filesystem is okay and the 10MB file made it to disk correctly.

Lookin' good so far.

Now, assuming there is a reason that the cdrom_read_capacity() function
is only used as a fallback for normal ide-cd devices, my change might
break non-MO devices. I also don't know what to do when read_capacity
fails - setting capacity to 0 obviously breaks as we've seen before,
so maybe setting it to the lowest possible MO size (128M) would be a
good way to handle that situation.

Jens, what do you think?

-- 
Ciao,
Pascal

