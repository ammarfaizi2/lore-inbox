Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264044AbTE3XHn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 19:07:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264045AbTE3XHn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 19:07:43 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:7070 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S264044AbTE3XHk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 19:07:40 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Jeffrey Baker <jwbaker@acm.org>
Date: Sat, 31 May 2003 01:20:45 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: Different geometry settings for identical drives
Cc: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <306584240A9@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 30 May 03 at 15:46, Jeffrey Baker wrote:

> hda: host protected area => 1
> hda: setmax LBA 234441648, native  234375000
> hda: 234375000 sectors (120000 MB) w/8192KiB Cache, CHS=232514/16/63, UDMA(100)
> hdc: attached ide-disk driver.
> hdc: host protected area => 1
> hdc: setmax LBA 234441648, native  234375000
> hdc: 234375000 sectors (120000 MB) w/8192KiB Cache, CHS=232514/16/63, UDMA(100)
> hdd: attached ide-cdrom driver.
> hdd: ATAPI 24X CD-ROM drive, 128kB Cache, UDMA(33)
> 
> The result is that hda works fine but hdc doesn't.  When I try to mke2fs
> on the latter I see:
> 
> hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hdc: dma_intr: error=0x10 { SectorIdNotFound }, LBAsect=234441583, sector=232343808
> 
> You can see that LBAsect (234441583) is higher than the "native" sectors
> quoted by the kernel (234375000, difference 66583 sectors).  Why are
> these two disks being addressed differently?  

As far as I can tell, it has nothing to do with disk geometry.

Someone just cut couple of sectors at the end from disk, you compiled
your kernel without CONFIG_IDEDISK_STROKE, but still kernel for some
reason reports block size as if idedisk_set_max_address() was invoked.

I do not see how this could happen with 2.4.21-rc3... Can you recheck
that you are using 2.4.21-rc3 without any additional patches?
                                            Petr Vandrovec
                                            vandrove@vc.cvut.cz
                                            

