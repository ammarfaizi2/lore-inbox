Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291383AbSBSMsd>; Tue, 19 Feb 2002 07:48:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291384AbSBSMsX>; Tue, 19 Feb 2002 07:48:23 -0500
Received: from amsfep16-int.chello.nl ([213.46.243.25]:13604 "EHLO
	amsfep16-int.chello.nl") by vger.kernel.org with ESMTP
	id <S291383AbSBSMsM>; Tue, 19 Feb 2002 07:48:12 -0500
Content-Type: text/plain; charset=US-ASCII
From: Jos Hulzink <josh@stack.nl>
To: Richard Russon <ntfs@flatcap.org>
Subject: Re: VFS issues (was: Re: 2.5.5-pre1: mounting NTFS partitions -t VFAT)
Date: Tue, 19 Feb 2002 13:48:49 +0100
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <20020219102539.J93925-100000@snail.stack.nl> <1014119542.2788.10.camel@addlestones>
In-Reply-To: <1014119542.2788.10.camel@addlestones>
Cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020219124417.IVI19167.amsfep16-int.chello.nl@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 19 February 2002 12:52, Richard Russon wrote:

> Whatever you throw at mount, you want it to fail_safe_.  i.e. in the
> worst case, do nothing.

Agreed.

> Without any help, mount (userspace) tries to determine the partition
> type.  It understands the magics of a LOT of filesystems.
>
> It looks for the NTFS magic before the DOS magic (or any of its variants).

Well, the story: I reinstalled Win2k and updated from FAT32 to NTFS, the day 
before I tested 2.5.5pre-1. I forgot to update /etc/fstab. So mount was 
called with the -t vfat option.

> Which is passed to the VFS, and the to the driver which performs some
> more rigid tests (hopefully :-)

Working on those tests, though it is hard to tell what limits are valid. I 
never saw more than 2 FATs, but can I assume there never will be more ? FAT 
has no real fingerprint, unfortunately. There are some bytes that can be 
checked, but they depend very much on the FAT version. FAT v 4.0 and higher 
have the fingerprint 'FAT' somewhere in the bootsector, but this doesn't hold 
anymore for some Win98/ME formatted partitions.

A test I'm thinking about is trying to match the FATs if there is more than 
one. You want to bail out if the FATs aren't the same anyway. The chance that 
the FAT-sectors are the same on non-FAT partitions is very small. Though this 
test can be rather slow, maybe we should only test the first sector(s).

Jos

