Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261821AbUDEINJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 04:13:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262986AbUDEINJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 04:13:09 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:2203 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S261821AbUDEIM7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 04:12:59 -0400
Date: Mon, 5 Apr 2004 10:12:31 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Ross Biro <ross.biro@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, mj@ucw.cz, jack@ucw.cz,
       "Patrick J. LoPresti" <patl@users.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cowlinks v2
Message-ID: <20040405081231.GB28924@wohnheim.fh-wedel.de>
References: <s5gznab4lhm.fsf@patl=users.sf.net> <20040320152328.GA8089@wohnheim.fh-wedel.de> <20040329171245.GB1478@elf.ucw.cz> <s5g7jx31int.fsf@patl=users.sf.net> <20040329231635.GA374@elf.ucw.cz> <20040402165440.GB24861@wohnheim.fh-wedel.de> <20040402180128.GA363@elf.ucw.cz> <20040402181707.GA28112@wohnheim.fh-wedel.de> <20040402182357.GB410@elf.ucw.cz> <2B32499D.222B761B@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2B32499D.222B761B@mail.gmail.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 April 2004 11:28:55 -0800, Ross Biro wrote:
> 
> Of course, it gets more interesting if you try to do it at the block
> level instead of at the file level.  For ext2, you could just reserve
> a block #, say -1, to mean take the data from the master cow file, and
> anything else is treated normally.  You would need a deamon to make
> sure you were still saving space though.

More interesting is correct.  I see the advantages and proposed this
myself some time ago, but there are downsides.  Basically, for each
block you need additional data, at least a counter telling you the
number of users it currently has.  Eats up memory.

If it really has to make sense, you also have to detect duplicated
blocks at runtime.  So you need a checksum for each block and a
balanced tree containing those checksums or some other means of quick
access.  Eats up 40 bytes (16 checksum, 3*8 tree pointers).  With 4k
blocks, that's 1% memory overhead.

Runtime is even worse.  Unless the tree fits into memory, you have 1-3
disk reads for each write.  Most filesystem developers don't like to
hear such news.

Frankly, the disadvantages still outweigh the advantages today.  With
64k blocks, more memory and more diskspace and in comparison less
unique blocks, it might make sense.  Later. :)

Jörn

-- 
Ninety percent of everything is crap.
-- Sturgeon's Law
