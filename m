Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751170AbWJQTSQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170AbWJQTSQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 15:18:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751179AbWJQTSQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 15:18:16 -0400
Received: from web57803.mail.re3.yahoo.com ([68.142.236.81]:27068 "HELO
	web57803.mail.re3.yahoo.com") by vger.kernel.org with SMTP
	id S1751170AbWJQTSP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 15:18:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=ct+AJIrdOiD0iu57YLgBDO2hX1op6uhZmklU+K1I7zG4iNAA6kKYdNGerHq7uPs6ERplcwhaHU1Xlxi9/jMjpwgZAgr/a0hOLFMtzhxU4uajwx06iqB5iHt83PwF4Q7hroLJKcbxXqJ4Wh+kyod9/x6ya864cSQUD/7XOto9c9U=  ;
Message-ID: <20061017191814.55313.qmail@web57803.mail.re3.yahoo.com>
Date: Tue, 17 Oct 2006 12:18:14 -0700 (PDT)
From: John Philips <johnphilips42@yahoo.com>
Subject: Re: BUG: warning at kernel/softirq.c:141/local_bh_enable()
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
In-Reply-To: <200610171853.56170.dada1@cosmosbay.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hum, given your slow cpu, you might revert tx queue
> length to 2.4.XX level 
> (100 instead of 1000)

I tried that, it didn't help any.

> Are you sure you cannot post here : 
> 
> tc -s -d qdisc show dev eth6

As I said, there are rules in place for every single
IP in a /22 subnet.  It would be over 12000 lines.  I
tried turning off the traffic shaping, it didn't help.
 
> You might want to make inet_peer_cache purge faster
> :
> 
> echo 1 >/proc/sys/net/ipv4/inet_peer_gc_mintime
> echo 2 >/proc/sys/net/ipv4/inet_peer_gc_maxtime

I tried that as well, unfortunately it didn't help.

It's worth noting that this behavior happens at
seemingly random times for random amounts of time.  It
also causes the interface to auto-negotiate it's
settings again.  During these periods, ping times to a
switch plugged directly into eth6 are 4000+ms.  When I
statically set the interface to 100baseT/full duplex
with mii-tool, ping times to the switch immediately
return to normal.  Unfortunately this fix only lasts a
few minutes, because the interface hangs up and
returns to auto-negotiation.

Also, I know this isn't a problem with my hardware
since it started happening immediately after I
upgraded the kernel from 2.4.25.

Thanks.

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
