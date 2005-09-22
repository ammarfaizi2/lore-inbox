Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030450AbVIVRW0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030450AbVIVRW0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 13:22:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030455AbVIVRW0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 13:22:26 -0400
Received: from spirit.analogic.com ([204.178.40.4]:9734 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1030450AbVIVRW0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 13:22:26 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <4332E3F5.3040905@yandex.ru>
References: <432817FF.10307@yandex.ru> <4329251C.7050102@mw-itcon.de> <4329288B.8050909@yandex.ru> <43292AC6.40809@mw-itcon.de> <43292E16.70401@yandex.ru> <43292F91.9010302@mw-itcon.de> <432FE1EF.9000807@yandex.ru> <432FEF55.5090700@mw-itcon.de> <433006D8.4010502@yandex.ru> <20050920133244.GC4634@wohnheim.fh-wedel.de> <20050921190759.GC467@openzaurus.ucw.cz>            <43328C07.9070001@yandex.ru> <200509221646.j8MGkYo3017314@turing-police.cc.vt.edu> <4332E3F5.3040905@yandex.ru>
X-OriginalArrivalTime: 22 Sep 2005 17:22:19.0730 (UTC) FILETIME=[2FC5FB20:01C5BF9A]
Content-class: urn:content-classes:message
Subject: Re: data loss on jffs2 filesystem on dataflash
Date: Thu, 22 Sep 2005 13:22:18 -0400
Message-ID: <Pine.LNX.4.61.0509221306350.4631@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: data loss on jffs2 filesystem on dataflash
Thread-Index: AcW/mi/P+1rw+qikQuC4IJBWe7DPWw==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Artem B. Bityutskiy" <dedekind@yandex.ru>
Cc: <Valdis.Kletnieks@vt.edu>, "Pavel Machek" <pavel@ucw.cz>,
       "J Engel" <joern@wohnheim.fh-wedel.de>,
       "Peter Menzebach" <pm-mtd@mw-itcon.de>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 22 Sep 2005, Artem B. Bityutskiy wrote:

> Valdis.Kletnieks@vt.edu wrote:
>> On Thu, 22 Sep 2005 14:48:39 +0400, "Artem B. Bityutskiy" said:
>>
>>> Joern meant that if HDD starts a block write operation, it will
>>> accomplish it even if power-fail happens (probably there are some
>>> capacitors there). So, it is impossible, say, that HDD has written one
>>> half of a sector and has not written the other half.
>>
>> Hard drives contain capacitors to prevent writing of runt sectors on
>> a powerfail?  Didn't we go around this a while ago and decide it's mostly
>> urban legend, and that plenty of people have seen runt/bad sectors?
>
> No idea. But theoretically it should be so, at least "good" drives
> should. May be a competent person will comment on this, that's quite
> interesting.
>
> --
> Best Regards,
> Artem B. Bityuckiy,
> St.-Petersburg, Russia.

The only significant energy storage that hard disks contain
is the inertia of the rotating disk assembly. Since the platter
motor is not a generator it doesn't help. Those tiny bypass
capacitors you see can't store enough energy to do anything
useful during a power failure.

BUT... The PC/AT power supplies store a lot of energy and
they run for many milliseconds after a power fail.
2-100 uF in series = 50 uF @ 300 v.
J = 1/2 CV^2

J = 50uF * 300^2 / 2 =  2.25 joules (lots of energy).

If the power-fail line is properly connected and if the
power fail line operates at the correct time, the CPU
will be halted while there is still enough energy available
to complete any write that has gotten to the disk-drives sector
buffer. This does not protect data, but it should certainly
protect the sectors which might now contain header, good data
or junk, and a proper CRC. IOW a good sector.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13 on an i686 machine (5589.55 BogoMips).
Warning : 98.36% of all statistics are fiction.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
