Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135532AbRDSDYC>; Wed, 18 Apr 2001 23:24:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135531AbRDSDXx>; Wed, 18 Apr 2001 23:23:53 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:48086 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S135532AbRDSDXl>;
	Wed, 18 Apr 2001 23:23:41 -0400
Date: Wed, 18 Apr 2001 23:23:35 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Rik van Riel <riel@conectiva.com.br>
cc: Daniel Phillips <phillips@nl.linux.org>, linux-kernel@vger.kernel.org,
        adilger@turbolinux.com, ext2-devel@lists.sourceforge.net
Subject: Re: Ext2 Directory Index - Delete Performance
In-Reply-To: <Pine.LNX.4.21.0104182343240.1685-100000@imladris.rielhome.conectiva>
Message-ID: <Pine.GSO.4.21.0104182319100.15153-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 18 Apr 2001, Rik van Riel wrote:

> On Thu, 19 Apr 2001, Daniel Phillips wrote:
> 
> > OK, now I know what's happening, the next question is, what should be
> > dones about it.  If anything.
> 
> [ discovered by alexey on #kernelnewbies ]
> 
> One thing we should do is make sure the buffer cache code sets
> the referenced bit on pages, so we don't recycle buffer cache
> pages early.
> 
> This should leave more space for the buffercache and lead to us
> reclaiming the (now unused) space in the dentry cache instead...

Sorry, but that's just plain wrong. We shouldn't keep inode table in
buffer-cache at all. And we should be more aggressive on icache -
dcache looks sane now (recent 2.4.4-pre), but icache holds unused
inodes for too long. And freeing them is very slow _and_ random -
recipe for kmem_cache fragmentation.

/me sits down to port inode-table-in-pagecache to 2.4.4-pre4...

