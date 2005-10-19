Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751290AbVJSUJU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751290AbVJSUJU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 16:09:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751294AbVJSUJU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 16:09:20 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:43016 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1751290AbVJSUJT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 16:09:19 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <1129741246.25383.23.camel@gnupooh.mitre.org>
References: <1129741246.25383.23.camel@gnupooh.mitre.org>
X-OriginalArrivalTime: 19 Oct 2005 20:09:17.0717 (UTC) FILETIME=[FC1CBC50:01C5D4E8]
Content-class: urn:content-classes:message
Subject: Re: 26 ways to set a device driver variable from userland
Date: Wed, 19 Oct 2005 16:09:17 -0400
Message-ID: <Pine.LNX.4.61.0510191603160.5489@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 26 ways to set a device driver variable from userland
Thread-Index: AcXU6Pwjilj+almeQ9609v7D/cN6bg==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Rick Niles" <fniles@mitre.org>
Cc: <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 19 Oct 2005, Rick Niles wrote:

> There are so many ways to set a configuration value in a device driver. I'm wondering
> which are "recommended" methods. I'm looking for some sort of guidance when writing a
> new driver.  I kinda assume this is a FAQ, but I didn't see it anyway, maybe it should
> be added to the FAQ.
>
> OK there might not be 26 ways, but there's a few major ones. I'm thinking in term of
> char devices so some of these might not apply to block and network drivers.
>
> (1) ioctl, probably the oldest.
> (2) use read/write to a special configuration-only /dev file (e.g. /dev/dvb)
> (3) /proc filesystem
> (4) sysfs
> (5) module load-time command line options.
>
> I understand that flexibility is a good thing, but some guidance would be helpful.
>
> I sorta got the idea that /proc is "out" this year and sysfs is the "in" thing, but
> what about the others?  Would you say that (2) should be be discouraged?  Did anyone
> tell the DVB people that? Or maybe more is better, that is, a good driver should
> allow for ALL of the above! (OK, yeah that was flame bait.)  Should EVERY variable
> that can be modified by say sysfs also be settable by insmod command line?
>
> Any guidance would be greatly appreciated,
> Rick Niles.
>

There is no question that ioctl() will always exist. You will never
have a problem compiling your module when Linux-99.99 rolls out
in the year 2054. That said, you want to start your ioctl control
values above anything the kernel uses and return -ENOTTY for anything
out of range. This will allow somebody to do `od /dev/YourDevice` without
breaking your device!


Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.55 BogoMips).
Warning : 98.36% of all statistics are fiction.
.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
