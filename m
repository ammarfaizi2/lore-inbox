Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262618AbRE0ABZ>; Sat, 26 May 2001 20:01:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262663AbRE0ABQ>; Sat, 26 May 2001 20:01:16 -0400
Received: from zeus.kernel.org ([209.10.41.242]:20146 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S262664AbRE0ABC>;
	Sat, 26 May 2001 20:01:02 -0400
Message-ID: <3B0F7D04.5F567871@yahoo.com>
Date: Sat, 26 May 2001 05:53:08 -0400
From: Paul Gortmaker <p_gortmaker@yahoo.com>
X-Mailer: Mozilla 3.04 (X11; I; Linux 2.4.4 i586)
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Hal Duston <hald@sound.net>, linux-kernel@vger.kernel.org,
        rasmus@jaquet.dk
Subject: Re: PS/2 Esdi patch #8
In-Reply-To: <Pine.GSO.4.10.10105231748550.23376-200000@sound.net> <3B0D733F.1829DC88@yahoo.com> <20010525164615.C14899@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> 
> On Thu, May 24 2001, Paul Gortmaker wrote:
>
> > Probably makes sense for driver to set it regardless, seeing
> > as default (MAX_SECTORS) has changed several times over last
> > few months.  At least then it will be under driver control
> > and not at the mercy of some global value.
> 
> You might want to assign that max_sect array too, otherwise it's just
> going to waste space :-)

Heh, yes. :) 

> Take a look at how ps2esdi handles requests -- always processing just
> the first segment. Alas, it doesn't matter how big the request is.

Well here is the missing line, for completeness, in case somebody
someday gets bored and changes the above behaviour (it won't be me!)

Paul.

--- drivers/block/ps2esdi.c~	Thu May 24 16:33:46 2001
+++ drivers/block/ps2esdi.c	Sat May 26 04:47:45 2001
@@ -424,6 +424,7 @@
 	request_dma(dma_arb_level, "ed");
 	request_region(io_base, 4, "ed");
 	blksize_size[MAJOR_NR] = ps2esdi_blocksizes;
+	max_sectors[MAJOR_NR] = ps2esdi_maxsect;
 
 	for (i = 0; i < ps2esdi_drives; i++) {
 		register_disk(&ps2esdi_gendisk,MKDEV(MAJOR_NR,i<<6),1<<6,




