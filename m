Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271775AbRH2BBI>; Tue, 28 Aug 2001 21:01:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271780AbRH2BA7>; Tue, 28 Aug 2001 21:00:59 -0400
Received: from smtp6.mindspring.com ([207.69.200.110]:8476 "EHLO
	smtp6.mindspring.com") by vger.kernel.org with ESMTP
	id <S271779AbRH2BAw>; Tue, 28 Aug 2001 21:00:52 -0400
From: volodya@mindspring.com
Date: Tue, 28 Aug 2001 21:03:21 -0400 (EDT)
Reply-To: volodya@mindspring.com
To: Trond Myklebust <trond.myklebust@fys.uio.no>
cc: linux-kernel@vger.kernel.org
Subject: Re: NFS in 2.4.9
In-Reply-To: <shsbsl0ij35.fsf@charged.uio.no>
Message-ID: <Pine.LNX.4.20.0108282041120.23923-100000@node2.localnet.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 28 Aug 2001, Trond Myklebust wrote:

> >>>>> " " == volodya  <volodya@mindspring.com> writes:
> 
>      > I have upgraded to 2.4.9 and NFS no longer works for me. I get
>      > ---------------------------------------------------------------
>      > NFS: NFSv3 not supported.  nfs warning: mount version older
>      > than kernel
> 
> You forgot to enable NFSv3 support in your 2.4.9 kernel.

I did.. I'll make clean and recompile the kernel again, just in case. 
But still: why complain about mount ? Why allow to mount a partition ?
I do not think this is the cause (also see below).

> 
>      > ---------------------------------------------------------------
>      > even though I upgraded to the most recent version of util-linux
>      > (2.11h) and when reading certain files programs lock up and the
>      > kernel prints out the following messages:
> 
>      > nfs: server node4 not responding, still trying nfs: server
>      > node4 not responding, still trying
> 
>      > However, node4 is fine (I can telnet in it) and seems to work
>      > ok. (node4 is running 2.4.7, with knfsd).
> 
> In 99.999% of cases this is due to a network configuration
> error. Usually it's things like running full-duplex against a
> half-duplex capable switch etc.
> TCP is less sensitive to this sort of thing than UDP is, so you won't
> see it using telnet.

You were right about networking. It turns out that I can ping just fine 
when the packet size is 5524 and under (with header 5532). When I ping 
with size 5525 and above (with header 5533) no packets (at all !) get
thru. Pinging localhost goes fine. None of the machines on my local
network can ping with sizes about 5525. Using tcpdump shows that packets
do arrive on the interface. Setting wsize and rsize to 5000 helped - thank
you very much ! I guess that between 2.4.7 and 2.4.9 the default rsize and
wsize went up.

Now I am wondering what is wrong with large udp packets ? (my mtu is 
1500 and they do get chopped up in smaller packets, but so do size
5524). Any ideas ?

                  thanks !

                       Vladimir Dergachev

> 
> If you can't resolve where the problem lies, try setting rsize and
> wsize manually to some smaller value.
> 
> Cheers,
>   Trond
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

