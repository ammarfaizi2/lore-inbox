Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265059AbSKJSpl>; Sun, 10 Nov 2002 13:45:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265061AbSKJSpl>; Sun, 10 Nov 2002 13:45:41 -0500
Received: from packet.digeo.com ([12.110.80.53]:60866 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265059AbSKJSpk>;
	Sun, 10 Nov 2002 13:45:40 -0500
Message-ID: <3DCEAAE3.C6EE63EF@digeo.com>
Date: Sun, 10 Nov 2002 10:52:19 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ed Tomlinson <tomlins@cam.org>
CC: lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
       Chris Mason <mason@suse.com>
Subject: Re: 2.5.46-mm2 - oops
References: <3DCDD9AC.C3FB30D9@digeo.com> <200211101309.21447.tomlins@cam.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Nov 2002 18:52:19.0692 (UTC) FILETIME=[4BE68AC0:01C288EA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ed Tomlinson wrote:
> 
> On November 9, 2002 10:59 pm, Andrew Morton wrote:
> 
> > Of note in -mm2 is a patch from Chris Mason which teaches reiserfs to
> > use the mpage code for reads - it should show a nice reduction in CPU
> > load under reiserfs reads.
> 
> Booting into mm2 I get:
> 
> ...
> Unable to handle kernel NULL pointer dereference at virtual address 00000004
> 
> ...
> EIP is at mpage_readpages+0x47/0x140

whoops.  The ->readpages API was changed...

--- 25/fs/reiserfs/inode.c~reiserfs-readpages-fix	Sun Nov 10 10:44:28 2002
+++ 25-akpm/fs/reiserfs/inode.c	Sun Nov 10 10:44:39 2002
@@ -2081,7 +2081,7 @@ static int reiserfs_readpage (struct fil
 }
 
 static int
-reiserfs_readpages(struct address_space *mapping,
+reiserfs_readpages(struct file *file, struct address_space *mapping,
                struct list_head *pages, unsigned nr_pages)
 {
     return mpage_readpages(mapping, pages, nr_pages, reiserfs_get_block);

_
