Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135179AbRAPXAl>; Tue, 16 Jan 2001 18:00:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135180AbRAPXAO>; Tue, 16 Jan 2001 18:00:14 -0500
Received: from h24-65-192-120.cg.shawcable.net ([24.65.192.120]:39932 "EHLO
	webber.adilger.net") by vger.kernel.org with ESMTP
	id <S135177AbRAPW7u>; Tue, 16 Jan 2001 17:59:50 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200101162259.f0GMxcN01740@webber.adilger.net>
Subject: Re: super_operations in -pre7
In-Reply-To: <20010116221357.H20275@parcelfarce.linux.theplanet.co.uk>
 "from Matthew Wilcox at Jan 16, 2001 10:13:57 pm"
To: Matthew Wilcox <matthew@wil.cx>
Date: Tue, 16 Jan 2001 15:59:37 -0700 (MST)
CC: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL73 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mattew Wilcox writes:
> several new operations have been added to super_operations, presumably
> as part of the reiserfs merge.  write_super_lockfs and unlockfs are
> never called.  can we remove them?

These operations were added to co-ordinate filesystem backups/snapshots
for journalling filesystems (especially in conjunction with LVM).  At
some point in the future ext3 will also be using them.  However, (only
having looked at preliminary patches, and not the final 2.4.1-pre reiserfs
merge) it is bad to insert them in the middle of the super_operations
struct at this point, as it breaks every filesystem that isn't part of
the kernel.  That said, the addition of (reiserfs-specific) read_inode2
and dirty_inode pointers also break all non-kernel filesystems.  Argh!

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
