Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265140AbSLIL2d>; Mon, 9 Dec 2002 06:28:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265143AbSLIL2d>; Mon, 9 Dec 2002 06:28:33 -0500
Received: from 213-187-164-3.dd.nextgentel.com ([213.187.164.3]:7905 "EHLO
	mail.pronto.tv") by vger.kernel.org with ESMTP id <S265140AbSLIL2c> convert rfc822-to-8bit;
	Mon, 9 Dec 2002 06:28:32 -0500
Content-Type: text/plain; charset=US-ASCII
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Organization: ProntoTV AS
To: Zwane Mwaikambo <zwane@holomorphy.com>
Subject: Re: BUG in 2.5.50
Date: Mon, 9 Dec 2002 12:36:06 +0100
User-Agent: KMail/1.4.1
Cc: Kernel mailing list <linux-kernel@vger.kernel.org>,
       Jens Axboe <axboe@suse.de>
References: <200212091056.08860.roy@karlsbakk.net> <Pine.LNX.4.50.0212090508390.2139-100000@montezuma.mastecende.com>
In-Reply-To: <Pine.LNX.4.50.0212090508390.2139-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212091236.06966.roy@karlsbakk.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
>
> Is this reproducible? If so without CONFIG_PREEMPT?

I found it easily reproducable - I just did the same old 'make 
modules_install' from the kernel dir, and BUG. Witout CONFIG_PREEMPT, 
however, I was not, and I tried to stress it quite a bit

roy
-- 
Roy Sigurd Karlsbakk, Datavaktmester
ProntoTV AS - http://www.pronto.tv/
Tel: +47 9801 3356

Computers are like air conditioners.
They stop working when you open Windows.

