Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319355AbSIFTfX>; Fri, 6 Sep 2002 15:35:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319358AbSIFTfX>; Fri, 6 Sep 2002 15:35:23 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:19105 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S319355AbSIFTfW>;
	Fri, 6 Sep 2002 15:35:22 -0400
Message-ID: <3D790499.8020501@colorfullife.com>
Date: Fri, 06 Sep 2002 21:40:09 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/4.0 (compatible; MSIE 5.5; Windows NT 4.0)
X-Accept-Language: en, de
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: haveblue@us.ibm.com, hadi@cyberus.ca, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: Early SPECWeb99 results on 2.5.33 with TSO on e1000
References: <3D78F55C.4020207@colorfullife.com> <20020906.113829.65591342.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
>    From: Manfred Spraul <manfred@colorfullife.com>
>    Date: Fri, 06 Sep 2002 20:35:08 +0200
> 
>    The second point was that interrupt mitigation must remain enabled, even 
>    with NAPI: the automatic mitigation doesn't work with process space 
>    limited loads (e.g. TCP: backlog queue is drained quickly, but the 
>    system is busy processing the prequeue or receive queue)
> 
> Not true.  NAPI is in fact a %100 replacement for hw interrupt
> mitigation strategies.  The cpu usage elimination afforded by
> hw interrupt mitigation is also afforded by NAPI and even more
> so by NAPI.
>    
> See Jamal's paper.
> 
I've read his paper: it's about MLFFR. There is no alternative to NAPI 
if packets arrive faster than they are processed by the backlog queue.

But what if the backlog queue is empty all the time? Then NAPI thinks 
that the system is idle, and reenables the interrupts after each packet :-(

In my tests, I've used a pentium class system (I have no GigE cards - 
that was the only system where I could saturate the cpu with 100MBit 
ethernet). IIRC 30% cpu time was needed for the copy_to_user(). The 
receive queue was filled, the backlog queue empty. With NAPI, I got 1 
interrupt for each packet, with hw interrupt mitigation the throughput 
was 30% higher for MTU 600.

Dave, do you have interrupt rates from the clients with and without NAPI?

--
	Manfred

