Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262184AbSJJTTA>; Thu, 10 Oct 2002 15:19:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262167AbSJJTR6>; Thu, 10 Oct 2002 15:17:58 -0400
Received: from packet.digeo.com ([12.110.80.53]:27062 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262184AbSJJTQu>;
	Thu, 10 Oct 2002 15:16:50 -0400
Message-ID: <3DA5D374.330E5970@digeo.com>
Date: Thu, 10 Oct 2002 12:22:28 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: [LART] inode mismanagement in hugetlb code
References: <Pine.GSO.4.21.0210101447390.13421-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Oct 2002 19:22:28.0807 (UTC) FILETIME=[5F695570:01C27092]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> 
> [A discussion of the meanings of the terms "MUST", "SHOULD", and "MAY" appears
> in RFC-1123; the terms "MUST NOT" and "SHOULD NOT" are logical extensions of
> this usage]
> 
>         a) inodes MUST have an address of valid struct super_block in their
> ->i_sb.  Had been discussed quite a few times already.
> 

afaict, that code only wants an inode because it is borrowing
the pagecache functions for page lookup.  It's using i_ino as
a search key too.  It has no superblock.

Solutions might be: 1) allocate a private <int key, radix tree>
structure or 2) require that these inodes come from hugetlbfs,
although the "key" makes that a bit tricky.
