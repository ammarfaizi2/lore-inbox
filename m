Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279875AbRJ3F0N>; Tue, 30 Oct 2001 00:26:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279876AbRJ3F0D>; Tue, 30 Oct 2001 00:26:03 -0500
Received: from [202.135.142.195] ([202.135.142.195]:11537 "EHLO
	haven.ozlabs.ibm.com") by vger.kernel.org with ESMTP
	id <S279875AbRJ3FZ5>; Tue, 30 Oct 2001 00:25:57 -0500
Date: Tue, 30 Oct 2001 15:28:12 +1100
From: Rusty Russell <rusty@rustcorp.com.au>
To: Rolf Fokkens <fokkensr@linux06.vertis.nl>
Cc: linux-kernel@vger.kernel.org, kuznet@ms2.inr.ac.ru
Subject: Re: iptables and tcpdump
Message-Id: <20011030152812.2e9ba8ee.rusty@rustcorp.com.au>
In-Reply-To: <01102817104101.01788@home01>
In-Reply-To: <01102817104101.01788@home01>
X-Mailer: Sylpheed version 0.5.3 (GTK+ 1.2.10; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Oct 2001 17:10:41 -0800
Rolf Fokkens <fokkensr@linux06.vertis.nl> wrote:

> Hi!
> 
> I've been "tcpdumping" traffic that passes through a NAT box based on
> netfilter. Everything works wonderful, but tcpdump presents confusing data.
> With the help of google I found out that tcpdump sees the data right after
> the NF_IP_PRE_ROUTING and the NF_IP_POST_ROUTING hooks. This explains it all,
> but results in a new question: why does tcpdump "see" the data after the
> NF_IP_PRE_ROUTING hook instead of before, which more accurately reflects the
> data that's on the wire?

It should see the packets on the wire (they are grabbed by tcpdump before
IP processing), but IIRC they are cloned (not copied) for tcpdump's use.

Alexey, should the NAT layer be doing skb_unshare() before altering the packet?

> icmp 1 29 src=145.66.17.200 dst=10.13.92.231 ... [UNREPLIED]
> src=130.130.92.231 dst=145.66.17.200 ...
> 
> One half shows an unNATted dst, the second half shows the NATted src.
> Logically speaking they should match but now they don't.

No, that's what the connection tracking will actually see.  If there is
no NAT, they will match.

Hope that clarifies,
Rusty.
