Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310172AbSCPI0M>; Sat, 16 Mar 2002 03:26:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310168AbSCPI0C>; Sat, 16 Mar 2002 03:26:02 -0500
Received: from smtp000.nwlink.com ([209.20.130.57]:59140 "EHLO
	smtp000.nwlink.com") by vger.kernel.org with ESMTP
	id <S310163AbSCPIZp>; Sat, 16 Mar 2002 03:25:45 -0500
Message-ID: <3C93012F.9080601@nwlink.com>
Date: Sat, 16 Mar 2002 00:24:15 -0800
From: Paul Allen <allenp@nwlink.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011126 Netscape6/6.2.1
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Ext2 zeros inode in directory entry when deleting files.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While helping a friend recover from a catastrophic "rm -rf" accident,
I discovered that deleted files have the inode number in their old
directory entries zeroed.  This makes it impossible to match file
names with recovered files.  I've verified this behavior on Mandrake
8.1 with Mandrake's stock 2.4.8 kernel.  In my kernel sources and
in the stock 2.4.8 sources, the function ext2_delete_entry() in
fs/ext2/dir.c has this line:

	dir->inode = 0;

I've done some searching with Google for discussion of this feature.
I didn't find any, but I did find a patch that appears to have
introduced the above line and an "annotated" listing of dir.c
suggesting that the line is part of revision 1.2.  The patch that
apparently introduced this line looks like it was part of a major
overhaul.

Now, I'm tempted to comment the line out in my kernel and see
what happens.  But it does occur to me that hackers with more
experience than I may zeroing the inode number for a reason and
may be depending on it elsewhere in the kernel.  Or perhaps the
ext2 flavor of fsck will malfunction if deleted directory entries
have a non-zero inode?

Can anybody suggest a reason for the existence of the above line
in fs/ext2/dir.c?  Or possibly suggest what would certainly break
if I removed it in my kernel?

Thanks!

Paul Allen
allenp@nwlink.com

