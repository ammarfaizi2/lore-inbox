Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269340AbRHCH67>; Fri, 3 Aug 2001 03:58:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269342AbRHCH6t>; Fri, 3 Aug 2001 03:58:49 -0400
Received: from ns.caldera.de ([212.34.180.1]:8156 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S269340AbRHCH6h>;
	Fri, 3 Aug 2001 03:58:37 -0400
Date: Fri, 3 Aug 2001 09:56:40 +0200
From: Christoph Hellwig <hch@caldera.de>
To: Andries.Brouwer@cwi.nl
Cc: alan@lxorguk.ukuu.org.uk, hch@caldera.de, torvalds@transmeta.com,
        viro@math.psu.edu, linux-kernel@vger.kernel.org
Subject: Re: [semiPATCH] another vxfs fix
Message-ID: <20010803095640.A9328@caldera.de>
Mail-Followup-To: Christoph Hellwig <hch@caldera.de>,
	Andries.Brouwer@cwi.nl, alan@lxorguk.ukuu.org.uk,
	torvalds@transmeta.com, viro@math.psu.edu,
	linux-kernel@vger.kernel.org
In-Reply-To: <200108030043.AAA103538@vlet.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200108030043.AAA103538@vlet.cwi.nl>; from Andries.Brouwer@cwi.nl on Fri, Aug 03, 2001 at 12:43:48AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 03, 2001 at 12:43:48AM +0000, Andries.Brouwer@cwi.nl wrote:
> 
> With the brelse() fix, a failed vxfs mount is OK.
> But after a successful vxfs mount the umount still yields
>   VFS: Busy inodes after unmount. Self-destruct in 5 seconds.  Have a nice day
> (And today's [yesterday's] patch by Christoph makes no difference.)
> 
> The reason is that the routine vxfs_fake_inode() does
> new_inode(), but this inode is never returned.
> I fixed this but am not sure against which base source
> the patch should be described.
> A minimal version would be to change the six [1] calls of
> 	vxfs_put_inode()
> in vxfs_super.c into calls of
> 	iput()
> 
> (In my source I turned vxfs_fake_inode() into vxfs_get_fake_inode()
> and added vxfs_put_fake_inode() that just does iput().)

Sounds fine - just submit me any version and I'll rebase it against
the latest Linus and Alan trees.

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
