Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315629AbSE2Wzf>; Wed, 29 May 2002 18:55:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315630AbSE2Wze>; Wed, 29 May 2002 18:55:34 -0400
Received: from [195.63.194.11] ([195.63.194.11]:19978 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S315629AbSE2Wze>; Wed, 29 May 2002 18:55:34 -0400
Message-ID: <3CF54EB9.6050603@evision-ventures.com>
Date: Wed, 29 May 2002 23:57:13 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Andries.Brouwer@cwi.nl
CC: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.18 IDE 73
In-Reply-To: <UTC200205291807.g4TI7DN15827.aeb@smtp.cwi.nl>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl wrote:
>     - Don't allow check_partition to be more clever then the writer of a driver.
>        It was interfering with drivers which check partitions as they go and
>        finally if we want to spew something about it - we can do it ourself.
> 
>     - Eliminate ide_geninit(). We scan for partitions now inside the recently
>        introduced attach method. register_disk() is broken by the way and 90% of
>        places where it's used it is doing literally nothing. Either some one didn't
>        finish some code or the code is basically just junk from the past.
> 
>        Anyway we grok the partitions now one by one as we detect the channels.
> 
> Pity you send this gzipped, otherwise I would have looked at the code.

Well otherwise it wouldn't get through lkml. And since there
are actually right now quite a lot of people interressted in
the intermediate patches I'm sending it gzip-ed.
And no I don't buy in to the fact that we need a separate
mailing list for every single topic out there.
The traffic on lkml isn't that high if you learn to filter:

1. Some very active people who are posting only garbage.
2. Some perpetuant topics which are irrelevant.

> Yes, 90% of the uses of register_disk() are empty. I submitted a patch
> to remove this cruft last year, but Al was attached to it - wanted to
> make them nonempty.

For what would that be good?
In the time between the kernel eveolved entierly in to a different
direction, *we have* now the device tree the devfs and grock
parition stuff.

> About scanning for partitions I say the same thing I said to Al a few
> days ago:
> Several partitioning schemes exist, and reading partition tables is not
> something a driver should do without getting explicit requests.
> For all we know the disk contents may be completely random.

You are right but the fact is right now we have to do it this way.
And I'm sure some people will start to wimmer about "back-ass compatibility".
But I agree with Larry that unnecessary compatibility
concerns for tools which should be considered as tightly coupled to
the system in question killed partily in the middle of the 90's UNIX
advancement somehow. For Linux this translates to:

1. util-linux
2. modutils
3. pcmci-utils
and so on...

You know that I'm one of the few who is always trying to
push such changes where they make sense. However it always turns out
that the people who don't understand this simlpe fact are just loud
enough to don't be ignored.

> You should offer the list of disks seen to user space, and user space
> should decide which disks have to be investigated, and tell the kernel
> about the partitions it wants to have on these disks.
> That way all knowledge about partitioning, dynamic disks, disk managers
> and the like is removed from the kernel, and moved into partx-type code.

But there is one thing, which isn't prette about the above sheme: races
and atomicity of operations... Well this could be solved
by making the mount system call passing this information as a parameters.
You wouldn't even need to pass any list of disks to user land - we don't
do it right now. Just notify the kernel of the avalibility of a particular
device on hot plug and let mount scan partitions and therelike itself.
It could do it perfectly fine itself.
Since the ATA code was anyway the much uglier part in the game
well there are chances that finally someone will pick up this
idea...

But no matter what right now the changes I did had to be done.

