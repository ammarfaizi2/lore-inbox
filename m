Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261601AbUC3W6j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 17:58:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261597AbUC3WwT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 17:52:19 -0500
Received: from mail1.slu.se ([130.238.96.11]:17881 "EHLO mail1.slu.se")
	by vger.kernel.org with ESMTP id S261601AbUC3WvY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 17:51:24 -0500
From: Robert Olsson <Robert.Olsson@data.slu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Message-ID: <16489.62887.320005.806119@robur.slu.se>
Date: Wed, 31 Mar 2004 00:33:11 +0200
To: Andrea Arcangeli <andrea@suse.de>
Cc: "David S. Miller" <davem@redhat.com>, kuznet@ms2.inr.ac.ru,
       dipankar@in.ibm.com, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       Robert.Olsson@data.slu.se, paulmck@us.ibm.com, akpm@osdl.org
Subject: Re: route cache DoS testing and softirqs
In-Reply-To: <20040330213742.GL3808@dualathlon.random>
References: <20040329222926.GF3808@dualathlon.random>
	<200403302005.AAA00466@yakov.inr.ac.ru>
	<20040330211450.GI3808@dualathlon.random>
	<20040330133000.098761e2.davem@redhat.com>
	<20040330213742.GL3808@dualathlon.random>
X-Mailer: VM 7.17 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrea Arcangeli writes:

 > He posted these numbers:
 > 
 > 	softirq_count, ksoftirqd_count and other_softirq_count shows -
 > 	
 > 	CPU 0 : 638240  554     637686
 > 	CPU 1 : 102316  1       102315
 > 	CPU 2 : 675696  557     675139
 > 	CPU 3 : 102305  0       102305
 > 
 > that means nothing runs in ksoftirqd for Dipankar, so he cannot be using
 > NAPI.
 > 
 > Either that or I'm misreading his numbers, or his stats results are wrong.

 Well we have to ask Dipankar... But I'll buy a beer if it's not on. :)

 Anyway w. NAPI enabled. 2 * 304 kpps DoS flows into eth0, eth2. Flows 
 are 2 * 10 Millions 64 byte pkts. 32 k buckets routehash. Full Internet
 routing means ~130 k routes. Linux 2.6.4 2*2.66 MHz XEON. 


 26:        896          0   IO-APIC-level  eth0
 27:      25197          0   IO-APIC-level  eth1
 28:          8        579   IO-APIC-level  eth2
 29:         10      26112   IO-APIC-level  eth3

T-put is seen on output dev. eth1, eth3. So about 16% of incoming load,

eth0   1500   0 1577468 9631270 9631270 8422828    237      0      0      0 BRU
eth1   1500   0     42      0      0      0 1573355      0      0      0 BRU
eth2   1500   0 1636154 9603432 9603432 8363849     41      0      0      0 BRU
eth3   1500   0     54      0      0      0 1632274      0      0      0 BRU

And lots of 
.
.
printk: 1898 messages suppressed.
dst cache overflow
printk: 829 messages suppressed.
dst cache overflow

Cheers.
						--ro
