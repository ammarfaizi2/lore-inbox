Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269183AbRGaFn0>; Tue, 31 Jul 2001 01:43:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269184AbRGaFnQ>; Tue, 31 Jul 2001 01:43:16 -0400
Received: from cu344.adelaide.adsl.on.net ([150.101.235.90]:57863 "EHLO
	mars.foursticks.com.au") by vger.kernel.org with ESMTP
	id <S269183AbRGaFnG>; Tue, 31 Jul 2001 01:43:06 -0400
To: linux-kernel@vger.kernel.org
cc: pschulz@foursticks.com
Subject: Re: Linux sk_buff issues.
Date: Tue, 31 Jul 2001 15:13:03 +0930
From: Paul Schulz <pschulz@foursticks.com.au>
Message-Id: <E15RSJ5-0001mT-00@mars.foursticks.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Greetings,

In the 2.4.1 kernel..
While looking at the packet classifier code (net/sched/cls_u32.c) and other
ipv4 code that makes use of sk_buf, the following is observed:

-- There exist data structures in sk_buf for the mac layer (mac), net
	header (nh), and transport header (h).

-- These data structures contain explicit labels for the various header
	fields (depending on the protocol used) as well as a 'raw'
	field.

-- Most of the cls_u32 code and packet handling code uses the
	'raw' label in the data-structure.

Using kgdb, and tracing these datastructures, there are cases where the data
looks to be inconsistant. (for example, skb->nh.iph
points to one part of memory and skb->h.tcphdr points to a different part).
Also, the values seem to be different, eg., (struct udphdr *)((char
*)skb->nh.raw + 20)->source != skb->h.udp->source. I am assuming using
skb->nh.raw is the corrent version to use at this point. Is this correct and
are their any guidelines to be aware of?

Thanks,
Paul
--
                       Paul Schulz - Software Engineer
        Foursticks Pty Ltd - 2/259 Glen Osmond Road, Frewville, SA 5063
    Phone: +61 8 8338 5500   Fax: +61 8 8338 5511   Mobile: +61 401 981 301
       Email: pschulz@foursticks.com           Web: www.foursticks.com



