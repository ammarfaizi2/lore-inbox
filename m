Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265238AbTAEV1A>; Sun, 5 Jan 2003 16:27:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265230AbTAEV1A>; Sun, 5 Jan 2003 16:27:00 -0500
Received: from hera.cwi.nl ([192.16.191.8]:56511 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S265222AbTAEV05>;
	Sun, 5 Jan 2003 16:26:57 -0500
From: Andries.Brouwer@cwi.nl
Date: Sun, 5 Jan 2003 22:35:03 +0100 (MET)
Message-Id: <UTC200301052135.h05LZ3725302.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, luben@splentec.com
Subject: Re: inquiry in scsi_scan.c
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net, mdharm-kernel@one-eyed-alien.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Andries.Brouwer@cwi.nl wrote:
    > 
    > The SCSI code has no means of knowing the actual length transferred,
    > so has no choice but to believe the length byte in the reply.
    > But the USB code does the transferring itself, and knows precisely
    > how many bytes were transferred. If 36 bytes were transferred and
    > the additional length byte is 0, indicating a length of 5, then the
    > USB code can fix the response and change the additional length byte
    > to 31, indicating a length of 36.

    And what if the transport is *not* USB? Or they used
    a similar firmware of their device server in another
    product which used another transport?

    I suggest that this device is blacklisted in that
    SCSI Core would know that the ADDITIONAL LENGTH field
    in the INQURY response is incorrectly set (to 0).
    I.e. leave it to the interpreter.

    A transport is *not* supposed to peek and poke in the
    data it transfers!


There are at least four replies:

The factual: It seems you are unaware of the present USB storage code.
For many devices the INQUIRY response is entirely fabricated.

The vicious circle: The SCSI blacklist works by attaching quirks
to vendor and model data. This fails when the quirk is precisely
that vendor and model data are not reported.

The theoretical: USB-storage is the SCSI host - it is responsible
for presenting the SCSI layer with a device that complies with the
SCSI standard. If any blacklisting is to be done it must be
blacklisting in the USB storage code, not in the SCSI code.
(And that blacklist exists, of course - it is called unusual_devs.h.)

The practical: USB devices are notoriously bad as far as standard
compliance is concerned. If it works with Windows that is good
enough. That standard, too expensive to implement it all, or,
after implementing, to test it all.
Your philosophy leads to blacklisting almost every USB storage device
(I possess a dozen or so, not a single one without quirks).

Of course that is a possibility: describe for every device on the market
in what ways it fails. But it is counterproductive. When people buy
a new device it would be nice if it worked with Linux immediately,
not first after adding its quirks to some list. Indeed, several times
a week I read someone reporting "add this to unusual_devs.h to make
this device work". No doubt thousands of people just decide that their
device does not work with Linux. In cases where it is possible to
automatically detect and correct faulty data no list of quirks is
required, and more devices will work with Linux out-of-the-box.

Andries


