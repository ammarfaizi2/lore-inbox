Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315783AbSE2Xks>; Wed, 29 May 2002 19:40:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315785AbSE2Xks>; Wed, 29 May 2002 19:40:48 -0400
Received: from hera.cwi.nl ([192.16.191.8]:28613 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S315783AbSE2Xkp>;
	Wed, 29 May 2002 19:40:45 -0400
From: Andries.Brouwer@cwi.nl
Date: Thu, 30 May 2002 01:40:43 +0200 (MEST)
Message-Id: <UTC200205292340.g4TNehj03682.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, dalecki@evision-ventures.com
Subject: Re: [PATCH] 2.5.18 IDE 73
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> About scanning for partitions:
>> Several partitioning schemes exist, and reading partition tables is not
>> something a driver should do without getting explicit requests.
>> For all we know the disk contents may be completely random.

> You are right but the fact is right now we have to do it this way.

That is OK - I just write to make sure we all agree that this must
only be an intermediate stage. Scanning for partitions must not be
something obscure that happens deep down in some driver.

>> You should offer the list of disks seen to user space, and user space
>> should decide which disks have to be investigated, and tell the kernel
>> about the partitions it wants to have on these disks.
>> That way all knowledge about partitioning, dynamic disks, disk managers
>> and the like is removed from the kernel, and moved into partx-type code.

> But there is one thing, which isn't prette about the above sheme: races
> and atomicity of operations... Well this could be solved
> by making the mount system call passing this information as a parameters.
> You wouldn't even need to pass any list of disks to user land - we don't
> do it right now.

You see, some disks belong to RAIDs, some disks are in reality very
slow objects, like compact flash cards or so, some disk have some foreign
partitioning scheme. There can be all kinds of reasons why we do not
want to start reading and interpreting any random disk-like device.

I know that we used to do this, but it was wrong, so we must slowly move
to a setup where we do no longer do this.

So, user space is started on a ramdisk or so, and gets parameters
rootdev=, rootpttype=, rootpartition=, rootfstype=.
Now it can use rootpttype to scan rootdev, find the partitions,
find rootpartition, mount it as type rootfstype on /.

Afterwards the existence of more devices, possibly with partitions,
becomes of interest, for example because there is a "mount -a" somewhere.
Here userspace needs a list of available devices. Maybe /proc/partitions.

Andries
