Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262470AbUDOMCc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 08:02:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262882AbUDOMC1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 08:02:27 -0400
Received: from tench.street-vision.com ([212.18.235.100]:24247 "EHLO
	tench.street-vision.com") by vger.kernel.org with ESMTP
	id S262470AbUDOMCR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 08:02:17 -0400
Subject: Re: poor sata performance on 2.6
From: Justin Cormack <justin@street-vision.com>
To: kos@supportwizard.com
Cc: Ryan Geoffrey Bourgeois <rgb005@latech.edu>,
       Kernel mailing list <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org
In-Reply-To: <200404151455.36307.kos@supportwizard.com>
References: <200404150236.05894.kos@supportwizard.com>
	 <1082001287.407e0787f3c48@webmail.LaTech.edu>
	 <200404151455.36307.kos@supportwizard.com>
Content-Type: text/plain
Message-Id: <1082030525.14389.70.camel@lotte.street-vision.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 15 Apr 2004 13:02:05 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ah I see from your config you have himem_4G turned on. How much memory
do you have? Sii3112 appears (I dont actually have datasheets) to only
have 32 bit DMA support, and will use bounce buffers quite a lot of the
time if you turn on himem at all, reducing throughput substantially. Try
again with no himem support at all and see if it helps.

Justin



On Thu, 2004-04-15 at 11:55, Konstantin Sobolev wrote:
> On Thursday 15 April 2004 07:54, Ryan Geoffrey Bourgeois wrote:
> > > /dev/hde:
> > >  Timing buffer-cache reads:   1436 MB in  2.00 seconds = 717.03 MB/sec
> > >  Timing buffered disk reads:  100 MB in  3.03 seconds =  32.95 MB/sec
> > >
> > > for sata_sil:
> > >
> > > /dev/sda:
> > >  Timing buffer-cache reads:   1412 MB in  2.00 seconds = 705.05 MB/sec
> > >  Timing buffered disk reads:   84 MB in  3.06 seconds =  27.43 MB/sec
> > >
> > > So my old IDE HDD appears to be considerably faster. Expected results
> > > were 55-70MB/s.
> >
> > Which kernel version did you get these results using?  Have you
> 
> Results are the same on different kernels, I tried 2.6.4-ck1 and -ck2,
> 2.6.4-wolk2.3, 2.6.5 vanilla and 2.6.5-mm5
> 
> > speed-tested the drive(s) on a different SATA controller?  I don't mean to
> 
> Not yet, but I'm going to test it on Intel ICH5 soon.
> 
> > imply that you should buy another one - that would be rediculuous since
> > your motherboard should laready has it - but it would help to eliminate
> > possible causes of error.  I took the same readings on my machine.  I'm
> 
> I'm almost ready to buy separate controller, but all that I could find nearby 
> are based on the same Silicon Image chipset
> 
> > using an ASUS SK8N motherboard - that's the Promise TX2 SATA controller -
> > with Western Digital's 36gb 10K RPM Raptor:
> >
> > /dev/sda:
> >  Timing buffer-cache reads:   128 MB in  0.12 seconds =1075.79 MB/sec
> >  Timing buffered disk reads:  64 MB in  1.20 seconds = 53.43 MB/sec
> >
> > I'm using the latest stable vanilla kernel (2.6.5), compiled today.  It
> > would also help to have your kernel config, if at all possible.
> 
> Sure. Attached is .config for 2.6.5-mm5
> Thanks

