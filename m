Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263107AbTCMXNm>; Thu, 13 Mar 2003 18:13:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263112AbTCMXNm>; Thu, 13 Mar 2003 18:13:42 -0500
Received: from packet.digeo.com ([12.110.80.53]:60128 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S263107AbTCMXNk>;
	Thu, 13 Mar 2003 18:13:40 -0500
Date: Thu, 13 Mar 2003 15:10:38 -0800
From: Andrew Morton <akpm@digeo.com>
To: Andreas Dilger <adilger@clusterfs.com>
Cc: bzzz@tmi.comex.ru, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net
Subject: Re: [PATCH] concurrent block allocation for ext2 against 2.5.64
Message-Id: <20030313151038.221f0360.akpm@digeo.com>
In-Reply-To: <20030313160334.G12806@schatzie.adilger.int>
References: <m3el5bmyrf.fsf@lexa.home.net>
	<20030313015840.1df1593c.akpm@digeo.com>
	<m3of4fgjob.fsf@lexa.home.net>
	<20030313142512.69f82864.akpm@digeo.com>
	<20030313160334.G12806@schatzie.adilger.int>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Mar 2003 23:15:50.0813 (UTC) FILETIME=[7CDF64D0:01C2E9B6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger <adilger@clusterfs.com> wrote:
>
> >    I think it's probably better to just lump all the root-reserved blocks
> >    into as few blockgroups as possible.
> 
> I might disagree here.  One of the reasons for having the reserved blocks
> is to prevent fragmentation, and not necessarily to reserve space for root.
> For the lots of small files cases it makes more sense to leave free space
> in each group to prevent fragmentation at the group level.

Alex's approach effectively makes every blockgroup a little bit smaller.  I
don't expect it will improve fragmentation effects.  Not sure...

> ...
> We could also say that for the purpose of allocating new files in a directory,
> anything more than 95% full is "full" and the inode should be allocated in
> a different group regardless of where the parent is.  It may be that the
> Orlov allocator already has such a heuristic, but I think that is a different
> discussion.

Yes, both find_group_other() and find_group_orlov() do things like that.

But only in 2.5, or in 2.4 with Ted's backport patches.  find_group_other()
in 2.4 forgets to look at the free block count, which is rather sad.

