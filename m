Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312834AbSDBJgF>; Tue, 2 Apr 2002 04:36:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312836AbSDBJfz>; Tue, 2 Apr 2002 04:35:55 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:15118 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S312834AbSDBJfo>; Tue, 2 Apr 2002 04:35:44 -0500
Message-ID: <3CA97B1A.13E6765D@aitel.hist.no>
Date: Tue, 02 Apr 2002 11:34:18 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.7 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, linux-kernel@vger.kernel.org
Subject: Re: [Q] FAT driver enhancement
In-Reply-To: <20020328135555.U6796-100000@snail.stack.nl> <871ye479sz.fsf@devron.myhome.or.jp>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OGAWA Hirofumi wrote:
> 
> Jos Hulzink <josh@stack.nl> writes:
> 
> > Hi,
> >
> > A while ago I initiated a thread about mounting a NTFS partition as FAT
> > partition. The problem is that FAT partitions do not have a real
> > fingerprint, so the FAT driver mounts almost anything.
> >
> > The current 2.5 driver only tests if some values in the bootsector are
> > non-zero. IMHO, this is not strict enough. For example, the number of FATs
> > is always 1 or 2 (anyone ever seen more ?). Besides, when there are two
> > FATs, all entries in those FATs should be equal. If they are not, we deal
> > with a non-FAT or broken FAT partition, and we should not mount.
> >
> > It's not a real fingerprint, but what are the chances all sectors of what
> > we think is the FAT are equal on non-FAT filesystems ? Yes, when you just
> > did a
> >
> > dd if=/dev/zero of=/dev/partition; mkfs.somefs /dev/partition
> >
> > there is a chance, but that's an empty filesystem. Data corruption isn't
> > that bad on an empty disk. We know that a FAT is at the beginning of a
> > partition and I assume that any other filesystem will fill up those first
> > sectors very soon.
> >
> > Questions:
> >
> > 1) How do you think about the checking of the FAT tables ? It definitely
> >    will slow down the mount.
> 
> Unfortunately if FAT table has bad sector, FAT tables may not be the
> same.

And then you don't want to mount unless you know what you
are doing.  And those knowing what they are doing can be bothered
to use some kind of "force" option in this case.  Or perhaps an
option that selects which FAT to trust.

Helge Hafting
