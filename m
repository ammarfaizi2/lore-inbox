Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262076AbRFWNuO>; Sat, 23 Jun 2001 09:50:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262715AbRFWNuE>; Sat, 23 Jun 2001 09:50:04 -0400
Received: from obelix.hrz.tu-chemnitz.de ([134.109.132.55]:3538 "EHLO
	obelix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S262076AbRFWNt4>; Sat, 23 Jun 2001 09:49:56 -0400
Date: Sat, 23 Jun 2001 15:50:31 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Ho Chak Hung <hunghochak@netscape.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How does ramfs actually fills the page cache with data?
Message-ID: <20010623155030.Q754@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <65E4C5C3.33174328.0F76C228@netscape.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <65E4C5C3.33174328.0F76C228@netscape.net>; from hunghochak@netscape.net on Fri, Jun 22, 2001 at 05:45:27PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2001 at 05:45:27PM -0400, Ho Chak Hung wrote:
> In fs/ramfs/inode.c, how does ramfs actually fills the page
> cache with data? In the readpage operation, it only zero-fill
> the page if it didn't already exist in the page cache. However,
> how do I actually fill the page with data?

The page cache does it itself. 

"readpage" is to move pages from the backing store into the page
cache. 

"writepage" and friends is for updating the backing store with
the contents of the page cache.

There is no real backing store of ramfs, since ramfs data lives
completly in page cache. 

But we cannot give the user random memory contents, so we zero it
out on readpage and prepare_write.

The data is copied with copy_{from,to}_user in the generic file
operations (look how ramfs_file_operations is defined and look at
the functions referenced), which read/write through page cache.

Regards

Ingo Oeser
-- 
Use ReiserFS to get a faster fsck and Ext2 to fsck slowly and gently.
