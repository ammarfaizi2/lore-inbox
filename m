Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161029AbWBAPLQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161029AbWBAPLQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 10:11:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161079AbWBAPLQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 10:11:16 -0500
Received: from odyssey.analogic.com ([204.178.40.5]:38416 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1161029AbWBAPLP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 10:11:15 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <7d40d7190602010619g20be73c5k@mail.gmail.com>
X-OriginalArrivalTime: 01 Feb 2006 15:11:12.0303 (UTC) FILETIME=[BCF2E3F0:01C62741]
Content-class: urn:content-classes:message
Subject: Re: Right way to configure a driver? (sysfs, ioctl, proc, configfs,....)
Date: Wed, 1 Feb 2006 10:11:11 -0500
Message-ID: <Pine.LNX.4.61.0602010959580.16044@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Right way to configure a driver? (sysfs, ioctl, proc, configfs,....)
Thread-Index: AcYnQbz8zNoy62LOQLCk1NdO3txeJw==
References: <7d40d7190601261206wdb22ccck@mail.gmail.com> <20060127050109.GA23063@kroah.com> <7d40d7190601270230u850604av@mail.gmail.com> <20060130214118.GB26463@kroah.com> <7d40d7190602010537i3f10b722h@mail.gmail.com> <Pine.LNX.4.61.0602010849100.15638@chaos.analogic.com> <7d40d7190602010619g20be73c5k@mail.gmail.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Aritz Bastida" <aritzbastida@gmail.com>
Cc: "Greg KH" <greg@kroah.com>, <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 1 Feb 2006, Aritz Bastida wrote:

> Hi!
>
>> At the risk of the obvious....
>>
>>         struct meminfo meminfo;
>>          ioctl(fd, UPDATE_PARAMS, &meminfo);
>>
>> ... and define UPDATE_PARAMS and other function codes to start
>> above those normally used by kernel stuff so that `strace` doesn't
>> make up stories.
>>
>> This is what the ioctl() interface is for. Inside the kernel
>> you can use spinlocks (after you got the data from user-space)
>> to make the operations atomicc.
>>
>
> Well, actually that's more or less what I had done before, and it
> worked. I had a group of ioctl commands for configuring my device. The
> command number was based on an unusded "magic number", as I was told
> when reading Linux Device Drivers 3rd:
>
> #define SCULL_IOCSQUANTUM _IOW(SCULL_IOC_MAGIC,  1, int)
> #define SCULL_IOCSQSET        _IOW(SCULL_IOC_MAGIC,  2, int)
>

This is not good. If you change your kernel, you would have to
recompile your applications as well. The ioctl() command value
needs to be a constant that doesn't change when kernel headers
change.

> This actually works, but it doesnt seem to be "ellegant" code for new
> drivers in 2.6. Or at least that's what it says in LDD3, since the
> ioctls are system wide, unstructured, and so on.
>

Ioctls() contain a unique file-descriptor that means it's for your
device only, not something "system wide". I noticed some bugs with
some kernel version where all ioctls seemed to be treated the same
like a function meant for my device could actually do something
to a terminal. If this still exists, it's a bug. I don't know
if these bugs still exist.

> That's why I was asking for a more ellegant and cleaner configuration
> method. It seems that the new filesystem "configfs" is perfect for
> that, but I would like to know if netlink sockets can also be used for
> that purpose (as I'm writing a kind of network device).
>

Well ellegant isn't necessarily better, just different. The writers
of sysfs want you to use their interface, the writers of xxxfs
want you to use their interface,... etc. Ioctls are forever.
They will exist as long as there is a kernel. Even network
manipulating things like ethtool, ifconfig, and route use
ioctls.

> Thank you anyway
> Regards
>
> Aritz
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.66 BogoMips).
Warning : 98.36% of all statistics are fiction.
_
To unsubscribe


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
