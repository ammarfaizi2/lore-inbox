Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131742AbRCORc1>; Thu, 15 Mar 2001 12:32:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131743AbRCORcR>; Thu, 15 Mar 2001 12:32:17 -0500
Received: from smtp.Stanford.EDU ([171.64.14.23]:4745 "EHLO smtp.Stanford.EDU")
	by vger.kernel.org with ESMTP id <S131742AbRCORb7>;
	Thu, 15 Mar 2001 12:31:59 -0500
From: "Zack Weinberg" <zackw@stanford.edu>
Date: Thu, 15 Mar 2001 09:31:16 -0800
To: linux-kernel@vger.kernel.org
Cc: Alan Cox <alan@redhat.com>
Subject: 2.2.19 pre13 doesn't like retransmitted SYN ACK packets
Message-ID: <20010315093116.B2523@stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.2.19 pre13 sends an RST in response to a retransmitted SYN ACK which
arrives after we've sent out the final ACK of the handshake.  For
example:

tcpdump: listening on eth0
15:15:15.075670 wolery.Stanford.EDU.1341 > plan9.bell-labs.com.www:
        S 1057306555:1057306555(0) win 32120
        <mss 1460,sackOK,timestamp 49252305 0,nop,wscale 0> (DF) [tos 0x10] 
15:15:15.156320 plan9.bell-labs.com.www > wolery.Stanford.EDU.1341:
        S 1042976132:1042976132(0) ack 1057306556 win 1460 <mss 1460>
15:15:15.156364 wolery.Stanford.EDU.1341 > plan9.bell-labs.com.www:
        . ack 1 win 32120 (DF) [tos 0x10] 
15:15:15.204186 plan9.bell-labs.com.www > wolery.Stanford.EDU.1341:
        S 1042976132:1042976132(0) ack 1057306556 win 1460 <mss 1460>
15:15:15.204232 wolery.Stanford.EDU.1341 > plan9.bell-labs.com.www:
        R 1057306556:1057306556(0) win 0

I do not know if this behavior is correct or not from the TCP spec.
It seems unlikely to me, given that duplicate packets are expected 
and ignored just about everywhere else.  As a practical matter, this
behavior makes it close to impossible to communicate with a host that
commonly sends duplicate SYN ACKs.  plan9.bell-labs.com is just such;
I estimate I get past the initial handshake one connection in twenty.

This kernel does not have SYN cookies compiled in.  rp_filter is 1,
all other TCP and IP tunables are at their defaults.

zw
