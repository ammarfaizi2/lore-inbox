Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268339AbTGIOKJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 10:10:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268341AbTGIOKI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 10:10:08 -0400
Received: from sea2-f60.sea2.hotmail.com ([207.68.165.60]:9482 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S268339AbTGIOKD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 10:10:03 -0400
X-Originating-IP: [63.173.114.243]
X-Originating-Email: [kambo77@hotmail.com]
From: "Kambo Lohan" <kambo77@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: pktgen 1.2 hangs in rh 2.4.20-18 smp
Date: Wed, 09 Jul 2003 10:24:36 -0400
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <Sea2-F60CU9rEiKkZDD000025f4@hotmail.com>
X-OriginalArrivalTime: 09 Jul 2003 14:24:37.0021 (UTC) FILETIME=[D35B34D0:01C34625]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pktgen has intermittent stalls playing about 770mbits/sec traffic through an 
intel e1000 nic.  We are using count = clone_skb=1000000, looping it with a 
script.   Each run takes 10 seconds assuming it doesnt hang.  After putting 
in some code diagnostic code, pktgen is hanging after all packets are sent 
and it is looping waiting for the skb->users to get to 1.  So you have to 
hit control c to get it out of that loop.  We got tired of that so we made 
it go through the wait loop a max of 1000 times with a per loop mdelay(10) 
and then automatically break out.

We ran it overnight and got 49 instances where it had to give up after 
waiting 10 seconds for users to get to 1.  Each time, skb->users was stuck 
at 2.   This is a dual p3 600.

I suppose we can work around this by simply making the test infinite and 
break it when needed but the behavior was a little concerning...at least I 
dont know if these skbs are ever being finally released...

_________________________________________________________________
Help STOP SPAM with the new MSN 8 and get 2 months FREE*  
http://join.msn.com/?page=features/junkmail

