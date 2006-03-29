Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750810AbWC2Eej@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750810AbWC2Eej (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 23:34:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750815AbWC2Eej
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 23:34:39 -0500
Received: from javad.com ([216.122.176.236]:28425 "EHLO javad.com")
	by vger.kernel.org with ESMTP id S1750810AbWC2Eei (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 23:34:38 -0500
From: Sergei Organov <osv@javad.com>
To: linux@horizon.com
Cc: linux-os@analogic.com, dedekind@yandex.ru, kalin@thinrope.net,
       linux-kernel@vger.kernel.org
Subject: Re: Lifetime of flash memory
References: <20060329010111.26121.qmail@science.horizon.com>
Date: Wed, 29 Mar 2006 08:33:31 +0400
In-Reply-To: <20060329010111.26121.qmail@science.horizon.com>
	(linux@horizon.com's message of "28 Mar 2006 20:01:11 -0500")
Message-ID: <87mzf96fac.fsf@javad.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux@horizon.com writes:
>>> Note that the actual block size is usually 64k, not the 512 bytes of a
>>> 'sector'. Apparently, some of the data-space on each block is used for
>>> relocation and logical-to-physical mapping.
>
>> Wrong. AFAIK, first disks had FLASH with 512b blocks, then next
>> generation had 16K blocks, and currently most of cards have 128K
>> blocks. Besides, each page of a block (64 pages * 2K for 128K block) has
>> additional "system" area of 64 bytes. One thing that is in the system
>> area is bad block indicator (2 bytes) to mark some blocks as bad on
>> factory, and the rest could be used by application[1] the same way the
>> rest of the page is used. So physical block size is in fact 64 * (2048 +
>> 64) = 135168 bytes.
>
> Er, I think you know what you're talking about, but some people reading
> this might be confused by the Flash-ROM-specific meaning of the word
> "block" here.

Yes, it's NAND-FLASH specific indeed, and block here means the unit of
erasure, while page is a unit of write, as you carefully describe
below.

> In NAND Flash terminology, a PAGE is the unit of write.  Thus was
> originaly 256+8 bytes,

Yes, with 2 pages per block, AFAIK, thus the block was 512 bytes and was
equal to the sector size that is used in the interface of CF card. I
indeed used a few of them and while their average write time was much
worse than those with current technology, it was *much* more predictable
due to the block size not exceeding interface sector size.

> which quickly got bumped to 512+16 bytes.

Yes, with 32 pages per block, thus the block became 16K.

> This is called a "small page" device. "large page" devices have
> 2048+64 byte pages.

Yes, with 64 pages per block (typically?), thus the block became 128K.

BTW, it's a pity the information about physical block size is not
accessible anywhere in CF interface.

> E.g. the 2 Gbyte device
> at
> http://www.samsung.com/Products/Semiconductor/NANDFlash/SLC_LargeBlock/16Gbit/K9WAG08U1M/K9WAG08U1M.htm
>
> Now, in a flash device, "writing" is changing selected bits from 1 to 0.
> "Erasing" is changing a large chunk of bits to 1.
>
> In some NOR devices, you can perform an almost unlimited number of writes,
> limited only by the fact that each one has to change at least one 1 bit
> to a 0 or there's no point.
>
> Due to the multiplexing scheme used in high-density NAND flash devices,
> even the non-programmed cells are exposed to a fraction of the programming
> voltage and there are very low limits on the number of write cycles to
> a page before it has to be erased again.  Exceeding that can cause some
> unwanted bits to change from 1 to 0.  Typically, however, it is enough
> to write each 512-byte portion of a page independently.

Well, I'm not sure. The Toshiba and Samsung NANDs I've read manuals for
seem to limit number of writes to a single page before block erase, --
is 512-byte portion some implementation detail I'm not aware of?

> Now, erasing is done in larger units called BLOCKs.  This is more
> variable, but a power of two multiple of the page size.  32 to 64 pages
> (16 k for small page/32-page blocks to 128K for large page with 64-page
> blocks) is a typical quantity.  You can only erase a block at a time.

Typical? Are you aware of a "large page" NAND FLASH with different
number of pages per block? It's not just curiosity, it's indeed
important for me to know if there are CF cards in the market with
physical block size != 128K.

[... skip interesting and nicely put details of NAND technology ...]

-- Sergei.
