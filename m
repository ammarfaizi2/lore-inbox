Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750901AbWC2P4T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750901AbWC2P4T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 10:56:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751090AbWC2P4T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 10:56:19 -0500
Received: from science.horizon.com ([192.35.100.1]:62281 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1750901AbWC2P4S
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 10:56:18 -0500
Date: 29 Mar 2006 10:56:10 -0500
Message-ID: <20060329155610.4903.qmail@science.horizon.com>
From: linux@horizon.com
To: linux@horizon.com, osv@javad.com
Subject: Re: Lifetime of flash memory
Cc: dedekind@yandex.ru, kalin@thinrope.net, linux-kernel@vger.kernel.org,
       linux-os@analogic.com
In-Reply-To: <87mzf96fac.fsf@javad.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Due to the multiplexing scheme used in high-density NAND flash devices,
>> even the non-programmed cells are exposed to a fraction of the programming
>> voltage and there are very low limits on the number of write cycles to
>> a page before it has to be erased again.  Exceeding that can cause some
>> unwanted bits to change from 1 to 0.  Typically, however, it is enough
>> to write each 512-byte portion of a page independently.

> Well, I'm not sure. The Toshiba and Samsung NANDs I've read manuals for
> seem to limit number of writes to a single page before block erase, --
> is 512-byte portion some implementation detail I'm not aware of?

No.  I just meant that I generally see "you may program each 2K page a
maximum of 4 times before performing an erase cycle", and I assume the
spec came from 2048/512 = 4, so you can program each 512-byte sector
separately.  I would assume if the page size were changed again, they'd
try to keep that property.

E.g. from the Samsung K9K8G08U1A/K9F4G08U0A data sheet (p. 34):

	PAGE PROGRAM

	The device is programmed basically on a page basis, but it does
	allow multiple partial page programming of a word or consecutive
	bytes up to 2,112, in a single page program cycle.  The number
	of consecutive partial page programming operations within the
	same page without an intervening erase operation must not exceed
	4 times for a single page.  The addressing should be done in
	sequential order in a block.
	[...]
	The internal write verify detects only errors for "1"s that are
	not successfully programmed to "0"s."

>> Now, erasing is done in larger units called BLOCKs.  This is more
>> variable, but a power of two multiple of the page size.  32 to 64 pages
>> (16 k for small page/32-page blocks to 128K for large page with 64-page
>> blocks) is a typical quantity.  You can only erase a block at a time.

> Typical? Are you aware of a "large page" NAND FLASH with different
> number of pages per block? It's not just curiosity, it's indeed
> important for me to know if there are CF cards in the market with
> physical block size != 128K.

No, I'm not aware of any violations of that rule; I just hadn't looked
hard enough to verify that it was a rule, but I had seen the device ID
bits that allow a wide range to be specified.

The "more variable" statement is really based on NOR flash experience,
where it truly does vary all over the map.

> [... skip interesting and nicely put details of NAND technology ...]

Hopefully this makes descriptions like the start of the Samsung data
sheet more comprehensible:

	Product Information

	The K9F4G08U0A is a 4,224 Mbit (4,429,185,024 bit) memory
	organized as 262,144 rows (pages) by 1,112x8 columns.  Spare
	64x8 columns are located from column address of 2,048-2,111.
	A 2,112-byte data register is connected to memory cell arrays
	accomodating data transfer between the I/O buffers and memory
	during page read and page program operations.  The memory array
	is made up of 32 cells that are serially connected to form a
	NAND structure.  Each of the 32 cells resides in a different page.
	A block consists of two NAND structured strings.  A NAND structure
	consists of 32 cells.  Total 1,081,244 NAND cells reside in
	a block.  The program and read operations are executed on a page
	basis, while the erase operation is executed on a block basis.
	The memory array consists of 4,086 separately erasable 128K-byte
	blocks.  It indicates that the bit-by-bit erase operation is
	prohibited on the K9F4G08U0A.
