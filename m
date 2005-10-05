Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932557AbVJEHz3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932557AbVJEHz3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 03:55:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932563AbVJEHz3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 03:55:29 -0400
Received: from [85.21.88.2] ([85.21.88.2]:28556 "HELO mail.dev.rtsoft.ru")
	by vger.kernel.org with SMTP id S932557AbVJEHz3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 03:55:29 -0400
Message-ID: <43438746.2000904@ru.mvista.com>
Date: Wed, 05 Oct 2005 11:56:54 +0400
From: Vitaly Wool <vwool@ru.mvista.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Brownell <david-b@pacbell.net>
CC: linux-kernel@vger.kernel.org, spi-devel-general@lists.sourceforge.net,
       basicmark@yahoo.com, stephen@streetfiresound.com, dpervushin@gmail.com
Subject: Re: [PATCH/RFC 0/2] simple SPI framework, refresh + ads7864 driver
References: <20051004180237.9B4FDEE8F2@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
In-Reply-To: <20051004180237.9B4FDEE8F2@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

BTW, haven't seen any place where message->complete() is called... Can 
you please point out one?

Vitaly

David Brownell wrote:

>Following this will be two patches, refreshing the minimalist SPI stack
>I've sent before.  Notable changes are:
>
>  - Various updates to support real hardware, including reporting the
>    IRQ associated with an SPI slave chip, providing void* handles for
>    various flavors of board and controller state, dma_addr_t for I/O
>    buffers, some control over protocol delays, and more.
>
>  - New spi_alloc_master().  The driver model is happier if drivers
>    don't allocate the class devices; this helps "rmmod" and friends,
>    kind of handy for debugging drivers.  It allocates controller
>    specific memory not unlike alloc_netdev().
>
>  - Various cleanup, notably removing Kconfig for all those drivers
>    that don't yet exist.  That was added purely to illustrate the
>    potential scope of an SPI framework, when more folk were asking
>    just why a Serial Peripheral Interface (*) was useful.
>
>  - More kerneldoc.  No Documentation/DocBook/spi.html though.
>
>  - Now there's a real ADS7864 touchscreen/sensor driver; lightly
>    tested, but it emits the right sort of input events and gives
>    syfs access to the temperature, battery, and voltage sensors.
>
>This version seems real enough to integrate with.
>
>One goal is promote reuse of driver code -- for SPI controllers and
>slave chips connected using SPI -- while fitting them better into the
>driver model framework.  Today, SPI devices only seem to get drivers
>that are board-specific; there's a fair amount of reinvent-the-wheel,
>and drivers that are unsuitable for upstream merging.
>
>I can now report this seems to be working with real controllers and
>real slave chips ... two of each to start with, but as yet there's no
>mix'n'match (with e.g. that touchscreen driver being used with a PXA
>SSP controller, not just OMAP MicroWire).  That should just take a
>little bit of time and debugging.
>
>- Dave
>
>(*) And distinguish it from Singapore Paranormal Investigators.  ;)
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>  
>

