Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273967AbRIXPzq>; Mon, 24 Sep 2001 11:55:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273965AbRIXPzh>; Mon, 24 Sep 2001 11:55:37 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:52749 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S273964AbRIXPza>; Mon, 24 Sep 2001 11:55:30 -0400
Message-ID: <3BAF5726.32C4204B@zip.com.au>
Date: Mon, 24 Sep 2001 08:54:14 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9-ac12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mike Black <mblack@csihq.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.10 and ext3
In-Reply-To: <02aa01c144f8$14a461e0$e1de11cc@csihq.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Black wrote:
> 
> Status report...
> Upgraded from 2.4.8 to 2.4.10 (with new 2.4.10 patch).
> This is on a dual PIII/1Ghz FibreChannel 2G RAM
> 
> Single-threaded Seq Read improves a LOT (doubles+)
> Multi-threaded Seq Read improved a bit
> Seq Write improves a LOT
> Rand Write decreases a bit
> All are using less CPU time.
> 
> Here's 2.4.8
> Linux yeti 2.4.8 #2 SMP Fri Aug 17 05:50:03 EDT 2001 i686 unknown
> Done 9/5/01
> root@yeti:/usr5# tiobench.pl --size 4000
> Size is MB, BlkSz is Bytes, Read, Write, and Seeks are MB/secd . -T
> 
>          File   Block  Num  Seq Read    Rand Read   Seq Write  Rand Write
>   Dir    Size   Size   Thr Rate (CPU%) Rate (CPU%) Rate (CPU%) Rate (CPU%)
> ------- ------ ------- --- ----------- ----------- ----------- -----------
>    .     4000   4096    1  39.83 30.8% 0.572 0.87% 21.83 55.8% 1.226 0.70%
>    .     4000   4096    2  21.30 21.2% 0.711 1.52% 9.695 70.0% 1.274 1.05%
>    .     4000   4096    4  18.86 19.6% 0.844 1.92% 9.568 70.1% 1.228 1.62%
>    .     4000   4096    8  17.38 18.7% 0.983 2.12% 5.995 98.7% 1.255 1.54%
> 
> Here's 2.4.10
> tiobench.pl --size 4000
> Size is MB, BlkSz is Bytes, Read, Write, and Seeks are MB/secd . -T
> 
>          File   Block  Num  Seq Read    Rand Read   Seq Write  Rand Write
>   Dir    Size   Size   Thr Rate (CPU%) Rate (CPU%) Rate (CPU%) Rate (CPU%)
> ------- ------ ------- --- ----------- ----------- ----------- -----------
>    .     4000   4096    1  85.57 46.9% 0.689 0.83% 26.02 28.7% 0.993 0.57%
>    .     4000   4096    2  28.08 16.4% 0.805 1.36% 25.71 36.4% 1.062 0.57%
>    .     4000   4096    4  22.50 13.5% 0.927 1.76% 16.69 26.3% 1.097 0.72%
>    .     4000   4096    8  20.37 12.6% 1.062 2.00% 13.01 21.5% 1.114 0.85%
> 

So the sequential write rate at eight threads has quadrupled, while
the CPU utilisation has halved.  That's OK :)

None of this will be due to ext3, BTW: it'll be due to VM and/or RAID5
improvements.

-
