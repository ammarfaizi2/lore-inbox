Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263417AbTDDC63 (for <rfc822;willy@w.ods.org>); Thu, 3 Apr 2003 21:58:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263436AbTDDC62 (for <rfc822;linux-kernel-outgoing>); Thu, 3 Apr 2003 21:58:28 -0500
Received: from web21209.mail.yahoo.com ([216.136.175.167]:27302 "HELO
	web21209.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263417AbTDDC6W (for <rfc822;linux-kernel@vger.kernel.org>); Thu, 3 Apr 2003 21:58:22 -0500
Message-ID: <20030404030950.93490.qmail@web21209.mail.yahoo.com>
Date: Thu, 3 Apr 2003 19:09:50 -0800 (PST)
From: Melkor Ainur <melkorainur@yahoo.com>
Subject: out_of_window handling in TIMEWAIT state
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I see in tcp_ipv4.c:tcp_v4_rcv. I see that a special
case is done that if an OTW data segment is received
in TIMEWAIT, then a correct ACK is generated. This is
not the case if the state was LAST_ACK or CLOSING
where OTW data is discarded. RFC793 appears to suggest
that OTW data arriving in these states be treated the
same. Was there a specific reason why this is
implemented as such? I'm hoping to gain an
understanding of whether there may have been known
problems interoperating with other stacks resulting in
this need or if the change was simply to match RFC
requirement. If it was the RFC requirement, am I
correct in that LAST_ACK and CLOSING are treated
differently and if so why is that the case. Any
advice/pointers would be appreciated.

       if (sk->state == TCP_TIME_WAIT)
                goto do_time_wait;

       case TCP_TW_ACK:
                tcp_v4_timewait_ack(sk, skb);
                break;


Melkor



__________________________________________________
Do you Yahoo!?
Yahoo! Tax Center - File online, calculators, forms, and more
http://tax.yahoo.com
