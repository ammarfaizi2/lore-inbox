Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265326AbSKVFsI>; Fri, 22 Nov 2002 00:48:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265336AbSKVFsH>; Fri, 22 Nov 2002 00:48:07 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:45316 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S265326AbSKVFsG>;
	Fri, 22 Nov 2002 00:48:06 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200211220555.gAM5tC5337098@saturn.cs.uml.edu>
Subject: Re: Where is ext2/3 secure delete ("s") attribute?
To: jgarzik@pobox.com (Jeff Garzik)
Date: Fri, 22 Nov 2002 00:55:12 -0500 (EST)
Cc: acahalan@cs.uml.edu (Albert D. Cahalan), linux-kernel@vger.kernel.org,
       kentborg@borg.org, alan@lxorguk.ukuu.org.uk
In-Reply-To: <3DDDB4EF.9090300@pobox.com> from "Jeff Garzik" at Nov 21, 2002 11:39:11 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik writes:
> Albert D. Cahalan wrote:
>> Jeff Garzik writes:

>>> Please name a filesystem that moves allocated blocks around
>>> on you.  And point to code, too.
>>
>> Reiserfs tails
>>   fs/reiserfs
>
> inodes don't move

In that case I suppose you could iterate through all possible
tail sizes. In any case, Reiserfs 4 is coming. Reiserfs 4 shifts
the tree all over.

>> ext3 with data journalling
>>   fs/ext3
>
> the allocated blocks don't change

Same effect though: only the filesystem driver can know how
to overwrite a file.

>> the journalling flash filesystems
>>   fs/jffs
>>   fs/jffs2
>
> yep
>
>> NTFS with compression
>>   fs/ntfs
>
> the allocated blocks don't change

They must. I suppose that might not be implemented yet.

>> Multiple overwrites won't protect you from the disk manufacturer
>> or the NSA. Only one is needed to protect against root & kernel.
>> So it makes sense to have the filesystem zero the blocks when
>> they are freed from a file.
>
> if you need to protect against root, then zeroing the blocks isn't
> going to help for LVM or jffs or other journalling.

By "protect against root" of course I mean a future cracked box
or the drive put into another machine.

LVM has to cooperate. If it can't, then that's a bug. Snapshots
count the same as keeping backups on separate media. Likewise,
fsck and defraggers need to cooperate.
