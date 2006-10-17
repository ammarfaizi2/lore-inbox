Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751223AbWJQTkY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751223AbWJQTkY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 15:40:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751228AbWJQTkY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 15:40:24 -0400
Received: from sp604001mt.neufgp.fr ([84.96.92.60]:52118 "EHLO Smtp.neuf.fr")
	by vger.kernel.org with ESMTP id S1751223AbWJQTkX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 15:40:23 -0400
Date: Tue, 17 Oct 2006 21:28:21 +0200
From: Eric Dumazet <dada1@cosmosbay.com>
Subject: Re: BUG: warning at kernel/softirq.c:141/local_bh_enable()
In-reply-to: <20061017191814.55313.qmail@web57803.mail.re3.yahoo.com>
To: John Philips <johnphilips42@yahoo.com>
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Message-id: <45352ED5.70505@cosmosbay.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 8BIT
References: <20061017191814.55313.qmail@web57803.mail.re3.yahoo.com>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Philips a écrit :
>> Hum, given your slow cpu, you might revert tx queue
>> length to 2.4.XX level 
>> (100 instead of 1000)
> 
> I tried that, it didn't help any.
> 
>> Are you sure you cannot post here : 
>>
>> tc -s -d qdisc show dev eth6
> 
> As I said, there are rules in place for every single
> IP in a /22 subnet.  It would be over 12000 lines.  I
> tried turning off the traffic shaping, it didn't help.
>  
>> You might want to make inet_peer_cache purge faster
>> :
>>
>> echo 1 >/proc/sys/net/ipv4/inet_peer_gc_mintime
>> echo 2 >/proc/sys/net/ipv4/inet_peer_gc_maxtime
> 
> I tried that as well, unfortunately it didn't help.

This was just to reduce size of the table (and time of the lookups), not to 
solve the nic problem at all :)

> 
> It's worth noting that this behavior happens at
> seemingly random times for random amounts of time.  It
> also causes the interface to auto-negotiate it's
> settings again.  During these periods, ping times to a
> switch plugged directly into eth6 are 4000+ms.  When I
> statically set the interface to 100baseT/full duplex
> with mii-tool, ping times to the switch immediately
> return to normal.  Unfortunately this fix only lasts a
> few minutes, because the interface hangs up and
> returns to auto-negotiation.
> 
> Also, I know this isn't a problem with my hardware
> since it started happening immediately after I
> upgraded the kernel from 2.4.25.

Yes, I supposed that your hardware was running OK with previous kernels.

Which NIC driver is handling eth6 ?

