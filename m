Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268963AbUIBUfh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268963AbUIBUfh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 16:35:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269035AbUIBU3S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 16:29:18 -0400
Received: from scl-ims.phoenix.com ([216.148.212.222]:10958 "EHLO
	scl-ims.phoenix.com") by vger.kernel.org with ESMTP id S269021AbUIBU0g convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 16:26:36 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] Early USB handoff
Date: Thu, 2 Sep 2004 13:26:35 -0700
Message-ID: <5F106036E3D97448B673ED7AA8B2B6B3016ADED2@scl-exch2k.phoenix.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] Early USB handoff
Thread-Index: AcSRJXCX8PkqXjNLTZSJLdLmqV3qhQAAmaJg
From: "Aleksey Gorelov" <Aleksey_Gorelov@Phoenix.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: "Pete Zaitcev" <zaitcev@redhat.com>,
       "David Brownell" <david-b@pacbell.net>,
       <linux-usb-devel@lists.sourceforge.net>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 02 Sep 2004 20:26:36.0291 (UTC) FILETIME=[24F58D30:01C4912B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>   Basically, in a case of legacy free BIOS, HC is not in 
>> SMM mode, and USB IRQ is routed to PCI IRQ line and generates
>> interrupts. When this IRQ is enabled in PIC (by driver that 
>> starts before HC driver), system is flooded with interrupts.
>
>The BIOS should not be leaving the device generating 
>interrupts surely ?
>If that IRQ line ends up shared we are in trouble at boot time. 
  Well, this is what happened on Motion tablet.
  While still in real mode, BIOS takes care of interrupts from 
devices. But once OS takes control over and goes to protected 
mode, there is no easy way for BIOS to detect that and disable HC.
So, one should either avoid 'sharing' it with other devices (at
IRQ routing stage), or reprogram HC in native OS mode first (at 
least disable interrupts).

>We don't always want to hand off. Some setups only work in USB legacy
>mode because of other bugs. That's why the SMM fixup I did for E750x is
>triggered in specific cases. We can do such things with DMI table
>blacklists easily enough.
  I was not aware of this. However, there is an option and handoff
is disabled by default. DMI table may be Ok if there are only 
a few such machines. Unfortunately, I personally had USB legacy 
problems on several laptops, plus saw some reports on the web.
But I guess it is not for me to decide ;)

Aleks.

