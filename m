Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262006AbTIRSIq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 14:08:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262011AbTIRSIq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 14:08:46 -0400
Received: from hqemgate00.nvidia.com ([216.228.112.144]:9990 "EHLO
	hqemgate00.nvidia.com") by vger.kernel.org with ESMTP
	id S262006AbTIRSIp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 14:08:45 -0400
Message-ID: <8F12FC8F99F4404BA86AC90CD0BFB04F039F7138@mail-sc-6.nvidia.com>
From: Allen Martin <AMartin@nvidia.com>
To: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>
Cc: "Andre Hedrick (andre@linux-ide.org)" <andre@linux-ide.org>,
       "LKML (linux-kernel@vger.kernel.org)" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] 2.4.23-pre4 support for new nForce IDE controllers
Date: Thu, 18 Sep 2003 11:08:25 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Thanks will look over these.
> 
> One first question - does the serial ata stuff need to
> avoid cable detect too ?

Actually cable detect is a problem even with PATA.  The driver is reading a
register at offset 0x52 in config space of the controller (AMD_CABLE_DETECT)
to determine cable type, but this register doesn't exist on nForce chips.
The cable detect signal is wired to a GPIO pin on the nForce southbridge,
unfortunately some board makers have chosen different GPIO pins to wire this
up to, so only the BIOS knows for sure where the cable detect signal is. 

Under Windows OS'es this isn't a problem because UDMA modes are set via an
ACPI method, so the driver doesn't have to know anything about the registers
or cable validation.

I saw the driver tries to detect if this bit is not working and turn it on,
but it only seems to happen on the primary channel.  As far as I can tell it
doesn't prevent setting higher DMA modes though.  Even when the driver
reports 40pin on the secondary channel I can still set dma modes >UDMA2.

-Allen
