Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273282AbRIRJoV>; Tue, 18 Sep 2001 05:44:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273281AbRIRJoL>; Tue, 18 Sep 2001 05:44:11 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:43961 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S273290AbRIRJnz>;
	Tue, 18 Sep 2001 05:43:55 -0400
Date: Tue, 18 Sep 2001 05:44:18 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Andrea Arcangeli <andrea@suse.de>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.10-pre11
In-Reply-To: <20010918113938.B2723@athlon.random>
Message-ID: <Pine.GSO.4.21.0109180540320.25323-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 18 Sep 2001, Andrea Arcangeli wrote:

> what other design solution do you propose rather both inodes sharing the
> i_mapping across the different inodes like I did?
> 
> I found more handy to just bump the i_count of the first inode and
> referencing it from the bd_inode, rather than dynamically allocating the
> i_mapping and have a bd_mapping, but if you prefer to dynamically
> allocate the i_mapping rather than using the i_data of the fist inode we
> can change that of course. Not sure what's the mess in the patch you're
> talking about, could you elaborate?

Bumping ->i_count on inode is _not_ an option - think what it does if
you umount the first fs.

_If_ you need an inode for block_device - allocate a new one instead of
reusing the inode that had been passed to ->open().

