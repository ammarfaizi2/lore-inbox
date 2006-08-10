Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161411AbWHJQQY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161411AbWHJQQY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 12:16:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161415AbWHJQQY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 12:16:24 -0400
Received: from mga01.intel.com ([192.55.52.88]:10763 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1161411AbWHJQQX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 12:16:23 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.08,111,1154934000"; 
   d="scan'208"; a="114625676:sNHT2389076550"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH 2/2] acpi,backlight: MSI S270 laptop support - driver
Date: Thu, 10 Aug 2006 12:15:52 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB60133DB99@hdsmsx411.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 2/2] acpi,backlight: MSI S270 laptop support - driver
Thread-Index: Aca8cqvA6jfgfYhbRPuqT3Yy7BurHQAI1Vqw
From: "Brown, Len" <len.brown@intel.com>
To: "Lennart Poettering" <mzxreary@0pointer.de>
Cc: <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>
X-OriginalArrivalTime: 10 Aug 2006 16:15:54.0903 (UTC) FILETIME=[41A52270:01C6BC98]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>If you look closely you'll see that the patch already adds a new
>entry to MAINTAINERS.

Excellent.

>I put the the driver in drivers/acpi/ because it relies heavily on the
>ACPI EC stuff. But OK, what is a better place for the driver? 

It is possible that parts of it should live in different places,
but I agree that it is also desireable to keep the compnents of a
platform
specific driver together in as few files as possible.

>drivers/char/ 
>  It doesn't even register any character device.

I believe that is okay, and that creating a /dev file isn't a
requirement.

>drivers/video/backlight/
>  It doesn't just do backlight control.

Perhaps the backlight part should live there.

>drivers/misc/
>  Seems to be the last resort for everything that doesn't fit it
>  otherwise.
>
>Unless anyone has a better idea I will move it to drivers/misc/, then.

Yeah, there is probably a better place than misc.

The only thing I can say for sure is that it implements
platform-dependent
features rather than standard features in the ACPI spec,
and thus it must live outside of drivers/acpi/.

>> lcd brightness platform support should talk to the existing
>> backlight stuff under sysfs.
>
>It already does exactly that, you can find the backlight class driver
>in /sys/class/backlight/s270/.

Excellent.

>I cannot map the "automatic brightness control" feature to the
>backlight class driver, that's why I duplicated the brightness stuff
>in /proc/acpi/s270/.

Better to extend the backlight code so that it can handle the
special features of this platform than to duplicate brightness
control in multiple places.

>> wlan and bluetooth indicators/controls need to appear under
>> generic places under sysfs -- not under platform specific
>> files under /proc/acpi.
>
>What are those "generic" places? I cannot think of any besides a
>"platform" device.

They should appear as properties under their associated
devices in /sys/devices tree rather than invening a new place.

>Any ideas on that ec_transaction() patch I sent earlier?

I agree 100% that ec.c needs to be whacked.  Unfortunately
there seem to be 3 people doing it at the same time,
so we'll have to sort that out.

thanks,
-Len

ps. Lennart, please understand that I didn't intend to be gruff.
I figured that by the quality of your work -- which is better than most
--
that I'd go for an immediate reply, even though I was still holding a
sharp pointed stick at the end of a 6-hour bug scrub marathon.
