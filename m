Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262118AbSJJTlG>; Thu, 10 Oct 2002 15:41:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262130AbSJJTlG>; Thu, 10 Oct 2002 15:41:06 -0400
Received: from holomorphy.com ([66.224.33.161]:47083 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S262118AbSJJTlE>;
	Thu, 10 Oct 2002 15:41:04 -0400
Date: Thu, 10 Oct 2002 12:43:31 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
Subject: Re: [LART] inode mismanagement in hugetlb code
Message-ID: <20021010194331.GT10722@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@digeo.com>, Alexander Viro <viro@math.psu.edu>,
	linux-kernel@vger.kernel.org
References: <Pine.GSO.4.21.0210101447390.13421-100000@weyl.math.psu.edu> <3DA5D374.330E5970@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DA5D374.330E5970@digeo.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
>>         a) inodes MUST have an address of valid struct super_block in their
>> ->i_sb.  Had been discussed quite a few times already.

On Thu, Oct 10, 2002 at 12:22:28PM -0700, Andrew Morton wrote:
> afaict, that code only wants an inode because it is borrowing
> the pagecache functions for page lookup.  It's using i_ino as
> a search key too.  It has no superblock.
> Solutions might be: 1) allocate a private <int key, radix tree>
> structure or 2) require that these inodes come from hugetlbfs,
> although the "key" makes that a bit tricky.

shm clobbers hugetlbfs-assigned inode numbers with the shp->id
somewhere around newseg(), (which doesn't matter because it's the
only user of the kern_mounted fs) so ->i_ino will need to avoid
clashing there. But there are several ways to wean hugetlbpage.c off
->i_ino so it's not a big deal.

Bill
