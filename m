Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751628AbWJMH4k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751628AbWJMH4k (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 03:56:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751624AbWJMH4k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 03:56:40 -0400
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:1545 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751620AbWJMH4j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 03:56:39 -0400
Date: Fri, 13 Oct 2006 08:56:27 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: pHilipp Zabel <philipp.zabel@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [MMC] Use own work queue
Message-ID: <20061013075626.GB28654@flint.arm.linux.org.uk>
Mail-Followup-To: Pierre Ossman <drzeus-list@drzeus.cx>,
	pHilipp Zabel <philipp.zabel@gmail.com>,
	linux-kernel@vger.kernel.org
References: <20061001124240.16996.34557.stgit@poseidon.drzeus.cx> <74d0deb30610070717k17079940ybedbf94dc8af8460@mail.gmail.com> <452AB97B.5040309@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <452AB97B.5040309@drzeus.cx>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2006 at 11:04:59PM +0200, Pierre Ossman wrote:
> pHilipp Zabel wrote:
> > 
> > This patch makes pxamci stop working for me on a HTC Magician (PXA272).
> > Switching from 2.6.18 to 2.6.19-rc1 I got a kernel panic:
> > 
> > mmc0: clock 0Hz busmode 1 powermode 0 cs 0  Vdd 0 width 0
> > PXAMCI: clkrt = 0 cmdat = 0
> > VFS: Cannot open root device "mmcblk0p2" or unknown-block(0,0)
> > Please append a correct "root=" boot option
> > Kernel panic - not syncing: VFS: Unable to mount root fs on
> > unknown-block(0,0)
> > 
> > After removing this patch from 2.6.19-rc1, everything is working again.
> > Are there any changes to pxamci.c needed to be compatible with it?
> > 
> 
> No, the drivers shouldn't be affected. As this is a root device, my
> guess would be that you have a race in your bootup that is causing problem.

The problem is likely that the boot is continuing in parallel with
detecting the card, because the card detection is running in its own
separate thread.  Meanwhile, the init thread is trying to read from
the as-yet missing root device and erroring out.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
