Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750750AbVILPxd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750750AbVILPxd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 11:53:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750752AbVILPxd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 11:53:33 -0400
Received: from EXCHG2003.microtech-ks.com ([65.16.27.37]:61126 "EHLO
	EXCHG2003.microtech-ks.com") by vger.kernel.org with ESMTP
	id S1750750AbVILPxc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 11:53:32 -0400
From: "Roger Heflin" <rheflin@atipa.com>
To: "'Eyal Lebedinsky'" <eyal@eyal.emu.id.au>,
       "'Nuno Silva'" <nuno.silva@vgertech.com>
Cc: "'list linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: RE: RAID resync speed
Date: Mon, 12 Sep 2005 10:57:55 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Thread-Index: AcW2dlisbjh0+R3MRUmrkDo4A5/KPABO1/Nw
In-Reply-To: <43239374.8010604@eyal.emu.id.au>
Message-ID: <EXCHG2003WpSWerOc0N000006b6@EXCHG2003.microtech-ks.com>
X-OriginalArrivalTime: 12 Sep 2005 15:49:57.0480 (UTC) FILETIME=[A0343E80:01C5B7B1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

> 
> Actually, I took another look at this matter and I now think 
> that you had the correct approach.
> 
> The rebuild speed is the speed at which the new disk is being 
> built, not the total rebuild i/o. This means that it does not 
> contain the read operations. So the PCI limit is a limiting 
> factor. On a 32-bit 33MHz PCI controller (132MB/s theoretical 
> bandwidth) a 2->3 rebuild cannot be faster 44MB/s and a 3->4 
> is limited to 33MB/s.
> 
> I think this is true.
> 
> The same limit will also apply to any raid i/o as we 
> read/write to all the disks for any data.
> 
> To use 5 60MB/s disks I will need 300MB/s bandwidth which a 
> 64-bit 66MHz PCI can deliver. A 32-bit/66MHz will come close 
> - what can PCIe do?.
> A proper RAID card will alleviate the PCI limitation as it 
> will have dedicated channels for each disk (well, a good 
> controller should) with full bandwidth and the PCI will only 
> need to go at the one-disk speed (for raid-5).

You will need to carefully check the real raid controllers 
as some have separate channels some do not, it is all very 
much a mess, and you need to be very careful in checking
them and very careful in testing them if you need
real speed.

> 
> On-board SATA controllers will have better bandwidth if they 
> sit on a better than PCI bus (or on more than one PCI bus).

The all of on-board SATA controllers I have used have lots 
of shared hardware and are very very bad if you use more
than 1 disk per set of shared hardware, and  build in does
not mean that they will have a better PCI connection than
a card, it all depends on the sata chipset that they used,
there is stuff build into motherboards with pcix slots that
have the ide, sata, and network subsystems connected to 
33mhz buses.

Most of the stuff I have used is high end dual and quad
cpu motherboards, and the build in stuff does have lots
of corners cut, I would expect the desktop class stuff
to be as bad or worse.

                    Roger

