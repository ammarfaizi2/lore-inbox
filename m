Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283571AbRK3Ixo>; Fri, 30 Nov 2001 03:53:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283568AbRK3Ixe>; Fri, 30 Nov 2001 03:53:34 -0500
Received: from h55p103-2.delphi.afb.lu.se ([130.235.187.175]:29663 "EHLO gin")
	by vger.kernel.org with ESMTP id <S283571AbRK3IxW>;
	Fri, 30 Nov 2001 03:53:22 -0500
Date: Fri, 30 Nov 2001 09:53:14 +0100
To: Jens Axboe <axboe@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>, rwhron@earthlink.net
Subject: Re: 2.5.1-pre3 FIXED (was Re: 2.5.1-pre3 DON'T USE)
Message-ID: <20011130095314.D21256@h55p111.delphi.afb.lu.se>
In-Reply-To: <20011129091554.E5788@suse.de> <20011129121431.D10601@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011129121431.D10601@suse.de>
User-Agent: Mutt/1.3.23i
From: andersg@0x63.nu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2001 at 12:14:31PM +0100, Jens Axboe wrote:
> On Thu, Nov 29 2001, Jens Axboe wrote:
> > Hi,
> > 
> > Please don't use this kernel unless you can afford to loose your data.
> > I'm looking at the problem right now.
> 
> Ok the problem was only on highmem machines, the copying of data was
> just wrong. The attached patch fixes that and a few other buglets, such
> as:
> 
> - BIO_HASH remnant in LVM

shouldn't line 1046 in lvm.c be:
  bio.bi_io_vec[0].bv_len = lvm_get_blksize(bio.bi_dev);

with this patch it atleast compiles..

--- linux-2.5.1-pre4-vanilj/drivers/md/lvm.c	Fri Nov 30 09:45:31 2001
+++ linux-2.5.1-pre4/drivers/md/lvm.c	Fri Nov 30 09:32:42 2001
@@ -1043,7 +1043,7 @@
 
 	memset(&bio,0,sizeof(bio));
 	bio.bi_dev = inode->i_rdev;
-	bio.bi_io_vec.bv_len = lvm_get_blksize(bio.bi_dev);
+	bio.bi_io_vec[0].bv_len = lvm_get_blksize(bio.bi_dev);
  	bio.bi_sector = block * bio_sectors(&bio);
 	bio.bi_rw = READ;
 	if ((err=lvm_map(&bio)) < 0)  {



-- 

//anders/g

