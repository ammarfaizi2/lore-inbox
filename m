Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317755AbSHOXgO>; Thu, 15 Aug 2002 19:36:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317772AbSHOXgO>; Thu, 15 Aug 2002 19:36:14 -0400
Received: from pina.terra.com.br ([200.176.3.17]:16089 "EHLO pina.terra.com.br")
	by vger.kernel.org with ESMTP id <S317755AbSHOXgN>;
	Thu, 15 Aug 2002 19:36:13 -0400
Date: Thu, 15 Aug 2002 20:40:04 -0300
From: Christian Reis <kiko@async.com.br>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: eepro100@scyld.com, nfs@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [NFS] General network slowness on SIS 530 with eepro100
Message-ID: <20020815204004.D1095@blackjesus.async.com.br>
References: <20020813212923.L2219@blackjesus.async.com.br> <shs1y92p7ho.fsf@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <shs1y92p7ho.fsf@charged.uio.no>; from trond.myklebust@fys.uio.no on Wed, Aug 14, 2002 at 03:13:55AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2002 at 03:13:55AM +0200, Trond Myklebust wrote:
> >>>>> " " == Christian Reis <kiko@async.com.br> writes:
> 
>      > Helle there,
> 
>      > I've been, for the past days, setting up a fairly big diskless
>      > network based on Linux. I've chosen to use 2.4.19 as the kernel
>      > because there were some hardware requirements, and for most of
>      > the newer boxes, it runs fine. However, for three of the older
>      > boxes, we have had some pretty odd performance and stability
>      > issues. This message is about the latest one, which is an ASUS
>      > P5S-B (has the infamous SIS 530 chipset) on an intel eepro100
>      > card. Details:
> 
> Is all this NFS over UDP? If so, numbers should not really have
> changed in 2.4.19 ( - yes my patchset changes things, but stock 2.4.19
> should not be too different w.r.t 2.4.18)

Trond, I've been looking at this a bit more. I've tried 2.4.18 and
2.2.21 and nothing changes - it always looks bad. If I look at top
output for

    time dd if=/dev/zero of=TESTFILE count=3000 bs=100k

rpciod is around 60% of CPU and there is 0% idle. A typical vmstat line
is:

  procs                      memory    swap          io     system cpu
r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs us  sy  id 
1  0  0      0  16228      4 197316   0   0     0     0 1426   603 14  86   0

Now, I contrast this to the other box (same CPU speed, other mobo):

  procs                      memory    swap          io     system cpu
r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs us  sy  id 
0  1  0      0 196216      0  53656   0   0     0     0  103     9   0 0 100

I see rpciod running, but very rarely. So any idea why rpciod would be
running and burning up CPU a lot in the first case, but not in the
second? Maybe I need a kernel profiler to go after the actual problem?

Take care,
--
Christian Reis, Senior Engineer, Async Open Source, Brazil.
http://async.com.br/~kiko/ | [+55 16] 261 2331 | NMFL
