Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262389AbVCIX7C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262389AbVCIX7C (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 18:59:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262400AbVCIX6N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 18:58:13 -0500
Received: from www.rapidforum.com ([80.237.244.2]:32654 "HELO rapidforum.com")
	by vger.kernel.org with SMTP id S262544AbVCIXxH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 18:53:07 -0500
Message-ID: <422F8C58.4000809@rapidforum.com>
Date: Thu, 10 Mar 2005 00:52:56 +0100
From: Christian Schmid <webmaster@rapidforum.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a3) Gecko/20040817
X-Accept-Language: de, en
MIME-Version: 1.0
To: Ben Greear <greearb@candelatech.com>
CC: Nick Piggin <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org
Subject: Re: BUG: Slowdown on 3000 socket-machines tracked down
References: <4229E805.3050105@rapidforum.com> <422BAAC6.6040705@candelatech.com> <422BB548.1020906@rapidforum.com> <422BC303.9060907@candelatech.com> <422BE33D.5080904@yahoo.com.au> <422C1D57.9040708@candelatech.com> <422C1EC0.8050106@yahoo.com.au> <422D468C.7060900@candelatech.com> <422DD5A3.7060202@rapidforum.com> <422F8A8A.8010606@candelatech.com>
In-Reply-To: <422F8A8A.8010606@candelatech.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yes, 2.6.11.  I have tuned max_backlog and some other TCP and networking
> related settings to give more buffers etc to networking tasks.  I have not
> tried any significant disk-IO while doing these tests.
> 
> I finally got my systems set up so I can run my WAN emulator at full 1Gbps:
> 
> I am getting right at 986Mbps throughput with 30ms round-trip latency
> (15ms in both directions).
> 
> So, latency does not seem to be the problem either.
> 
> I think the problem can be narrowed down to:
> 
> 1)  Non-optimal kernel network tunings on your server.

I used all the default-settings on 2.6.11

> 2)  Disk-IO (my disk is small and slow compared to a 'real' server, not 
> sure I can
>      really test this side of things, and I have not tried as of yet.)

This doesnt explain the speed-up when I change lower_zone_protection from 0 to 1024. It also doesnt 
explain the slowdown on 2.6.11 compared to 2.6.10

> 3)  Your clients have much more latency and/or don't have enough bandwidth
>      to fully load your server.  Since you didn't answer before:  I 
> assume you
>      do not have a reliable test bed and are just hoping that enough 
> clients connect
>      to do your benchmarking.

Yes I just wait until they connect. On the graph it only takes about 2 minutes until 3000 sockets 
are created again.

> 4)  There is something strange with sendfile and/or your application's 
> coding.

I am not doing more than calling sendfile. There  is nothing one can do wrong.

> My suggestion would be to eliminate these variables by coming up with a 
> repeatable
> test bed, alternative traffic generators, WAN/Network emulators for 
> latency, etc.

The problem still is that 1) it speeds up immediately when lower_zone_protection is raised to 1024. 
This proves it is NOT a disk-bottleneck. And second: it got much worse with 2.6.11 and 
lower_zone_protection disappeared on 2.6.11

Chris
