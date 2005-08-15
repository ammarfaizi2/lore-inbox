Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964849AbVHOROP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964849AbVHOROP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 13:14:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964850AbVHOROP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 13:14:15 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:7953 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S964849AbVHOROP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 13:14:15 -0400
Date: Mon, 15 Aug 2005 18:51:41 +0200
From: Willy Tarreau <willy@w.ods.org>
To: mustang4@free.fr
Cc: Willy Tarreau <willy@w.ods.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux Kernel Hang or stop after uncompressing MPC8245
Message-ID: <20050815165141.GA29660@alpha.home.local>
References: <1124122213.4300be659dc89@imp5-q.free.fr> <20050815155505.GF20363@alpha.home.local> <1124125002.4300c94a31810@imp5-q.free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1124125002.4300c94a31810@imp5-q.free.fr>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Aug 15, 2005 at 06:56:42PM +0200, mustang4@free.fr wrote:
> Hi,
 
> This is what my board say (in console mode) about serial address:
> 0x08 COM1             DUART8245    0xfc004500 0x07a12000 0x00000001 0x01effc70
> 0x09 COM2             DUART8245    0xfc004600 0x07a12000 0x00000001 0x01e107d0

Have you read this thread ?

  http://ozlabs.org/pipermail/linuxppc-embedded/2005-August/019482.html

It discusses your about your board, on which interrupts must be set to LEVEL
and not EDGE. BTW, they also used 8250. I don't know how you have to configure
the serial ports though.

This boot log also confirms that you have to use 8250/16550 :

  http://mhonarc.axis.se/jffs-dev/msg01350.html

> >   - are you sure that you enabled "console on serial port" in the config ?
> Yes, i enable " Support for console on virtual terminal" but i enable
> "Non-standard serial port support" option too...
> So i recompile without the last one... and i recompile "with Serial drivers
> --->" "[*]   Console on 8250/16550 and compatible serial port" perhaps it's
> that... And i came back to you.
> But, perhaps i've allready tested... i ll check.. it's not a default option ?

It's not necessarily a default option. There are many console and serial
ports combination available. BTW, you could also try netconsole which will
send you the console data over an ethernet port if you cannot get the serial
to work.

> >   - how can you be certain that the serial will appear on ttyS0 and not ttyS1
> >     or another one (the kernel might detect another serial port which it
> >     assigns ttyS0)
> I pass parameter directly to the kernel;

ok.

> Another option i set :
>  Default bootloader kernel arguments  x x  x x(console=ttyS0,9600 console=tty0

ok.

Regards,
Willy

