Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261155AbTIRLgp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 07:36:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261178AbTIRLfc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 07:35:32 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:64745 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261174AbTIRLfN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 07:35:13 -0400
Date: Wed, 17 Sep 2003 21:19:29 +0200
From: Pavel Machek <pavel@suse.cz>
To: Jens Axboe <axboe@suse.de>
Cc: Rogier Wolff <R.E.Wolff@BitWizard.nl>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Stephan von Krawczynski <skraw@ithnet.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       neilb@cse.unsw.edu.au,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: experiences beyond 4 GB RAM with 2.4.22
Message-ID: <20030917191929.GC9125@openzaurus.ucw.cz>
References: <20030916102113.0f00d7e9.skraw@ithnet.com> <Pine.LNX.4.44.0309161009460.1636-100000@logos.cnet> <20030916153658.3081af6c.skraw@ithnet.com> <1063722973.10037.65.camel@dhcp23.swansea.linux.org.uk> <20030917084102.A19276@bitwizard.nl> <20030917102629.GL906@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030917102629.GL906@suse.de>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > and memory remappings. By considering the top part of RAM as swap,
> > you'll force the important stuff into the more easily accessable
> > RAM (Compare to fastram as it was called on the Amiga!). 
> 
> You are misunderstanding the problem. You don't use bounce buffers just
> because the page happens to reside in high memory, it is only used if
> the hardware cannot DMA to it. And that is exactly the problem here with
> the 3ware adapter, it cannot dma to > 4GB. So in a 6GB setup (with
> potentially 5G of highmem), only the last 2G requires bouncing.
> 
> To answer one of the other questions regarding slowdown - it can be
> nastier than 2x, remember that for reads the copy back happens inside
> the interrupt handler... It would also be interesting to note (with

Ouch, I guess I see. If big part of time is spent in interrupt
copying data, network is going to loose packets and perform
awfully. Could he run some interrupt latency tester?

Perhaps we are copying way too much in one chunk, therefore starving
network?
Heh, old ide disk in PIO mode should allow that 6GB machine
to perform better...
At least you don't loose packets during PIO reads...
				Pavel
-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

