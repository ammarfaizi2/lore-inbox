Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266820AbUHVM5o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266820AbUHVM5o (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 08:57:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266837AbUHVM5o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 08:57:44 -0400
Received: from relay.pair.com ([209.68.1.20]:32518 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id S266820AbUHVM5l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 08:57:41 -0400
X-pair-Authenticated: 66.190.51.173
Message-ID: <41289844.6080300@cybsft.com>
Date: Sun, 22 Aug 2004 07:57:40 -0500
From: "K.R. Foley" <kr@cybsft.com>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Florian Schmidt <mista.tapas@gmx.net>
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P7
References: <20040816120933.GA4211@elte.hu> <1092716644.876.1.camel@krustophenia.net> <20040817080512.GA1649@elte.hu> <20040819073247.GA1798@elte.hu> <20040820133031.GA13105@elte.hu> <20040820195540.GA31798@elte.hu> <20040821140501.GA4189@elte.hu> <1093125390.817.22.camel@krustophenia.net> <4127E386.5000701@cybsft.com> <1093133810.817.26.camel@krustophenia.net> <20040822063500.GA20828@elte.hu>
In-Reply-To: <20040822063500.GA20828@elte.hu>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
 > * Lee Revell <rlrevell@joe-job.com> wrote:
 >
 >
 >>On Sat, 2004-08-21 at 20:06, K.R. Foley wrote:
 >>
 >>>I just posted a similar trace of ~4141 usec from P6 here:
 >>>
 >>>http://www.cybsft.com/testresults/2.6.8.1-P6/latency-trace1.txt
 >>>
 >>
 >>This looks wrong:
 >>
 >>00000003 0.008ms (+0.001ms): dummy_socket_sock_rcv_skb (tcp_v4_rcv)
 >>00000004 0.008ms (+0.000ms): tcp_v4_do_rcv (tcp_v4_rcv)
 >>00000004 0.009ms (+0.000ms): tcp_rcv_established (tcp_v4_do_rcv)
 >>00010004 3.998ms (+3.989ms): do_IRQ (tcp_rcv_established)
 >>00010005 3.999ms (+0.000ms): mask_and_ack_8259A (do_IRQ)
 >>00010005 4.001ms (+0.002ms): generic_redirect_hardirq (do_IRQ)
 >>00010004 4.002ms (+0.000ms): generic_handle_IRQ_event (do_IRQ)
 >>
 >>Probably a false positive, Ingo would know better.  What kind of
 >>stress testing were you doing?
 >
 >
 > indeed this looks suspect. Is this an SMP system?
 >
 > 	Ingo
 >

Actually no. It is an SMP ready system, but with a single PII 450. As I
responded to Lee's response, I am not sure that I completely trust the
results of this trace anyway.

I would like to know why you guys think this may be a false positive. Is
it just the extremely long latency? Or is there something else that
makes it look suspect?

By the way I just posted two more traces, one that I caught last night
and one from this morning:

This is another one similar to the last but much more reasonably latency:

http://www.cybsft.com/testresults/2.6.8.1-P7/2.6.8.1-P7-1.txt

And this one this morning appears to be from updatedb running, while the
  tests were running. It's worth noting that this one appears to have
happened about the same time today that the other ~4100+ one happened
yesterday. Also worth noting is that the system was probably swapping
pretty good when this occurred.

http://www.cybsft.com/testresults/2.6.8.1-P7/2.6.8.1-P7-2.txt

kr
