Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267994AbRGVP1u>; Sun, 22 Jul 2001 11:27:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267995AbRGVP13>; Sun, 22 Jul 2001 11:27:29 -0400
Received: from mail11.svr.pol.co.uk ([195.92.193.23]:9480 "EHLO
	mail11.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S267994AbRGVP1Z>; Sun, 22 Jul 2001 11:27:25 -0400
From: "Alan J. Wylie" <alan.nospam@glaramara.freeserve.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15194.61662.338810.87576@glaramara.freeserve.co.uk>
Date: Sun, 22 Jul 2001 16:27:26 +0100
To: linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>
Subject: ipt_unclean: TCP flags bad: 4
X-Mailer: VM 6.93 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


I've just upgraded to 2.4.7, and I'm getting lots of errors:

ipt_unclean: TCP flags bad: 4

I only see them when my ppp link is up - pppd version 2.4.0

Looking at ipt_unclean.c it seems that this message will be generated
when I send a packet with flags set to RST only.

I've run a ppp session with the pppd option "record" turned on, and
analysed the output with "ethereal". This is indeed what is on the
wire. I'm no expert on TCP I'm afraid. The complete TCP stream
follows:

------------------------------------------------------------------------------
No. Time        Source                Destination           Protocol Info

129 12.800000   62.137.113.223        news.svr.pol.co.uk    TCP
    1148 > nntp [SYN] Seq=3684831495 Ack=0 Win=5840 Len=0

131 12.900000   news.svr.pol.co.uk    62.137.113.223        TCP
    nntp > 1148 [SYN, ACK] Seq=2607886663 Ack=3684831496 Win=32736 Len=0

137 13.300000   62.137.113.223        news.svr.pol.co.uk    TCP
    1148 > nntp [FIN, ACK] Seq=3684831502 Ack=2607887466 Win=7090 Len=0

142 13.400000   62.137.113.223        news.svr.pol.co.uk    TCP
    1148 > nntp [RST] Seq=3684831503 Ack=0 Win=0 Len=0
------------------------------------------------------------------------------

-- 
Alan J. Wylie                        http://www.glaramara.freeserve.co.uk/
"Perfection [in design] is achieved not when there is nothing left to add,
but rather when there is nothing left to take away."
  Antoine de Saint-Exupery
