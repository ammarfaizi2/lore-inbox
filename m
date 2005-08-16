Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030198AbVHPPuv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030198AbVHPPuv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 11:50:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030199AbVHPPuv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 11:50:51 -0400
Received: from emulex.emulex.com ([138.239.112.1]:48845 "EHLO
	emulex.emulex.com") by vger.kernel.org with ESMTP id S1030198AbVHPPuu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 11:50:50 -0400
From: James.Smart@Emulex.Com
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
Subject: RE: [PATCH] add transport class symlink to device object
Date: Tue, 16 Aug 2005 11:50:16 -0400
Message-ID: <9BB4DECD4CFE6D43AA8EA8D768ED51C20F43EE@xbl3.ma.emulex.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] add transport class symlink to device object
Thread-Index: AcWh/v2KeSUwGUUJSxaee4vQQup1bAAca9EA
To: <James.Bottomley@SteelEye.com>
Cc: <matthew@wil.cx>, <greg@kroah.com>, <akpm@osdl.org>,
       <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
       <alan@lxorguk.ukuu.org.uk>, <rmk@arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, 2005-08-15 at 20:52 -0400, James.Smart@Emulex.Com wrote:
> > What is "0000:00:04:0" in this case ? The "device" is not a serial
> > port, which is what the ttyXX back link would lead you to believe.
> > Thus, it's a serial port multiplexer that supports up to N ports,
> > right ? and wouldn't the more correct representation have been to
> > enumerate a device for each serial port ? (e.g. 0000:00:04.0/line0,
> > 0000:00:04.0/line1, or similar)
> 
> It's PCI segment 0, bus 0, slot 4, function 0, which is apparently a 3
> port serial card (probably the GSP function of a pa8800?)

I guess you missed my point. The device (the PCI serial card) isn't the
member of the class, but rather an element of the device (one of the ports
on the pci card) is the class member. Thus, I believe the device backlink
for the class entity is misleading. The backlink implies the pci serial
card itself is the port. Ignoring this, the other headache is the device
backlink gives no clue as to what port or part of the pci adapter it
corresponds to.

In my conceptual thinking, there's a "wholeness" to the relationship of a
device and it's classes. E.g. trying to illustrate this with pci rather than
scsi - if there's a 3 slot pci bridge, with an adapter in each slot, I would
expect 4 different device entities: the bridge, and one for each adapter.
Each device would then be bound to whatever class makes sense for that
adapter. What I would not expect is a single device for the bridge and 3
class devices (one for each slot) that points back to the bridge device.

-- james s
