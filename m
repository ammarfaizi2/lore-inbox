Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129886AbQKPNVN>; Thu, 16 Nov 2000 08:21:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129718AbQKPNVC>; Thu, 16 Nov 2000 08:21:02 -0500
Received: from [62.172.234.2] ([62.172.234.2]:26288 "EHLO saturn.homenet")
	by vger.kernel.org with ESMTP id <S129886AbQKPNUy>;
	Thu, 16 Nov 2000 08:20:54 -0500
Date: Thu, 16 Nov 2000 12:51:39 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Alexander Viro <viro@math.psu.edu>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] get_empty_inode() cleanup
In-Reply-To: <Pine.LNX.4.21.0011161242330.1530-100000@saturn.homenet>
Message-ID: <Pine.LNX.4.21.0011161250290.1530-100000@saturn.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

replying to myself before someone flames me :)

I missed the word "inline" in Alexander's email (maybe because his code
snippet did not have it) so the "issues" I raised are in fact
"non-issues". (and if they were issues then there would be a serious bug
in his patch -- namely new_inode would need to be exported).

Regards,
Tigran

 On Thu, 16 Nov 2000, Tigran Aivazian wrote:

> On Thu, 16 Nov 2000, Tigran Aivazian wrote:
> 
> > On Thu, 16 Nov 2000, Alexander Viro wrote:
> > 
> > > 	Almost all (== all filesystem and then some) callers of
> > > get_empty_inode() follow it with
> > > 	inode->i_sb = some_sb;
> > > 	inode->i_dev = some_sb->s_dev;
> > > Some of them do it twice for no good reason (assign the same value,
> > > even though neither ->i_sb nor ->i_dev could change in interval).
> > > Some of them duplicate the initializations already done by get_empty_inode()
> > > (e.g. ->i_size to 0, ->i_nlink to 1, etc.).
> > > 
> > > 	Patch below adds an inlined function
> > > struct inode *new_inode(struct super_block *sb)
> > > {
> > > 	struct inode *inode = get_empty_inode();
> > > 	if (inode) {
> > > 		inode->i_sb = sb;
> > > 		inode->i_dev = sb->s_dev;
> > > 	}
> > > 	return inode;
> > > }
> > 
> > Alexander,
> > 
> > IMHO, instead of adding a new function, it is cleaner to just add the 'sb'
> > argument to get_empty_inode() and those who do not wish to pass it should
> > just pass NULL. Checking if(sb) inside it is easier than making yet
> > another function call, maybe.
> > 
> 
> on the other hand, even 1 minute's thought reveals that making strict
> logical separation between "consumers of inode with sb" and "consumers of
> inode without sb" is probably worth the overhead of an extra function
> call. So, I don't strongly feel about the above... maybe you are right :)
> 
> Regards,
> Tigran
> 
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
