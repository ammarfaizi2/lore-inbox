Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265200AbUFDPPl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265200AbUFDPPl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 11:15:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265730AbUFDPPl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 11:15:41 -0400
Received: from [202.125.86.130] ([202.125.86.130]:7379 "EHLO
	ns2.astrainfonets.net") by vger.kernel.org with ESMTP
	id S265200AbUFDPPh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 11:15:37 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: removable media support on 2.6.x
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Date: Fri, 4 Jun 2004 20:41:53 +0530
Message-ID: <1118873EE1755348B4812EA29C55A9722AF016@esnmail.esntechnologies.co.in>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: removable media support on 2.6.x
Thread-index: AcRKRkS63KTDfQLvSBi8hsnyeIJhWQ==
From: "Jinu M." <jinum@esntechnologies.co.in>
To: <linux-kernel@vger.kernel.org>
Cc: <kernelnewbies@nl.linux.org>,
       "Surendra I." <surendrai@esntechnologies.co.in>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

We are developing a storage driver (block driver) on 2.6.x kernel. The 
hardware we are using supports media removal on the fly. We are facing
some problem when the media is removed while the disk is mounted. The
system freezes and the module count never goes to zero.

This is what we do when the disk is removed on the fly.

disk_removed(...)
{
	/* invalidate disk */
	if(gDisk->bdev) {
		invalidate_bdev(gDisk->bdev, 1);
		bdput(gDisk->bdev);
	}

	/* indicates that no disk present */
	set_capacity(gDisk->gd, 0);

	/* cleanup gendisk */
	del_gendisk(gDisk->gd);
	put_disk(gDisk->gd);

	/* clean up blkqueue */
	blk_cleanup_queue(gDisk->blkqueue);
}

disk_removed() is called from the workqueue that is initiated from the
tasklet()<=isr() on card removal.

We guess invalidate_bdev() is the culprit ;) but would like to know
from you all if we are doing some mistake. Is there something missing
or something wrong in the way we are trying to provide removable media
support?

Thanks in advance,

-Jinu
