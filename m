Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311575AbSCQHZa>; Sun, 17 Mar 2002 02:25:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311865AbSCQHZU>; Sun, 17 Mar 2002 02:25:20 -0500
Received: from SNAP.THUNK.ORG ([216.175.175.173]:18450 "EHLO snap.thunk.org")
	by vger.kernel.org with ESMTP id <S311575AbSCQHZO>;
	Sun, 17 Mar 2002 02:25:14 -0500
Date: Sun, 17 Mar 2002 02:25:05 -0500
From: tytso@mit.edu
To: Paul Allen <allenp@nwlink.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Ext2 zeros inode in directory entry when deleting files.
Message-ID: <20020317072505.GA768@snap.thunk.org>
Mail-Followup-To: tytso@mit.edu, Paul Allen <allenp@nwlink.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3C93012F.9080601@nwlink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C93012F.9080601@nwlink.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 16, 2002 at 12:24:15AM -0800, Paul Allen wrote:
> While helping a friend recover from a catastrophic "rm -rf" accident,
> I discovered that deleted files have the inode number in their old
> directory entries zeroed.  This makes it impossible to match file
> names with recovered files.  I've verified this behavior on Mandrake
> 8.1 with Mandrake's stock 2.4.8 kernel.  In my kernel sources and
> in the stock 2.4.8 sources, the function ext2_delete_entry() in
> fs/ext2/dir.c has this line:
> 
> 	dir->inode = 0;
> 
> Now, I'm tempted to comment the line out in my kernel and see
> what happens.  But it does occur to me that hackers with more
> experience than I may zeroing the inode number for a reason and
> may be depending on it elsewhere in the kernel.  Or perhaps the
> ext2 flavor of fsck will malfunction if deleted directory entries
> have a non-zero inode?

Um....  the way directory entries are marked as deleted is by zeroing
out the inode number.

So if you take out that line, deleted files will appear not to be
deleted, the kernel will get confused, and you can be sure that fsck
will complain.

						- Ted
