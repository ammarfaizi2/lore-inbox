Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313154AbSC1N03>; Thu, 28 Mar 2002 08:26:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313153AbSC1N0T>; Thu, 28 Mar 2002 08:26:19 -0500
Received: from vaak.stack.nl ([131.155.140.140]:43280 "HELO mailhost.stack.nl")
	by vger.kernel.org with SMTP id <S313149AbSC1N0A>;
	Thu, 28 Mar 2002 08:26:00 -0500
Date: Thu, 28 Mar 2002 14:25:58 +0100 (CET)
From: Jos Hulzink <josh@stack.nl>
To: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: [Q] FAT driver enhancement
Message-ID: <20020328135555.U6796-100000@snail.stack.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

A while ago I initiated a thread about mounting a NTFS partition as FAT
partition. The problem is that FAT partitions do not have a real
fingerprint, so the FAT driver mounts almost anything.

The current 2.5 driver only tests if some values in the bootsector are
non-zero. IMHO, this is not strict enough. For example, the number of FATs
is always 1 or 2 (anyone ever seen more ?). Besides, when there are two
FATs, all entries in those FATs should be equal. If they are not, we deal
with a non-FAT or broken FAT partition, and we should not mount.

It's not a real fingerprint, but what are the chances all sectors of what
we think is the FAT are equal on non-FAT filesystems ? Yes, when you just
did a

dd if=/dev/zero of=/dev/partition; mkfs.somefs /dev/partition

there is a chance, but that's an empty filesystem. Data corruption isn't
that bad on an empty disk. We know that a FAT is at the beginning of a
partition and I assume that any other filesystem will fill up those first
sectors very soon.

Questions:

1) How do you think about the checking of the FAT tables ? It definitely
   will slow down the mount.
2) If I implement it, where shoud it go ? At the moment, I hacked
   fat_read_super, for there the FAT fs is validated, but I got the
   feeling this is not the place to be.
3) Anyone seen more than two FATs on a filesystem ? Can I assume there is
   a limit ?
4) Comments, anyone ?

Jos

