Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750903AbWFTU1R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750903AbWFTU1R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 16:27:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750914AbWFTU1Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 16:27:16 -0400
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:10972
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S1750903AbWFTU0x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 16:26:53 -0400
Message-ID: <44985A07.9080807@microgate.com>
Date: Tue, 20 Jun 2006 15:26:47 -0500
From: Paul Fulghum <paulkf@microgate.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Shaun Jackman <sjackman@gmail.com>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: TL16C752B DUART: MCR_OUT2 disables interrupts
References: <7f45d9390606201307yfdb8aadn4d00a6afeba0b09b@mail.gmail.com>
In-Reply-To: <7f45d9390606201307yfdb8aadn4d00a6afeba0b09b@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shaun Jackman wrote:
> The datasheet I have for the TL16C752B labels the MCR_OUT1 bit as
> `FIFO Rdy enable' and the MCR_OUT2 bit as `IRQ enable'. The latter bit
> concerns me. The 8250.c driver sets MCR_OUT2 by default; however, if
> the user space clears MCR_OUT2 (through an ioctl TIOCMSET operation or
> similar), it seems to me that interrupts for that UART will stop
> working. Can someone confirm my suspicion?
> 
> I'd expect that clearing/setting the OUT1 and OUT2 pins from user
> space should be an innocuous operation. Disabling interrupts is a
> fairly nasty side effect.

The old 16550 OUT2 output (MCR:3) used to be a truly
independant control output that was commonly used
with an external gate to connect/disconnect the
interrupt request to the ISA bus.

Reading the TL16C752B datasheet, it seems pretty clear
that this gating is performed internal to the device.
MCR:3 is no longer an independant, general purpose I/O.

The result is the same though: If you dink around with
MCR:3 you could disable interrupts in either case.

So I don't see this as more or less of a problem than
other 16550 type devices.

-- 
Paul Fulghum
Microgate Systems, Ltd.
