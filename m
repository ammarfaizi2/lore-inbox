Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270810AbTGPNZa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 09:25:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270813AbTGPNZa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 09:25:30 -0400
Received: from covert.brown-ring.iadfw.net ([209.196.123.142]:26116 "EHLO
	covert.brown-ring.iadfw.net") by vger.kernel.org with ESMTP
	id S270810AbTGPNZ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 09:25:29 -0400
Date: Wed, 16 Jul 2003 08:40:12 -0500
From: Art Haas <ahaas@airmail.net>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Trying to get DMA working with IDE alim15x3 controller
Message-ID: <20030716134012.GA1161@artsapartment.org>
References: <20030715233202.GB17444@artsapartment.org> <Pine.SOL.4.30.0307160212040.27735-100000@mion.elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.SOL.4.30.0307160212040.27735-100000@mion.elka.pw.edu.pl>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 16, 2003 at 02:20:36AM +0200, Bartlomiej Zolnierkiewicz wrote:
> 
> > I've been using the 2.5 series for a long time now, but I have vague
> > memories of not needing to use 'ide=nodma' before this patch was added:
> 
> I don't think so, but you can safely revert this chunk and check.
> 
> > ===== setup-pci.c 1.5 vs 1.6 =====
> > --- 1.5/drivers/ide/setup-pci.c	Sat Sep 21 07:59:59 2002
> > +++ 1.6/drivers/ide/setup-pci.c	Tue Sep 24 09:24:57 2002
> > @@ -250,6 +250,7 @@
> >
> >  		switch(dev->device) {
> >  			case PCI_DEVICE_ID_AL_M5219:
> > +			case PCI_DEVICE_ID_AL_M5229:
> >  			case PCI_DEVICE_ID_AMD_VIPER_7409:
> >  			case PCI_DEVICE_ID_CMD_643:
> >  			case PCI_DEVICE_ID_SERVERWORKS_CSB5IDE:
> >

I built a new kernel with this line commented out and booted up this new
kernel. Sadly the problem remained. Trying this kernel with the
'ide0=autotune' was also unsuccessful. For the curious, the kernel gets
to the point where the drive partitions are examined and then things go
splat. A sample of the messages ...

hda: dma_timer_expiry: dma_status == 0x20
hda: (__ide_dma_test_irq) called while not waiting
hda: drive not ready for command
hda: lost interrupt

Things limp along as the partitions on the hda drive are gradually
printed out, but there is one change in the kernel messages

hda: dma_timer_expiry: dma_status == 0x21

I'll try modifing the ali15x3 driver with the patch you sent and see how
that goes.

Art Haas
-- 
Man once surrendering his reason, has no remaining guard against absurdities
the most monstrous, and like a ship without rudder, is the sport of every wind.

-Thomas Jefferson to James Smith, 1822
