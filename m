Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314553AbSGPLOb>; Tue, 16 Jul 2002 07:14:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315278AbSGPLOa>; Tue, 16 Jul 2002 07:14:30 -0400
Received: from mail4.ucc.ie ([143.239.1.34]:43018 "EHLO mail4.ucc.ie")
	by vger.kernel.org with ESMTP id <S314553AbSGPLO1>;
	Tue, 16 Jul 2002 07:14:27 -0400
Message-ID: <9FBB394A25826C46B2C6F0EBDAD42755018E6E3C@xch2.ucc.ie>
From: "O'Riordan, Kevin" <K.ORiordan@ucc.ie>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: [rl@hellgate.ch: [PATCH] #8 VIA Rhine (stalls, stats, backoff
	 , clean up)]
Date: Tue, 16 Jul 2002 12:17:17 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just thought I'd mention, my chip is a VT6102, so the original stalling
problem was with more than just the VT86C100A chip. With the patch, my chip
now recovers successfully from a TxAbort, so I'm able to download large
files again.

-----Original Message-----
From: O'Riordan, Kevin [mailto:K.ORiordan@ucc.ie] 
Sent: 16 July 2002 09:11
To: 'Roger Luethi '
Cc: 'linux-kernel@vger.kernel.org'
Subject: RE: [rl@hellgate.ch: [PATCH] #8 VIA Rhine (stalls, stats, backoff ,
clean up)]

Have tested this patch against 2.4.19-rc1 on a via rhine-II chip. Seems to
work fine with no ill effects. No longer getting timeout errors, or problem
where chip refuses to reset.
Have been testing with downloading several large ISOs.
 
From: Roger Luethi <rl@hellgate.ch>
Subject: [PATCH] #8 VIA Rhine (stalls, stats, backoff, clean up)
To: linux-kernel@vger.kernel.org
Cc: Urban Widmark <urban@teststation.com>,
	Jeff Garzik <jgarzik@mandrakesoft.com>
Date:	Mon, 15 Jul 2002 15:36:15 +0200
User-Agent: Mutt/1.3.27i
X-Mailing-List:	linux-kernel@vger.kernel.org

This patch is a more comprehensive and cleaned up version of earlier VIA
Rhine patches I posted in May. It should be self-explanatory. The change
summary reads:

- show confused chip where to continue after Tx error; this is known to
fix
  at least some (hopefully all) of the infamous Rhine stalls under load

- location of collision counter is chip specific (underflow counter,
too)

- allow selecting backoff algorithm -- added new module parameter;
  this is a trade-off; higher performance typically means many aborts
due
  to excessive collisions and performance degradation for other users.
  Default comes from EEPROM and depends on the card.

- cosmetic cleanups

Note: Testing on several cards seems to indicate that waiting for the
chip
before restarting the Tx engine is pointless; in the rare case where the
flag is not down by the time the driver is ready to restart, it will
stay
up forever, but restarting the Tx engine immediately still works.

Beware: It seems that in certain cases, the interrupt status the driver
relies on for error handling is wrong. In those cases, only the
respective
buffer descriptor carries the correct error information. Should this
turn
out to be a problem in real life, the error handling handling can be
moved
into via_rhine_rx(), or the correct error code can be passed to
via_rhine_error() alternatively.

Some changes in the statistics section are tentative. They are coded
according to the specs, and they assume that the old code worked for the
VT86C100A, and that all chips but the VT86C100A work like the VT6102,
for
which the changes have been tested. FWIW, some counters work with the
VT6102 for the first time with this patch (it's not as if anybody cared,
or
the broken counters wouldn't have gone unnoticed for such a long time).

The patch is against the latest version in Jeff's public tree. It is
most
definitely an improvement for many Rhine users and should not create any
problems. Unless somebody finds bugs, I don't intend to release a new
version anytime soon.

Roger

----- End forwarded message -----

-- 
Expenditures rise to meet income.
 <<via-rhine.c.8.patch>> 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
