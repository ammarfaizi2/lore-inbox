Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266702AbTBCPW2>; Mon, 3 Feb 2003 10:22:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266730AbTBCPW1>; Mon, 3 Feb 2003 10:22:27 -0500
Received: from host194.steeleye.com ([66.206.164.34]:32779 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S266702AbTBCPW0>; Mon, 3 Feb 2003 10:22:26 -0500
Subject: Re: PnP Model
From: James Bottomley <James.Bottomley@steeleye.com>
To: linux-kernel@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk, mochel@osdl.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 03 Feb 2003 10:31:53 -0500
Message-Id: <1044286316.1777.30.camel@mulgrave>
Mime-Version: 1.0
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I agree. A lot of drivers should be able to use one model for
> everything including "enable_device" stuff.  Right not its all a bit
> too detailed

Actually, while we're on the subject of PnP-ISA, I was wondering if we
could also migrate straight ISA to the device model probing (The 3c509
now looks a bit of a mess because it's got probes for EISA and MCA,
needs probes for PNP-ISA and still has to use Space.c for ISA).

If we just had a bus matching function that always matched and the
device probe would do its usual port etc. probe and return success if it
found a device or fail if it didn't, that would move ISA over reasonably
effectively.  The only nasty is multiple cards: here the probe routine
would have to detect the extra cards, allocate struct devices for them
and then catch them again when they come back in through the driver
probe routine (this will work today because all probes are single
threaded on the bus semaphore, obviously it will fail if probes ever
become multi-threaded).

The last issue is probably that we'd like the ISA probes to be run after
all the rest of the busses so that all resources in use in the system
have a good chance of being claimed and the ISA memory poking should
have the least potential for doing damage---this would require a change
in the way the device model works, I think, wouldn't it?

James



