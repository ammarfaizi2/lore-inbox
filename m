Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270940AbSISKD4>; Thu, 19 Sep 2002 06:03:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270964AbSISKD4>; Thu, 19 Sep 2002 06:03:56 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:22237 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S270940AbSISKD4>;
	Thu, 19 Sep 2002 06:03:56 -0400
Date: Thu, 19 Sep 2002 12:08:31 +0200
From: Jens Axboe <axboe@suse.de>
To: Anton Altaparmakov <aia21@cantab.net>
Cc: Andre Hedrick <andre@linux-ide.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: ide double init? + Re: BUG: Current 2.5-BK tree dies on boot!
Message-ID: <20020919100831.GC31033@suse.de>
References: <E17rlgP-0006wL-00@storm.christs.cam.ac.uk> <E17rlgP-0006wL-00@storm.christs.cam.ac.uk> <5.1.0.14.2.20020919102432.0438bec0@pop.cus.cam.ac.uk> <20020919094520.GB31033@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020919094520.GB31033@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 19 2002, Jens Axboe wrote:
> > Note there is something odd wrt IDE initialization. The driver seems to be 
> > trying to initialize twice and there quite a few messages output which 
> > don't reflect reality (probably a consequence of the double init). For 
> > example it says DMA disabled but checking with hdparm and in /proc/ide/via 
> > DMA is enabled just fine. And it says neither IDE port enabled (BIOS) which 
> > isn't true either.
> 
> Yes you are right, it does seem to try and init twice. Wonder why. I'll
> take a look at that.

Seems to be ide probe calling the pci probe functions, and then they get
called by the pci layer later when they register. Dunno what the best
way to handle this is. Alan quotes ordering constraints as the reason.
Then maybe the easiest fix is to just do

chipset_init(bla)
{
	if (chipset already setup)
		return;

	do_init();
}

Alan?

-- 
Jens Axboe

