Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261508AbVC1LEB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261508AbVC1LEB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 06:04:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261516AbVC1LEB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 06:04:01 -0500
Received: from tornado.reub.net ([60.234.136.108]:27278 "EHLO tornado.reub.net")
	by vger.kernel.org with ESMTP id S261508AbVC1LDs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 06:03:48 -0500
Message-ID: <4247E491.2070601@reub.net>
Date: Mon, 28 Mar 2005 23:03:45 +1200
From: Reuben Farrelly <reuben-lkml@reub.net>
User-Agent: Mozilla Thunderbird 1.0+ (Windows/20050325)
MIME-Version: 1.0
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       rmk+serial@arm.linux.org.uk
Subject: Re: 2.6.12-rc1-mm3
References: <fa.e0rq9h4.h02o3e@ifi.uio.no> <fa.dhfu5qn.1l68cj1@ifi.uio.no>
In-Reply-To: <fa.dhfu5qn.1l68cj1@ifi.uio.no>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reuben Farrelly wrote:

> 
> I'm repeatably getting this crash on shutdown in -mm3, and a few 
> releases earlier (but I can't be certain it was the same crash..)
> 
> Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
> ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
> ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
> ttyS4 at I/O 0xa400 (irq = 16) is a 16550A
> ttyS5 at I/O 0xa408 (irq = 16) is a 16550A
> 
> This _may_ be the culprit, but I'm not sure:
> 
> 03:03.0 Serial controller: Timedia Technology Co Ltd PCI2S550 (Dual 
> 16550 UART) (rev 01) (prog-if 02 [16550])
>         Subsystem: Timedia Technology Co Ltd: Unknown device 0002
>         Flags: stepping, medium devsel, IRQ 16
>         I/O ports at a400 [size=32]

Ugh.  I'm an idiot, that will teach me for having two sessions to boxes 
running at once.

Wrong info above, but the trace is still valid.

Correct info follows:

ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS14 at I/O 0xb400 (irq = 217) is a 16550A
ttyS15 at I/O 0xb000 (irq = 217) is a 16550A

06:02.0 Serial controller: NetMos Technology PCI 9835 Multi-I/O 
Controller (rev
01) (prog-if 02 [16550])
         Subsystem: LSI Logic / Symbios Logic 2S (16C550 UART)
         Flags: medium devsel, IRQ 217
         I/O ports at b400 [size=8]
         I/O ports at b000 [size=8]
         I/O ports at ac00 [size=8]
         I/O ports at a800 [size=8]
         I/O ports at a400 [size=8]
         I/O ports at a000 [size=16]


> The board is an Intel D925XCV.
> 
> Shutdown goes like this:   (yes, hyperterminal sucks for the ^M 
> characters, sorry)

<trace omitted>

reuben
