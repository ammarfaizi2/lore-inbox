Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270490AbRHHOCQ>; Wed, 8 Aug 2001 10:02:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270491AbRHHOCH>; Wed, 8 Aug 2001 10:02:07 -0400
Received: from ausxc07.us.dell.com ([143.166.99.215]:28607 "EHLO
	ausxc07.us.dell.com") by vger.kernel.org with ESMTP
	id <S270490AbRHHOBz>; Wed, 8 Aug 2001 10:01:55 -0400
Message-ID: <71714C04806CD51193520090272892178BD3E0@ausxmrr502.us.dell.com>
From: Matt_Domsch@Dell.com
To: linux-kernel@vger.kernel.org
Subject: Re: How does "alias ethX drivername" in modules.conf work?
Date: Wed, 8 Aug 2001 08:59:35 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Userspace init scripts point the finger at kernel, saying "there
> is no good and no well documented mapping method". Kernel points
> its finger at userspace, saying "this is the way we do it" and
> "we cant guarantee a perfect 100% mapping solution, so we're not
> even going to try for 90%" and "futz with your drivers and
> modules.conf and init scripts till you get something that
> works".

Ethtool can help out initscripts, and I've recently submitted patches to the
appropriate maintainers for the eepro100 (both in-kernel and Donald's),
acenic, bcm5700, Intel e100 and e1000, so those cards report back their
assignments when using ethtool.  Several other drivers already have this
support in them.

ethtool -i eth0 returns:
driver: eepro100
version: someversionstring
firmware-version: someversionstring
bus-info: 00:05.0

Now you know at least that eth0 is an eepro100-driven card, and it's a PCI
device at 00:05.0.  lspci can give you the name of the card then if you want
it.
This helps, but doesn't solve the problem of knowing, looking from the
outside, which physical card is considered eth0, or conversely, what ethX
assignment did my embedded NIC get.  On x86, the $PIR PCI IRQ Routing Table
provided by BIOS can help.  It describes embedded (Slot 0) or add-in (Slot
x>0) cards using slot names likely silkscreened on the motherboard or
numbered externally.

Slot 0: PCI 00:05.
Slot 0: PCI 00:06.
Slot 0: PCI 00:08.
Slot 0: PCI 00:0f.
Slot 1: PCI 00:07.
Slot 2: PCI 03:08.
Slot 3: PCI 03:09.
Slot 4: PCI 03:0a.
Slot 5: PCI 03:0b.
Slot 6: PCI 0d:0c.
Slot 7: PCI 0d:0d.

A little sorting is required, as the table doesn't include (or for it's
purposes need to include) the PCI function number of multi-function devices,
but at least you know what's embedded and what's add-in now, and what
physical PCI slot.

I'm continuing to flesh out this idea, so if you've got thoughts for how to
make good use of this info, please let me know.

Thanks,
Matt

-- 
Matt Domsch
Sr. Software Engineer
Dell Linux Solutions
www.dell.com/linux
#2 Linux Server provider with 17% in the US and 14% Worldwide (IDC)!
#3 Unix provider with 18% in the US (Dataquest)!



