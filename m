Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268703AbUHYVPW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268703AbUHYVPW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 17:15:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268812AbUHYVKv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 17:10:51 -0400
Received: from fw.osdl.org ([65.172.181.6]:22459 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268602AbUHYVAb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 17:00:31 -0400
Date: Wed, 25 Aug 2004 14:00:01 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: viro@parcelfarce.linux.theplanet.co.uk
cc: Christoph Hellwig <hch@lst.de>, Hans Reiser <reiser@namesys.com>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
In-Reply-To: <20040825204240.GI21964@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.58.0408251348240.17766@ppc970.osdl.org>
References: <20040824202521.GA26705@lst.de> <412CEE38.1080707@namesys.com>
 <20040825200859.GA16345@lst.de> <Pine.LNX.4.58.0408251314260.17766@ppc970.osdl.org>
 <20040825204240.GI21964@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 25 Aug 2004 viro@parcelfarce.linux.theplanet.co.uk wrote:
>
> On Wed, Aug 25, 2004 at 01:22:55PM -0700, Linus Torvalds wrote:
> > 
> > It's the UNIX way.
> 
> Not if you allow link(2) on them.

Heh. I don't think that's a very strong argument against being "unixy", 
considering how traditional unix _used_ to handle directories.

mkdir/rmdir/rename only came later. Now, obviously they did come later for 
a good reason, but still..

The interesting part is that thanks to the dcache, we should be perfectly
able to actually _see_ circular links etc, so some of the problems with 
linking directories should actually be quite solvable - something that is 
_not_ true for a traditional UNIX VFS layer.

Of course, the dcache introduces some new problems of its own wrt
directory aliasing, but I don't actually think that should be fundamental
either. Treating them more as a "static mountpoint" from an FS angle and
less as a traditional Unix hardlink should be doable, I'd have thought.

(Also, it's entirely possible that the filesystem may not support some of
the more esoteric linking/renaming operations. For example, in a
traditional xattrs setup where the xattr is linked on-disk with the file
it is associated with, you simply _can't_ link it somewhere else, or
rename it to any other directory. That's not a VFS layer issue, obviously,
but I thought I'd bring up the point that file-as-dir cases may have
limitations that normal files don't have).

>  And not if you design and market your stuff as a general-purpose
> backdoor into kernel.

Now that's a separate argument, and not one I'm personally interested in
arguing at least right now. I haven't actually looked at the reiser4 code,
so I'm really _only_ arguing against special-case attributes.

		Linus
