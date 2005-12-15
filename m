Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161046AbVLOIWu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161046AbVLOIWu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 03:22:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161061AbVLOIWu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 03:22:50 -0500
Received: from HELIOUS.MIT.EDU ([18.248.3.87]:20107 "EHLO neo.rr.com")
	by vger.kernel.org with ESMTP id S1161046AbVLOIWt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 03:22:49 -0500
Date: Thu, 15 Dec 2005 04:25:36 -0500
From: Adam Belay <ambx1@neo.rr.com>
To: Ed Sweetman <safemode@comcast.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: pci unsupported PM regs version (7), means hardware isn't working?
Message-ID: <20051215092536.GA8122@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Ed Sweetman <safemode@comcast.net>, linux-kernel@vger.kernel.org
References: <438F800C.1050903@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <438F800C.1050903@comcast.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2005 at 05:58:20PM -0500, Ed Sweetman wrote:
> I'm getting this warning when i try to load the madwifi drivers on my 
> WRAP board for the WMIA-166AG mini-pci card using kernel 2.6.13.3 and 
> the latest trunk of madwifi.  
> 
> This is the only error that's printed before the HAL driver for madwifi 
> responds with "no hardware found or unsupported hardware" etc etc.   I 
> had to add the pcid's to madwifi for it to even detect it enough to try 
> and send it to the HAL module, but the madwifi dev team isn't looking at 
> any bug reports because of this printk that's being made by the PCI 
> subsystem in the kernel. 
> 
> So, does this printk mean anything (i've seen posts where the hardware 
> producing it was working, the printks were just a nuissance) or does it 
> indicate some issue the PCI subsystem is having in powering the card up 
> and communicating with it.   In either case, I'd be more than happy with 
> providing anyone able to patch the pci code with information i have on 
> the card. 
> 
> If it's nothing but a harmless warning, i'll forward the response to the 
> madwifi wiki and mailing list, so something can be done upstream to the 
> hal module to work the card. 
> 
> Thanks in advance. 

The power management spec version reported by the driver doesn't exist as
far as I know.  Would it be possible to see the output of "lspci -xxx"?

Even if the kernel isn't able to understand the PM registers, we may want
to assume the device is in D0 and print a warning. The bar restore changes
possibly have changed this behavior.  As a result, pci_enable_device() would
return an error.

Thanks,
Adam
