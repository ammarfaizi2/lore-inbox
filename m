Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263894AbRFYDBs>; Sun, 24 Jun 2001 23:01:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265850AbRFYDBj>; Sun, 24 Jun 2001 23:01:39 -0400
Received: from imo-m03.mx.aol.com ([64.12.136.6]:8147 "EHLO imo-m03.mx.aol.com")
	by vger.kernel.org with ESMTP id <S263894AbRFYDBb>;
	Sun, 24 Jun 2001 23:01:31 -0400
Date: Sun, 24 Jun 2001 23:01:23 -0400
From: hunghochak@netscape.net (Ho Chak Hung)
To: linux-kernel@vger.kernel.org
Subject: Re: How does ramfs actually fills the page cache with data?
Mime-Version: 1.0
Message-ID: <2E88A0D1.6C921C1E.0F76C228@netscape.net>
X-Mailer: Franklin Webmailer 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

thanks a lot for your reply

But is it at all possible to put data into page cache without going through the inodes or files? I mean, for example, if you are given a string "abcde", and you want to allocate a page to store this "abcde" into that page and add that page to the page cache, what would you do? 

2)The ramfs uses the generic file operation
Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de> wrote:
>
> On Fri, Jun 22, 2001 at 05:45:27PM -0400, Ho Chak Hung wrote:
> > In fs/ramfs/inode.c, how does ramfs actually fills the page
> > cache with data? In the readpage operation, it only zero-fill
> > the page if it didn't already exist in the page cache. However,
> > how do I actually fill the page with data?
> 
> The page cache does it itself. 
> 
> "readpage" is to move pages from the backing store into the page
> cache. 
> 
> "writepage" and friends is for updating the backing store with
> the contents of the page cache.
> 
> There is no real backing store of ramfs, since ramfs data lives
> completly in page cache. 
> 
> But we cannot give the user random memory contents, so we zero it
> out on readpage and prepare_write.
> 
> The data is copied with copy_{from,to}_user in the generic file
> operations (look how ramfs_file_operations is defined and look at
> the functions referenced), which read/write through page cache.
> 
> Regards
> 
> Ingo Oeser
> -- 
> Use ReiserFS to get a faster fsck and Ext2 to fsck slowly and gently.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
__________________________________________________________________
__________________________________________________________________
Get your own FREE, personal Netscape Webmail account today at http://webmail.netscape.com/
