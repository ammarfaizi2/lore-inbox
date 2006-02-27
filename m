Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751226AbWB0O00@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751226AbWB0O00 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 09:26:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751249AbWB0O00
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 09:26:26 -0500
Received: from odyssey.analogic.com ([204.178.40.5]:6416 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1751226AbWB0O0Z convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 09:26:25 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <20060227132848.GA27601@csclub.uwaterloo.ca>
x-originalarrivaltime: 27 Feb 2006 14:26:18.0289 (UTC) FILETIME=[C5EE7A10:01C63BA9]
Content-class: urn:content-classes:message
Subject: Re: o_sync in vfat driver
Date: Mon, 27 Feb 2006 09:26:17 -0500
Message-ID: <Pine.LNX.4.61.0602270909460.4305@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: o_sync in vfat driver
Thread-Index: AcY7qcX42+K8XNcbQASKK/5Ct1tRzg==
References: <op.s5cj47sxj68xd1@mail.piments.com> <op.s5jpqvwhui3qek@mail.piments.com> <op.s5kxhyzgfx0war@mail.piments.com> <op.s5kx7xhfj68xd1@mail.piments.com> <op.s5kya3t0j68xd1@mail.piments.com> <op.s5ky2dbcj68xd1@mail.piments.com> <op.s5ky71nwj68xd1@mail.piments.com> <op.s5kzao2jj68xd1@mail.piments.com> <op.s5lq2hllj68xd1@mail.piments.com> <20060227132848.GA27601@csclub.uwaterloo.ca>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Cc: <col-pepper@piments.com>, <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 27 Feb 2006, Lennart Sorensen wrote:

> On Sun, Feb 26, 2006 at 11:50:40PM +0100, col-pepper@piments.com wrote:
>> Hi,
>>
>> OMG what do I have to do to post here? 10th attempt.
>> {part2}
>>
>> Here is a non-exhaustive list of typical devices types requiring fat vfat
>> support:
>>
>> fd ide-hd scsi-hd usb-hd cdrom usb-hd usb-handheld (iPod, iRiver etc)
>> usb-flash (usbsticks, cameras, some music devices.)
>>
>> IIRC the sync mount option for vfat is ignored for file systems >2G, this
>> effectively (and probably intentionally) excludes nearly all hd partitions
>> and iPod type devices.
>
> I think many people wish it was ignored on smaller devices too given
> what it does to write performance.  And if your device is flash based
> and is one of the ones that doesn't have proper wear leveling the card
> won't last long with sync enabled (even with wear leveling rewriting the
> fat that often as sync seems to do can't be good for the lifespan of the
> flash).
>
> I suspect either vfat should ignore sync all the time, or it should at
> least warn about its use so distributions don't think enabling it on all
> removeable media is a good idea in general.  Or perhaps the vfat driver
> could be made to wait for a file to be closed or at least have some
> timeout before updating the fat table again.  Not sure.
>
> Len Sorensen

I really don't think one needs to worry about this! The flash-file-
system designers know how to minimize wear and spread the wear
throughout the device. It's not up to the file-systems to be
concerned whatsoever! The filesystems need to concern themselves
with the proper implementation of their structural details, nothing
else. Any special device considerations do not belong in the
file-system code. If there are any special device considerations,
they need to be in the device driver, nowhere else.

BYW, even the drivers can't effectively compensate for any
potential wear because they don't know where the physical
write will occur. The physical sectors (pages) of many of
these devices are 64k. All of the access, both read and
write, is buffered in read/write static RAM. It's only
when the disk emulator of the FlashRAM decides that the
static RAM needs to be flushed to flash, that the write
actually occurs. Typically, a LRU 64k page is erased
and re-written. Then a table is updated to reference the
new correct block. This is all transparent, and it
needs to be, because erasing a 64k block takes nearly
a second! Without the buffering, write performance
would be unacceptable.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.15.4 on an i686 machine (5589.53 BogoMips).
Warning : 98.36% of all statistics are fiction, book release in April.
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
