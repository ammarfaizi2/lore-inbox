Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281326AbRKRBhR>; Sat, 17 Nov 2001 20:37:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281815AbRKRBhH>; Sat, 17 Nov 2001 20:37:07 -0500
Received: from pc-62-30-255-29-az.blueyonder.co.uk ([62.30.255.29]:47605 "EHLO
	kushida.jlokier.co.uk") by vger.kernel.org with ESMTP
	id <S281326AbRKRBgv>; Sat, 17 Nov 2001 20:36:51 -0500
Date: Sun, 18 Nov 2001 01:34:15 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Andrew Morton <akpm@zip.com.au>, "Theodore Ts'o" <tytso@mit.edu>,
        Brian <hiryuu@envisiongames.net>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: File server FS?
Message-ID: <20011118013415.A5732@kushida.jlokier.co.uk>
In-Reply-To: <200111132203.fADM3jW03006@demai05.mw.mediaone.net> <20011113175348.B24864@mikef-linux.matchmail.com> <20011117181253.B5003@kushida.jlokier.co.uk>, <20011117181253.B5003@kushida.jlokier.co.uk> <20011117135542.H21354@mikef-linux.matchmail.com> <3BF6E039.923E0577@zip.com.au> <20011117142326.I21354@mikef-linux.matchmail.com> <20011117153808.U1308@lynx.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011117153808.U1308@lynx.no>; from adilger@turbolabs.com on Sat, Nov 17, 2001 at 03:38:08PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger wrote:
> > Can ext2resize change the block size too?  If the journal is larger than
> > 100MB then it would need to be made smaller for 1k blocks 200MB for 2k
> > blocks, and left at 400MB for 4k blocks.
> 
> No, that is a very difficult problem (especially growing the blocksize,
> which is what most people would want to do), because none of the 1kB
> blocks would be aligned properly.  You would need to move basically all
> of the data in the filesystem, at which point you are far better off to
> create a new fs and copy over the data - faster and much less likely to
> have any problems.

Well, it's not really faster if you don't have that much spare disk
space.  You end up doing lots of resizes of the old fs, to gradually
make space for the new fs, and between each resize copy over some of the
files.  Oh, and lots of scary "dd" commands to slide the new fs down the
disk as it grows.

I know this because it's what I had to do, on two computers.

cheers,
-- Jamie
