Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135909AbREFXQJ>; Sun, 6 May 2001 19:16:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135910AbREFXP7>; Sun, 6 May 2001 19:15:59 -0400
Received: from mail2.bonn-fries.net ([62.140.6.78]:33299 "HELO
	mail2.bonn-fries.net") by vger.kernel.org with SMTP
	id <S135909AbREFXPw>; Sun, 6 May 2001 19:15:52 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
Subject: Re: [PATCH][CFT] (updated) ext2 directories in pagecache
Date: Mon, 7 May 2001 01:16:27 +0200
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01050701135600.07657@starship>
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Cc: Albert Cranford <ac9410@bellsouth.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch updates ext2_getblk and ext2_bread to use the ERR_PTR style 
of error return.  As Al Viro pointed out, this is a better way of doing 
things for a function returning a pointer.  This approach would have 
prevented the bug I fixed with the previous patch.  20 20 hindsight, 
and I can only plead that I was following the interface of the old 
ext2_getblk.  But since these functions are only used only by the ext2 
directory code - which in turn is the only part of ext2 that is 
interested in file data - there was no problem changing the interface.

The patch is at:

    http://nl.linux.org/~phillips/htree/dx.pcache-2.4.4-4

This is lightly tested and apparently stable.  I wish I could say the 
same for kernel 2.4.4 - cache performance sucks horribly.  
(Nontechnical evaluation.)  So it is probably not a good idea to take 
benchmarks too seriously this month.  The previous stable kernels, 
2.4.2 and 2.4.3, had their problems too, fixable via patching.  Maybe 
next month...

This patch requires Al Viro's directory-in-page-cache patch to be 
applied first, available from:

   ftp://ftp.math.psu.edu/pub/viro/ext2-dir-patch-S4.gz

The other flavor of indexing patch, dx.testme..., also does 
directory-in-page-cache, using the good old ext2 directory code.  This 
works fine and is stable, but IMHO Al's patches constitute a pretty 
major cleanup.

To apply:

    cd source/tree
    zcat ext2-dir-patch-S4.gz | patch -p1
    cat dx.pcache-2.4.4-4 | patch -p0

To create an indexed directory:

    mount /dev/hdxxx /test -o index
    mkdir /test/foo

--
Daniel
