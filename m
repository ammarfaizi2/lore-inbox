Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130431AbRCCIim>; Sat, 3 Mar 2001 03:38:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130432AbRCCIid>; Sat, 3 Mar 2001 03:38:33 -0500
Received: from [139.134.6.86] ([139.134.6.86]:51694 "EHLO mailin9.bigpond.com")
	by vger.kernel.org with ESMTP id <S130431AbRCCIi1>;
	Sat, 3 Mar 2001 03:38:27 -0500
Message-ID: <3AA1D522.7050300@bigpond.net.au>
Date: Sat, 03 Mar 2001 19:39:46 -1000
From: Mark Reginald James <mrj@bigpond.net.au>
Organization: WahSounds
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.2 i686; en-US; 0.7) Gecko/20010119
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: TCP Congestion Window Bug?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:

TCP only sends a packet if:

         tcp_packets_in_flight(tp) < tp->snd_cwnd

         (function tcp_snd_test in include/net/tcp.h)

but regards transmission as application-limited if

         tp->packets_out < tp->snd_cwnd

         (function tcp_cwnd_validate in include/net/tcp.h)

So the kernel _always_ thinks the connection is
application-limited, forcing many un-necessary
reductions in the size of the congestion window.

I think the condition in tcp_snd_test should be:

         tcp_packets_in_flight(tp) <= tp->snd_cwnd

Mark

