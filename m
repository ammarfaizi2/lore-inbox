Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262738AbVF2XGU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262738AbVF2XGU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 19:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262736AbVF2XGU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 19:06:20 -0400
Received: from magic.adaptec.com ([216.52.22.17]:24217 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S262714AbVF2XD7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 19:03:59 -0400
Message-ID: <42C328D5.7050602@adaptec.com>
Date: Wed, 29 Jun 2005 19:03:49 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@SteelEye.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Greg KH <greg@kroah.com>
Subject: Re: struct class question
References: <42C31268.8010606@adaptec.com> <1120082466.5866.13.camel@mulgrave>
In-Reply-To: <1120082466.5866.13.camel@mulgrave>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Jun 2005 23:02:59.0130 (UTC) FILETIME=[B17E29A0:01C57CFE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/29/05 18:01, James Bottomley wrote:
>>Thus we get the pretty flat sysfs class hierarchy:
>>/sys/class/<if>/<device>
> 
> That's by design.  The class contains a list of all the devices
> implementing the interface.

Ok, makes sense.

> Interface (class) is tied to struct device.  If it doesn't have a struct
> device, then it can't have a class and isn't a proper sysfs leaf.  If

Makes sense.

> the device doesn't exist or it can't be directly controlled, then we
> probably don't need a class for it, right?  As to whether it needs to

Yes, we don't need a struct device and/or struct class_device for it.

> exist at all if we can't do anything with it, I suppose that depends on
> whether it's necessary to the tree representation or not (a bit like
> channels in SCSI.  They have meaning, but no sysfs representation on
> their own).

Very good analogy.  In this respect I think we should represent
phys, ports, and expanders just as the discover process sees them,
in the same way, as you pointed out, channels are represented
even though the do not quite exist (but are an abstraction).

>>/sys/class/sas/
>>/sys/class/sas/ha0/
>>/sys/class/sas/ha1/
>>/sys/class/sas/ha1/phys/
>>/sys/class/sas/ha1/ports/
>>etc.
> 
> 
> No, this is where you go wrong.  The sysfs tree exists under the host<n>
> for scsi (and is parented to the PCI/etc device), so you can have
> something like
> 
> .../host1/
> .../host1/phys/
> .../host1/ports/

Is this

/sys/class/scsi_host/host1

Or is it (e.g.),

/sys/devices/pci0000:00/0000:00:1f.2/host1

?

> (and obviously you need to know where you're putting the targets under
> this).

True.

> So the rich deep tree is under devices and the class tree represents a
> flat look into that for devices implementing the specific interface.

In which case the flat class/ wouldn't represent phys, ports and expanders
as they do not have struct device/struct class_device; and not directly
controlled by the kernel;  just as "channel".

	Luben

