Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758280AbWK0P0v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758280AbWK0P0v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 10:26:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758279AbWK0P0v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 10:26:51 -0500
Received: from calculon.skynet.ie ([193.1.99.88]:58240 "EHLO
	calculon.skynet.ie") by vger.kernel.org with ESMTP id S1758272AbWK0P0v
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 10:26:51 -0500
Date: Mon, 27 Nov 2006 15:26:48 +0000
To: Andi Kleen <ak@suse.de>
Cc: akpm@osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Add debugging aid for memory initialisation problems
Message-ID: <20061127152648.GA16573@skynet.ie>
References: <20061127140804.GA15405@skynet.ie> <200611271514.03612.ak@suse.de> <Pine.LNX.4.64.0611271437560.15577@skynet.skynet.ie> <200611271608.34484.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <200611271608.34484.ak@suse.de>
User-Agent: Mutt/1.5.9i
From: mel@skynet.ie (Mel Gorman)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On (27/11/06 16:08), Andi Kleen didst pronounce:
> 
> > > So how many new lines does that add overall?
> > 
> > I don't know for sure, but it's probably around the 150 LOC mark from 
> 
> Sorry I meant just dmesg foot print. I think before you add anything
> new you first need a construct like apic_printk() with a configurable log level
> with a low default.
> 

Oh right, my bad.

At normal logging levels, the largest output is from stuff like this

Zone PFN ranges:
  DMA          1024 ->   262144
  Normal     262144 ->   262144
early_node_map[3] active PFN ranges
  0:     1024 ->    30719
  0:    32768 ->    65413
  0:    65440 ->    65505

So, that is one line per zone, one line per map entry (that can get
large). There is also lines outputting pages used for memmap, that's
more lines per zone and the DMA zone reserve.

Ok.... it's adding up.

With loglevel at KERN_DEBUG, there can be a very large number of lines
like

Entering add_active_range(0, 1024, 30719) 0 entries of 256 used

I see your point. I'll look into doing something like apic_printk().

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
