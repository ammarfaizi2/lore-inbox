Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314273AbSDRI6u>; Thu, 18 Apr 2002 04:58:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314274AbSDRI6t>; Thu, 18 Apr 2002 04:58:49 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:32266 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S314273AbSDRI6t>;
	Thu, 18 Apr 2002 04:58:49 -0400
Message-ID: <3CBE8AAA.FD940076@zip.com.au>
Date: Thu, 18 Apr 2002 01:58:18 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Anton Blanchard <anton@samba.org>
CC: linux-kernel@vger.kernel.org, hannal@us.ibm.com
Subject: Re: 12 way dbench analysis: 2.5.9, dalloc and fastwalkdcache
In-Reply-To: <20020418081843.GE4209@krispykreme>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Blanchard wrote:
> 
> Hi,
> 
> Its about time I took to the kernel with the dbench stick. The following
> results were done on a 12 way ppc64 machine with 250MHz cpus. I tested
> 2.5.9, 2.5.9 with Andrew Morton's dalloc work and Hanna Linder's fast
> walk dcache patch. The results can be found at:
> 
> http://samba.org/~anton/linux/2.5.9/
> 

Thanks, Anton.

I should point out that the patches are misnamed - this stuff
has nothing to do with "delayed allocation".  It just started out
that way.

The code Anton tested was the removal of the buffer LRUs and
the buffer hashtable and the introduction of address_space-based
writeback.  That code is >this< close to being ready.  Still
chasing a couple of oddities.

Anton also found a ratcache locking bug.  Patch is under test.

After the writeback changes I plan on:

- A ton of little cleanups
- Add dirty address_spaces to the superblocks, don't find them
  via inodes.
- Assemble BIOs direct against pagecache for buffer-backed
  filesystems - bypass the buffer layer for bulk file I/O.
- All sorts of other stuff.
- Then back onto delayed allocate.  That's item 78 on the
  79-entry todo list...

-
