Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266006AbUGIWZe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266006AbUGIWZe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 18:25:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266011AbUGIWZe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 18:25:34 -0400
Received: from dirac.phys.uwm.edu ([129.89.57.19]:29582 "EHLO
	dirac.phys.uwm.edu") by vger.kernel.org with ESMTP id S266006AbUGIWZZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 18:25:25 -0400
Date: Fri, 9 Jul 2004 17:25:19 -0500 (CDT)
From: Bruce Allen <ballen@gravity.phys.uwm.edu>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Adam Radford <aradford@amcc.com>, Peter Maas <fedora@rooker.dyndns.org>,
       Jurgen Kramer <gtm.kramer@inter.nl.net>,
       Claudio Martins <ctpm@ist.utl.pt>
Subject: RE: 3ware 9500S Drivers (mm kernel)
In-Reply-To: <Pine.GSO.4.21.0406160006310.12222-100000@dirac.phys.uwm.edu>
Message-ID: <Pine.GSO.4.21.0407091720210.18072-100000@dirac.phys.uwm.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter, Jurgen, Claudio,

> > I am also working with Bruce Allen (smartmontools developer) to make
> > the 3w-9xxx driver work with smartmontools.  This shouldn't require
> > any driver changes.
> 
> This should happen on the timescale of two weeks.  I've got a 9500 series
> controller on hand and some SATA disks on order. Once the disks arrive,
> with Adam's help it shouldn't take me long to get smartmontools working on
> the 9500 series controllers.
> 
> The most novel aspect is that this will use the driver's character device
> interface rather than the block interface.

I've now checked code into CVS for this, so smartmontools now can be used
with 3ware/AMCC 9000 series controllers (3w-9xxx driver). Many thanks to
Adam Radford for his help with this.

I'd be grateful if you could give it a try and report back. I'm especially
interested in reports about 64-bit or big-endian (or both) hardware.
                                                                                                                                       
You'll need to follow the instructions at http://smartmontools.sf.net/ to
check a copy out of CVS and build it.  You'll have to use the 'character
device' syntax to address the disks, for example:
                                                                                                                                       
./smartctl -a -d 3ware,0 /dev/twa0
./smartctl -a -d 3ware,1 /dev/twa0
./smartctl -a -d 3ware,2 /dev/twa0
                                                                                                                                       
for the first three disks on the first controller, and
                                                                                                                                       
./smartctl -a -d 3ware,0 /dev/twa1
./smartctl -a -d 3ware,1 /dev/twa1
                                                                                                                                       
for the first two disks on the second controller.  Likewise use /dev/twa?
in /etc/smartd.conf.
                                                                                                                                       
If you don't have the /dev/twa? devices on your system, please run the
tw_cli or 3dmd tools once: this will automatically create the /dev/twa?
nodes.

I've also added support for 6000/7000/8000 cards to use the character
device interface /dev/twe?.  These devices can ALSO use the SCSI interface
via /dev/sd?
                                                                                                                                       
Cheers,
        Bruce



