Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261479AbTCOQUs>; Sat, 15 Mar 2003 11:20:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261480AbTCOQUs>; Sat, 15 Mar 2003 11:20:48 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:42412 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S261479AbTCOQUq>;
	Sat, 15 Mar 2003 11:20:46 -0500
Date: Sat, 15 Mar 2003 17:31:37 +0100
From: Jens Axboe <axboe@suse.de>
To: Daniel Egger <degger@fhm.edu>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.64-ac3: Crash in ide_init_queue
Message-ID: <20030315163137.GR791@suse.de>
References: <1047676410.7452.34.camel@sonja> <20030314212510.GE791@suse.de> <1047741940.10690.1.camel@sonja> <1047742416.10689.3.camel@sonja>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1047742416.10689.3.camel@sonja>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 15 2003, Daniel Egger wrote:
> Am Sam, 2003-03-15 um 16.25 schrieb Daniel Egger:
> 
> > > using ide tcq?
> 
> > It's compiled into the kernel but unused since there's no harddrive in
> > the machine. I'll remove it from the config and retry.
> 
> Nope, same problem without tcq.

Please double check, TCQ is the only way that ide_init_queue() would end
up with NULL EIP.

You could make the ide_dma_queued_on() conditional, ala:

#ifdef CONFIG_BLK_DEV_IDE_TCQ_DEFAULT
	if (HWIF(drive)->ide_dma_queued_on)
		HWIF(drive)->ide_dma_queued_on(drive);
#endif


-- 
Jens Axboe

