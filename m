Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129228AbQK3DK0>; Wed, 29 Nov 2000 22:10:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129226AbQK3DKQ>; Wed, 29 Nov 2000 22:10:16 -0500
Received: from adsl-151-200-27-41.dc.adsl.bellatlantic.net ([151.200.27.41]:40967
        "EHLO tatooine.casagrau.org") by vger.kernel.org with ESMTP
        id <S129183AbQK3DKG>; Wed, 29 Nov 2000 22:10:06 -0500
Date: Wed, 29 Nov 2000 21:39:33 -0500
From: Federico Grau <donfede@casagrau.org>
To: linux-kernel@vger.kernel.org
Subject: rocketport pci question... it stopped working after 250 days uptime
Message-ID: <20001129213933.A5309@casagrau.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello Kernel people,

I am not subscribed to the kernel mailing list, so please cc responses to me.

We have several linux boxes useing 8 port rocketport pci multiport serial
cards.  Earlier last week 3 of them stopped working within a 24 hour period.
These three boxes had similar uptimes (since their last kernel rebuild); 249
days, 248 days, 250 days.  Comparing the logs of each box, we saw that each
box's rocketport stopped working after aproximately 248 days 16 hours uptime.

The rocketports are used both for dialin and also to simply take in streams of
data from an audio encoder.  The simptoms from dialin were that mgetty could
not initialize the modems (function mg_init_data timed out when waiting for a
read from the tty).  The simptoms from the data stream were simply that no
data stream came in... a simple cat on /dev/ttyR0 did not dump any data.

The problem was bypassed by warmbooting (simply running shutdown -r now) the
boxes.

The hardware are intel pentium pro and intel pentium 2 cpus using brand name
motherboards (tyan).  The rocketport cards are "Comtrol RocketPort 8 Oct (rev
4)".  They are all running kernel version 2.2.14, with the stock rocketport
driver that comes with it.  One of the boxes had the rocketport driver
compiled as a module... unloading and reloading the module had no effect on
the problem.



Checking to see if this bug had been corrected in later versions I compared
the changes in the rocketport code (/usr/src/linux/drivers/char/rocket.c) in
2.2.14 with 2.2.17...  the latter only had 2 additional lines calling
wake_up_interruptible().  The 2.2.14 kernel lists the rocketport driver
version as 1.14c.  However, comparing it with the 1.14 kernel at
rocketport.sourceforge.net it does not appear to match, though some parts are
similar I am not clear where they matched and where they forked.  Regardless I
saw no mention of a bug like this being corrected in the HISTORY file that was
with version 1.22 from sourceforge.

I spent a couple hours looking through the rocketport code in the kernel and
could not see where this bug may be caused (I have some background with C but
not much with hacking the kernel).  I am not even sure if the bug is with the
hardware, the rocketport driver, or possibly someplace else in the kernel
(doubtful I imagine).


So, my questions are:

 - has anyone heard of such a bug before?

 - does anyone have any suggestions to find/correct the bug?

 - We have another box with the rocketport cards which we exprect to reach
   this time limit in the next 48 hours (Dec 1st EST)... what kind of
   debugging/analysis could I do to help track where the problem might be?




Thanks,
donfede


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
