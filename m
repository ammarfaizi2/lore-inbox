Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130801AbQKJAfn>; Thu, 9 Nov 2000 19:35:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130806AbQKJAfd>; Thu, 9 Nov 2000 19:35:33 -0500
Received: from pizda.ninka.net ([216.101.162.242]:7296 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S130801AbQKJAfW>;
	Thu, 9 Nov 2000 19:35:22 -0500
Date: Thu, 9 Nov 2000 16:20:44 -0800
Message-Id: <200011100020.QAA00913@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: ben@zeus.com
CC: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0011091902530.31452-100000@artemis.cam.zeus.com>
	(message from Ben Mansell on Thu, 9 Nov 2000 19:36:23 +0000 (GMT))
Subject: Re: Missing ACKs with Linux 2.2/2.4?
In-Reply-To: <Pine.LNX.4.30.0011091902530.31452-100000@artemis.cam.zeus.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: 	Thu, 9 Nov 2000 19:36:23 +0000 (GMT)
   From: Ben Mansell <ben@zeus.com>

   Any ideas whats going on? I'm no expert at reading tcpdumps, if
   anyone can shed some light on the problem, I'd be most greatful.

Anything less than ~2.2.16 are about as buggy as they come wrt. TCP
Please upgrade ;-)

Something is wrong with the Cobalt side, for sure:

10:10:15.845869 cobalt-box.echo > hydra.3700: . ack 8681 win 30408 <nop,nop,timestamp 15607469 268081752> (DF)

Cobalt sends the ACK, everything is fine.  

10:10:18.836367 cobalt-box.echo > hydra.3700: P 1:1449(1448) ack 8681 win 31856 <nop,nop,timestamp 15607768 268081752> (DF)

Cobalt then waits for 3 seconds to send data bytes 1:1449
(ie. the echo service response).

10:10:18.836421 hydra.3700 > cobalt-box.echo: . ack 1449 win 31856 <nop,nop,timestamp 268082051 15607768> (DF)

Then hydra immediately ACKs.  Hydra is perfectly fine.

Cobalt appears to delay wakeup of echo process to notify it that
data is ready.  Ask Cobalt for a more recent 2.2.x kernel so that
maybe you can continue proper Zeus server tuning :-)

The other systems you tested which did not have the delay just do
not trigger the necessary conditions for the wakeup delay on the
Cobalt side, thats all.

Based upon this trace it is erroneous to blame anything but the
2.2.12 kernel on the Cobalt machine.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
