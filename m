Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135176AbRDVChH>; Sat, 21 Apr 2001 22:37:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135177AbRDVCg6>; Sat, 21 Apr 2001 22:36:58 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:27402 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S135176AbRDVCgo>;
	Sat, 21 Apr 2001 22:36:44 -0400
Date: Sun, 22 Apr 2001 04:36:18 +0200
From: Jens Axboe <axboe@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Daniel Kobras <kobras@tat.physik.uni-tuebingen.de>,
        linux-kernel@vger.kernel.org
Subject: Re: MO-Drive under 2.4.3
Message-ID: <20010422043618.C4058@suse.de>
In-Reply-To: <20010422013738.A520@pelks01.extern.uni-tuebingen.de> <E14r7I2-0004d8-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E14r7I2-0004d8-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sun, Apr 22, 2001 at 12:59:44AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 22 2001, Alan Cox wrote:
> > a) Put in lots of bigblock special case code in FAT;
> > b) teach submit_bh() or generic_make_request() to transparently reblock 
> >    bhs < hw_blksize and remove most special cases from FAT. Specifically,
> >    it ought to stop pretending in sb->s_blocksize to use 2k blocks when
> >    the fs is really tied to 512 byte blocks.
> > 
> > I tend to favour b), but which one is more likely to be accepted?
> 
> Al Viro suggested c) which was to transparently make it a loopback mount of
> the raw device and let a loopback layer do the work.

... which is basically the same thing, in that we need to support writes
< hardware block size to devices. This is never going to be an efficient
mechanism, the read gathering required for a 512b write on a 2048b media
is scary. Think cd-rw 64kB blocksize for write. Ugh.

-- 
Jens Axboe

