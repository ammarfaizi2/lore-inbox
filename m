Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266968AbUBMMr3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 07:47:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266975AbUBMMr3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 07:47:29 -0500
Received: from mail4-141.ewetel.de ([212.6.122.141]:48836 "EHLO
	mail4.ewetel.de") by vger.kernel.org with ESMTP id S266968AbUBMMr1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 07:47:27 -0500
Date: Fri, 13 Feb 2004 13:48:36 +0100 (CET)
From: der.eremit@email.de
To: Nick Bartos <spam99@2thebatcave.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: getting usb mass storage to finish before running init?
In-Reply-To: <52496.192.168.1.12.1076639642.squirrel@mail.2thebatcave.com>
Message-ID: <Pine.LNX.4.58.0402131338510.163@neptune.local>
References: <1oAMR-6St-13@gated-at.bofh.it> <E1ArSm1-0003ei-Pv@localhost>
 <52496.192.168.1.12.1076639642.squirrel@mail.2thebatcave.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Feb 2004, Nick Bartos wrote:

> well, the root filesystem is an initrd, so I can't do that.

Then I mean look for the filesystem you want to mount.

> I suppose I could compile in the extra info for /proc/partitions and see
> if that gives me anything I can keep looking for (don't know if it puts
> file system labels in there, but that is probably what I would have to go
> on since that is really the only thing that is constant on all systems).

Well, if you know what filesystem type is wanted you could just attempt
to mount all the partitions from /proc/partitions with that type
(read-only) and look for a unique file - if it's there, keep the fs
mounted, otherwise umount and try next candidate.

That's basically what I do in an initrd I wrote for CD-ROM booting, I'm
just trying to mount iso9660 filesystems and look for /etc/rc.d/rc.cdrom
when it succeeds. Better ways to identifiy a block device exist, I'm
sure, but the approach works for me. I'm narrowing down the search by
scanning the dmesg buffer for ATAPI and SCSI CD-ROM detection messages,
but that approach doesn't work for your problem (and is also fragile
when using it across several kernel versions).

> Is there a quick/clean way to query a device and get the label?

findfs from the e2fsprogs package, maybe.

> I suppose
> I could use tune2fs or something, but I didn't know if there is anything
> better/simpler.  I don't know if I like the idea of running tune2fs on
> each partition again and again.  I guess I could keep a list in memory and
> only check each one once, but that is getting a bit more complicated &
> time consuming.

Well, it's read-only access, so I don't see a problem even with running
it multiple times on the same device. Keeping a list of already tried
devices isn't black magic, though.

-- 
Ciao,
Pascal
