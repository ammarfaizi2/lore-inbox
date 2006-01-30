Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964772AbWA3Qho@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964772AbWA3Qho (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 11:37:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964771AbWA3Qho
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 11:37:44 -0500
Received: from kepler.fjfi.cvut.cz ([147.32.6.11]:11150 "EHLO
	kepler.fjfi.cvut.cz") by vger.kernel.org with ESMTP id S964772AbWA3Qhn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 11:37:43 -0500
Date: Mon, 30 Jan 2006 17:37:32 +0100 (CET)
From: Martin Drab <drab@kepler.fjfi.cvut.cz>
To: Harish K Harshan <harish@arl.amrita.edu>
cc: James Courtier-Dutton <James@superbug.co.uk>, linux-kernel@vger.kernel.org
Subject: Re: DMA Transfer problem
In-Reply-To: <43D62989.3070108@arl.amrita.edu>
Message-ID: <Pine.LNX.4.60.0601301726190.9429@kepler.fjfi.cvut.cz>
References: <43D5B473.3060006@arl.amrita.edu> <43D624B4.5070300@superbug.co.uk>
 <43D62989.3070108@arl.amrita.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Jan 2006, Harish K Harshan wrote:

> Thank You, James,
> 
>   But the problem with sound card drivers are that they dont have a
> configurable clock on them, do they??? and as far as i know, this ADC card
> involves a lot of register writings for the counter ICs that help configuring
> the clock speed for the DMA transfer.... First we set the control properties,
> which involves the IRQ, start channel, stop channel, etc (the card is an
> 8-channel ADC), (the jumper settings configure the DMA channels that should be
> used, 1 or 3). Now we initialize the DMA controller, so that it throws an
> interrupt once the transfer of DMA_COUNT samples of data. The interrupt
> service routine for this interrupt can handle the data transfer to the user
> program. Roughly thats how the driver works... Now, the problem is that, when
> running on the Chino-Laxsons board PCs, the DMA transfers take varying time to
> complete (say, if one transfer takes one second, the next might take one and a

I'm not really sure what do you mean by that, but there may be lots of 
reasons for this. Bad bus latencies, other devices blocking the bus, bad 
chipset, bad PCI/DMA controller on the device (this happend to me with 
an AMCC S5933 MatchMaker PCI chip, since it has about 16 HW construction 
bugs within it which makes it nearly impossible to reliably use it with 
any reaonably new chipset - with very old chipsets the bugs didn't 
demonstrate themselfs that much), etc. And you may also consider a hard 
real-time system if it's really time critical and intensive.

Martin
