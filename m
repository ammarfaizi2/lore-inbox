Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263921AbUDOOAq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 10:00:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263897AbUDOOAq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 10:00:46 -0400
Received: from tench.street-vision.com ([212.18.235.100]:37303 "EHLO
	tench.street-vision.com") by vger.kernel.org with ESMTP
	id S264080AbUDOOAk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 10:00:40 -0400
Subject: Re: poor sata performance on 2.6
From: Justin Cormack <justin@street-vision.com>
To: Konstantin Sobolev <kos@supportwizard.com>
Cc: Ryan Geoffrey Bourgeois <rgb005@latech.edu>,
       Kernel mailing list <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org
In-Reply-To: <200404151734.03786.kos@supportwizard.com>
References: <200404150236.05894.kos@supportwizard.com>
	 <200404151455.36307.kos@supportwizard.com>
	 <1082030525.14389.70.camel@lotte.street-vision.com>
	 <200404151734.03786.kos@supportwizard.com>
Content-Type: text/plain
Message-Id: <1082037632.19567.72.camel@lotte.street-vision.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 15 Apr 2004 15:00:32 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hmm, odd. I get 50MB/s or so from normal (7200, 8MB cache) WD disks, and
Seagate from the same controller. Can you send lspci, /proc/interrupts
and dmesg...

Justin


On Thu, 2004-04-15 at 14:34, Konstantin Sobolev wrote:
> On Thursday 15 April 2004 16:02, Justin Cormack wrote:
> > Ah I see from your config you have himem_4G turned on. How much memory
> > do you have? Sii3112 appears (I dont actually have datasheets) to only
> > have 32 bit DMA support, and will use bounce buffers quite a lot of the
> > time if you turn on himem at all, reducing throughput substantially. Try
> > again with no himem support at all and see if it helps.
> 
> I have 1.5 GB. I tried to disable highmem, now less than 1GB is visible, but 
> there is no noticable difference in SATA performance:
> 
> siimage:
> /dev/hde:
>  setting fs readahead to 8129
>  setting 32-bit IO_support flag to 1
>  setting multcount to 16
>  multcount    = 16 (on)
>  IO_support   =  1 (32-bit)
>  unmaskirq    =  0 (off)
>  using_dma    =  1 (on)
>  keepsettings =  0 (off)
>  readonly     =  0 (off)
>  readahead    = 8128 (on)
>  geometry     = 16383/255/63, sectors = 145226112, start = 0
>  Timing buffer-cache reads:   1428 MB in  2.00 seconds = 713.75 MB/sec
>  Timing buffered disk reads:  100 MB in  3.03 seconds =  32.99 MB/sec
> 
> libata
> /dev/sda:
>  setting fs readahead to 8192
>  readahead    = 8192 (on)
>  Timing buffered disk reads:   82 MB in  3.02 seconds =  27.17 MB/sec

