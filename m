Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312573AbSDBN23>; Tue, 2 Apr 2002 08:28:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312577AbSDBN2T>; Tue, 2 Apr 2002 08:28:19 -0500
Received: from mail.parknet.co.jp ([210.134.213.6]:55304 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S312573AbSDBN2O>; Tue, 2 Apr 2002 08:28:14 -0500
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Q] FAT driver enhancement
In-Reply-To: <20020328135555.U6796-100000@snail.stack.nl>
	<871ye479sz.fsf@devron.myhome.or.jp> <3CA97B1A.13E6765D@aitel.hist.no>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Tue, 02 Apr 2002 22:27:52 +0900
Message-ID: <87663acjs7.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting <helgehaf@aitel.hist.no> writes:

> OGAWA Hirofumi wrote:
> > 
> > Jos Hulzink <josh@stack.nl> writes:
> > 
> > > Hi,
> > >
> > > A while ago I initiated a thread about mounting a NTFS partition as FAT
> > > partition. The problem is that FAT partitions do not have a real
> > > fingerprint, so the FAT driver mounts almost anything.
> > >
> > > The current 2.5 driver only tests if some values in the bootsector are
> > > non-zero. IMHO, this is not strict enough. For example, the number of FATs
> > > is always 1 or 2 (anyone ever seen more ?). Besides, when there are two
> > > FATs, all entries in those FATs should be equal. If they are not, we deal
> > > with a non-FAT or broken FAT partition, and we should not mount.
> > >
> > > It's not a real fingerprint, but what are the chances all sectors of what
> > > we think is the FAT are equal on non-FAT filesystems ? Yes, when you just
> > > did a
> > >
> > > dd if=/dev/zero of=/dev/partition; mkfs.somefs /dev/partition
> > >
> > > there is a chance, but that's an empty filesystem. Data corruption isn't
> > > that bad on an empty disk. We know that a FAT is at the beginning of a
> > > partition and I assume that any other filesystem will fill up those first
> > > sectors very soon.
> > >
> > > Questions:
> > >
> > > 1) How do you think about the checking of the FAT tables ? It definitely
> > >    will slow down the mount.
> > 
> > Unfortunately if FAT table has bad sector, FAT tables may not be the
> > same.
> 
> And then you don't want to mount unless you know what you
> are doing.  And those knowing what they are doing can be bothered
> to use some kind of "force" option in this case.  Or perhaps an
> option that selects which FAT to trust.

I mean I/O error, not data damage.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
