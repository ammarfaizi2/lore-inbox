Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132896AbRAHVtW>; Mon, 8 Jan 2001 16:49:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132964AbRAHVtN>; Mon, 8 Jan 2001 16:49:13 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:46093 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S132896AbRAHVtF>;
	Mon, 8 Jan 2001 16:49:05 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200101082150.f08Lots13085@flint.arm.linux.org.uk>
Subject: Re: The advantage of modules?
To: meissner@spectacle-pond.org (Michael Meissner)
Date: Mon, 8 Jan 2001 21:50:55 +0000 (GMT)
Cc: ookhoi@dds.nl (Ookhoi), meissner@spectacle-pond.org (Michael Meissner),
        linux-kernel@vger.kernel.org
In-Reply-To: <20010108140521.C11682@munchkin.spectacle-pond.org> from "Michael Meissner" at Jan 08, 2001 02:05:21 PM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Meissner writes:
> Quoting from drivers/scsi/scsi.c:
> 
> 	/*
> 	 * Usage: echo "scsi add-single-device 0 1 2 3" >/proc/scsi/scsi
> 	 * with  "0 1 2 3" replaced by your "Host Channel Id Lun".
> 	 * Consider this feature BETA.
> 	 *     CAUTION: This is not for hotplugging your peripherals. As
> 	 *     SCSI was not designed for this you could damage your
> 	 *     hardware !
> 	 * However perhaps it is legal to switch on an
> 	 * already connected device. It is perhaps not
> 	 * guaranteed this device doesn't corrupt an ongoing data transfer.
> 	 */
> 
> so my take is unless you explicitly use hotplug devices (I wasn't), that
> it is much safer to unload the driver, unattach/attach scsi devices, and
> then reload the driver (which will scan the scsi bus for devices), which
> you need modules for.

I don't believe that is what it's trying to say.  There have been instances
in the past where unplugging a SCSI device from a powered on SCSI bus can
result in blown terminator power fuses and the like.  Whether this still
applies today, I don't know (are active terminators better or worse than
passive when it comes to this type of thing?)  However, what I do know is
the following, and I learnt it the hard way:

  I once had a machine and other stuff on a 4-way mains connector block
  that has been used for many years.  Unknown to me, the earth wire
  had become intermittent.  I was just about to connect another peripheral
  which was directly connected to the wall socket to this computer, and
  I happened to touch the connector body on both the peripheral and the
  computer.  I now know what a shock of >120V feels like.

Now, imagine what would happen if you connect a SCSI device, where this
condition exists, and the first thing that makes contact is the SCSI
databus.  Say goodbye to most, if not all devices on that SCSI bus.
   _____
  |_____| ------------------------------------------------- ---+---+-
  |   |         Russell King        rmk@arm.linux.org.uk      --- ---
  | | | | http://www.arm.linux.org.uk/personal/aboutme.html   /  /  |
  | +-+-+                                                     --- -+-
  /   |               THE developer of ARM Linux              |+| /|\
 /  | | |                                                     ---  |
    +-+-+ -------------------------------------------------  /\\\  |
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
