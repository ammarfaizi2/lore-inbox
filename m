Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751280AbWC1Mzn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751280AbWC1Mzn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 07:55:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751289AbWC1Mzm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 07:55:42 -0500
Received: from odyssey.analogic.com ([204.178.40.5]:24082 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1751280AbWC1Mzm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 07:55:42 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
in-reply-to: <87acbb6vlj.fsf@javad.com>
x-originalarrivaltime: 28 Mar 2006 12:55:38.0833 (UTC) FILETIME=[E9BE1C10:01C65266]
Content-class: urn:content-classes:message
Subject: Re: Lifetime of flash memory
Date: Tue, 28 Mar 2006 07:55:32 -0500
Message-ID: <Pine.LNX.4.61.0603280737210.21370@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Lifetime of flash memory
Thread-Index: AcZSZunHlM5ECW6rQWCj+5DKNnV+jQ==
References: <20060326162100.9204.qmail@science.horizon.com><4426C320.9010002@yandex.ru><20060327161845.GA16775@csclub.uwaterloo.ca><Pine.LNX.4.61.0603271242100.16721@chaos.analogic.com> <87acbb6vlj.fsf@javad.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Sergei Organov" <s.organov@javad.com>
Cc: "Artem B. Bityutskiy" <dedekind@yandex.ru>, <linux@horizon.com>,
       <kalin@thinrope.net>, <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 27 Mar 2006, Sergei Organov wrote:

> "linux-os \(Dick Johnson\)" <linux-os@analogic.com> writes:
> [...]
>> CompactFlash(tm) like SanDisk(tm) has very good R/W characteristics.
>
> Try to write 512-byte sectors in random order, and I'm sure write
> characteristics won't be that good.
>
>> It consists of a connector that exactly emulates an IDE drive connector
>> in miniature, an interface controller that emulates and responds to
>> most IDE commands, plus a method of performing reads and writes using
>> static RAM buffers and permanent storage in NVRAM.
>
> Are you sure they do have NVRAM? What kind of NVRAM? Do they have backup
> battery inside to keep NVRAM alive?
>

NVRAM means [N]on-[V]olatile-[RAM]. Any of many types, currently NAND flash.
No battery required.

> [...]
>
>> Note that the actual block size is usually 64k, not the 512 bytes of a
>> 'sector'. Apparently, some of the data-space on each block is used for
>> relocation and logical-to-physical mapping.
>
> Wrong. AFAIK, first disks had FLASH with 512b blocks, then next
> generation had 16K blocks, and currently most of cards have 128K
> blocks. Besides, each page of a block (64 pages * 2K for 128K block) has
> additional "system" area of 64 bytes. One thing that is in the system
> area is bad block indicator (2 bytes) to mark some blocks as bad on
> factory, and the rest could be used by application[1] the same way the
> rest of the page is used. So physical block size is in fact 64 * (2048 +
> 64) = 135168 bytes.
>
> Due to FLASH properties, it's a must to have ECC protection of the data
> on FLASH, and AFAIK 22-bits ECC is stored for every 256 bytes of data,
> so part of that extra memory on each page is apparently used for ECC
> storage taking about 24 bytes out of those 64. I have no idea how the
> rest of extra memory is used though.
>

Huh? There is no ECC anywhere nor is it required. The flash RAM is
the same kind of flash used in re-writable BIOS, etc. It requires
that an entire page be erased (all bits set high) because the
write only writes zeros. The write-procedure is a byte-at-a-time
and results in a perfect copy being written for each byte. This
procedure is hidden in devices that emulate hard-disks. The
immediate read/writes are cached in internal static RAM and
an ASIC manages everything so that the device looks like an
IDE drive.

> BTW, the actual block size could be rather easily found from outside, --
> just compare random access write speed against sequential write speed
> using different number of 512b sectors as a write unit. Increase number
> of sectors in a write unit until you get a jump in random access write
> performance, -- that will give you the number of sectors in the block.
>

Huh? The major time is the erase before the physical write, the entire
physical page needs to be erased. That's why there is static-RAM buffering.
It is quite unlikely that you will find a page size using any such
method.

> [1] By application here I mean the code that works inside the CF card
> and deals with the FLASH directly. This memory is invisible from outside
> of CF card.
>
> -- Sergei.
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.15.4 on an i686 machine (5589.42 BogoMips).
Warning : 98.36% of all statistics are fiction, book release in April.
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
