Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750854AbVIWJf5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750854AbVIWJf5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 05:35:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750852AbVIWJf5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 05:35:57 -0400
Received: from gw1.cosmosbay.com ([62.23.185.226]:712 "EHLO gw1.cosmosbay.com")
	by vger.kernel.org with ESMTP id S1750768AbVIWJf5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 05:35:57 -0400
Message-ID: <4333CC69.3000401@cosmosbay.com>
Date: Fri, 23 Sep 2005 11:35:37 +0200
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: akpm@osdl.org
CC: "David S. Miller" <davem@davemloft.net>, kiran@scalex86.org,
       rusty@rustcorp.com.au, dipankar@in.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 0/6] mm: alloc_percpu and bigrefs
References: <20050923062529.GA4209@localhost.localdomain>	<20050923001013.28b7f032.akpm@osdl.org> <20050923.001729.101033164.davem@davemloft.net> <4333C4E2.9000000@cosmosbay.com>
In-Reply-To: <4333C4E2.9000000@cosmosbay.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [172.16.8.80]); Fri, 23 Sep 2005 11:35:38 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton a écrit :
 > Eric Dumazet <dada1@cosmosbay.com> wrote:
 >
 >> Please (re)consider this patch since it really reduce CPU load and/or memory
 >> bus trafic between CPUS.
 >
 >
 > Did you actually measure this?   If so, you should publish the results.
 >
 >

Hi Andrew

Well yes I did.

Here is part of the mail sent on netdev one month ago :



Hi David

I played and I have very good results with the following patches.

# tc -s -d qdisc show dev eth0 ; sleep 10 ; tc -s -d qdisc show dev eth0
qdisc pfifo_fast 0: bands 3 priomap  1 2 2 2 1 2 0 0 1 1 1 1 1 1 1 1
  Sent 440173135511 bytes 3211378293 pkt (dropped 240817, overlimits 0 
requeues 27028035)
  backlog 0b 0p requeues 27028035
qdisc pfifo_fast 0: bands 3 priomap  1 2 2 2 1 2 0 0 1 1 1 1 1 1 1 1
  Sent 440216655667 bytes 3211730812 pkt (dropped 240904, overlimits 0 
requeues 27031668)
  backlog 0b 0p requeues 27031668

(So about 360 requeues per second, much better than before (12000 / second))

oprofile results give
0.6257  %    qdisc_restart  (instead of 2.6452 %)


thread is archived here :

http://marc.theaimsgroup.com/?l=linux-netdev&m=112521684415443&w=2

Thank you

Eric
