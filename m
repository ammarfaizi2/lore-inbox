Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262546AbSJGTcc>; Mon, 7 Oct 2002 15:32:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262613AbSJGTcD>; Mon, 7 Oct 2002 15:32:03 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:60678 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262546AbSJGTa6>; Mon, 7 Oct 2002 15:30:58 -0400
Date: Mon, 7 Oct 2002 12:35:26 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Daniel Phillips <phillips@arcor.de>
cc: Chris Friesen <cfriesen@nortelnetworks.com>,
       Andrew Morton <akpm@digeo.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Oliver Neukum <oliver@neukum.name>, Rob Landley <landley@trommello.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: The reason to call it 3.0 is the desktop (was Re: [OT] 2.6 not
 3.0 -  (NUMA))
In-Reply-To: <E17ydRY-0003uQ-00@starship>
Message-ID: <Pine.LNX.4.33.0210071229080.10168-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 7 Oct 2002, Daniel Phillips wrote:
> 
> Ext2 likes to spread directory inodes around the volume so that there is
> room to keep the associated file blocks nearby.  This interacts rather
> poorly with readahead.

Not a read-ahead problem. It interacts rather poory _full_stop_.

It means that the inode tables are spread all out, the bitmaps are
fragmented etc, so the disk head has to move all over the disk even when
only working with one directory tree like the kernel sources.

Kernel-level read-ahead doens't much help, because the FS tries to keep
the data blocks for individual files together - which is the case the
kernel _can_ try to optimize a bit. Physical read-ahead doesn't work
either, since the parts that can be physically read ahead are the ones
that the regular in-file read-ahead already mostly takes care of it.

So the problem with spreading stuff out doesn't have anything to do with 
read-ahead, and has everything to do with the basic issue of BAD LOCALITY. 
Locality is _good_, independently of read-ahead and independently of 
medium. 

Locality helps regardless of any read-ahead, although it is clearly true 
that bad locality makes readahead more futile.

		Linus

