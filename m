Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262057AbUJYRAD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262057AbUJYRAD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 13:00:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262053AbUJYQ7e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 12:59:34 -0400
Received: from math.ut.ee ([193.40.5.125]:39561 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S262072AbUJYQzz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 12:55:55 -0400
Date: Mon, 25 Oct 2004 19:55:42 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: Jens Axboe <axboe@suse.de>
cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: readcd hangs in blk_execute_rq
In-Reply-To: <20041021201532.GG32465@suse.de>
Message-ID: <Pine.GSO.4.44.0410251951340.20253-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Turned DMA off with hdparm -d 0 /dev/hdc, still the same.
> > Turned ATAPI DMA support off completely (activated "Use DMA only for
> > disks" compile option), still the same half-hang.
>
> Can I talk you into trying to find out when this broke? You mention
> 2.4.18 as working, did 2.4.19 break? Narrowing this down as much as
> possible would be very helpful.

OK, did some testing.

2.4.18, 2.4.19 and 2.4.20 are the same - mostly working. This means that
it reads non-broken data CD-s with DMA with no problems, but it loses an
interrupt and disables DMA with a faulty data CD (dmesg below).

The IDE changes in 2.4.21-pre1 cause DMA to fail at first read attempt
and all later kernels behave the same.

The dmesg from 2.4.18 in case of CD read error (with a known faulty cd):

hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x54
end_request: I/O error, dev 16:00 (hdc), sector 1274020
ide_dmaproc: chipset supported ide_dma_lostirq func only: 13
hdc: lost interrupt
hdc: status timeout: status=0xd0 { Busy }
hdc: DMA disabled
hdc: drive not ready for command
hdc: ATAPI reset complete


-- 
Meelis Roos (mroos@linux.ee)

