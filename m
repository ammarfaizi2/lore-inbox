Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288413AbSADANw>; Thu, 3 Jan 2002 19:13:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288412AbSADANl>; Thu, 3 Jan 2002 19:13:41 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:37384 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S288411AbSADANe>;
	Thu, 3 Jan 2002 19:13:34 -0500
Message-ID: <3C34F3AA.23431926@mandrakesoft.com>
Date: Thu, 03 Jan 2002 19:13:30 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alessandro Suardi <alessandro.suardi@oracle.com>
CC: linux-kernel@vger.kernel.org, andries.brouwer@cwi.nl,
        torvalds@transmeta.com
Subject: Re: 2.5.2-pre7 still missing bits of kdev_t
In-Reply-To: <3C34F1E4.5B0FC1D9@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alessandro Suardi wrote:
> ./fs/reiserfs/inode.c
> ./fs/reiserfs/super.c
> ./fs/reiserfs/journal.c
> ./include/linux/reiserfs_fs.h

reiserfs is blindly storing the kernel's kdev_t value raw to disk.

AFAICS this will need a policy decision not just cleanup, before it
works in 2.5.2 properly.  If we switch the kernel to 12:20 major:minor
numbers, suddenly the reiserfs disk format changes based on kernel
version, and earlier kernels see corrupted major:minor numbers.

For many filesystems with just 16-bits of major/minor storage, they
store the raw kdev_t value as well, but have different problems when
12:20 comes around.

If reiserfs guys had planned ahead they would be decoding the
major/minor number before it hits disk, and already storing it in 12:20
fashion or somesuch.

Unless I am missing something...

	Jeff


-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno
