Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263301AbTEMHON (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 03:14:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263303AbTEMHON
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 03:14:13 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:59054 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263301AbTEMHOK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 03:14:10 -0400
Date: Tue, 13 May 2003 12:48:07 +0530
From: Bharata B Rao <bharata@in.ibm.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Adrian Bunk <bunk@fs.tum.de>, linux-kernel <linux-kernel@vger.kernel.org>,
       Suparna Bhattacharya <suparna@in.ibm.com>
Subject: Re: 2.5.69-mjb1: undefined reference to `blk_queue_empty'
Message-ID: <20030513124807.A31823@in.ibm.com>
Reply-To: bharata@in.ibm.com
References: <9380000.1052624649@[10.10.2.4]> <20030512205139.GT1107@fs.tum.de> <20570000.1052797864@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20570000.1052797864@[10.10.2.4]>; from mbligh@aracnet.com on Mon, May 12, 2003 at 08:51:05PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 12, 2003 at 08:51:05PM -0700, Martin J. Bligh wrote:
> 
> --Adrian Bunk <bunk@fs.tum.de> wrote (on Monday, May 12, 2003 22:51:40 +0200):
> 
> > <--  snip  -->
> > 
> > ...
> >   gcc -Wp,-MD,drivers/dump/.dump_blockdev.o.d -D__KERNEL__ -Iinclude 
> > -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe 
> > -mpreferred-stack-boundary=2 -march=k6 -Iinclude/asm-i386/mach-default 
> > -fomit-frame-pointer -nostdinc -iwithprefix include    -DKBUILD_BASENAME=dump_blockdev 
> > \-DKBUILD_MODNAME=dump_blockdev -c -o drivers/dump/dump_blockdev.o 
> > drivers/dump/dump_blockdev.c
> > drivers/dump/dump_blockdev.c: In function `dump_block_silence':
> > drivers/dump/dump_blockdev.c:264: warning: implicit declaration of function `blk_queue_empty'
> > ...
> > 386/oprofile/built-in.o  net/built-in.o --end-group  -o .tmp_vmlinux1
> > drivers/built-in.o(.text+0x77edaf): In function `dump_block_silence':
> > : undefined reference to `blk_queue_empty'
> > ...
> > make: *** [.tmp_vmlinux1] Error 1
> > 
> > <--  snip  -->
> > 
> > This is the only occurence of blk_queue_empty in the whole kernel tree.
> 
> Thanks Adrian ... this is LKCD stuff, maybe Suparna / Bharata can fix it?
> Looks like it disappeared in 2.5.67 or so.
> 

Martin,

I have already sent you a fix for this. Anyway here it is again.

--- linux-2.5.69/drivers/dump/dump_blockdev.c.orig	Tue May 13 12:30:49 2003
+++ linux-2.5.69/drivers/dump/dump_blockdev.c	Tue May 13 12:34:09 2003
@@ -261,7 +261,7 @@
 
 	/* For now we assume we have the device to ourselves */
 	/* Just a quick sanity check */
-	if (!blk_queue_empty(bdev_get_queue(dump_bdev->bdev))) {
+	if (elv_next_request(bdev_get_queue(dump_bdev->bdev))) {
 		/* i/o in flight - safer to quit */
 		return -EBUSY;
 	}

Regards,
Bharata.
