Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313236AbSC1TtY>; Thu, 28 Mar 2002 14:49:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313237AbSC1TtO>; Thu, 28 Mar 2002 14:49:14 -0500
Received: from mail.parknet.co.jp ([210.134.213.6]:12050 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S313236AbSC1TtH>; Thu, 28 Mar 2002 14:49:07 -0500
To: Jos Hulzink <josh@stack.nl>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [Q] FAT driver enhancement
In-Reply-To: <20020328135555.U6796-100000@snail.stack.nl>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Fri, 29 Mar 2002 04:48:44 +0900
Message-ID: <871ye479sz.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jos Hulzink <josh@stack.nl> writes:

> Hi,
> 
> A while ago I initiated a thread about mounting a NTFS partition as FAT
> partition. The problem is that FAT partitions do not have a real
> fingerprint, so the FAT driver mounts almost anything.
> 
> The current 2.5 driver only tests if some values in the bootsector are
> non-zero. IMHO, this is not strict enough. For example, the number of FATs
> is always 1 or 2 (anyone ever seen more ?). Besides, when there are two
> FATs, all entries in those FATs should be equal. If they are not, we deal
> with a non-FAT or broken FAT partition, and we should not mount.
> 
> It's not a real fingerprint, but what are the chances all sectors of what
> we think is the FAT are equal on non-FAT filesystems ? Yes, when you just
> did a
> 
> dd if=/dev/zero of=/dev/partition; mkfs.somefs /dev/partition
> 
> there is a chance, but that's an empty filesystem. Data corruption isn't
> that bad on an empty disk. We know that a FAT is at the beginning of a
> partition and I assume that any other filesystem will fill up those first
> sectors very soon.
> 
> Questions:
> 
> 1) How do you think about the checking of the FAT tables ? It definitely
>    will slow down the mount.

Unfortunately if FAT table has bad sector, FAT tables may not be the
same.

> 2) If I implement it, where shoud it go ? At the moment, I hacked
>    fat_read_super, for there the FAT fs is validated, but I got the
>    feeling this is not the place to be.
> 3) Anyone seen more than two FATs on a filesystem ? Can I assume there is
>    a limit ?
> 4) Comments, anyone ?

How about writing the mount.xxx/fsck.xxx? The mount.xxx/fsck.xxx can
check many of the ordinary FAT status. If the something occurs, output
message to user. And user can handle it by option etc.

Regards.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
