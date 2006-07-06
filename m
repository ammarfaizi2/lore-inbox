Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030285AbWGFONs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030285AbWGFONs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 10:13:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030286AbWGFONs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 10:13:48 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:22479 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S1030285AbWGFONs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 10:13:48 -0400
Date: Thu, 6 Jul 2006 16:13:19 +0200
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: AVR32 architecture patch against Linux 2.6.18-rc1 available
Message-ID: <20060706161319.3ae0d9ef@cad-250-152.norway.atmel.com>
In-Reply-To: <1152187083.2987.117.camel@pmac.infradead.org>
References: <20060706105227.220565f8@cad-250-152.norway.atmel.com>
	<1152187083.2987.117.camel@pmac.infradead.org>
Organization: Atmel Norway
X-Mailer: Sylpheed-Claws 2.3.0 (GTK+ 2.8.18; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Jul 2006 12:58:03 +0100
David Woodhouse <dwmw2@infradead.org> wrote:

> [lots of stuff I'll get fixed]
> 
> Do you really need the EARLY_PRINTK crap? Can't you just register your
> proper console nice and early? There's no need to wait for
> console_init() and use console_initcall(). You can do it right at the
> beginning of setup_arch(), as long as you parse the command line early
> enough for console= options. 

I didn't know that. But since the "proper console" would usually mean
at91_serial, I'd have to remove console_initcall() from there and call
it directly from setup_arch().

I suppose I could just remove the EARLY_PRINTK crap now and worry
about driver modifications later.

> You're including <linux/config.h> in a few places -- kill them all.

Will do.

> "DMA controller framework".... isn't that what drivers/dma was
> recently invented for? If appropriate, you should probably use that.
> If not, you should explain why, and perhaps we should get it fixed.

It was written some time before the drivers/dma stuff. I suppose I
should try to use the DMA subsystem instead.

As I understand it, though, drivers/dma is mostly for memory-to-memory
to transfers, while what I really need is memory-to-hardware and
hardware-to-memory transfers.

I'll just drop the DMA controller stuff for now as it doesn't have any
users yet anyway.

> You're a bit behind on syscall support -- I note you have
> TIF_RESTORE_SIGMASK (which means you're ahead of x86_64) but you
> haven't wired up ppoll() and pselect(), amongst others.

I'll sync up with i386. By the way, are there any syscalls I
_shouldn't_ have wired up? It's probably too late to remove any of them
at this point, but if we get it sorted out quickly, we might get away
with a shorter grace period than usual...

> You say 'MB' in a few places where you actually mean 'MiB', probably
> copied from sloppy code elsewhere.

Will do.

Thanks,
Håvard
