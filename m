Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262439AbUCHJtM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 04:49:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262436AbUCHJsd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 04:48:33 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:33443 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262441AbUCHJlU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 04:41:20 -0500
Date: Mon, 8 Mar 2004 10:41:19 +0100
From: Jens Axboe <axboe@suse.de>
To: linux-kernel@vger.kernel.org
Cc: sneakums@zork.net
Subject: Re: [PATCH] 2.6 ide-cd DMA ripping
Message-ID: <20040308094119.GS23525@suse.de>
References: <20040303113756.GQ9196@suse.de> <6ufzcmm5qt.fsf@zork.zork.net> <20040307103542.GD23525@suse.de> <6u7jxwn9sb.fsf@zork.zork.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6u7jxwn9sb.fsf@zork.zork.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 07 2004, Sean Neakums wrote:
> Jens Axboe <axboe@suse.de> writes:
> 
> > On Sat, Mar 06 2004, Sean Neakums wrote:
> >> Jens Axboe <axboe@suse.de> writes:
> >> 
> >> > Hi,
> >> >
> >> > 2.6 still uses PIO for CDROMREADAUDIO cdda ripping, which is less than
> >> > optimal of course... This patch uses the block layer infrastructure to
> >> > enable zero copy DMA ripping through CDROMREADAUDIO.
> >> >
> >> > I'd appreciate people giving this a test spin. Patch is against
> >> > 2.6.4-rc1 (well current BK, actually).
> >> 
> >> Applied successfully to 2.6.4-rc1-mm2, and it works great.  For some
> >> reason, on two different machines, ripping with cdparanoia used to
> >> somehow crowd out the serial port, but now everything just works.
> >
> > cd ripping was highly cpu intensive when it ran in pio, so it's very
> > likely that this screwed up your serial port communication. It doesn't
> > matter with the patch, but had you used hdparm -u1 on your cd device
> > on an unpatched kernel, you would have had better luck.
> 
> I had a look, just for pig iron, and hdparm -u on one of the machines
> reports that it is already enabled.  That machine is SMP with two
> 1.13GHz PIIIs.  I can't check the other machine as the drive in
> question is no longer functional.

Then isr runtime was likely too high, even with interrupt masking
enabled. So just be glad that it works with dma :)

-- 
Jens Axboe

