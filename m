Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270003AbRHJUCv>; Fri, 10 Aug 2001 16:02:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270004AbRHJUCm>; Fri, 10 Aug 2001 16:02:42 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:5233 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S270001AbRHJUCa>; Fri, 10 Aug 2001 16:02:30 -0400
Date: Fri, 10 Aug 2001 16:02:29 -0400 (EDT)
From: Ben LaHaise <bcrl@redhat.com>
X-X-Sender: <bcrl@touchme.toronto.redhat.com>
To: =?iso-8859-1?Q?Ragnar_Kj=F8rstad?= <kernel@ragnark.vestdata.no>
cc: <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <mike@bigstorage.com>, <kevin@bigstorage.com>
Subject: Re: [PATCH] 64 bit scsi read/write
In-Reply-To: <20010810215136.C16864@vestdata.no>
Message-ID: <Pine.LNX.4.33.0108101557480.5531-100000@touchme.toronto.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Aug 2001, Ragnar Kjørstad wrote:

> * >1TB devices over scsi.
>   * /proc/partitions report incorrect sizes

Okay, interesting, I'll have to dig through that.

>   * mkreiserfs fails: "mkreiserfs: can not create filesystem on that
>     small device (0 blocks)."
>   * mkfs.xfs fails: "warning - cannot set blocksize on block device
>     /dev/sdb: Invalid argument"

Someone needs to patch reiserfs/xfs.

>   I assume both mkreiserfs and mkfs.xfs use ioctl to get the size
>   of the device, and that ioctl uses an unsigned int? How is
>   userspace supposed to get the devicesize of >2GB devices with
>   your code?

See the e2fsprogs patch (again, below).

>   * mkfs.ext2 makes the machine panic after a while.
>     Unfortenately I don't have the panic message anymore, and at the
>     moment I don't have the hardware to redo the test.

That would've been a useful bug report.

>   * fdisk bails out with 'Unable to read /dev/sdb'

MS-DOS partitions do not work on huge devices, so at best we can make it
report a more informative message.

The amount of response I've received is absolutely dismal for a feature
lots of people are clamouring on about needing.  At this rate, I doubt
we'll have any of it decently tested before we start advertising it as a
supported feature in 2.6.

		-ben

-- 
"The world would be a better place if Larry Wall had been born in
Iceland, or any other country where the native language actually
has syntax" -- Peter da Silva

