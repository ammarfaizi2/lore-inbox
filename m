Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129383AbQKJK0y>; Fri, 10 Nov 2000 05:26:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129878AbQKJK0q>; Fri, 10 Nov 2000 05:26:46 -0500
Received: from pizda.ninka.net ([216.101.162.242]:61312 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129383AbQKJK0d>;
	Fri, 10 Nov 2000 05:26:33 -0500
Date: Fri, 10 Nov 2000 02:12:01 -0800
Message-Id: <200011101012.CAA11999@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: ben@zeus.com
CC: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0011100951300.11412-100000@artemis.cam.zeus.com>
	(message from Ben Mansell on Fri, 10 Nov 2000 10:13:21 +0000 (GMT))
Subject: Re: Missing ACKs with Linux 2.2/2.4?
In-Reply-To: <Pine.LNX.4.30.0011100951300.11412-100000@artemis.cam.zeus.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: Fri, 10 Nov 2000 10:13:21 +0000 (GMT)
   From: Ben Mansell <ben@zeus.com>

   This is a resend of the data sent on line 8 of the trace:

   10:10:15.845002 cobalt-box.echo > hydra.3700: P 1:1449(1448) ack 1449 win 31856 <nop,nop,timestamp 0 268081751> (DF)

   It looks like hydra didn't ACK this data, so the server eventually
   re-sent it?

Maybe hydra didn't even receive it. :-)

There are two things to make to solve this riddle.

First, reproduce this as you have been, and afterwards
check if various network error statistic counters have been
incremented.  Here is a short list:

1) On the line from /proc/net/dev for the device used in the
   transfer, any counter other than bytes or packets.

2) From /proc/net/snmp

	Ip: InHdrErrors
	Ip: InDiscards
	Tcp: InErrs

Next, reproduce the problem and trace the session using tcpdump
simultaneously from both sides of the connection.  This will answer
the "did the packets even make it to the other end" questions.

Thanks a lot for helping to hunt this down.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
