Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261743AbVGZFrE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261743AbVGZFrE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 01:47:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261738AbVGZFrB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 01:47:01 -0400
Received: from fmr16.intel.com ([192.55.52.70]:49583 "EHLO
	fmsfmr006.fm.intel.com") by vger.kernel.org with ESMTP
	id S261743AbVGZFpJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 01:45:09 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: fix suspend/resume irq request free for yenta..
Date: Tue, 26 Jul 2005 01:44:42 -0400
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B300424AE38@hdsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: fix suspend/resume irq request free for yenta..
Thread-Index: AcWPWjR2Mu+QWW5URgef4yOCzgIyigCSfYSg
From: "Brown, Len" <len.brown@intel.com>
To: "Russell King" <rmk+lkml@arm.linux.org.uk>, "Pavel Machek" <pavel@ucw.cz>
Cc: "Dmitry Torokhov" <dtor_core@ameritech.net>,
       <linux-kernel@vger.kernel.org>, "Dave Airlie" <airlied@linux.ie>,
       "Li, Shaohua" <shaohua.li@intel.com>
X-OriginalArrivalTime: 26 Jul 2005 05:44:45.0325 (UTC) FILETIME=[20A51BD0:01C591A5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>On Sat, Jul 23, 2005 at 02:29:24AM +0200, Pavel Machek wrote:
>> > Is it necessary to do free_irq for suspend? Shouldn't disable_irq
>> > be enough?
>> 
>> Due to recent changes in ACPI, yes, it is neccessary.
>
>What if some other driver is sharing the IRQ, and requires IRQs to be
>enabled for the resume to complete?

IRQ sharing is an excellent example, not a counter-example,
of why it is necessary to disable devices and free IRQs
on suspend, and acquire them again on resume.

eg. if a device is suspended, but the hardware still causes
an interrupt on a shared IRQ, another device can
suffer a screaming IRQ failure.

Documentation/power/pci.txt has as much as we know about
how to address this -- but I'm certainly open to suggestions
on how to be less invasive to the drivers while having some
chance of being robust.

thanks,
-Len

