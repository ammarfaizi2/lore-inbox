Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262526AbSJGSrU>; Mon, 7 Oct 2002 14:47:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262529AbSJGSrU>; Mon, 7 Oct 2002 14:47:20 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:20755 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262526AbSJGSrT>; Mon, 7 Oct 2002 14:47:19 -0400
Date: Mon, 7 Oct 2002 11:51:46 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrew Morton <akpm@digeo.com>
cc: Daniel Phillips <phillips@arcor.de>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Oliver Neukum <oliver@neukum.name>, Rob Landley <landley@trommello.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: The reason to call it 3.0 is the desktop (was Re: [OT] 2.6 not
 3.0 -  (NUMA))
In-Reply-To: <3DA1D30E.B3255E7D@digeo.com>
Message-ID: <Pine.LNX.4.33.0210071145120.1356-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 7 Oct 2002, Andrew Morton wrote:
> 
> Devices do physical readahead, and it works nicely.

Indeed. There isn't any reasonable device where this isn't the case: the
_device_ (and sometimes the driver - floppy.c) does a lot better at
readahead than higher layers can do anyway.

> Go into ext2_new_inode, replace the call to find_group_dir with
> find_group_other.

I hate that thing. Hate hate hate. Maybe we should just do this, and hope 
that somebody will do a proper off-line cleanup tool.

In the meantime, it might just be possible to take a look at the uid, and 
if the uid matches use find_group_other, but for non-matching uids use 
find_group_dir. That gives a "compact for same users, distribute for 
different users" heuristic, which might be acceptable for normal use (and 
the theoretical cleanup tool could fix it up).

Add some other heuristics ("if the difference between free group sizes is 
bigger than a factor of two"), and maybe it would be useful.

The current approach sucks for everybody, and makes it impossible to get 
good throughput on a disk on many very common loads.

		Linus

