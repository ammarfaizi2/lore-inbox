Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312093AbSCQSVs>; Sun, 17 Mar 2002 13:21:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312087AbSCQSVj>; Sun, 17 Mar 2002 13:21:39 -0500
Received: from mark.mielke.cc ([216.209.85.42]:20747 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S312094AbSCQSVU>;
	Sun, 17 Mar 2002 13:21:20 -0500
Date: Sun, 17 Mar 2002 13:17:02 -0500
From: Mark Mielke <mark@mark.mielke.cc>
To: Oliver Xymoron <oxymoron@waste.org>
Cc: "Theodore Y. Ts'o" <tytso@mit.edu>, Paul Allen <allenp@nwlink.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Ext2 zeros inode in directory entry when deleting files.
Message-ID: <20020317131702.A16140@mark.mielke.cc>
In-Reply-To: <20020317072505.GA768@snap.thunk.org> <Pine.LNX.4.44.0203171049400.31834-100000@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0203171049400.31834-100000@waste.org>; from oxymoron@waste.org on Sun, Mar 17, 2002 at 11:21:08AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 17, 2002 at 11:21:08AM -0600, Oliver Xymoron wrote:
> Also, (for the benefit of our readers) in the case of ext2 directories,
> dirents are in the form
>     [inode][reclen][namelen]["name"][inode][reclen][namelen]["name"]
> where reclen is effectively a pointer to the next record. It should be
> sufficient for the purposes of e2fsck and the kernel that records be
> unlinked from the list by extending the previous record and the inode in
> the entry be marked unused in the inode bitmap. So I see no reason to be
> zeroing the contents of unreferenced disk space, as it needlessly hinders
> future rescue attempts.

Out of curiosity... how would you mark the first entry in a directory
as 'deleted' under your suggestion?

Also, I'm not certain, but I suspect that the reclen vs namelen
difference allows the ext2(/3) format to be extended while minimizing
breakage to existing code. One day another field might be added to the
inode and any assumptions regarding the size of a record length would
limit such extensions. (One such field is currently the 'file type',
although, the file type does not actually use up any additional bytes)

After all, if the record length was always the inode length + name
length + the name, I would personally vote for removing the reclen
altogether. :-)

mark (who likes "rm -fr" being very fast... the easiest way to not
      remove things you don't want to remove is (1) keep backups,
      and (2) don't use it as a habit. Additionally, using a shell
      like /bin/zsh allows you to catch nasty typos involving
      "rm -fr *")

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

