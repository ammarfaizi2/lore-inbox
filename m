Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318718AbSHQT5I>; Sat, 17 Aug 2002 15:57:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318719AbSHQT5I>; Sat, 17 Aug 2002 15:57:08 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:28914 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318718AbSHQT5H>; Sat, 17 Aug 2002 15:57:07 -0400
Subject: Re: IDE?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Larry McVoy <lm@bitmover.com>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0208161657240.1674-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0208161657240.1674-100000@home.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 17 Aug 2002 21:00:18 +0100
Message-Id: <1029614418.4634.36.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-08-17 at 01:02, Linus Torvalds wrote:
> Even something as simple as a PIIX driver (which _should_ just register 
> itself as a driver for the piix chipsets) doesn't do that. Instead, we 
> have ide-pci.c, which has a list of all the chipsets it knows about, and 
> then does initialization and calls the init routines that it knows about. 
> That's just incestuous.

The pci scan can't go away to get the nasty BIOS ordering crap right.
Andre now has that code as it should be however. The scan loop is
basically no more than

	pci_foreach_device_in_weird_ide_order()
	{
		call probe function(dev)
	}

Which also means we are really really close to hot plug ide controllers.

The probe function->generic pci init->driver->generic->driver-> chain is
still too ugly but its getting better and lives in a struct now

