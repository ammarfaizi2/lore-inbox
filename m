Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289125AbSAGFYw>; Mon, 7 Jan 2002 00:24:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289126AbSAGFYm>; Mon, 7 Jan 2002 00:24:42 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:4054 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S289125AbSAGFYc>;
	Mon, 7 Jan 2002 00:24:32 -0500
Date: Mon, 7 Jan 2002 00:24:26 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Andrew Morton <akpm@zip.com.au>
cc: Andrea Arcangeli <andrea@suse.de>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] truncate fixes
In-Reply-To: <3C390DAA.3339768C@zip.com.au>
Message-ID: <Pine.GSO.4.21.0201070021320.4370-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 6 Jan 2002, Andrew Morton wrote:

> Andrea Arcangeli wrote:
> > 
> > I prefer my fix that simply recalls the ->truncate callback if -ENOSPC
> > is returned by prepare_write. vmtruncate seems way overkill,
> 
> No opinion on that here.  This is what was in -ac.  Perhaps Al can
> comment?

a) It's obviously correct
b) it's a friggin error-handling path and I'll take correctness over
anything here.

Keep in mind that you want to zero the area out, so at the very least
truncate_inode_pages() + ->truncate() are needed.  And locking/ordering
consideration here are tricky enough to make duplicating them a Bad
Thing(tm).

