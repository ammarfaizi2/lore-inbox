Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965125AbWHQQkz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965125AbWHQQkz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 12:40:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965126AbWHQQkz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 12:40:55 -0400
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:48769
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S965125AbWHQQky (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 12:40:54 -0400
Message-ID: <44E49C0F.7030600@microgate.com>
Date: Thu, 17 Aug 2006 11:40:47 -0500
From: Paul Fulghum <paulkf@microgate.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Raphael Hertzog <hertzog@debian.org>
CC: Lee Revell <rlrevell@joe-job.com>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: How to avoid serial port buffer overruns?
References: <20060816104559.GF4325@ouaza.com> <1155753868.3397.41.camel@mindpipe> <44E37095.9070200@microgate.com> <1155762739.7338.18.camel@mindpipe> <1155767066.2600.19.camel@localhost.localdomain> <20060817161042.GC10818@ouaza.com>
In-Reply-To: <20060817161042.GC10818@ouaza.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Raphael Hertzog wrote:
> I tried 2.6.17.7.
> 
> But I'm really not sure that the 2.6 is a regression from 2.4, in fact I
> think it does better by default.
> 
> The stock 2.4.31 kernel I was using had serial overruns at 9600 bauds
> already. Once patched with the low latency/preemptive kernel patchs, it
> was way better and I had only overruns at 115200 bauds.
> 
> With the 2.6.17.7 kernel (configured with CONFIG_PREEMPT and
> CONFIG_HZ=1000), I'm seeing overruns starting at 38400 bauds. So
> compared to plain 2.4, it's better. However compared to the patched
> 2.4, it's worse.

This tells me your issue is not a problem with the
serial or tty code, but rather a matter of IRQ latency.
(Which you may have already known, but I was unclear on)
I do not expect 2.6.18-rc4 to make a difference.

For fun, have you tried playing with the rx FIFO trigger
level in the 16550A entry in drivers/serial/8250.c ?
You could try replacing UART_FCR_R_TRIG_10 (8 char trigger)
with UART_FCR_R_TRIG_01 (4 char trigger) or even
UART_FCR_R_TRIG_00 (1 char trigger).
That creates more interrupts, but allows
more time to activate the ISR before overrun.

Lee's issue may still merit investigation into the
serial/tty code.

-- 
Paul Fulghum
Microgate Systems, Ltd.
