Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262640AbREZLSV>; Sat, 26 May 2001 07:18:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262638AbREZLSN>; Sat, 26 May 2001 07:18:13 -0400
Received: from fungus.teststation.com ([212.32.186.211]:27115 "EHLO
	fungus.svenskatest.se") by vger.kernel.org with ESMTP
	id <S262640AbREZLSH>; Sat, 26 May 2001 07:18:07 -0400
Date: Sat, 26 May 2001 13:17:47 +0200 (CEST)
From: Urban Widmark <urban@teststation.com>
To: Jay Thorne <Yohimbe@userfriendly.org>
cc: George France <france@handhelds.org>, <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: Alpha SMP Low Outbound Bandwidth
In-Reply-To: <990836703.27355.6.camel@gracie.userfriendly.org>
Message-ID: <Pine.LNX.4.30.0105260239260.1953-100000@cola.teststation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 25 May 2001, Jay Thorne wrote:

> Netperf is a pretty good idea. Should not be a cpu bottleneck. Thats a
> good thing. So pretty much the same results as wu-ftpd: Note that I used
> the 466 mhz quad with a via-rhine, since the 400 locked up and was still
> fscking when I started this test.
> 
>              Recv   Send    Send                          
>              Socket Socket  Message  Elapsed              
>              Size   Size    Size     Time     Throughput  
>              bytes  bytes   bytes    secs.    10^6bits/sec  
> 
> To alpha     87380  16384  16384    10.02      39.25   
> x86 local    87380  16384  16384    9.99      559.46
> alpha local  87380  16384  16384    10.01     547.27   
> alp to x86   87380  16384  16384    10.01      25.77   
> another x86  87380  16384  16384    9.99      553.67   
> to same x86  87380  16384  16384    10.00      82.79   
> and back     87380  16384  16384    10.00      93.89   

What type of NIC is in the x86'es? If they are not the same, what happens
if you put one of those in the alphas?
(and what happens with the via-rhine if put in one of the x86'es?)


Alphas don't like unaligned memory accesses (not sure how bad those are).  
I think that you can get some idea on the frequence of those with 'cat
/proc/cpuinfo' where it should say "kernel unaligned acc" and then some
numbers.

If that first number keeps going up then the driver(s) or something isn't
being nice. Well, just a though. Oh yes, your original message showed a
value of 1646246 for kernel space unaligned accesses. Is that high?

The userspace value is 0, so I assume that is high. The value for 'pc='
should give the address of where the last unaligned access took place
(look it up in System.map or /proc/ksyms)

Does the value grow faster when you run your netperf tests?


That still doesn't explain the SMP vs UP difference.

/Urban

