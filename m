Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264702AbTBETe3>; Wed, 5 Feb 2003 14:34:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264705AbTBETe3>; Wed, 5 Feb 2003 14:34:29 -0500
Received: from packet.digeo.com ([12.110.80.53]:51097 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S264702AbTBETe1>;
	Wed, 5 Feb 2003 14:34:27 -0500
Date: Wed, 5 Feb 2003 11:43:53 -0800
From: Andrew Morton <akpm@digeo.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: lm@bitmover.com, linux-kernel@vger.kernel.org
Subject: Re: 2.5 changeset 1.952.4.2 corrupt in fs/jfs/inode.c
Message-Id: <20030205114353.6591f4c8.akpm@digeo.com>
In-Reply-To: <20030205184535.GG19678@dualathlon.random>
References: <20030205174021.GE19678@dualathlon.random>
	<20030205102308.68899bc3.akpm@digeo.com>
	<20030205184535.GG19678@dualathlon.random>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 Feb 2003 19:43:57.0182 (UTC) FILETIME=[EC1641E0:01C2CD4E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
> In this context I don't mind which is the correct one.
> 
> I only would like to know what is supposed to be stored inside the
> 2.5.59 tarball on kernel.org and what is supposed to be changed between
> 2.5.59 and the 1.952.4.2 changeset.
> 
> The one I see in 2.5.59 (I double checked the tar.gz) is this:
> 
> void jfs_truncate(struct inode *ip)
> {
> 	jFYI(1, ("jfs_truncate: size = 0x%lx\n", (ulong) ip->i_size));
> 
> 	block_truncate_page(ip->i_mapping, ip->i_size, jfs_get_block);
> 
> And I see no changes in this area starting from 2.5.59, until changeset
> 1.952.4.2. So I deduce my software is right and that either the 2.5.59
> tarball or the 1.952.4.2 changeset are corrupt.

OK.  I see.

No, I cannot explain this either.  Shortly after 2.5.55, this change appears in the
web interface:


http://linux.bkbits.net:8080/linux-2.5/cset@1.879.43.1?nav=index.html|ChangeSet@-8w

And revtool shows that change on Jan 09 this year.

But it does not appear in Linus's 2.5.59 tarball, and there appears to be no
record in bitkeeper of where this change fell out of the tree.

In fact the above URL shows two instances of the same patch, with different
human-written summaries, on the same day.

I believe that shaggy had some problem with the nobh stuff, so possibly the
January 9 change was reverted in some manner, and it was reapplied
post-2.5.59, and the web interface does now show the revert.  Revtool does
not show it either.  Nor the reapply.

It is quite confusing.  Yes, something might have gone wrong.

