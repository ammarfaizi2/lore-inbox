Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261516AbSJIIvJ>; Wed, 9 Oct 2002 04:51:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261518AbSJIIvJ>; Wed, 9 Oct 2002 04:51:09 -0400
Received: from guardian.hermes.si ([193.77.5.150]:36109 "EHLO
	guardian.hermes.si") by vger.kernel.org with ESMTP
	id <S261516AbSJIIvI>; Wed, 9 Oct 2002 04:51:08 -0400
Message-ID: <A1C30C1C0FB8D5118D810004754C03756677C5@hsl-lj3x.hermes.si>
From: Luka Renko <luka.renko@hermes.si>
To: Christoph Hellwig <hch@infradead.org>,
       Andreas Gruenbacher <agruen@suse.de>
Cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: RE: [Ext2-devel] [RFC] [PATCH 3/4] Add extended attributes to ext
	2/3
Date: Wed, 9 Oct 2002 10:53:47 +0200 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > With the registration API modules doing HSM/LSM/... can 
> just register 
> > handlers
> > without having to modify the file system code. Otherwise we 
> would have to 
> > hand code additional hooks for independently loadable modules.
> 
> a) if the HSM/whatever is so standalone that it should patch ext2 code
>    it is truely generic and thus above the filesystem.
> b) you don;t even export the register/unregister to modules, 
> not mention
>    other ext2/ext3 core functionality that it would need.
> c) looks at the 'would'  there is no such code currently and 
> if it gets
>    a real consern it still could be added.  Don't bloat the kernel
>    more than you really need to..

Actually we are currently developing HSM application that stacks on top of
standard file system (ext3 and XFS today) and we are using EA to store HSM
specific information with each inode. However, we are not using registration
API, but rather store this in user EA (even if we don't like some
limitations of user EA), because registration API is not exported and
registration API is per-FS and not generic. This would mean that we would
need to have handlers defined for each supported filesystem (ext3 and XFS
today, reiserfs and JFS in near future). As we use user EA, we just call VFS
EA operations of the bottom FS (ext3 or XFS or any other FS that supports
EA).

I agree with your point that this interfaces needs to be exported, but I
would also prefer if they would be generic in terms of being able to
register the same EA handler for each FS supporting EAs (an allowing
extensions/registrations).
I think that we could also then have only single ACL code for both ext2 and
ext3 - currently ACL patch adds similar (same?) code to both ext2 and ext3
and this code could be shared for sure.

Regards,
Luka
