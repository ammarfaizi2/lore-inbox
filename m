Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281739AbRKQWXu>; Sat, 17 Nov 2001 17:23:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281735AbRKQWXl>; Sat, 17 Nov 2001 17:23:41 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:54516
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S281739AbRKQWXc>; Sat, 17 Nov 2001 17:23:32 -0500
Date: Sat, 17 Nov 2001 14:23:26 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: Jamie Lokier <lk@tantalophile.demon.co.uk>,
        "Theodore Ts'o" <tytso@mit.edu>, Brian <hiryuu@envisiongames.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andreas Dilger <adilger@turbolabs.com>
Subject: Re: File server FS?
Message-ID: <20011117142326.I21354@mikef-linux.matchmail.com>
Mail-Followup-To: Andrew Morton <akpm@zip.com.au>,
	Jamie Lokier <lk@tantalophile.demon.co.uk>,
	Theodore Ts'o <tytso@mit.edu>, Brian <hiryuu@envisiongames.net>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Andreas Dilger <adilger@turbolabs.com>
In-Reply-To: <200111132203.fADM3jW03006@demai05.mw.mediaone.net> <20011113175348.B24864@mikef-linux.matchmail.com> <20011117181253.B5003@kushida.jlokier.co.uk>, <20011117181253.B5003@kushida.jlokier.co.uk> <20011117135542.H21354@mikef-linux.matchmail.com> <3BF6E039.923E0577@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BF6E039.923E0577@zip.com.au>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 17, 2001 at 02:10:01PM -0800, Andrew Morton wrote:
> Mike Fedyk wrote:
> > 
> > I haven't actually resized any ext2/3 partitions.  Didn't need to.  I'll do
> > some tests though.
>
> I tested it a while back - it worked OK.  If you could retest that'd be
> neat.
> 

I'll try to do that over the next couple weeks.

> The journal shouldn't be affected - it's just a regular file.
>

That's what I meant by "as long as the inode number is the same".  Since it
is a normal file, the only thing ext2resize might overlook would be the
inode number for the jounal that's kept in the super block.  If, in fact
ext2resize does decide to change inode numbers for some reason.  I don't
know if it does. 

> mke2fs and tune2fs choose an initial journal size based
> on the size of the fs, so if you were increasing the
> fs size by a large ratio then there may be a case for
> increasing the journal size.  But as you've pointed out,
> an 8, 16 or 32 megabyte journal covers an awful lot of metadata.

Yep.  It would be more important for data=journal mode.

Can ext2resize change the block size too?  If the journal is larger than
100MB then it would need to be made smaller for 1k blocks 200MB for 2k
blocks, and left at 400MB for 4k blocks.

Mike
