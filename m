Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314082AbSFCTfR>; Mon, 3 Jun 2002 15:35:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314395AbSFCTfQ>; Mon, 3 Jun 2002 15:35:16 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:53764 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S314082AbSFCTfP>; Mon, 3 Jun 2002 15:35:15 -0400
Date: Mon, 3 Jun 2002 12:34:30 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Chris Mason <mason@suse.com>
cc: Andrew Morton <akpm@zip.com.au>, Alexander Viro <aviro@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] iput() cleanup (was Re: [patch 12/16] fix race between
 writeback and unlink)
In-Reply-To: <1023131376.22609.1856.camel@tiny>
Message-ID: <Pine.LNX.4.33.0206031232500.1947-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 3 Jun 2002, Chris Mason wrote:
> 
> Now that is kinda neat, calling it with the inode lock held lets me move
> some things out of reiserfs_file_release which need i_sem, and move them
> into a less expensive drop_inode call without grabbing the semaphore.

CAREFUL!

If you make real per-FS use of this, and aren't just using the standard 
ones, you need to be very very careful. In particular, you get called with 
the inode lock held, but you would have to drop the lock yourself after 
having removed the inode from the hash chains etc. I'd like people to 
avoid playing too many games in this area, the locking and the exact 
semantics of "drop_inode" are rather nasty.

		Linus

