Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314998AbSDWBcD>; Mon, 22 Apr 2002 21:32:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315005AbSDWBcC>; Mon, 22 Apr 2002 21:32:02 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:14042 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S314998AbSDWBcB>;
	Mon, 22 Apr 2002 21:32:01 -0400
Date: Mon, 22 Apr 2002 21:31:54 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Andrew Morton <akpm@zip.com.au>
cc: Dave Hansen <haveblue@us.ibm.com>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@transmeta.com>,
        "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Subject: Re: locking in sync_old_buffers
In-Reply-To: <3CC489CE.19A91699@zip.com.au>
Message-ID: <Pine.GSO.4.21.0204222130270.5686-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 22 Apr 2002, Andrew Morton wrote:

> Al would know better than I, but...
> 
> If you're going to do this, then the BKL should be acquired
> in fs/super.c:write_super(), so the per-fs ->write_super
> functions do not see changed external locking rules.

Definitely.
 
> Possibly, fs/inode.c:write_inode() needs the same treatment.
> But Doc/filesystems/Locking says that lock_kernel() is not
> held across ->write_inode so there should be no need to take
> it on the kupdate path.

It isn't - it had been shifted into the instances back in 2.3.

