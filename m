Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265725AbTF2Sfl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 14:35:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265728AbTF2Sfl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 14:35:41 -0400
Received: from smtp-out.comcast.net ([24.153.64.115]:44431 "EHLO
	smtp-out.comcast.net") by vger.kernel.org with ESMTP
	id S265725AbTF2Sfe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 14:35:34 -0400
Date: Sun, 29 Jun 2003 14:48:58 -0400
From: rmoser <mlmoser@comcast.net>
Subject: Re: File System conversion -- ideas
In-reply-to: <200306291837.h5TIbsJi001136@81-2-122-30.bradfords.org.uk>
To: John Bradford <john@grabjohn.com>, linux-kernel@vger.kernel.org
Message-id: <200306291448580250.01DF77C5@smtp.comcast.net>
MIME-version: 1.0
X-Mailer: Calypso Version 3.30.00.00 (3)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
References: <200306291837.h5TIbsJi001136@81-2-122-30.bradfords.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm the only one in the world who can have 80 gig of partitions
and not have capped on any of them (i.e. they've got free space
but it's getting less and less each day).  ;-)

*********** REPLY SEPARATOR  ***********

On 6/29/2003 at 7:37 PM John Bradford wrote:

>> This is a place where logical volume management can help.
>>
>> For example, suppose you have a 60G disk, 55G of data, in ext2, and you
>> wish to convert to ReiserFS.
>>
>> Step 1: Shrink the volume to 55G. This requires a "shrink disk" utility
>> for the source file system (which exists for the major file systems in
>> use today).
>> Step 2: Create an LVM block in the remaining 5G.
>> Step 3: Create a ReiserFS in the LVM block.
>> Step 4: Move 5G of data from the ext2 system to the ReiserFS block.
>> Step 5: Shrink the ext2 volume by another 5G
>> Step 6: Convert that 5G into an LVM block
>> Step 7: Add that block to the ReiserFS volume group.
>> Step 8: Grow the ReiserFS.
>> Step 9: Repeat 4-8 as needed.
>>
>>
>> This is why I'd really love to see LVM|EVM become standard, not just in
>> the kernel but in the distributions - if every distro by default made
>> all Linux volumes in LVM, then migrating data to bigger drives/adding
>> more space/converting file systems would be so much easier.
>
>It's also a good reason not to use one huge partition on each disk,
>and a good reason not to partition the whole disk when it's not
>needed.
>
>I've seen, (mainly desktop, not server), Linux machines with one
>physical disk containing two partitions, root and swap, with the swap
>partition being twice the physical memory of the box, even when the
>box has more than a gigabyte of physical RAM.
>
>It's usually more flexible just to partition the space you need, and
>add more partitions when necessary.  For typical desktop use, swap
>isn't even necessary with 1 GB of physical RAM.
>
>For example, if you have an 80 GB disk, you could initially partition
>10 GB for the root partition, and leave 70 GB unused.  When the root
>partition fills us, you can simply use du -s /* to see which
>directories are taking up the most space, and move them to separate
>partitions.
>
>John.
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/



