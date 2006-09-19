Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750790AbWISOBI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750790AbWISOBI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 10:01:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751984AbWISOBI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 10:01:08 -0400
Received: from smarthost2.sentex.ca ([205.211.164.50]:2782 "EHLO
	smarthost2.sentex.ca") by vger.kernel.org with ESMTP
	id S1750790AbWISOBH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 10:01:07 -0400
From: "Stuart MacDonald" <stuartm@connecttech.com>
To: "'Samuel Tardieu'" <sam@rfc1149.net>, <linux-kernel@vger.kernel.org>
Subject: RE: TCP stack behaviour question
Date: Tue, 19 Sep 2006 10:00:49 -0400
Organization: Connect Tech Inc.
Message-ID: <006301c6dbf4$035a71c0$294b82ce@stuartm>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
In-Reply-To: <87wt802hd9.fsf@willow.rfc1149.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: On Behalf Of Samuel Tardieu
> >>>>> "Stuart" == Stuart MacDonald <stuartm@connecttech.com> writes:
> Stuart> I suppose that the TCP retransmits aren't being sent because
> Stuart> the ethernet and/or IP layers don't know what's going on,
> Stuart> which is what's producing the arps. Is that correct?
> 
> It seems correct. You cannot expect TCP packets to be sent if the
> target is supposedly on a directly connected network and ARP cannot
> get its MAC address. What should the IP layer put as the MAC address
> if it is unknown?

I'd agree, but the MAC is/was known. Only part way through the
sequence of retransmits (with MAC filled in) do the arps start. Also,
tellingly maybe, the first three arps are sent directly to the
unreachable MAC. Only after those are unanswered are broadcast arps
attempted.

Ah, interesting, see below. ***

> You may want to run another test with another unreachable target
> located after a router, so that the MAC address of the router is used
> on the wire. You should see all the TCP retransmits you expect to see.

I'll try that if I have time, but I agree, I expect to see all the
retransmits in that case.


*** I found arp(7) and read up on it while I was typing. And now I see
something interesting in the tcpdump; my app is actually talking on
two TCP connections at the same time. Both are in retransmit phase,
and the first arp is 5 seconds (delay_first_probe_time) after an
_aggregate total_ of 15 retransmits (being the two original unanswered
packets and 7 and 6 retransmits of each).

My reading of tcp(7)'s documentation of tcp_retries2 is that
tcp_retries2 is a per-TCP packet count. My tcpdump seems to show that
it is in fact a global count. Which is correct?

..Stu

