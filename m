Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264886AbTBGNQD>; Fri, 7 Feb 2003 08:16:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264920AbTBGNQD>; Fri, 7 Feb 2003 08:16:03 -0500
Received: from betty.seh.de ([195.145.22.40]:39698 "EHLO seh.de")
	by vger.kernel.org with ESMTP id <S264886AbTBGNQC> convert rfc822-to-8bit;
	Fri, 7 Feb 2003 08:16:02 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Martin Zielinski <mz@seh.de>
Organization: SEH Computertechnik GmbH
To: linux-kernel@vger.kernel.org
Subject: TCP Connection times out
Date: Fri, 7 Feb 2003 14:30:33 +0100
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200302071430.34001.mz@seh.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I'm not on the list, so I'm not really informed what's going on. But...

our problem is a network printer the has paper empty.
The socket connection to the printer broke down after ~45 minutes with
errno 110 (Connection timed out).

Linux base version is 2.4.18 on a strongarm machine.

Tracking this down brought us to the tcp_send_probe0 function in 
net/ipv4/tcp_output.c.
The tp->backoff value becomes allways increased.
on this machine from 31 on  (tp->rto << tp->backoff) is 0.

The xmit timer is set to this timeout value - resulting in an ACK burst.
If the TCP sender gets the (default) 16 ACKS out, before the receiver can 
answer them, the connection dies.
This happened every night, when the printer received a huge job from a foreign 
office.

If this isn't a bug, it should be made configurable. Or do we miss something?

Thanks.




