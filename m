Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030476AbWAXNW5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030476AbWAXNW5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 08:22:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030480AbWAXNW5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 08:22:57 -0500
Received: from anchor-post-34.mail.demon.net ([194.217.242.92]:34318 "EHLO
	anchor-post-34.mail.demon.net") by vger.kernel.org with ESMTP
	id S1030477AbWAXNW4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 08:22:56 -0500
Message-ID: <43D62A2E.10500@superbug.co.uk>
Date: Tue, 24 Jan 2006 13:22:54 +0000
From: James Courtier-Dutton <James@superbug.co.uk>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Harish K Harshan <harish@arl.amrita.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: DMA Transfer problem
References: <43D5B473.3060006@arl.amrita.edu> <43D624B4.5070300@superbug.co.uk> <43D62989.3070108@arl.amrita.edu>
In-Reply-To: <43D62989.3070108@arl.amrita.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Harish K Harshan wrote:
> Thank You, James,
>
>   But the problem with sound card drivers are that they dont have a 
> configurable clock on them, do they??? and as far as i know, this ADC 
> card involves a lot of register writings for the counter ICs that help 
> configuring the clock speed for the DMA transfer.... 
It depends which clock you are referring to. Sound cards can set the 
sample rate. Sound cards also set "period" sizes, so that once enough 
samples have been captured by the sound card hardware, the hardware 
initiates a DMA transfer. Could this "period" be the "clock speed" 
setting you are talking about?

> First we set the control properties, which involves the IRQ, start 
> channel, stop channel, etc (the card is an 8-channel ADC), (the jumper 
> settings configure the DMA channels that should be used, 1 or 3). Now 
> we initialize the DMA controller, so that it throws an interrupt once 
> the transfer of DMA_COUNT samples of data. The interrupt service 
> routine for this interrupt can handle the data transfer to the user 
> program. Roughly thats how the driver works... Now, the problem is 
> that, when running on the Chino-Laxsons board PCs, the DMA transfers 
> take varying time to complete (say, if one transfer takes one second, 
> the next might take one and a half), but this is not supposed to (and 
> doesnt) happen on any other machines we tested on. Its absolutely 
> synchronous with the clock, and theres the minimal drift. Can anyone 
> suggest why this could be happening on this particular board??? And 
> another interesting thing is that, this card seems to work fine with 
> the Windows driver available to it (provided by the company.). I need 
> help on this very urgently. If anybody has had any such experience, 
> and solved it, please let me know.
>
So, the "DMA_COUNT" sounds like what ALSA refers to as the period.
All the rest, IRQ, start/stop are handled but the current ALSA sound 
card drivers. The DMA channel to use would have to be a kernel module 
option if they use jumpers.


James

