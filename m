Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129828AbRCPFeC>; Fri, 16 Mar 2001 00:34:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129740AbRCPFdw>; Fri, 16 Mar 2001 00:33:52 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:10376 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129733AbRCPFdi>;
	Fri, 16 Mar 2001 00:33:38 -0500
Date: Fri, 16 Mar 2001 00:32:56 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Chris Mason <mason@suse.com>
cc: David <david@blue-labs.org>, linux-kernel@vger.kernel.org
Subject: Re: [OOPS] report
In-Reply-To: <635010000.984720574@tiny>
Message-ID: <Pine.GSO.4.21.0103160030230.10709-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 16 Mar 2001, Chris Mason wrote:

> > ObReiserfs_panic: what the hell is that ->s_lock bit about? panic()
> > _never_ tries to do any block IO. It looks like a rudiment of something
> > that hadn't been there for 5 years, if not longer. The same goes for
> > ext2_panic() and ufs_panic(), BTW... I would suggest crapectomey here.
> 
> Ugh, that should have been dragged out and shot...patch will come in the AM.
> 
Unfortunately it's nastier than I thought. panic() does sys_sync(). And
IMO it really shouldn't. Notice that ->s_lock doesn't prevent ->write_inode()
and friends from being called.

I suspect that the right fix is to drop the ->s_lock bogosity along with
sys_sync() call in panic()...


