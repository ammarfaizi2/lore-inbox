Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290981AbSBSKCn>; Tue, 19 Feb 2002 05:02:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290983AbSBSKCY>; Tue, 19 Feb 2002 05:02:24 -0500
Received: from vaak.stack.nl ([131.155.140.140]:524 "HELO mailhost.stack.nl")
	by vger.kernel.org with SMTP id <S290981AbSBSKCU>;
	Tue, 19 Feb 2002 05:02:20 -0500
Date: Tue, 19 Feb 2002 11:02:15 +0100 (CET)
From: Jos Hulzink <josh@stack.nl>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: VFS issues (was: Re: 2.5.5-pre1: mounting NTFS partitions -t VFAT)
In-Reply-To: <874rken8ik.fsf@devron.myhome.or.jp>
Message-ID: <20020219102539.J93925-100000@snail.stack.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Feb 2002, OGAWA Hirofumi wrote:

> Jos Hulzink <josh@stack.nl> writes:
>
> > What lacks is a fingerprint detector, and iirc -long time ago- FAT has a
> > very easy to detect fingerprint.
> >
> > I'll dig into FAT documentation tonight.
>
> I read the document repeatedly and did much tests. If you read the
> document, you may use BS_OEMName or BS_FilSysType, however, these
> don't have a meaning.

Hmmm. You seem to be right there. In my OS (IBM PC only) I checked the
partition table (see below).

The first question I want answered: Should I just call myself stupid for
trying to mount NTFS as VFAT, or should we consider this a real issue that
needs fixing ? (I see the problem as a generic problem. There must be
other combinations of filesystems and partition types that pass the
test, but are wrong). IMHO the latter, for every lost partition makes an
angry linux user.

Anyway. I have already been thinking further. Maybe I'm talking nonsense,
but I'll give it a try.

The type of a partition is written in the partition table, or something
similar. Maybe we should check that ?

While mounting a partition, the vfs layer tries to determine the partition
type, and passes that info to the filesystem driver, which checks whether
that partition type can be mounted by the driver. If no partition type is
provided by the vfs layer (for the partition type is not available in the
used partition table, or whatever), the fs driver must try to find out
itself.

If you don't want the calls to change, another option is to move the check
to the vfs. Problem there however is that the vfs needs a "filesystem <->
partition type" table. On the other hand, this way we can add extra
security without breaking anything.

Jos

