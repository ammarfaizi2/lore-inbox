Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262539AbSJGTU2>; Mon, 7 Oct 2002 15:20:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262560AbSJGTU1>; Mon, 7 Oct 2002 15:20:27 -0400
Received: from dsl-213-023-021-129.arcor-ip.net ([213.23.21.129]:32939 "EHLO
	starship") by vger.kernel.org with ESMTP id <S262539AbSJGTUZ>;
	Mon, 7 Oct 2002 15:20:25 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Chris Friesen <cfriesen@nortelnetworks.com>,
       Andrew Morton <akpm@digeo.com>
Subject: Re: The reason to call it 3.0 is the desktop (was Re: [OT] 2.6 not 3.0 -  (NUMA))
Date: Mon, 7 Oct 2002 21:21:28 +0200
X-Mailer: KMail [version 1.3.2]
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, Oliver Neukum <oliver@neukum.name>,
       Rob Landley <landley@trommello.org>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
References: <m17yCIx-006hSwC@Mail.ZEDAT.FU-Berlin.DE> <3DA1D30E.B3255E7D@digeo.com> <3DA1D969.8050005@nortelnetworks.com>
In-Reply-To: <3DA1D969.8050005@nortelnetworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17ydRY-0003uQ-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 07 October 2002 20:58, Chris Friesen wrote:
> Andrew Morton wrote:
> 
> > Go into ext2_new_inode, replace the call to find_group_dir with
> > find_group_other.  Then untar a kernel tree, unmount the fs,
> > remount it and see how long it takes to do a
> > 
> > 	`find . -type f  xargs cat > /dev/null'
> > 
> > on that tree.  If your disk is like my disk, you will achieve
> > full disk bandwidth.
> 
> Pardon my ignorance, but what's the difference between find_group_dir 
> and find_group_other, and why aren't we using find_group_other already 
> if its so much faster?

These are the heuristics that determine where in the volume directory
inodes are allocated:

   http://lxr.linux.no/source/fs/ext2/ialloc.c#L221

Ext2 likes to spread directory inodes around the volume so that there is
room to keep the associated file blocks nearby.  This interacts rather
poorly with readahead.

-- 
Daniel
