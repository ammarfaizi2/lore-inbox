Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129226AbRAHTFY>; Mon, 8 Jan 2001 14:05:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129818AbRAHTFO>; Mon, 8 Jan 2001 14:05:14 -0500
Received: from munchkin.spectacle-pond.org ([209.192.197.45]:32774 "EHLO
	munchkin.spectacle-pond.org") by vger.kernel.org with ESMTP
	id <S129226AbRAHTE6>; Mon, 8 Jan 2001 14:04:58 -0500
Date: Mon, 8 Jan 2001 14:05:21 -0500
From: Michael Meissner <meissner@spectacle-pond.org>
To: Ookhoi <ookhoi@dds.nl>
Cc: Michael Meissner <meissner@spectacle-pond.org>,
        linux-kernel@vger.kernel.org
Subject: Re: The advantage of modules?
Message-ID: <20010108140521.C11682@munchkin.spectacle-pond.org>
In-Reply-To: <20010105225020.A1188@evaner.penguinpowered.com> <20010108114734.A11682@munchkin.spectacle-pond.org> <20010108192601.J3680@ookhoi.dds.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20010108192601.J3680@ookhoi.dds.nl>; from ookhoi@dds.nl on Mon, Jan 08, 2001 at 07:26:01PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 08, 2001 at 07:26:01PM +0100, Ookhoi wrote:
> >    3)	Having drivers as modules means that you can remove them and
> >    reload them.  When I was working in an office, I had one scsi
> >    controller that was a different brand (Adaptec) than the main scsi
> >    controller (TekRam), and I hung a disk in a removable chasis on the
> >    scsi chain in addition to a tape driver and cd-rom.  When I was
> >    about to go home, I would copy all of the data to the disk, unmount
> >    it, and then unload the scsi device driver.  I would take the disk
> >    out, and reload the scsi device driver to get the tape/cd-rom.  I
> >    would then take the disk to my home computer.  I would reverse the
> >    process when I came in the morning.
> 
> You don't need modules for this to work.

Quoting from drivers/scsi/scsi.c:

	/*
	 * Usage: echo "scsi add-single-device 0 1 2 3" >/proc/scsi/scsi
	 * with  "0 1 2 3" replaced by your "Host Channel Id Lun".
	 * Consider this feature BETA.
	 *     CAUTION: This is not for hotplugging your peripherals. As
	 *     SCSI was not designed for this you could damage your
	 *     hardware !
	 * However perhaps it is legal to switch on an
	 * already connected device. It is perhaps not
	 * guaranteed this device doesn't corrupt an ongoing data transfer.
	 */

so my take is unless you explicitly use hotplug devices (I wasn't), that it is
much safer to unload the driver, unattach/attach scsi devices, and then reload
the driver (which will scan the scsi bus for devices), which you need modules
for.

-- 
Michael Meissner, Red Hat, Inc.  (GCC group)
PMB 198, 174 Littleton Road #3, Westford, Massachusetts 01886, USA
Work:	  meissner@redhat.com		phone: +1 978-486-9304
Non-work: meissner@spectacle-pond.org	fax:   +1 978-692-4482
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
