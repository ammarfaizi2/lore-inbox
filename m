Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289241AbSAGQHj>; Mon, 7 Jan 2002 11:07:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289245AbSAGQHa>; Mon, 7 Jan 2002 11:07:30 -0500
Received: from dsl-213-023-038-159.arcor-ip.net ([213.23.38.159]:33039 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S289241AbSAGQHM>;
	Mon, 7 Jan 2002 11:07:12 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Jeff Garzik <jgarzik@mandrakesoft.com>, torvalds@transmeta.com,
        viro@math.psu.edu
Subject: Re: PATCH 2.5.2.9: ext2 unbork fs.h (part 1/7)
Date: Mon, 7 Jan 2002 17:10:21 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        ext2-devel@lists.sourceforge.net
In-Reply-To: <20020107132121.241311F6A@gtf.org> 
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16NcLw-0001R9-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 7, 2002 04:19 pm, Daniel Phillips wrote:
>   - You are dreferencing a pointer, and have two allocations for every
>     inode instead of one.

Oh no, you only have one allocator, and you have the filesystem do it, with 
per-sb methods.  Why is this better than having the VFS do it?  Does this 
imply you might have different sized inodes with different mounts of the same 
filesystem?

The per-fs cost with my variant is: 4-8 bytes per filesystem, period.  No 
methods needed, and the object management code doesn't get replicated through 
all the filesystems.

Also, having the inode point at itself is a little, hmm, 'what's wrong with 
this picture', don't you think?

--
Daniel
