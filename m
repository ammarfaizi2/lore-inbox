Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030190AbWFAPJu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030190AbWFAPJu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 11:09:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030191AbWFAPJt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 11:09:49 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:787 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1030190AbWFAPJs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 11:09:48 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-OriginalArrivalTime: 01 Jun 2006 15:09:46.0879 (UTC) FILETIME=[6B9A38F0:01C6858D]
Content-class: urn:content-classes:message
Subject: Re: USB devices fail unnecessarily on unpowered hubs
Date: Thu, 1 Jun 2006 11:09:46 -0400
Message-ID: <Pine.LNX.4.61.0606011104140.1745@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.44L0.0606011050330.6784-100000@iolanthe.rowland.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: USB devices fail unnecessarily on unpowered hubs
Thread-Index: AcaFjWujvtGSGlSBTNuAnIXbJyrhaQ==
References: <Pine.LNX.4.44L0.0606011050330.6784-100000@iolanthe.rowland.org>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Alan Stern" <stern@rowland.harvard.edu>
Cc: "Andrew Morton" <akpm@osdl.org>, "David Liontooth" <liontooth@cogweb.net>,
       <linux-kernel@vger.kernel.org>, <linux-usb-devel@lists.sourceforge.net>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 1 Jun 2006, Alan Stern wrote:

> On Thu, 1 Jun 2006, Andrew Morton wrote:
>
>> On Thu, 01 Jun 2006 02:18:20 -0700
>> David Liontooth <liontooth@cogweb.net> wrote:
>>
>>> Starting with 2.6.16, some USB devices fail unnecessarily on unpowered
>>> hubs. Alan Stern explains,
>>>
>>> "The idea is that the kernel now keeps track of USB power budgets.  When a
>>> bus-powered device requires more current than its upstream hub is capable
>>> of providing, the kernel will not configure it.
>>>
>>> Computers' USB ports are capable of providing a full 500 mA, so devices
>>> plugged directly into the computer will work okay.  However unpowered hubs
>>> can provide only 100 mA to each port.  Some devices require (or claim they
>>> require) more current than that.  As a result, they don't get configured
>>> when plugged into an unpowered hub."
>>>
>>> http://www.mail-archive.com/linux-usb-devel@lists.sourceforge.net/msg43480.html
>>>
>>> This is generating a lot of grief and appears to be unnecessarily
>>> strict. Common USB sticks with a MaxPower value just above 100mA, for
>>> instance, typically work fine on unpowered hubs supplying 100mA.
>>>
>>> Is a more user-friendly solution possible? Could the shortfall
>>> information be passed to udev, which would allow rules to be written per
>>> device?
>
> I'm not sure whether we create a udev event when a new USB device is
> connected.  If we don't, we certainly could.  Although this event wouldn't
> contain information about the power budget shortfall, it would contain
> vendor and product IDs.  These would be sufficiently specific for a custom
> udev script to install the desired configuration.
>
>> Yes, it sounds like we're being non-real-worldly here.  This change
>> apparently broke things.  Did it actually fix anything as well?
>
> Yes.  At least, I think so.  The change directly addresses a complaint
> filed here:
>
> http://marc.theaimsgroup.com/?l=linux-usb-users&m=112438431718562&w=2
>
> I haven't checked back with the original poster to make sure that his
> problem has been solved, but presumably it has been.
>
> As an alternative, we could allow an "over-budget window" of say 10%.
> Configurations that exceed the power budget by less than that amount would
> still be accepted.  I don't know whether this would be enough of a help,
> however.  I've heard of devices that claim to require 200 mA, for
> instance.  It just doesn't seem right to enable them when the upstream hub
> can only provide 100 mA.
>
> Alan Stern
>

Many, most, perhaps all such devices don't take more power when they
are "enabled". Everything is already running and sucking up maximum
current when you plug it in! If the motherboard didn't smoke when
the device was plugged in, you might just as well let the user use
it! Perhaps a ** WARNING ** message somewhere, but by golly, they
got it running or else you wouldn't be able to read its parameters.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.4 on an i686 machine (5592.73 BogoMips).
New book: http://www.AbominableFirebug.com/
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
