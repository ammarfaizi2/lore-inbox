Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312294AbSC2XNc>; Fri, 29 Mar 2002 18:13:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312295AbSC2XNW>; Fri, 29 Mar 2002 18:13:22 -0500
Received: from [195.39.17.254] ([195.39.17.254]:53639 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S312294AbSC2XNK>;
	Fri, 29 Mar 2002 18:13:10 -0500
Date: Sat, 30 Mar 2002 00:11:00 +0100
From: Pavel Machek <pavel@suse.cz>
To: Jos Hulzink <josh@stack.nl>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [Q] FAT driver enhancement
Message-ID: <20020329231100.GE9974@elf.ucw.cz>
In-Reply-To: <20020328135555.U6796-100000@snail.stack.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

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

Reading FATs is very fast, and they are probably going to be needed,
anyway. I guess its okay.

> 2) If I implement it, where shoud it go ? At the moment, I hacked
>    fat_read_super, for there the FAT fs is validated, but I got the
>    feeling this is not the place to be.
> 3) Anyone seen more than two FATs on a filesystem ? Can I assume there is
>    a limit ?

No. I think you can only have two.

									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
