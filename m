Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932266AbWJGP2s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932266AbWJGP2s (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 11:28:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932268AbWJGP2s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 11:28:48 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:63425 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932266AbWJGP2r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 11:28:47 -0400
Message-ID: <4527C7AB.9080801@garzik.org>
Date: Sat, 07 Oct 2006 11:28:43 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Robert Hancock <hancockr@shaw.ca>
CC: linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org,
       prakash@punnoor.de
Subject: Re: [RFC PATCH] nForce4 ADMA with NCQ: It's aliiiive..
References: <45276085.3040102@shaw.ca>
In-Reply-To: <45276085.3040102@shaw.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Hancock wrote:
> I've been working on the patch for sata_nv ADMA support for nForce4 that 
> Jeff Garzik has in a git branch. I've gotten it into a state where the 
> ADMA and NCQ features appear to be working with no obvious problems. 
> I've attached a patch against 2.6.18-mm2.
> 
> The code was mostly in a working state for the non-NCQ case but there 
> were a number of heinous bugs that prevented NCQ from working, like in 
> the sg list to APRD conversion code and in the interrupt handler.
> 
> This is still in quite an experimental state. It has survived system 
> boots into Fedora Core 5 and Bonnie++ benchmark runs without blowing up, 
> but there could still be bugs that could corrupt data, etc. so test with 
> caution.
> 
> There is a module parameter adma_enabled which has to be set to 1 to 
> enable ADMA on CK804/MCP04 chipsets (either that or hack the code to 
> make the default 1). I only enabled ADMA on those chipsets and not 
> MCP51, MCP55 or MCP61 since that was all that the original NVIDIA 
> version did. I assume there was a reason for this, though maybe not. 
> Someone with one of these chipsets should probably try it out (replacing 
> the GENERIC type with CK804 in the PCI device table may be all it takes).

Nice!  Good work.


> A few outstanding issues:
> 
> -Error handling likely needs work. EH works well enough to get past 
> drive detection but that's likely about all. When I ran into errors 
> while debugging, it usually locked up the machine when trying to do a 
> soft reset.
> 
> -Error handling is also noisy at the moment (it dumps a bunch of 
> controller state information).
> 
> -Jeff will probably cringe at how I implemented the 
> bmdma_stop/start/status/setup functions. This kludge of toggling 
> ATA_FLAG_MMIO off for the call into libata was needed since this 
> controller is almost what libata calls ATA_FLAG_MMIO, but not quite (the 
> ATA taskfile registers are MMIO but the BMDMA registers are PIO). This 
> is also why I needed the patch to libata-sff.c to use the adapter's 
> bmdma_status function rather than hardcoded ata_bmdma_status.

*shrug*  I don't cringe if that's the most expedient way to do something.

But I really don't think that is necessary.  I will take a look at docs 
and see how things match up, when I am much more awake.  Most likely you 
need to be using another set of registers, and be all MMIO, all the time.

	Jeff


