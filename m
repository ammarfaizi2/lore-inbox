Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268997AbUHZOtk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268997AbUHZOtk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 10:49:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268976AbUHZOti
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 10:49:38 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:55731 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269028AbUHZOpn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 10:45:43 -0400
Date: Thu, 26 Aug 2004 15:45:41 +0100
From: Matthew Wilcox <willy@debian.org>
To: Christophe Saout <christophe@saout.de>
Cc: Adrian Bunk <bunk@fs.tum.de>, Hans Reiser <reiser@namesys.com>,
       Jamie Lokier <jamie@shareable.org>,
       viro@parcelfarce.linux.theplanet.co.uk,
       Linus Torvalds <torvalds@osdl.org>, Christoph Hellwig <hch@lst.de>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040826144541.GL16196@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.58.0408251314260.17766@ppc970.osdl.org> <20040825204240.GI21964@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0408251348240.17766@ppc970.osdl.org> <20040825212518.GK21964@parcelfarce.linux.theplanet.co.uk> <20040826001152.GB23423@mail.shareable.org> <20040826003055.GO21964@parcelfarce.linux.theplanet.co.uk> <20040826010049.GA24731@mail.shareable.org> <412DA40B.5040806@namesys.com> <20040826140500.GA29965@fs.tum.de> <1093530313.11694.56.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1093530313.11694.56.camel@leto.cs.pocnet.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2004 at 04:25:13PM +0200, Christophe Saout wrote:
> What reiser4 can do, but the VFS can't is to insert or remove data in
> the middle of a file. Adding this above the page cache would probably be
> almost impossible (truncate seems already complicated enough).
> 
> But below page-cache and thus invisible from the VFS or the applications
> it is extremely useful for the compression plugin. When changing some
> data in the middle of the file the compressed data might grow in size.
> reiser4 can handle this inside the storage layer and doesn't mess with
> the rest of the filesystem.

Never say never ... regular readers of -fsdevel already know what I'm
going to say so can skip this post.

When compressing data on an ext2-like filesystem, you can use the
property of "holes" to deallocate disc blocks in the middle of a file.
It works like this:

Split the file into 64k chunks
Compress each chunk individually, then write them to disc on 64k boundaries,
leaving gaps.
Now you can quickly seek to the appropriate 64k block for the data you're
looking for and decompress just that 64k block.

This is how RISCiX managed to fit an 80MB distro onto a 50MB disc.
Someone has written an equivalent filesystem for Linux called SquashFS.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
