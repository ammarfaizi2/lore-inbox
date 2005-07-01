Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263446AbVGAT1N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263446AbVGAT1N (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 15:27:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263437AbVGAT0y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 15:26:54 -0400
Received: from alog0205.analogic.com ([208.224.220.220]:2512 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263440AbVGAT0c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 15:26:32 -0400
Date: Fri, 1 Jul 2005 15:25:33 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Vojtech Pavlik <vojtech@suse.cz>
cc: christos gentsis <christos_gentsis@yahoo.co.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: PCI-X support
In-Reply-To: <20050701190939.GA2154@ucw.cz>
Message-ID: <Pine.LNX.4.61.0507011514570.5048@chaos.analogic.com>
References: <42C58203.40606@yahoo.co.uk> <Pine.LNX.4.61.0507011357290.5350@chaos.analogic.com>
 <42C585CE.1060509@yahoo.co.uk> <Pine.LNX.4.61.0507011453380.4921@chaos.analogic.com>
 <20050701190939.GA2154@ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Jul 2005, Vojtech Pavlik wrote:

> On Fri, Jul 01, 2005 at 03:02:11PM -0400, Richard B. Johnson wrote:
>
>> The driver (whatever that is), if it was written for a 64-bit
>> platform, can write a 64-bit word in one operation and it's
>> transparent. If the driver was written for a 32-bit environment,
>> it will still work because there is compatibility with PCI 2.x
>>
>> FYI, this machine has a PCI-X bus. I have some 32-bit cards
>> plugged into it (SCSI controller, etc.). They work. I also
>> have a 64-bit card plugged into it (fiber-optic data link).
>> It also works, but at 133 MHz. Software never talks to it
>> in 'long longs' so the increased data-width isn't being used.
>
> Are you sure about that? I'd assume when doing busmastering, it'll use
> 64-bit transfers, if the driver sets the correct DMA mask.
>

Yep. The board uses a PLX PCI 9656BA chip configured for local-bus
transfers during DMA The local-bus is 32-bits from a FIFO. There
is no way to collapse these writes from the 32-bit source/dest.
The transfers are 32 quadwords for a write and 16 quadwords for
a read, but that represents a burst, not the data-width. Without
a 64-bit data-path to memory on one side, and a 64-bit data-path
to the device (a FIFO) on the other side, you will not get 64-bit
transfers.


> -- 
> Vojtech Pavlik
> SuSE Labs, SuSE CR
> -

Cheers,
Dick Johnson
Penguin : Linux version 2.6.12 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
