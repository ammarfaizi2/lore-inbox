Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264448AbTF2UgV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 16:36:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265492AbTF2Uds
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 16:33:48 -0400
Received: from smtp-out.comcast.net ([24.153.64.115]:29834 "EHLO
	smtp-out.comcast.net") by vger.kernel.org with ESMTP
	id S265086AbTF2UdN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 16:33:13 -0400
Date: Sun, 29 Jun 2003 16:44:09 -0400
From: rmoser <mlmoser@comcast.net>
Subject: Re: File System conversion -- ideas
In-reply-to: <200306292020.h5TKKxJ2000188@81-2-122-30.bradfords.org.uk>
To: John Bradford <john@grabjohn.com>, linux-kernel@vger.kernel.org
Message-id: <200306291644090200.0248EFC0@smtp.comcast.net>
MIME-version: 1.0
X-Mailer: Calypso Version 3.30.00.00 (3)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
References: <200306292020.h5TKKxJ2000188@81-2-122-30.bradfords.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



*********** REPLY SEPARATOR  ***********

On 6/29/2003 at 9:20 PM John Bradford wrote:

>> If you think about it, you have this:
>>
>> [PARTITION 1]
>>     |
>>    V
>> [PARTITION 2]
>>
>> I have this (the == is an equivalence signm i.e. this is what's inside):
>>
>> [PARTITION]
>>     ==
>> [DATASYSTEM]
>>     ==
>> [FILESYSTEM 1]
>>     |
>>     V
>> [DATASYSTEM ATOMS]
>>     |
>>     V
>> [FILESYSTEM 2]
>>
>> Both filesystems are the full size of the partition, and so is the
>> datasystem.  The only difference is that before you start you have
>> to make sure that the datasystem's gonna fit in with the free space
>> on the first filesystem, and still have space to start the second
>> filesystem, and then have space for its atoms.
>
>Just thought - that's going to be a problem in read-write mode :-/.
>
>If the disk fills up, we'd need to be able to maintain a consistant
>filesystem structure, (at least good enough so that a separate
>fsck-like utility could repair it - if the disk filled up, then the
>conversion couldn't be done on-the-fly).
>


mmm.. hadn't thought of that.

1 second answer:  Lock down some of the freespace.  Do NOT let it
get full.  You know how ext2 reserves 5% for the superuser?  Do that.
Reserve enough freespace to keep working and finish the conversion.
Predict from the beginning how much free space is going to be needed,
and how much is going to be left over at the very final stages of the
conversion.

>> These atoms will
>> slowly be destroyed as they go into the second filesystem.  You
>> have to also make sure that the second FS won't be bigger than the
>> first, and will at the end have enough to hold at least the empty
>> datasystem and one atom.
>>
>> I feel I should note, since I forgot before, that an atom can contain
>part
>> of the data for an inode, as long as you know this and can write the atom
>> out to the new filesystem and get more of the old.
>
>Seems like a solid idea, though.  As long as it worked on at least
>read-only mounted filesystems, I'd be quite interested in seeing it in
>the mainline kernel.
>

On a side note, the bitch is gonna be trying to swap the superblock back
in over the datasystem's superblock.  Maybe we should set it up so that
the datasystem has the journal in a fixed place, or tell the user where it
is, so that if we do crash at that absolute final stage, we can finish it out
:/

Sorry, just spouting extra things.  To me, it's no good unless we've prepared
for 100% of the problems we will encounter, excluding bugs in the code.

>John.
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/


--Bluefox Icy

