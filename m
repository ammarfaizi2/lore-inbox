Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265513AbSLFTFB>; Fri, 6 Dec 2002 14:05:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265587AbSLFTFB>; Fri, 6 Dec 2002 14:05:01 -0500
Received: from packet.digeo.com ([12.110.80.53]:16062 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265513AbSLFTFB>;
	Fri, 6 Dec 2002 14:05:01 -0500
Message-ID: <3DF0F69E.FF0E513A@digeo.com>
Date: Fri, 06 Dec 2002 11:12:30 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Chris Mason <mason@suse.com>
CC: lkml <linux-kernel@vger.kernel.org>,
       "ext3-users@redhat.com" <ext3-users@redhat.com>
Subject: Re: [patch] fix the ext3 data=journal unmount bug
References: <3DF03B35.AA5858DC@digeo.com> <1039197769.7939.46.camel@tiny>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Dec 2002 19:12:31.0368 (UTC) FILETIME=[6CDB2080:01C29D5B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Mason wrote:
> 
> On Fri, 2002-12-06 at 00:52, Andrew Morton wrote:
> >
> >
> > This patch fixes the data loss which can occur when unmounting a
> > data=journal ext3 filesystem.
> >
> > The core problem is that the VFS doesn't tell the filesystem enough
> > about what is happening.  ext3 _needs_ to know the difference between
> > regular memory-cleansing writeback and sync-for-data-integrity
> > purposes.
> >
> 
> What happens when the user does a sync() immediately after kupdate
> trigger a write_super?
> 
> Since ext3_write_super just clears s_dirt, I don't see how sync_fs()
> will get called.
> 

It won't.  There isn't really a sane way of doing this properly unless
we do something like:

1) Add a new flag to the superblock
2) Set that flag against all r/w superblocks before starting the sync
3) Use that flag inside the superblock walk.

That would provide a reasonable solution, but I don't believe we
need to go to those lengths in 2.4, do you?
