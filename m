Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312142AbSCQX6g>; Sun, 17 Mar 2002 18:58:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312140AbSCQX6Z>; Sun, 17 Mar 2002 18:58:25 -0500
Received: from mark.mielke.cc ([216.209.85.42]:2060 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S312141AbSCQX6N>;
	Sun, 17 Mar 2002 18:58:13 -0500
Date: Sun, 17 Mar 2002 18:53:56 -0500
From: Mark Mielke <mark@mark.mielke.cc>
To: Oliver Xymoron <oxymoron@waste.org>
Cc: "Theodore Y. Ts'o" <tytso@mit.edu>, Paul Allen <allenp@nwlink.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Ext2 zeros inode in directory entry when deleting files.
Message-ID: <20020317185356.C16140@mark.mielke.cc>
In-Reply-To: <20020317131702.A16140@mark.mielke.cc> <Pine.LNX.4.44.0203171516540.21552-100000@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0203171516540.21552-100000@waste.org>; from oxymoron@waste.org on Sun, Mar 17, 2002 at 03:20:19PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 17, 2002 at 03:20:19PM -0600, Oliver Xymoron wrote:
> On Sun, 17 Mar 2002, Mark Mielke wrote:
> > Out of curiosity... how would you mark the first entry in a directory
> > as 'deleted' under your suggestion?
> As it happens, the first entry tends to be '.'.

If this was a guarantee, I would assume that the initial two entries
could be optimized as two inodes.

> > Also, I'm not certain, but I suspect that the reclen vs namelen
> > difference allows the ext2(/3) format to be extended while minimizing
> > breakage to existing code. One day another field might be added to the
> > inode and any assumptions regarding the size of a record length would
> > limit such extensions. (One such field is currently the 'file type',
> > although, the file type does not actually use up any additional bytes)
> Doesn't matter, reclen still makes it a linked list, and we'd still skip
> over 'dead' entries, regardless of content.

If the extra bytes (reclen - namelen) *were* extra bits of file system
information, there would be no safe way of ensuring that the allocation
of a new directory entry didn't 'accidentally' overwrite these bytes.

Exactly how big should you assume reclen *really* is, if reclen
sometimes means the length of the record, and other times means a next
pointer offset?

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

