Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318420AbSHENDa>; Mon, 5 Aug 2002 09:03:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318422AbSHENDa>; Mon, 5 Aug 2002 09:03:30 -0400
Received: from tolkor.SGI.COM ([192.48.180.13]:35768 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S318420AbSHEND3>;
	Mon, 5 Aug 2002 09:03:29 -0400
Subject: Re: BIG files & file systems
From: Stephen Lord <lord@sgi.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: "Albert D. Cahalan" <acahalan@cs.uml.edu>,
       Matti Aarnio <matti.aarnio@zmailer.org>,
       Christoph Hellwig <hch@infradead.org>,
       "Peter J. Braam" <braam@clusterfs.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33L2.0208021507420.14068-100000@dragon.pdx.osdl.net>
References: <Pine.LNX.4.33L2.0208021507420.14068-100000@dragon.pdx.osdl.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 05 Aug 2002 08:04:03 -0500
Message-Id: <1028552648.1251.26.camel@laptop.americas.sgi.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-08-02 at 17:14, Randy.Dunlap wrote:
> On Fri, 2 Aug 2002, Albert D. Cahalan wrote:
> 
> | Matti Aarnio writes:
> |
> | >   It depends on many things:
> | >    - Block layer (unsigned long)
> | >    - Page indexes (unsigned long)
> | >    - Filesystem format dependent limits
> | >       - EXT2/EXT3: u32_t FILESYSTEM block index, presuming the EXT2/EXT3
> | >                    is supported only up to 4 kB block sizes, that gives
> | >                    you a very hard limit.. of 16 terabytes (16 * "10^12")
> |
> | You first hit the triple-indirection limit at 4 TB.
> | http://www.cs.uml.edu/~acahalan/linux/ext2.gif
> |
> | >       - ReiserFS:  u32_t block indexes presently, u64_t in future;
> | >                    block size ranges ?   Max size is limited by the
> | >                    maximum supported file size, likely 2^63, which is
> | >                    roughly  8 * "10^18", or circa 500 000 times larger
> | >                    than EXT2/EXT3 format maximum.
> |
> | The top 4 st_size bits get stolen, so it's 60-bit sizes.
> | You also get the 32-bit block limit at 16 TB.
> | -
> 
> For a LinuxWorld presentation in August, I have asked each of the
> 4 journaling filesystems (ext3, reiserfs, JFS, and XFS) what their
> filesystem/filesize limits are.  Here's what they have told me.
> 
>                       ext3fs     reiserfs     JFS     XFS
> max filesize:         16 TB#      1 EB       4 PB$   8 TB%
> max filesystem size:   2 TB      17.6 TB*    4 PB$   2 TB!
> 
> Notes:
> #: think sparse files
> *: 4 KB blocks
> $: 16 TB on 32-bit architectures
> %: 4 KB pages
> !: block device limit

Randy,

If those are the numbers you are presenting then make it clear that
for XFS those are the limits imposed by the the Linux kernel. The
core of XFS itself can support files and filesystems of 9 Exabytes.
I do not think all the filesystems are reporting their numbers in
the same way.

Steve


