Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263338AbRFCQHB>; Sun, 3 Jun 2001 12:07:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263475AbRFCQBr>; Sun, 3 Jun 2001 12:01:47 -0400
Received: from mta1.snfc21.pbi.net ([206.13.28.122]:58568 "EHLO
	mta1.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S263452AbRFCQB3>; Sun, 3 Jun 2001 12:01:29 -0400
Date: Sun, 03 Jun 2001 09:00:24 -0700
From: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-usb-devel] *BAD* impact of usb on PCI performance
To: Linux usb mailing list <linux-usb-devel@lists.sourceforge.net>,
        kernel list <linux-kernel@vger.kernel.org>
Message-id: <013e01c0ec46$4d3727a0$6800000a@brownell.org>
MIME-version: 1.0
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
Content-type: text/plain; charset="iso-8859-1"
Content-transfer-encoding: 7bit
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
In-Reply-To: <20010602132200.A186@bug.ucw.cz>
X-Priority: 3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: "Georg Acher" <acher@in.tum.de>
> On Sat, Jun 02, 2001 at 01:22:00PM +0200, Pavel Machek wrote:
> > 
> > With Acher's uhci, even ifconfig up of usb-to-usb networking device
> > [plusb handled by generic usb-to-usb driver; see -ac series].
> > does 50% slowdown. When fsbr is being used, systems slows down by 350%
> 
> Hm, the 50% make me curious... have to look what's happening...

For PL-2301/2302 devices, "ifconfig up" is mostly just posting a bulk read.
True with both "usbnet" and its (now obsolete) predecessor drivers "plusb"
and (for different devices) "net1080".

Laplink-style cables can often support another mode (poll via USB "interrupts",
and then issue reads only when data is available) but not every device can work
that way (like, I seem to recall, an iPaq PDA).  And that'd increase the latency
per packet by a couple milliseconds, even when it's possible.


> > (running more than 4 times slower than normally. Ouch).
> 
> Blame Intel. Either low latency or low PCI usage, you can choose...

This problem is UHCI-specific, not USB-generic, yes?
Doesn't happen with OHCI?

- Dave



