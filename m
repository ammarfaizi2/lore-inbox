Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315792AbSE2XwP>; Wed, 29 May 2002 19:52:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315805AbSE2XwO>; Wed, 29 May 2002 19:52:14 -0400
Received: from [195.63.194.11] ([195.63.194.11]:50954 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S315792AbSE2XwL>; Wed, 29 May 2002 19:52:11 -0400
Message-ID: <3CF55C01.6080101@evision-ventures.com>
Date: Thu, 30 May 2002 00:53:53 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Andries.Brouwer@cwi.nl
CC: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] 2.5.18 IDE 73
In-Reply-To: <UTC200205292340.g4TNehj03682.aeb@smtp.cwi.nl>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl wrote:
>>>About scanning for partitions:
>>>Several partitioning schemes exist, and reading partition tables is not
>>>something a driver should do without getting explicit requests.
>>>For all we know the disk contents may be completely random.
>>
> 
>>You are right but the fact is right now we have to do it this way.
> 
> 
> That is OK - I just write to make sure we all agree that this must
> only be an intermediate stage. Scanning for partitions must not be
> something obscure that happens deep down in some driver.
> 
> 
>>>You should offer the list of disks seen to user space, and user space
>>>should decide which disks have to be investigated, and tell the kernel
>>>about the partitions it wants to have on these disks.
>>>That way all knowledge about partitioning, dynamic disks, disk managers
>>>and the like is removed from the kernel, and moved into partx-type code.
>>
> 
>>But there is one thing, which isn't prette about the above sheme: races
>>and atomicity of operations... Well this could be solved
>>by making the mount system call passing this information as a parameters.
>>You wouldn't even need to pass any list of disks to user land - we don't
>>do it right now.
> 
> 
> You see, some disks belong to RAIDs, some disks are in reality very
> slow objects, like compact flash cards or so, some disk have some foreign
> partitioning scheme. There can be all kinds of reasons why we do not
> want to start reading and interpreting any random disk-like device.

Ahhh... wait a moment you are the one who is responsible for
util-linux - wouldn't you care to take a bunch of patches?!

> I know that we used to do this, but it was wrong, so we must slowly move
> to a setup where we do no longer do this.
> 
> So, user space is started on a ramdisk or so, and gets parameters
> rootdev=, rootpttype=, rootpartition=, rootfstype=.
> Now it can use rootpttype to scan rootdev, find the partitions,
> find rootpartition, mount it as type rootfstype on /.
> 
> Afterwards the existence of more devices, possibly with partitions,
> becomes of interest, for example because there is a "mount -a" somewhere.
> Here userspace needs a list of available devices. Maybe /proc/partitions.

/etc/vfstab, /etc/mtab -  are conceptually just fine.

No need to inevent here. No need to do the book keeping in kernel.
passwd doesn't need /proc/users too and many people just forget that
we are still on a UNIX like system.
The only case which deserves special treatment is the parition
where / resides.

