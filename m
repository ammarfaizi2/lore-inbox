Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261439AbSIZSlH>; Thu, 26 Sep 2002 14:41:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261441AbSIZSlH>; Thu, 26 Sep 2002 14:41:07 -0400
Received: from web21401.mail.yahoo.com ([216.136.232.71]:64815 "HELO
	web21401.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S261439AbSIZSlE>; Thu, 26 Sep 2002 14:41:04 -0400
Message-ID: <20020926184618.35723.qmail@web21401.mail.yahoo.com>
Date: Thu, 26 Sep 2002 11:46:18 -0700 (PDT)
From: Venkatesh Rao <rpranesh@yahoo.com>
Subject: Problems with tcp_retransmit_skb - Please omit the previous incomplete mail
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I have a strange problem with tcp_retransmit_skb. I
will describe my setup before i describe my problem.

Please CC me.

Setup:
ucLinux 2.4.10 based kernel running on a embedded
processor (coldfire) with 40 MIPS processing
capablity.

Problem:
This embedded system sends relatively huge amount of
data (~1.5MB/s) over ethernet to a remote system which
process the data. On a normal case it all works great.
But when there is a lot of traffic on the network
(simulated by running flood ping between two desktop
linux systems connected to the same hub as this
embedded system), embedded systems Linux TCP/IP stack
go haywire. 

More details:
Since there is a high traffic on the network, the
embedded system cannot transmit packet and this
triggers tcp retransmit in the stack. 

But the first check on the tcp_transmit_skb fails

if (atomic_read(&sk->wmem_alloc) > min_t(int,
sk->wmem_queued+(sk->wmem_queued>>2),sk->sndbuf))
   return -EAGAIN

When conditions fails, the value of wmem_alloc is ~ 
around 56K-154K, sndbuf = 64K and wmem_queued is
around 44K.

Each time it tries to retransmit this if condition
always fail and the whole transmission times out. 

Once this retransmission phase kicks in, even if the
ping flooding is stopped , tcp stack never recovers.

This happens only on the send path of tcp never on the
receive path.

Any hints in  helping me debug this issue will be
appreciated.

Thanks
Venkatesh




__________________________________________________
Do you Yahoo!?
New DSL Internet Access from SBC & Yahoo!
http://sbc.yahoo.com
