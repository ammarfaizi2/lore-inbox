Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750762AbWC1I7W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750762AbWC1I7W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 03:59:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750992AbWC1I7W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 03:59:22 -0500
Received: from javad.com ([216.122.176.236]:52236 "EHLO javad.com")
	by vger.kernel.org with ESMTP id S1750723AbWC1I7W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 03:59:22 -0500
From: Sergei Organov <osv@javad.com>
To: "Magnus Damm" <magnus.damm@gmail.com>
Cc: "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       "Artem B. Bityutskiy" <dedekind@yandex.ru>, linux@horizon.com,
       kalin@thinrope.net, linux-kernel@vger.kernel.org
Subject: Re: Lifetime of flash memory
References: <20060326162100.9204.qmail@science.horizon.com>
	<4426C320.9010002@yandex.ru>
	<20060327161845.GA16775@csclub.uwaterloo.ca>
	<Pine.LNX.4.61.0603271242100.16721@chaos.analogic.com>
	<87acbb6vlj.fsf@javad.com>
	<aec7e5c30603272241n5c07aa0csd52b237aaaeb30d6@mail.gmail.com>
Date: Tue, 28 Mar 2006 12:58:54 +0400
In-Reply-To: <aec7e5c30603272241n5c07aa0csd52b237aaaeb30d6@mail.gmail.com>
	(Magnus Damm's message of "Tue, 28 Mar 2006 15:41:53 +0900")
Message-ID: <87zmjb54j5.fsf@javad.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Magnus Damm" <magnus.damm@gmail.com> writes:

> On 3/28/06, Sergei Organov <s.organov@javad.com> wrote:
>> "linux-os \(Dick Johnson\)" <linux-os@analogic.com> writes:
>> > Note that the actual block size is usually 64k, not the 512 bytes of a
>> > 'sector'. Apparently, some of the data-space on each block is used for
>> > relocation and logical-to-physical mapping.
>>
>> Wrong. AFAIK, first disks had FLASH with 512b blocks, then next
>> generation had 16K blocks, and currently most of cards have 128K
>> blocks. Besides, each page of a block (64 pages * 2K for 128K block) has
>> additional "system" area of 64 bytes. One thing that is in the system
>> area is bad block indicator (2 bytes) to mark some blocks as bad on
>> factory, and the rest could be used by application[1] the same way the
>> rest of the page is used. So physical block size is in fact 64 * (2048 +
>> 64) = 135168 bytes.
>
> Doesn't this depend on if we are talking about NOR or NAND memory? It
> looks like you are describing some kind of NAND memory. Also I guess
> it varies with manufacturer.

Yes, I talk about NAND FLASH as I've never seen CF cards based on NOR FLASH,
-- NOR FLASH write times and capacities are just too poor, I think.

> When it comes to CF the internal block size doesn't really matter
> because the CF controller will hide it for you. The controller will
> perform some kind of mapping between the 512 byte based IDE-interface
> and it's internal sector size. This together with wear levelling.

Yes, it will, but it can't entirely hide internal block size from you,
-- just compare write times for random access against write times for
sequential access. Old SanDisk CF cards based on NAND FLASH with 512b
blocks had these times roughly the same, and all recent CF cards that
I've tested have very big difference.

-- Sergei.
