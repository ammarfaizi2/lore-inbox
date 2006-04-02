Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932272AbWDBLWt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932272AbWDBLWt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 07:22:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932310AbWDBLWt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 07:22:49 -0400
Received: from ns2.suse.de ([195.135.220.15]:51893 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932272AbWDBLWs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 07:22:48 -0400
From: Andi Kleen <ak@suse.de>
To: Joerg Bashir <brak@archive.org>
Subject: Re: PCI-DMA: Out of IOMMU space on x86-64 (Athlon64x2), with solution
Date: Sun, 2 Apr 2006 13:16:50 +0200
User-Agent: KMail/1.9.1
Cc: Robert Hancock <hancockr@shaw.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>, jgarzik@pobox.com,
       mulix@mulix.org
References: <5Mq18-1Na-21@gated-at.bofh.it> <440CD09A.9040005@shaw.ca> <442F827E.8040104@archive.org>
In-Reply-To: <442F827E.8040104@archive.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200604021316.51019.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 02 April 2006 09:51, Joerg Bashir wrote:
> Robert Hancock wrote:
> > Michael Monnerie wrote:
> > 
> >> On Freitag, 3. März 2006 23:23 Jeff Garzik wrote:
> >>
> >>> I'll happen but not soon.  Motivation is low at NV and here as well,
> >>> since newer NV is AHCI.  The code in question, "NV ADMA", is
> >>> essentially legacy at this point -- though I certainly acknowledge
> >>> the large current installed base.  Just being honest about the
> >>> current state of things...
> >>
> >>
> >> I'd like to raise motivation a lot because most MB sold here (central
> >> Europe) are Nforce4 with Athlon64x2 at the moment. It would be nice
> >> from vendors if they support OSS developers more, as it's their
> >> interest to have good drivers.
> > 
> > 
> > I second that.. It appears that nForce4 will continue to be a popular
> > chipset even after the Socket AM2 chips are released, so the demand for
> > this (and for NCQ support as well, likely) will only increase.
> > 
> 
> I'll third it.  Just had another machine blow up it's RAID5 set because
> of this bug.  Tyan S2895 board, 4 500GB Hitachi SATA drives in RAID5.  I
> suppose I could buy a 3ware controller I suppose but that's a few
> hundred dollars per machine.
> 
> These machines are running SUSE 9.3 or SUSE 10, I've tried kernel.org
> kernels as well as the iommu=memaper=3 cmdline option.

You either have an IOMMU leak or very deep block device queues that overflow
the aperture. You can either increase it even more or try to reduce
the block queue lengths using the sysfs knobs (/sys/block/*/queue/)
The maximum memory pinned by all the block queues must be smaller than
the IOMMU aperture minus some slack for other devices.

If it's a leak someone has to debug it. 

Or alternatively someone fixes the driver that can run the NForce4 
controller without 4GB limits. If you still have a leak somewhere that won't 
help of course.

Queue overflow is more likely.

-Andi
