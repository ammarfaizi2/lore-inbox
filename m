Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265492AbUGaRBN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265492AbUGaRBN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 13:01:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266011AbUGaRBN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 13:01:13 -0400
Received: from mail1.kontent.de ([81.88.34.36]:39053 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S265492AbUGaRBK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 13:01:10 -0400
From: Oliver Neukum <oliver@neukum.org>
To: David Brownell <david-b@pacbell.net>
Subject: Re: Solving suspend-level confusion
Date: Sat, 31 Jul 2004 19:01:16 +0200
User-Agent: KMail/1.6.2
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Pavel Machek <pavel@suse.cz>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
References: <20040730164413.GB4672@elf.ucw.cz> <1091252962.7387.14.camel@gaston> <200407310723.12137.david-b@pacbell.net>
In-Reply-To: <200407310723.12137.david-b@pacbell.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200407311901.17390.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Disks in general are an example (IDE beeing the one that is currently
> > implemented, but we'll probably have to do the same for SATA and SCSI
> > at one point), you want to spin them off (with proper cache flush
> > etc...) when suspending to RAM, while you don't when suspending to
> > disk, as you really don't want them to be spun up again right away to
> > write the suspend image.
> 
> So suspend-to-RAM more or less matches PCI D3hot, and
> suspend-to-DISK matches PCI D3cold.  If those power states
> were passed to the device suspend(), the disk driver could act
> appropriately.  In my observation, D3cold was never passed
> down, it was always D3hot.

Maybe a better approach would be to describe the required features to
the drivers rather than encoding them in a single integer. Rather
like passing a request that states "lowest power level with device state
retained, must not do DMA, enable remote wake up"
 
[..]
> Though the PM core doesn't cooperate at all there.  Neither the
> suspend nor the resume codepaths cope well with disconnect
> (and hence device removal), the PM core self-deadlocks since
> suspend/resume outcalls are done while holding the semaphore
> that device_pm_remove() needs, ugh.

Shouldn't we deal with this like a failed resume?

	Regards
		Oliver
