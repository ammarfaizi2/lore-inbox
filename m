Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262324AbVCJE3y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262324AbVCJE3y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 23:29:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262563AbVCIXya
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 18:54:30 -0500
Received: from ns1.lanforge.com ([66.165.47.210]:7337 "EHLO www.lanforge.com")
	by vger.kernel.org with ESMTP id S261229AbVCIXpX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 18:45:23 -0500
Message-ID: <422F8A8A.8010606@candelatech.com>
Date: Wed, 09 Mar 2005 15:45:14 -0800
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.3) Gecko/20041020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christian Schmid <webmaster@rapidforum.com>
CC: Nick Piggin <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org
Subject: Re: BUG: Slowdown on 3000 socket-machines tracked down
References: <4229E805.3050105@rapidforum.com> <422BAAC6.6040705@candelatech.com> <422BB548.1020906@rapidforum.com> <422BC303.9060907@candelatech.com> <422BE33D.5080904@yahoo.com.au> <422C1D57.9040708@candelatech.com> <422C1EC0.8050106@yahoo.com.au> <422D468C.7060900@candelatech.com> <422DD5A3.7060202@rapidforum.com>
In-Reply-To: <422DD5A3.7060202@rapidforum.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Schmid wrote:

> Hmmmm.... can you try to following just to exclude some theories:
> 
> Run it with 4000 sockets and then do the following on the server-machine:
> 
> dd if=/dev/zero of=file1 bs=1M count=1024
> dd if=/dev/zero of=file2 bs=1M count=1024
> dd if=/dev/zero of=file3 bs=1M count=1024
> cat file1 > /dev/zero & cat file2 > /dev/zero & cat file3 > /dev/zero &
> 
> I THINK it might have something to do with caching-pressure or so. See 
> if there is a slow-down on the sending if the page-cache gets full and 
> has to be cleared again.
> 
> You are running 2.6.11?

Yes, 2.6.11.  I have tuned max_backlog and some other TCP and networking
related settings to give more buffers etc to networking tasks.  I have not
tried any significant disk-IO while doing these tests.

I finally got my systems set up so I can run my WAN emulator at full 1Gbps:

I am getting right at 986Mbps throughput with 30ms round-trip latency
(15ms in both directions).

So, latency does not seem to be the problem either.

I think the problem can be narrowed down to:

1)  Non-optimal kernel network tunings on your server.
2)  Disk-IO (my disk is small and slow compared to a 'real' server, not sure I can
      really test this side of things, and I have not tried as of yet.)
3)  Your clients have much more latency and/or don't have enough bandwidth
      to fully load your server.  Since you didn't answer before:  I assume you
      do not have a reliable test bed and are just hoping that enough clients connect
      to do your benchmarking.
4)  There is something strange with sendfile and/or your application's coding.

My suggestion would be to eliminate these variables by coming up with a repeatable
test bed, alternative traffic generators, WAN/Network emulators for latency, etc.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

