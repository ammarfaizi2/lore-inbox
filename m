Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319152AbSIKPle>; Wed, 11 Sep 2002 11:41:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319155AbSIKPle>; Wed, 11 Sep 2002 11:41:34 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:62277 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S319152AbSIKPld>; Wed, 11 Sep 2002 11:41:33 -0400
To: "David S. Miller" <davem@redhat.com>
Cc: mbligh@aracnet.com, hadi@cyberus.ca, tcw@tempest.prismnet.com,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com, niv@us.ibm.com
Subject: Re: Early SPECWeb99 results on 2.5.33 with TSO on e1000
References: <m1hegwoppm.fsf@frodo.biederman.org>
	<477096648.1031728254@[10.10.2.3]>
	<m1d6rko9ab.fsf@frodo.biederman.org>
	<20020911.081521.103561835.davem@redhat.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 11 Sep 2002 09:31:53 -0600
In-Reply-To: <20020911.081521.103561835.davem@redhat.com>
Message-ID: <m18z28o846.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@redhat.com> writes:

>    From: ebiederm@xmission.com (Eric W. Biederman)
>    Date: 11 Sep 2002 09:06:36 -0600
> 
>    "Martin J. Bligh" <mbligh@aracnet.com> writes:
>    
>    > We can push about 420MB/s of IO out of this thing (out of that 
>    > theoretical 800Mb/s). 
>    
>    Sounds about average for a P3.  I have pushed the full 800MiB/s out of
>    a P3 processor to memory but it was a very optimized loop.
> 
> You pushed that over the PCI bus of your P3?  Just to RAM
> doesn't count, lots of cpu's can do that.
> 
> That's what makes his number interesting.

I agree. Getting 420MB/s to the pci bus is nice, especially with a P3.  
The 800MB/s to memory was just the test I happened to conduct about 2 years
ago when I was still messing with slow P3 systems.  It was a proof of
concept test to see if we could plug in an I/O card into a memory
slot.  

On a current P4 system with the E7500 chipset this kind of thing is
easy.  I have gotten roughly 450MB/s to a single myrinet card.  And there 
is enough theoretical bandwidth to do 4 times that.  I haven't had a
chance to get it working in practice.  When I attempted to run to gige
cards simultaneously I had some weird problem (probably interrupt
related) where adding additional pci cards did not deliver any extra
performance.  

On a P3 to get writes from the cpu to hit 800MB/s you use the special
cpu instructions that bypass the cache.  

My point was that I have tested the P3 bus in question and I achieved
a real world 800MB/s over it.  So I expect that on the system in
question unless another bottleneck is hit, it should be possible to
achieve a real world 800MB/s of I/O.  There are enough pci busses
to support that kind of traffic.

Unless the memory controller is carefully placed on the system though
doing 400+MB/s could easily eat up most of the available memory
bandwidth and reduce the system to doing some very slow cache line fills.

Eric
