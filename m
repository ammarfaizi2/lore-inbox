Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265193AbRGSQrp>; Thu, 19 Jul 2001 12:47:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265149AbRGSQrf>; Thu, 19 Jul 2001 12:47:35 -0400
Received: from isis.its.uow.edu.au ([130.130.68.21]:18911 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S265042AbRGSQrR>; Thu, 19 Jul 2001 12:47:17 -0400
Message-ID: <3B570F54.D4087993@uow.edu.au>
Date: Fri, 20 Jul 2001 02:48:20 +1000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.7-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Wilfried Weissmann <Wilfried.Weissmann@gmx.at>
CC: "Kevin P. Fleming" <kevin@labsysgrp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.7-pre7 natsemi network driver random pauses
In-Reply-To: <00f101c1106e$a119e3c0$6baaa8c0@kevin> <3B570CCD.BC6A16C7@gmx.at>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Wilfried Weissmann wrote:
> 
> Just for curiosity, do you have those messages in our logfiles:
> 
> eth0: Transmit error, Tx status register 82.

That's a 3com message, not natsemi.

And it's such a common error that it is now specially detected in the
driver:

            if (tx_status == 0x82) {
                printk(KERN_ERR "Probably a duplex mismatch.  See "
                        "Documentation/networking/vortex.txt\n");

Which expands to:


Transmit error, Tx status register 82
-------------------------------------

This is a common error which is almost always caused by another host on
the same network being in full-duplex mode, while this host is in
half-duplex mode.  You need to find that other host and make it run in
half-duplex mode or fix this host to run in full-duplex mode.

As a last resort, you can force the 3c59x driver into full-duplex mode
with

        options 3c59x full_duplex=1

but this has to be viewed as a workaround for broken network gear and
should only really be used for equipment which cannot autonegotiate.

-
