Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262687AbVF3MV3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262687AbVF3MV3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 08:21:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262961AbVF3MV3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 08:21:29 -0400
Received: from [85.8.12.41] ([85.8.12.41]:22714 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S262687AbVF3MVY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 08:21:24 -0400
Message-ID: <42C3E3A4.3090305@drzeus.cx>
Date: Thu, 30 Jun 2005 14:20:52 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 1.0.2-7 (X11/20050623)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: LKML <linux-kernel@vger.kernel.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: ISA DMA controller hangs
References: <42987450.9000601@drzeus.cx>	 <1117288285.2685.10.camel@localhost.localdomain>	 <42A2B610.1020408@drzeus.cx> <42A3061C.7010604@drzeus.cx>	 <42B1A08B.8080601@drzeus.cx> <20050616170622.A1712@flint.arm.linux.org.uk>	 <42C3A698.9020404@drzeus.cx> <1120130926.6482.83.camel@localhost.localdomain>
In-Reply-To: <1120130926.6482.83.camel@localhost.localdomain>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>
>It is spelt "weird"
>  
>

Ooops... :)

>Looks basically OK although it would be good to document the situation
>for a bus mastering DMA controller. Does the device have to reconfigure
>the DMA on a resume or is that something the restore code for the device
>should handle ?
>
>My own feeling is tha we should dump that on the device (safer) and also
>expect the device to prevent suspends during an active DMA transfer (eg
>floppy)
>
>  
>

If you mean that the device drivers should restore any state then I
fully agree. A central restore of the complete state of the DMA
controller would require keeping a copy of all data passed to it (since
some registers are write only). The reason for my piece of code here is
that nobody "owns" channel 4 so it must be restored centrally. Also,
resetting the other registers makes the DMA controller behave the same
way on all systems (from the drivers' point of view at least).

Preventing suspend also needs to be done from the drivers. Simply
because only they can determine when the devices are doing the transfer
(examining the DMA controller will only tell us if it's _prepared_ for a
transfer).

I'll fix the typo and whip up a patch for x86_64 then.

Rgds
Pierre

