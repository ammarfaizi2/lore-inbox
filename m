Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261705AbTDKUSY (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 16:18:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261710AbTDKUSX (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 16:18:23 -0400
Received: from mail.mediaways.net ([193.189.224.113]:52127 "HELO
	mail.mediaways.net") by vger.kernel.org with SMTP id S261705AbTDKUST (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 16:18:19 -0400
Subject: Re: 2.4.21pre6 (__ide_dma_test_irq) called while not waiting
From: Soeren Sonnenburg <kernel@nn7.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1049885242.9897.7.camel@dhcp22.swansea.linux.org.uk>
References: <1049879881.2774.40.camel@fortknox>
	 <1049885242.9897.7.camel@dhcp22.swansea.linux.org.uk>
Content-Type: text/plain
Organization: 
Message-Id: <1050092626.2333.109.camel@fortknox>
Mime-Version: 1.0
Date: 11 Apr 2003 22:23:47 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-04-09 at 12:47, Alan Cox wrote:
> On Mer, 2003-04-09 at 10:18, Soeren Sonnenburg wrote:
> > hdi: 4 bytes in FIFO
> > hdi: timeout waiting for DMA
> > hdi: (__ide_dma_test_irq) called while not waiting
> > hdi: dma_intr: status=0x58 { DriveReady SeekComplete DataRequest }
> > 
> > hdk: dma_intr: status=0x58 { DriveReady SeekComplete DataRequest }
> 
> This looks like a shared IRQ occurred while a command was being
> sent. The IDE layer apparently tested for the IRQ before it 
> was ready to do so as part of finding out what is going on. The
> -ac tree (and pre7) may possibly have fixed it with the command
> delay stuff that Ross Biro figured out

Ok, I copied 2*25GB over the network trying all sorts of things to make
the compu crash. I was not successful :-)

However a hdparm -S0 -d1 -Xudma5 -c 1 -u 1 -m 16 /dev/hde was enough to
get that message again which I could not simple reproduce by just
copying things over the network. So it seems the actual bug was fixed in
pre7 but hdparm tweaking seems to need another fix to be safe...

Thanks,
Soeren.

