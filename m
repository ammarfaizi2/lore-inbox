Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262345AbUC1Syq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 13:54:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262356AbUC1Syq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 13:54:46 -0500
Received: from ns.suse.de ([195.135.220.2]:50410 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262345AbUC1Syn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 13:54:43 -0500
Date: Sun, 28 Mar 2004 20:54:41 +0200
From: Olaf Hering <olh@suse.de>
To: Jens Axboe <axboe@suse.de>, Stephen Rothwell <sfr@au1.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc2-mm4
Message-ID: <20040328185441.GA30602@suse.de>
References: <20040326131816.33952d92.akpm@osdl.org> <20040326132212.14bac327.akpm@osdl.org> <20040326214007.A10869@infradead.org> <20040326140027.044c96a3.akpm@osdl.org> <20040327175412.GB3175@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040327175412.GB3175@suse.de>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Sat, Mar 27, Jens Axboe wrote:

> On Fri, Mar 26 2004, Andrew Morton wrote:
> > > > 
> > > >  Suppress cdroms in /proc/partitions
> > > 
> > > What's this patch trying to archive?  IDE cdroms are partitionable in
> > > 2.5..
> 
> I'm not trying to kill partioning (which doesn't exist, btw), it's just
> an artifact of flagging the gendisk removable that they don't show up in
> /proc/partitions

you need this one as well:


--- ./drivers/cdrom/viocd.c~	2004-03-28 18:36:16.000000000 +0000
+++ ./drivers/cdrom/viocd.c	2004-03-28 18:44:19.000000000 +0000
@@ -615,7 +615,7 @@ static int __init viocd_init(void)
 				VIOCD_DEVICE_DEVFS "%d", deviceno);
 		gendisk->queue = viocd_queue;
 		gendisk->fops = &viocd_fops;
-		gendisk->flags = GENHD_FL_CD;
+		gendisk->flags = GENHD_FL_CD|GENHD_FL_REMOVABLE;
 		set_capacity(gendisk, 0);
 		gendisk->private_data = d;
 		d->viocd_disk = gendisk;

-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
