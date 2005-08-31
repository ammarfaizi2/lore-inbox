Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932422AbVHaH0t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932422AbVHaH0t (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 03:26:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932421AbVHaH0t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 03:26:49 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:28853 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932419AbVHaH0s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 03:26:48 -0400
Date: Wed, 31 Aug 2005 09:26:45 +0200
From: Jens Axboe <axboe@suse.de>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Holger Kiehl <Holger.Kiehl@dwd.de>,
       linux-raid <linux-raid@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Where is the performance bottleneck?
Message-ID: <20050831072644.GF4018@suse.de>
References: <Pine.LNX.4.61.0508291811480.24072@diagnostix.dwd.de> <20050829202529.GA32214@midnight.suse.cz> <Pine.LNX.4.61.0508301919250.25574@diagnostix.dwd.de> <20050831071126.GA7502@midnight.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050831071126.GA7502@midnight.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31 2005, Vojtech Pavlik wrote:
> On Tue, Aug 30, 2005 at 08:06:21PM +0000, Holger Kiehl wrote:
> > >>How does one determine the PCI-X bus speed?
> > >
> > >Usually only the card (in your case the Symbios SCSI controller) can
> > >tell. If it does, it'll be most likely in 'dmesg'.
> > >
> > There is nothing in dmesg:
> > 
> >    Fusion MPT base driver 3.01.20
> >    Copyright (c) 1999-2004 LSI Logic Corporation
> >    ACPI: PCI Interrupt 0000:02:04.0[A] -> GSI 24 (level, low) -> IRQ 217
> >    mptbase: Initiating ioc0 bringup
> >    ioc0: 53C1030: Capabilities={Initiator,Target}
> >    ACPI: PCI Interrupt 0000:02:04.1[B] -> GSI 25 (level, low) -> IRQ 225
> >    mptbase: Initiating ioc1 bringup
> >    ioc1: 53C1030: Capabilities={Initiator,Target}
> >    Fusion MPT SCSI Host driver 3.01.20
> > 
> > >To find where the bottleneck is, I'd suggest trying without the
> > >filesystem at all, and just filling a large part of the block device
> > >using the 'dd' command.
> > >
> > >Also, trying without the RAID, and just running 4 (and 8) concurrent
> > >dd's to the separate drives could show whether it's the RAID that's
> > >slowing things down.
> > >
> > Ok, I did run the following dd command in different combinations:
> > 
> >    dd if=/dev/zero of=/dev/sd?1 bs=4k count=5000000
> 
> I think a bs of 4k is way too small and will cause huge CPU overhead.
> Can you try with something like 4M? Also, you can use /dev/full to avoid
> the pre-zeroing.

That was my initial thought as well, but since he's writing the io side
should look correct. I doubt 8 dd's writing 4k chunks will gobble that
much CPU as to make this much difference.

Holger, we need vmstat 1 info while the dd's are running. A simple
profile would be nice as well, boot with profile=2 and do a readprofile
-r; run tests; readprofile > foo and send the first 50 lines of foo to
this list.

-- 
Jens Axboe

