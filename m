Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262072AbUJYRAA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262072AbUJYRAA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 13:00:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262066AbUJYQ6z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 12:58:55 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:19869 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262083AbUJYQ6b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 12:58:31 -0400
Date: Mon, 25 Oct 2004 18:58:01 +0200
From: Jens Axboe <axboe@suse.de>
To: Meelis Roos <mroos@linux.ee>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: readcd hangs in blk_execute_rq
Message-ID: <20041025165801.GX8306@suse.de>
References: <20041021201532.GG32465@suse.de> <Pine.GSO.4.44.0410251951340.20253-100000@math.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.44.0410251951340.20253-100000@math.ut.ee>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25 2004, Meelis Roos wrote:
> > > Turned DMA off with hdparm -d 0 /dev/hdc, still the same.
> > > Turned ATAPI DMA support off completely (activated "Use DMA only for
> > > disks" compile option), still the same half-hang.
> >
> > Can I talk you into trying to find out when this broke? You mention
> > 2.4.18 as working, did 2.4.19 break? Narrowing this down as much as
> > possible would be very helpful.
> 
> OK, did some testing.
> 
> 2.4.18, 2.4.19 and 2.4.20 are the same - mostly working. This means that
> it reads non-broken data CD-s with DMA with no problems, but it loses an
> interrupt and disables DMA with a faulty data CD (dmesg below).
> 
> The IDE changes in 2.4.21-pre1 cause DMA to fail at first read attempt
> and all later kernels behave the same.
> 
> The dmesg from 2.4.18 in case of CD read error (with a known faulty cd):
> 
> hdc: command error: status=0x51 { DriveReady SeekComplete Error }
> hdc: command error: error=0x54
> end_request: I/O error, dev 16:00 (hdc), sector 1274020
> ide_dmaproc: chipset supported ide_dma_lostirq func only: 13
> hdc: lost interrupt
> hdc: status timeout: status=0xd0 { Busy }
> hdc: DMA disabled
> hdc: drive not ready for command
> hdc: ATAPI reset complete

Alan, any ideas? IIRC, the 2.4.21-pre1 huge ide update is all your
doing.

-- 
Jens Axboe

