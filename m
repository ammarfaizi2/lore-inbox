Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317790AbSFMRxy>; Thu, 13 Jun 2002 13:53:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317791AbSFMRxx>; Thu, 13 Jun 2002 13:53:53 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:28383 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S317790AbSFMRxw>;
	Thu, 13 Jun 2002 13:53:52 -0400
Date: Thu, 13 Jun 2002 13:53:51 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Daniel Phillips <phillips@bonn-fries.net>
cc: Dawson Engler <engler@csl.Stanford.EDU>,
        Benjamin LaHaise <bcrl@redhat.com>, linux-kernel@vger.kernel.org,
        mc@cs.Stanford.EDU
Subject: Re: [CHECKER] 37 stack variables >= 1K in 2.4.17
In-Reply-To: <E17IYam-0000Qh-00@starship>
Message-ID: <Pine.GSO.4.21.0206131350180.20315-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 13 Jun 2002, Daniel Phillips wrote:

> > I mean that due to the loop (link_path_walk->do_follow_link->foofs_follow_link
> > ->vfs_follow_link->link_path_walk) you will get infinite maximal depth
> > for everything that can be called by any of these functions.  And that's
> > a _lot_ of stuff.
> 
> Then at the point of recursion a dynamic check for stack space is
> needed, and [checker]'s role would be to determine the deepest static
> depth, to plug into the stack check.  If we want to be sure about 
> stack integrity there isn't any way around this.

Wrong.  Check for stack _space_ will mean that maximal depth of nested
symlinks depends on syscall.  Definitely not what you want to see.
There is a static limit (no more than 5 nested), but it must be
explicitly known to checker - deducing it from code is easy for a
human, but hopeless for anything automatic.

