Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262191AbVBQTQ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262191AbVBQTQ6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 14:16:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262350AbVBQTM6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 14:12:58 -0500
Received: from it4systems-kln-gw.de.clara.net ([212.6.222.118]:42981 "EHLO
	frankbuss.de") by vger.kernel.org with ESMTP id S262326AbVBQTLb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 14:11:31 -0500
From: "Frank Buss" <fb@frank-buss.de>
To: "'David Brownell'" <david-b@pacbell.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: SL811 problem on mach-pxa
Date: Thu, 17 Feb 2005 20:11:28 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <200502171009.55375.david-b@pacbell.net>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2527
Thread-Index: AcUVHI2rRh0F0ZY3SVad0BtukGT/CQAA+TBw
Message-Id: <20050217191130.B750B5B874@frankbuss.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Some of that looks reasonable, not all.  In particular, don't
> change the convention on resources (memory to i/o), or expect
> that the two regions involve more than one byte each ... the
> hardware only has two single-byte registers!

ok, perhaps I've misunderstood the meaning of IORESOURCE_IO and
IORESOURCE_MEM. Is IORESOURCE_IO for "outb" and "inb" (Intel assembler,
don't know the Arm aquivalent)? Then you are right, it should be
IORESOURCE_MEM, only, because anything is accessed as like accessing normal
memory. I didn't found much documention of such low-level kernel
programming.

> I'll look at the ep->hep stuff ... I could believe rc1 got a
> bug added there.  The urb->hcpriv bit looks wrong though.
> It may take a little time for me to check it out though. 

ok, thanks. If you have a new patch, I'll try it on my platform.

> > There is still an important error: When a device is 
> > plugged, then opened and
> > then unplugged while open, it looks like the process 
> > freezes, which opened the device
> 
> That seems pretty odd; I certainly tested that (on 2.6.almost-10)
> as part of the initial development, and nothing in that area should
> have changed either in the sl811 driver or usbcore.  I suspect the
> issue is one of the other changes you made.

perhaps you are right, I don't understand the interactions between the
driver and the USB framework in detail.

> Hmm, what platform were you using?  I've had reports that one of the
> KARO boards has that issue.  

The platform was developed by a company I'm working for as a freelancer for
a product the company sells.

> That looks like the sort of thing that
> should be done in the reset() routine rather than start(); 
> and it should
> certainly use a symbolic constant not 0x08.

do you mean sl811->board->reset? I don't know, where I have to setup the
function pointer, but looks ok for me to reset the controller (and all
plugged USB devices) in the probe function.

-- 
Frank Buﬂ, fb@frank-buss.de
http://www.frank-buss.de, http://www.it4-systems.de

