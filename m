Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318500AbSIBVWk>; Mon, 2 Sep 2002 17:22:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318487AbSIBVWk>; Mon, 2 Sep 2002 17:22:40 -0400
Received: from hera.cwi.nl ([192.16.191.8]:56710 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S317334AbSIBVWi>;
	Mon, 2 Sep 2002 17:22:38 -0400
From: Andries.Brouwer@cwi.nl
Date: Mon, 2 Sep 2002 23:27:03 +0200 (MEST)
Message-Id: <UTC200209022127.g82LR3g12738.aeb@smtp.cwi.nl>
To: aebr@win.tue.nl, torvalds@transmeta.com
Subject: Re: PATCH - change to blkdev->queue calling triggers BUG in md.c
Cc: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org,
       linux-raid@vger.kernel.org, neilb@cse.unsw.edu.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    > But I hope he makes precisely this: a kernel that does not do any
    > partition reading of its own.

    I disagree, if only because of backwards compatibility issues.

    On a conceptual level I think you're right. However, it will break too 
    many standard installations as is.

    If/when we have a reasonable initrd setup that is usable, we could do some 
    automatic partitioning of devices that are available at bootup to minimize 
    the impact, but I don't think it is realistic otherwise.

Compare it with mounting.

It would be very bad if the kernel automatically mounted all
filesystems in sight. So, user space tells what to mount.
But at boot time there is a special situation.
In the end we want to have an initrd that mounts the rootfs,
but today we give kernel command line parameters with
rootfstype= and root=.

In a similar way it is bad that the kernel automatically tries
to interpret some data on a block device as a partition table.
The user can tell the kernel. (Yes, today.)
But at boot time there is a special situation.
In the end we want to have an initrd that does the partition reading,
but now we could give a kernel command line parameter with
rootpttype= and have the kernel only parse the partition table
of the root device.

Andries


[Yes, a shock, but very easy for people to add
      blockdev --rereadpt /dev/foo
(or a partx call) in some bootscripts.]

[Don't think that I actually propose doing this today as the default,
but it would be a very small patch to add this as an optional
behaviour. But there is today, and there is the faraway goal.
The faraway goal is: no partition table reading in the kernel.
And that influences designing today what to do on media change.
Already today I would consider it entirely reasonable if there
was no automatic partition table reading after a media change.]
