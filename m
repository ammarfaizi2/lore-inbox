Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265058AbSLIKrG>; Mon, 9 Dec 2002 05:47:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265099AbSLIKrG>; Mon, 9 Dec 2002 05:47:06 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:23081
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S265058AbSLIKrF>; Mon, 9 Dec 2002 05:47:05 -0500
Date: Mon, 9 Dec 2002 05:57:40 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
cc: Kernel mailing list <linux-kernel@vger.kernel.org>,
       Jens Axboe <axboe@suse.de>
Subject: Re: BUG in 2.5.50
In-Reply-To: <200212091056.08860.roy@karlsbakk.net>
Message-ID: <Pine.LNX.4.50.0212090508390.2139-100000@montezuma.mastecende.com>
References: <200212091056.08860.roy@karlsbakk.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Added Jens to CC to verify any incorrect information i may or may not put
down.

On Mon, 9 Dec 2002, Roy Sigurd Karlsbakk wrote:

> installed 2.5.50 and got an OOPS after a short while. .
> config is attached as tonjeconfig
> /var/log/messages including dmesg and oops is attached as tonje_messages

Perhaps this might help with debugging;

He has CONFIG_BLK_DEV_IDE_TCQ enabled and his IBM supports it,

when he gets to do_rw_disk();

We know its a READ request
	if (rq_data_dir(rq) == READ) {
		if (blk_rq_tagged(rq))
			return hwif->ide_dma_queued_read(drive);

... the request isn't tagged so we drop down here...

		if (drive->using_dma && !hwif->ide_dma_read(drive))
			return ide_started;

int __ide_dma_read (ide_drive_t *drive)
...
	if (HWGROUP(drive)->handler != NULL)
		BUG();

and ->handler = ?

Is this reproducible? If so without CONFIG_PREEMPT?

Cheers,
	Zwane
-- 
function.linuxpower.ca
