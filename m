Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267091AbSLKJgX>; Wed, 11 Dec 2002 04:36:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267094AbSLKJgX>; Wed, 11 Dec 2002 04:36:23 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:33990 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S267091AbSLKJgW>;
	Wed, 11 Dec 2002 04:36:22 -0500
Date: Wed, 11 Dec 2002 10:43:45 +0100
From: Jens Axboe <axboe@suse.de>
To: Zwane Mwaikambo <zwane@holomorphy.com>
Cc: Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
       Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: BUG in 2.5.50
Message-ID: <20021211094345.GS16003@suse.de>
References: <200212091056.08860.roy@karlsbakk.net> <Pine.LNX.4.50.0212090508390.2139-100000@montezuma.mastecende.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0212090508390.2139-100000@montezuma.mastecende.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 09 2002, Zwane Mwaikambo wrote:
> Added Jens to CC to verify any incorrect information i may or may not put
> down.
> 
> On Mon, 9 Dec 2002, Roy Sigurd Karlsbakk wrote:
> 
> > installed 2.5.50 and got an OOPS after a short while. .
> > config is attached as tonjeconfig
> > /var/log/messages including dmesg and oops is attached as tonje_messages
> 
> Perhaps this might help with debugging;
> 
> He has CONFIG_BLK_DEV_IDE_TCQ enabled and his IBM supports it,
> 
> when he gets to do_rw_disk();
> 
> We know its a READ request
> 	if (rq_data_dir(rq) == READ) {
> 		if (blk_rq_tagged(rq))
> 			return hwif->ide_dma_queued_read(drive);
> 
> ... the request isn't tagged so we drop down here...
> 
> 		if (drive->using_dma && !hwif->ide_dma_read(drive))
> 			return ide_started;
> 
> int __ide_dma_read (ide_drive_t *drive)
> ...
> 	if (HWGROUP(drive)->handler != NULL)
> 		BUG();
> 
> and ->handler = ?

If tcq is enabled on the drive, rq _must_ be tagged.

-- 
Jens Axboe

