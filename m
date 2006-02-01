Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030371AbWBANxW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030371AbWBANxW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 08:53:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932457AbWBANxW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 08:53:22 -0500
Received: from odyssey.analogic.com ([204.178.40.5]:25604 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S932453AbWBANxW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 08:53:22 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <7d40d7190602010537i3f10b722h@mail.gmail.com>
X-OriginalArrivalTime: 01 Feb 2006 13:53:18.0297 (UTC) FILETIME=[DB062C90:01C62736]
Content-class: urn:content-classes:message
Subject: Re: Right way to configure a driver? (sysfs, ioctl, proc, configfs,....)
Date: Wed, 1 Feb 2006 08:53:17 -0500
Message-ID: <Pine.LNX.4.61.0602010849100.15638@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Right way to configure a driver? (sysfs, ioctl, proc, configfs,....)
Thread-Index: AcYnNtsPM8BhsWUoRiunDolEXl5cJA==
References: <7d40d7190601261206wdb22ccck@mail.gmail.com> <20060127050109.GA23063@kroah.com> <7d40d7190601270230u850604av@mail.gmail.com> <20060130214118.GB26463@kroah.com> <7d40d7190602010537i3f10b722h@mail.gmail.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Aritz Bastida" <aritzbastida@gmail.com>
Cc: "Greg KH" <greg@kroah.com>, <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 1 Feb 2006, Aritz Bastida wrote:

>>> 3.- Actually the most difficult config I must do is to pass three
>>> values from userspace to my module. Specifically two integers and a
>>> long (it's an offset to a memory zone I've previously defined)
>>>
>>> struct meminfo {
>>>         unsigned int      id;         /* segment identifier */
>>>         unsigned int      size;     /* size of the memory area */
>>>         unsigned long   offset;   /* offset to the information */
>>> };
>>>
>>> How would you pass this information in sysfs? Three values in the same
>>> file? Note that using three different files wouldn't be atomic, and I
>>> need atomicity.
>>
>> Use configfs.
>>
>
> Ummhh, and would it be correct to configure my device via a netlink
> socket? Remember that my driver is a kind of network "virtual" device.
>
> There are so many old and new ways to configure a driver that I'm a
> bit overwhelmed...
>
> Regards
> Aritz

At the risk of the obvious....

 	struct meminfo meminfo;
         ioctl(fd, UPDATE_PARAMS, &meminfo);

... and define UPDATE_PARAMS and other function codes to start
above those normally used by kernel stuff so that `strace` doesn't
make up stories.

This is what the ioctl() interface is for. Inside the kernel
you can use spinlocks (after you got the data from user-space)
to make the operations atomicc.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.66 BogoMips).
Warning : 98.36% of all statistics are fiction.
_
To unsubscribe


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
