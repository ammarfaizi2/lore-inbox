Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261859AbSKUBRX>; Wed, 20 Nov 2002 20:17:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261914AbSKUBRX>; Wed, 20 Nov 2002 20:17:23 -0500
Received: from fmr02.intel.com ([192.55.52.25]:15818 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S261859AbSKUBRU>; Wed, 20 Nov 2002 20:17:20 -0500
Message-ID: <EDC461A30AC4D511ADE10002A5072CAD04C7A52C@orsmsx119.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'David Woodhouse'" <dwmw2@infradead.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "'Ducrot Bruno'" <poup@poupinou.org>, Felix Seeger <seeger@sitewaerts.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: Linux 2.4.20 ACPI 
Date: Wed, 20 Nov 2002 17:24:23 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: David Woodhouse [mailto:dwmw2@infradead.org] 
> alan@lxorguk.ukuu.org.uk said:
> >  I guess sonypi could take the ACPI global lock ?
> 
> I assume that's not a serious suggestion. Perhaps it could 
> release the 
> region while it's not _actually_ using it, and the ACPI code 
> could be fixed 
> to not touch regions which it doesn't own.
> 
> Or we write proper PM code for sonypi and make it not 
> possible to use both 
> sonypi and ACPI at once.

When I looked a few years ago, 0x60 through 0x6F were marked owned by the
keyboard driver (even though it only really uses 0x60 and 0x64). I don't see
either ACPI *or* sonypi currently claiming those IO ports properly. (sonypi
claims some ioports but not 0x62 and 0x66, probably for this reason.)

> Surely a proper driver should always be preferred over 
> binary-only bytecode?

The ACPI EC driver uses AML to properly configure itself (the cmd and data
ports actually can vary, and grabbing the GL is only sometimes required) but
beyond that the interpreter is not used.

However, since the only user of the EC driver until now has been ACPI, we
will need to do some work there to have nice, externally-callable
interfaces.

...and I suppose there will need to be some ifdef trickery to keep things
working when the ACPI EC driver is not there.

Stelian Pop is the current mantainer? Or davej? I should be able to do a
patch shortly to submit to whomever.

Regards -- Andy
