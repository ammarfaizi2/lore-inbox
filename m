Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261176AbTIFMqs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Sep 2003 08:46:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261159AbTIFMqs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Sep 2003 08:46:48 -0400
Received: from s7n18.hfx.eastlink.ca ([24.222.7.18]:60052 "EHLO
	brain.fop.ns.ca") by vger.kernel.org with ESMTP id S261176AbTIFMqq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Sep 2003 08:46:46 -0400
Date: Sat, 6 Sep 2003 09:44:49 -0300 (ADT)
From: Steve Bromwich <kernel@fop.ns.ca>
To: Nick Urbanik <nicku@vtc.edu.hk>
cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Single P4, many IDE PCI cards == trouble??
In-Reply-To: <3F4EA30C.CEA49F2F@vtc.edu.hk>
Message-ID: <Pine.LNX.4.50.0309060922070.25126-100000@brain.fop.ns.ca>
References: <3F4EA30C.CEA49F2F@vtc.edu.hk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a belated success story from me, Nick - hope it's still relevant.

On Fri, 29 Aug 2003, Nick Urbanik wrote:

> With a single 2.26GHz P4, an Asus P4B533-E motherboard, is it possible
> to reliably use two additional PCI IDE cards (using SI680), one hard
> disk per channel, and have the thing work reliably?

It should be. I have a couple of machines I've set up for clients that
should help:

Machine 1:
3 * Maxtor 4R060L0 (RAID1, 1 hot standby)
1 * OnStream ADR drive
1 * Via IDE onboard (OnStream)
1 * onboard Promise 20265
2 * Promise 20268 PCI cards

Only 3 drives, but there's plenty of controllers. The only problem we've
had has been with the Maxtor drives, which don't seem particularly
reliable (and tech support was atrocious). This machine runs a busy
mailserver and webmail interface, and has been up for 59 days currently.
Not sure what motherboard this is, I think it's an AOpen of some flavour
(!)

Machine 2 (this is from memory, as the machine's behind a firewall):
Tyan Tiger i7505 motherboard with dual Xeon (2.4GHz, I think)
6 * WD EJB 60 gig drives
1 * Onboard IDE (PIIX4? 2 drives)
1 * Onboard Promise RAID (Disabled, doesn't work too well in non-RAID
mode)
1 * Promise Ultra TX-2
1 * generic (possibly startech?) ATA100 IDE card (I think this is an
SI680, 2 drives).

This machine is a samba file server and PDC for a call centre running a
fleet of Win2K desktops. It's been in production for 2 or 3 weeks so far
without any problems, with files on RAID5 and system on RAID1. I think
peak bonnie bench speed was around 90 megabytes a second reading blocks.

> Could this be the cause of my lockups?  I have a total of 6 ATA133
> hard disks, one DVD player all connected to the two IDE channels on
> the motherboard, and one disk to each of the channels of the SI680
> cards.

The only rules of thumb I have are "don't have any device as slave on IDE"
- this includes stuff like DVDs, CDRs and the like, and "don't share IRQs"
- it works fine but performance can suffer. I usually disable USB, serial
port 2, any onboard sound, etc on servers to claw back some more IRQs.

> Some people have told me that this is just asking for trouble, and
> that I should buy a 3ware card instead.

3Ware cards are nice, but they're also quite expensive. If you can afford
them, I'd definitely go with 3Ware.

> I am also using software RAID1, RAID5 with LVM on top.

I don't use LVM, just RAID1 and RAID5.

> My machine locks solid at unpredictable intervals with no response
> from keyboard lights, no Alt-Sysrq-x response, etc, with a wide
> variety of 2.4.x kernels, including 2.4.22.

Try disabling all unnecessary hardware in the BIOS and recompile the
kernel with the drivers for the unnecessary hardware removed (or compiled
as modules) and see how that does?

Also, have you tried qualifying the rest of the hardware to make sure it's
not a problem there? Memtest, cpuburn, etc might be worth a go...

Cheers, Steve
