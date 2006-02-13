Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932336AbWBMTWl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932336AbWBMTWl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 14:22:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932418AbWBMTWl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 14:22:41 -0500
Received: from spirit.analogic.com ([204.178.40.4]:62216 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP id S932336AbWBMTWk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 14:22:40 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <43F0D7AD.8050909@bfh.ch>
X-OriginalArrivalTime: 13 Feb 2006 19:22:34.0876 (UTC) FILETIME=[D7D1E3C0:01C630D2]
Content-class: urn:content-classes:message
Subject: Re: RFC: disk geometry via sysfs
Date: Mon, 13 Feb 2006 14:22:34 -0500
Message-ID: <Pine.LNX.4.61.0602131410400.17242@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: RFC: disk geometry via sysfs
thread-index: AcYw0tfblOw7jIPuQUqj3Mj2gJoAdA==
References: <43EC8FBA.1080307@bfh.ch> <43F0B484.3060603@cfl.rr.com> <43F0D7AD.8050909@bfh.ch>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Seewer Philippe" <philippe.seewer@bfh.ch>
Cc: "Phillip Susi" <psusi@cfl.rr.com>, <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 13 Feb 2006, Seewer Philippe wrote:

>
>
> Phillip Susi wrote:
>> Seewer Philippe wrote:
>>
>>> Hello all!
>>>
>>> I don't want to start another geometry war, but with the introduction of
>>> the general getgeo function by Christoph Hellwig for all disks this
>>> simply would become a matter of extending the basic gendisk block driver.
>>>
>>> There are people out there (like me) who need to know about disk
>>> geometry. But since this is clearly post 2.6.16 I prefer to ask here
>>> before writing a patch...
>>>
>>
>>
>> Why do you need to know about geometry?  Geometry is a useless fiction
>> that only still exists in PC system BIOS for the sake of backward
>> compatibility with software that was originally designed to operate with
>> MFM and RLL disks that actually used geometric addressing.  These days
>> there is no such thing; it's just made up by the bios.
>
> ...Thats why I said i didn't want to start another geometry war. But
> then again, I did write RFC too, yes?
>
> Yes, geometry is a fiction. And a bad one at that. To be honest I'd
> rather get rid of it completely. But you said it: The geometry still
> exists for the sake of backward compatibility. If it is still there, why
> not export it? That's what sysfs is for...
>
> Additionally have a look at libata-scsi.c which is part of the SATA
> implementation. Theres CHS code in there...
>
> Personally I want the geometry information in sysfs because debugging
> partition tables not written by linux tools becomes just that tad more
> easier...
>

You can make your own:

Pretend a sector is 512 bytes.
Use the maximum number of cylinders of either 65535 or 1024
Use the maximum number of sectors up to 255
Use the maxumum number of heads up to 255


Try the above with 1024 cylinders first. If it doesn't fit, use
65535. That's all the BIOS does. It's just used to fit the
stuff into registers for 16-bit BIOS calls (see int 0x13).

>>
>>> Q1: Yes or No?
>>> If no, the other questions do not apply
>>>
>>> Q2: Where under sysfs?
>>> Either do /sys/block/hdx/heads, /sys/block/hdx/sectors, etc. or should
>>> there be a new sub-object like /sys/block/hdx/geometry/heads?
>>>
>>
>>
>> This is not suitable because block devices may not be bios accessible,
>> and thus, nowhere to get any bogus geometry information from.  Even if
>> it is, do we really want to be calling the bios to get this information
>> and keep it around?
> I did not say I'd implement it for _all_ devices. In fact I indent to
> make geometry available only for devices whose drivers provide the
> getgeo function.
>
>>
>>> Q3: Writable?
>>> Under some (weird) circumstances it would actually be quite nice to
>>> overwrite the kernels idea of a disks geometry. This would require a
>>> general function like setgeo. Acceptable?
>>>
>>>
>>
>>
>> What for?  The only purpose to geometry is bios compatibility.  Changing
>> the kernel's copy of the values won't do any good because the bios won't
>> be changed.
>
>
> Exactly. I don't want the kernel to fix BIOS problems. But i want to
> give userland the opportunity to overwrite what the kernel thinks (as in
> /proc/ide/hdx/settings).
> One example where this might be usable is connecting a PATA drive using
> an Adapter to SATA. PATA returns the drive's geometry. SATA defaults to
> x/255/63...
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.66 BogoMips).
Warning : 98.36% of all statistics are fiction.
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
