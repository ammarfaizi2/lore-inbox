Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932187AbVHRLJy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932187AbVHRLJy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 07:09:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932188AbVHRLJy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 07:09:54 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:3595 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S932187AbVHRLJy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 07:09:54 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <20050817143534.GC516@openzaurus.ucw.cz>
References: <4300F963.5040905@drzeus.cx> <20050816162735.GB21462@wohnheim.fh-wedel.de> <43021DB8.70909@drzeus.cx> <20050817143534.GC516@openzaurus.ucw.cz>
X-OriginalArrivalTime: 18 Aug 2005 11:09:46.0158 (UTC) FILETIME=[578C54E0:01C5A3E5]
Content-class: urn:content-classes:message
Subject: Re: Flash erase groups and filesystems
Date: Thu, 18 Aug 2005 07:09:04 -0400
Message-ID: <Pine.LNX.4.61.0508180700140.356@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Flash erase groups and filesystems
Thread-Index: AcWj5VeTa703DEOcQRuklKJzMh8j6Q==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Pavel Machek" <pavel@ucw.cz>
Cc: "Pierre Ossman" <drzeus-list@drzeus.cx>,
       =?iso-8859-2?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
       "LKML" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 17 Aug 2005, Pavel Machek wrote:

> Hi!
>
>>> Question came up before, albeit with a different phrasing.  One
>>> possible approach to benefit from this ability would be to create a
>>> "forget" operation.  When a filesystem already knows that some data is
>>> unneeded (after a truncate or erase operation), it will ask the device
>>> to forget previously occupied blocks.
>>>
>>> The device then has the _option_ of handling the forget operation.
>>> Further reads on these blocks may return random data.
>>>
>>> And since noone stepped up to implement this yet, you can still get
>>> all the fame and glory yourself! ;)
>>>
>> I'm not sure we're talking about the same thing. I'm not suggesting new
>> features in the VFS layer. I want to know if something breaks if I
>> implement this erase feature in the MMC layer. In essence the file
>> system has marked the sectors as "forget" by issuing a write to them.
>> The question is if it is assumed that they are unchanged if the write
>> fails half-way through.
>
> Journaling filesystems may not like finding 0xff's all over their journal...
> --

Then they are broken. A file-system can't assume an unwritten block
contains anything of importance. The method of writing these devices
involves erasing a sector, then writing new data. The "commit" can't
have happened until the write succeeds.

Power can fail or the system can crash at any time. The fact that
a write is a two-step process must be hidden from the file-system
code.

Erasing a sector ahead of time is a waste of time. There is no way
that the writer can know that the sector was previously erased except
by reading the whole sector (a waste of time). Some "forget" would
be forgotten after a power failure because one can't write some
"forget" flag to the device except by erasing then writing a
sector.

> 64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.12 on an i686 machine (5537.79 BogoMips).
Warning : 98.36% of all statistics are fiction.
.
I apologize for the following. I tried to kill it with the above dot :

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
