Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268200AbUIAWKE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268200AbUIAWKE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 18:10:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268095AbUIAWCP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 18:02:15 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:42512 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S268196AbUIAVzR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 17:55:17 -0400
Date: Wed, 1 Sep 2004 22:55:03 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Pierre Ossman <drzeus-list@drzeus.cx>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: MMC block major dev
Message-ID: <20040901225503.A26520@flint.arm.linux.org.uk>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Pierre Ossman <drzeus-list@drzeus.cx>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <4134CDF0.7070600@drzeus.cx> <20040831201556.B11053@flint.arm.linux.org.uk> <4134D5EF.9080903@drzeus.cx> <1094040990.2399.56.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1094040990.2399.56.camel@localhost.localdomain>; from alan@lxorguk.ukuu.org.uk on Wed, Sep 01, 2004 at 01:16:30PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01, 2004 at 01:16:30PM +0100, Alan Cox wrote:
> On Maw, 2004-08-31 at 20:47, Pierre Ossman wrote:
> > >Registering with the block layer with a major number of zero means
> > >"find me a free major number and assign that to me."  This is nothing
> > >new.  If devfs can't cope with that, devfs is buggy.  Use udev instead.
> 
> Registering with an ID of 0 is bad because you've no idea what existing
> device node you may reallocate and thus what permissions may be present
> for access unless you sweep all of storage.

Surely the same arguments also apply to character drivers as well?

>From what you're saying, any use of these dynamic majors what so
ever is buggy.  So WTF do we have this facility in the kernel in
the first place?

What about dynamically assigning physical serial ports to ttyS
numbers?  I suggest that your argument also applies there as well.
Also to SCSI disks, where if you load SCSI driver modules in a
differnet order your disks all move about.  It's all the same
problem.


I suggest that someone submits a patch to rip out this apparantly
buggy and useless feature, or at least make the kernel print a
warning when its used such that people are aware of its dangerous
nature.

Of course, if you do rip out dynamic majors then you _will_ need
to have an assigned major number for PCMCIA driver services, and
probably a bunch of other stuff.

I also seem to remember hearing that we will only be using dynamically
assigned device numbers in the new expanded device space.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
