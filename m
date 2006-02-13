Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964796AbWBMTDh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964796AbWBMTDh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 14:03:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964787AbWBMTDh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 14:03:37 -0500
Received: from mr1.bfh.ch ([147.87.250.50]:1768 "EHLO mr1.bfh.ch")
	by vger.kernel.org with ESMTP id S964791AbWBMTDf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 14:03:35 -0500
thread-index: AcYw0Cqof9uA3zwsQYOlDS8QtqXE5Q==
X-PMWin-Version: 2.5.0e, Antispam-Engine: 2.2.0.0, Antivirus-Engine: 2.32.10
Content-Class: urn:content-classes:message
Importance: normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.1830
Message-ID: <43F0D7AD.8050909@bfh.ch>
Date: Mon, 13 Feb 2006 20:02:05 +0100
From: "Seewer Philippe" <philippe.seewer@bfh.ch>
Organization: BFH
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050811)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Phillip Susi" <psusi@cfl.rr.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: RFC: disk geometry via sysfs
References: <43EC8FBA.1080307@bfh.ch> <43F0B484.3060603@cfl.rr.com>
In-Reply-To: <43F0B484.3060603@cfl.rr.com>
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Feb 2006 19:02:09.0209 (UTC) FILETIME=[FD43F290:01C630CF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Phillip Susi wrote:
> Seewer Philippe wrote:
> 
>> Hello all!
>>
>> I don't want to start another geometry war, but with the introduction of
>> the general getgeo function by Christoph Hellwig for all disks this
>> simply would become a matter of extending the basic gendisk block driver.
>>
>> There are people out there (like me) who need to know about disk
>> geometry. But since this is clearly post 2.6.16 I prefer to ask here
>> before writing a patch...
>>   
> 
> 
> Why do you need to know about geometry?  Geometry is a useless fiction
> that only still exists in PC system BIOS for the sake of backward
> compatibility with software that was originally designed to operate with
> MFM and RLL disks that actually used geometric addressing.  These days
> there is no such thing; it's just made up by the bios.

...Thats why I said i didn't want to start another geometry war. But
then again, I did write RFC too, yes?

Yes, geometry is a fiction. And a bad one at that. To be honest I'd
rather get rid of it completely. But you said it: The geometry still
exists for the sake of backward compatibility. If it is still there, why
not export it? That's what sysfs is for...

Additionally have a look at libata-scsi.c which is part of the SATA
implementation. Theres CHS code in there...

Personally I want the geometry information in sysfs because debugging
partition tables not written by linux tools becomes just that tad more
easier...

> 
>> Q1: Yes or No?
>> If no, the other questions do not apply
>>
>> Q2: Where under sysfs?
>> Either do /sys/block/hdx/heads, /sys/block/hdx/sectors, etc. or should
>> there be a new sub-object like /sys/block/hdx/geometry/heads?
>>   
> 
> 
> This is not suitable because block devices may not be bios accessible,
> and thus, nowhere to get any bogus geometry information from.  Even if
> it is, do we really want to be calling the bios to get this information
> and keep it around?
I did not say I'd implement it for _all_ devices. In fact I indent to
make geometry available only for devices whose drivers provide the
getgeo function.

> 
>> Q3: Writable?
>> Under some (weird) circumstances it would actually be quite nice to
>> overwrite the kernels idea of a disks geometry. This would require a
>> general function like setgeo. Acceptable?
>>
>>   
> 
> 
> What for?  The only purpose to geometry is bios compatibility.  Changing
> the kernel's copy of the values won't do any good because the bios won't
> be changed.


Exactly. I don't want the kernel to fix BIOS problems. But i want to
give userland the opportunity to overwrite what the kernel thinks (as in
/proc/ide/hdx/settings).
One example where this might be usable is connecting a PATA drive using
an Adapter to SATA. PATA returns the drive's geometry. SATA defaults to
x/255/63...
