Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965087AbWILClo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965087AbWILClo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 22:41:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965259AbWILClo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 22:41:44 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:58313 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965087AbWILCln (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 22:41:43 -0400
Message-ID: <45061E63.6010901@garzik.org>
Date: Mon, 11 Sep 2006 22:41:39 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Dan Williams <dan.j.williams@intel.com>
CC: NeilBrown <neilb@suse.de>, linux-raid@vger.kernel.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, christopher.leech@intel.com
Subject: Re: [PATCH 00/19] Hardware Accelerated MD RAID5: Introduction
References: <1158015632.4241.31.camel@dwillia2-linux.ch.intel.com>	 <4505F358.3040204@garzik.org> <e9c3a7c20609111653v29cd4609hd0584ae300b735b7@mail.gmail.com>
In-Reply-To: <e9c3a7c20609111653v29cd4609hd0584ae300b735b7@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Williams wrote:
> This is a frequently asked question, Alan Cox had the same one at OLS.
> The answer is "probably."  The only complication I currently see is
> where/how the stripe cache is maintained.  With the IOPs its easy
> because the DMA engines operate directly on kernel memory.  With the
> Promise card I believe they have memory on the card and it's not clear
> to me if the XOR engines on the card can deal with host memory.  Also,
> MD would need to be modified to handle a stripe cache located on a
> device, or somehow synchronize its local cache with card in a manner
> that is still able to beat software only MD.

sata_sx4 operates through [standard PC] memory on the card, and you use 
a DMA engine to copy memory to/from the card.

[select chipsets supported by] sata_promise operates directly on host 
memory.

So, while sata_sx4 is farther away from your direct-host-memory model, 
it also has much more potential for RAID acceleration:  ideally, RAID1 
just copies data to the card once, then copies the data to multiple 
drives from there.  Similarly with RAID5, you can eliminate copies and 
offload XOR, presuming the drives are all connected to the same card.

	Jeff


