Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262454AbSJPArK>; Tue, 15 Oct 2002 20:47:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264638AbSJPArK>; Tue, 15 Oct 2002 20:47:10 -0400
Received: from packet.digeo.com ([12.110.80.53]:4334 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262454AbSJPArJ>;
	Tue, 15 Oct 2002 20:47:09 -0400
Message-ID: <3DACB86A.829ECF3C@digeo.com>
Date: Tue, 15 Oct 2002 17:52:58 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andreas Gruenbacher <agruen@suse.de>
CC: tytso@mit.edu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] Add extended attributes to ext2/3
References: <E181a3N-0006No-00@snap.thunk.org> <3DACAC0C.D4C497C1@digeo.com> <200210160211.39284.agruen@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Oct 2002 00:52:58.0743 (UTC) FILETIME=[5F0A3070:01C274AE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Gruenbacher wrote:
> 
> ..
> > This should be converted to use sector_t for >2TB support, and tested
> > with CONFIG_LBD=y and n.
> 
> e_block is the block number; the e_indexes are hash values. Ext[23] only has
> 32bit block numbers. Am I getting you wrong?

Well it depends how generic the mbcache code is supposed to be.

The kernel has just gained supoprt for 64-bit sectors on ia32
and PPC32 but the new mbcache code will not support that.

I guess if there are no current 64-bit users of mbcache then
it can be deferred until there is a need.

> > The use of a dev_t search key is a bit old-fashioned.  Maybe
> > use the address of inode->i_sb->s_bdev?
> 
> That would do as well.
> 
> A related issue:
> 
> Would switching to a more decent hash algorithm in fs/ext?/xattr.c make sense?
> I think there are better ones in 2.5. This would only degrade sharing on
> "legacy" systems for a while, but the slow down would vanish over time.

Might do.  There's hash_long() in <linux/hash.h>
