Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261666AbSITIPZ>; Fri, 20 Sep 2002 04:15:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261679AbSITIPZ>; Fri, 20 Sep 2002 04:15:25 -0400
Received: from math.ut.ee ([193.40.5.125]:10944 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id <S261666AbSITIPU>;
	Fri, 20 Sep 2002 04:15:20 -0400
Date: Fri, 20 Sep 2002 11:20:16 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: Andre Hedrick <andre@linux-ide.org>, <linux-kernel@vger.kernel.org>
Subject: Re: PIIX4 IDE still broken in pre7-ac2
In-Reply-To: <Pine.LNX.4.10.10209200014350.25090-100000@master.linux-ide.org>
Message-ID: <Pine.GSO.4.44.0209201116060.20984-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Lemme work with you one on one!

I'm open to suggestions of what to try, patches etc.

I also have some additional information: it didn't actually hang with
2.4.20-pre7-ac2. It recovered after some minutes, just after I had sent
the last message. But the disk (hdd - the problematic mwdma Seagate) was
put offline so the problem persists, it just has a little different
form. The kernel decided that the disk is not accessible, that gave
errors to ext3 and ext3 survived too, giving IO errors and empty
directories to the user (and many errors in the syslog). The disk still
works fine in 2.4.18. dmesg:

hdd: dma_timer_expiry: dma status == 0x61
hda: dma_timer_expiry: dma status == 0x61
hdd: timeout waiting for DMA
hdd: timeout waiting for DMA
hdd: (__ide_dma_test_irq) called while not waiting
hdd: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hdd: drive not ready for command
hdd: status timeout: status=0xd0 { Busy }
hdc: DMA disabled
hdd: drive not ready for command
ide1: reset timed-out, status=0xff
hdd: dma_timer_expiry: dma status == 0x41
hda: dma_timer_expiry: dma status == 0x61
hdd: timeout waiting for DMA
hdd: timeout waiting for DMA
hdd: (__ide_dma_test_irq) called while not waiting
hdd: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hdd: drive not ready for command
hdd: status timeout: status=0xd0 { Busy }
hdd: drive not ready for command
ide1: reset timed-out, status=0xff
end_request: I/O error, dev 16:41 (hdd), sector 277216
end_request: I/O error, dev 16:41 (hdd), sector 277224
end_request: I/O error, dev 16:41 (hdd), sector 277232
end_request: I/O error, dev 16:41 (hdd), sector 277240
end_request: I/O error, dev 16:41 (hdd), sector 277248
end_request: I/O error, dev 16:41 (hdd), sector 277256
end_request: I/O error, dev 16:41 (hdd), sector 277264

and so on, later also ext3 errors as a result.


-- 
Meelis Roos (mroos@linux.ee)

