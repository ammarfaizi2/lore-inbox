Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280743AbRKOF4A>; Thu, 15 Nov 2001 00:56:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280737AbRKOFzu>; Thu, 15 Nov 2001 00:55:50 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:9711 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S280743AbRKOFzf>;
	Thu, 15 Nov 2001 00:55:35 -0500
Date: Wed, 14 Nov 2001 22:55:24 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: "Peter T. Breuer" <ptb@it.uc3m.es>,
        linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: blocks or KB? (was: .. current meaning of blk_size array)
Message-ID: <20011114225524.Z5739@lynx.no>
Mail-Followup-To: "Peter T. Breuer" <ptb@it.uc3m.es>,
	linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3BF23D01.F7E879E8@evision-ventures.com> <200111142041.fAEKfBN15594@oboe.it.uc3m.es> <20011115003434.A25883@node0.opengeometry.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <20011115003434.A25883@node0.opengeometry.ca>; from opengeometry@yahoo.ca on Thu, Nov 15, 2001 at 12:34:34AM -0500
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 15, 2001  00:34 -0500, William Park wrote:
> Judging by 'driver/block/nbd.c', it counts by BLOCK_SIZE=1204
> (BLOCK_SIZE_BITS=10), even though you can set the block size to
> [512,1024,...,PAGE_SIZE=4096].  Since NBD counts this 1KB block using
> 'u64' integer, the ultimate size of filesystem is determined by the
> kernel block device support.
> 
> Looking at 'fs/block_dev.c', you can set the block size to
> [512,1024,...,PAGE_SIZE=4096] also.  But, 'max_block()' returns block
> count in whatever block size of the device, not in BLOCK_SIZE:

Sadly, while you _might_ be able to change the BLOCK_SIZE to be something
other than 1kB, there are probably so many places that assume a 1kB size
that you will need a lot of fixing.  I'm not saying that fixing these
things is bad (it would actually be good for many reasons), but just a
heads-up that changing the BLOCK_SIZE define _probably_ won't get you 8TB
devices (maybe a broken system, or corrupt fs instead).  Use caution.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

