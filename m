Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281759AbRKQW3u>; Sat, 17 Nov 2001 17:29:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281795AbRKQW3l>; Sat, 17 Nov 2001 17:29:41 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:15861 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S281759AbRKQW3f>;
	Sat, 17 Nov 2001 17:29:35 -0500
Date: Sat, 17 Nov 2001 15:27:47 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>,
        "Theodore Ts'o" <tytso@mit.edu>, Brian <hiryuu@envisiongames.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@zip.com.au>
Subject: Re: File server FS?
Message-ID: <20011117152747.S1308@lynx.no>
Mail-Followup-To: Jamie Lokier <lk@tantalophile.demon.co.uk>,
	Theodore Ts'o <tytso@mit.edu>, Brian <hiryuu@envisiongames.net>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@zip.com.au>
In-Reply-To: <200111132203.fADM3jW03006@demai05.mw.mediaone.net> <20011113175348.B24864@mikef-linux.matchmail.com> <20011117181253.B5003@kushida.jlokier.co.uk> <20011117135542.H21354@mikef-linux.matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <20011117135542.H21354@mikef-linux.matchmail.com>; from mfedyk@matchmail.com on Sat, Nov 17, 2001 at 01:55:42PM -0800
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 17, 2001  13:55 -0800, Mike Fedyk wrote:
> On Sat, Nov 17, 2001 at 06:12:53PM +0000, Jamie Lokier wrote:
> > Mike Fedyk wrote:
> > > There are two utilities to resize ext2, which ext3 is except for an
> > > additional file (journal) after umount.
> > 
> > Two questions:
> > 
> >   1. Does the size of the "appropriately sized journal (given the size
> >      of the filesystem)" vary with filesystem size?

Only vaguely.  The current size of the journal is mostly guesswork, because
we don't have any tools to measure if the journal is full or not anyways.

> Journal size has more to do with activity when you are in data journaling
> mode.  Otherwise you will be hard pressed to fill a 32MB journal with
> meta-data.

Correct.

> >   2. If so, does resize2fs change the journal size properly?

No, neither does ext2resize.

> As long as resize2fs doesn't change the inode of the journal file you should
> be fine.

Correct.

> > When I have resized ext3 filesystems, I have removed then recreated the
> > journal manually because it wasn't clear from the documentation whether
> > resize2fs does the appropriate thing.

Like Mike says, there should be very minimal impact to the filesystem
operation, unless you are going from, say, a 16MB filesystem to a 500GB
filesystem.  You also have to watch out if you start with a filesystem
smaller than 500MB - you will get 1kB blocks, and you don't want to have
a large filesystem (10's of GB) with a 1kB blocksize.  There is nothing
that resize2fs or ext2resize can do about that, unfortunately.

> I haven't actually resized any ext2/3 partitions.  Didn't need to.  I'll do
> some tests though.

It works just fine with ext2resize, and I'm pretty sure resize2fs also
works on ext3 filesystems.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

