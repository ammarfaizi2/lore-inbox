Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130650AbRAHQr7>; Mon, 8 Jan 2001 11:47:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130669AbRAHQrj>; Mon, 8 Jan 2001 11:47:39 -0500
Received: from munchkin.spectacle-pond.org ([209.192.197.45]:21254 "EHLO
	munchkin.spectacle-pond.org") by vger.kernel.org with ESMTP
	id <S130007AbRAHQrW>; Mon, 8 Jan 2001 11:47:22 -0500
Date: Mon, 8 Jan 2001 11:47:34 -0500
From: Michael Meissner <meissner@spectacle-pond.org>
To: Evan Thompson <evaner@bigfoot.com>, linux-kernel@vger.kernel.org
Subject: Re: The advantage of modules?
Message-ID: <20010108114734.A11682@munchkin.spectacle-pond.org>
In-Reply-To: <20010105225020.A1188@evaner.penguinpowered.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20010105225020.A1188@evaner.penguinpowered.com>; from evaner@bigfoot.com on Fri, Jan 05, 2001 at 10:50:20PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 05, 2001 at 10:50:20PM -0600, Evan Thompson wrote:
> I'd like to know (I know, I'm being slightly off topic, while still
> staying on topic, so I'm on topic...er...yes) if there is any
> advantage, be it memory-wise or architectuarally wise, to use modules?
> 
> I already know the obvious points of if you are creating a distro that
> it is usually good to make a very modular kernel for those wishing not
> to recompile their kernel, but I was wondering if there were any other
> advantages to using modules vs. making a monolithic kernel for a
> kernel to be used only on one machine (with no other hardware support
> at all)?

A couple of thoughts:

   1)	A full kernel with everything compiled in might not fit on boot media
	such as floppies, while modules allows you to not load stuff that isn't
	needed to until after the main booting is accomplished.

   2)	There are several devices that have multiple drivers (such as tulip,
	and old_tulip for example).  Which particular driver works depends on
	your exact particular hardware.  If both of these drivers are linked
	into the kernel, whatever the kernel chooses to initialize first will
	talk to the device.

   3)	Having drivers as modules means that you can remove them and reload
	them.  When I was working in an office, I had one scsi controller that
	was a different brand (Adaptec) than the main scsi controller (TekRam),
	and I hung a disk in a removable chasis on the scsi chain in addition
	to a tape driver and cd-rom.  When I was about to go home, I would copy
	all of the data to the disk, unmount it, and then unload the scsi
	device driver.  I would take the disk out, and reload the scsi device
	driver to get the tape/cd-rom.  I would then take the disk to my home
	computer.  I would reverse the process when I came in the morning.

   4)	If you have multiple scsi controllers of different brands, building on
	into the kernel and the other brand(s) as modules allows you to control
	which scsi controller is the first controller in terms of where the
	disks are.

-- 
Michael Meissner, Red Hat, Inc.  (GCC group)
PMB 198, 174 Littleton Road #3, Westford, Massachusetts 01886, USA
Work:	  meissner@redhat.com		phone: +1 978-486-9304
Non-work: meissner@spectacle-pond.org	fax:   +1 978-692-4482
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
