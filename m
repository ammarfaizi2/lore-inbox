Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266921AbUHDBB5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266921AbUHDBB5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 21:01:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267170AbUHDBB5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 21:01:57 -0400
Received: from gate.crashing.org ([63.228.1.57]:34722 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S266921AbUHDBBz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 21:01:55 -0400
Subject: Re: Exposing ROM's though sysfs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Vojtech Pavlik <vojtech@suse.cz>,
       Jon Smirl <jonsmirl@yahoo.com>, Torrey Hoffman <thoffman@arnor.net>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <200408031755.56833.jbarnes@engr.sgi.com>
References: <1091207136.2762.181.camel@rohan.arnor.net>
	 <1091226981.5066.15.camel@localhost.localdomain>
	 <1091569261.1862.18.camel@gaston> <200408031755.56833.jbarnes@engr.sgi.com>
Content-Type: text/plain
Message-Id: <1091581190.1862.48.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 04 Aug 2004 10:59:51 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> So you can do port I/O on low addresses but not memory accesses?  For some 
> cards simply throwing away reads and writes to the low memory area is 
> probably ok since it'll just be doing things like printing a BIOS banner or a 
> pretty logo.  But then again, I've never disassembled one so I can't be sure.  
> Alan would probably know though :)

Yes, typically, on Apple north bridges, you have the PIO space memory
mapped somewhere in the CPU address space, generating IO cycles from 0
to N (usually 16Mb), but the MMIO space is directly mapped 1:1 from
0x8000000.

> If you can't do legacy port I/O on a given bus though, I think you'd be out of 
> luck wrt POSTing a card with an x86 BIOS.

Port IO should be fine in most cases (there might be one or 2 weird cases
with earlier models, but overall, it's fine). The typical case is a machine
using Apple "UniNorth" chipset (the one that supports AGP, been out for a while
now), since the AGP slot and the PCI bus are on 2 separate domains. Both can
do Port IO at any low address, but they are completely separate domains.

All this could be very nicely dealt with by the kernel driver.

Ben.


