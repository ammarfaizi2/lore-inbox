Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130432AbRCCJMc>; Sat, 3 Mar 2001 04:12:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130433AbRCCJMW>; Sat, 3 Mar 2001 04:12:22 -0500
Received: from pizda.ninka.net ([216.101.162.242]:53632 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S130432AbRCCJML>;
	Sat, 3 Mar 2001 04:12:11 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15008.46373.875068.681271@pizda.ninka.net>
Date: Sat, 3 Mar 2001 01:11:01 -0800 (PST)
To: Mark Reginald James <mrj@bigpond.net.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: TCP Congestion Window Bug?
In-Reply-To: <3AA1D522.7050300@bigpond.net.au>
In-Reply-To: <3AA1D522.7050300@bigpond.net.au>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Mark Reginald James writes:
 > TCP only sends a packet if:
 > 
 >          tcp_packets_in_flight(tp) < tp->snd_cwnd
 > 
 >          (function tcp_snd_test in include/net/tcp.h)
 > 
 > but regards transmission as application-limited if
 > 
 >          tp->packets_out < tp->snd_cwnd
 > 
 >          (function tcp_cwnd_validate in include/net/tcp.h)
 > 
 > So the kernel _always_ thinks the connection is
 > application-limited

Why?  After the final "send a packet if" test, tp->packets_out will be
incremented and thus be equal to tp->snd_cwnd, marking the connection
as _not_ application limited.

Later,
David S. Miller
davem@redhat.com
