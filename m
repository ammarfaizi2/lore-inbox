Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135213AbRDLPyL>; Thu, 12 Apr 2001 11:54:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135212AbRDLPyB>; Thu, 12 Apr 2001 11:54:01 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:5133 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S135211AbRDLPx4>;
	Thu, 12 Apr 2001 11:53:56 -0400
Date: Thu, 12 Apr 2001 08:51:18 -0700
From: Anton Blanchard <anton@samba.org>
To: Maneesh Soni <smaneesh@in.ibm.com>
Cc: tridge@samba.org, lkml <linux-kernel@vger.kernel.org>,
        lse tech <lse-tech@lists.sourceforge.net>
Subject: Re: [Lse-tech] Re: [RFC][PATCH] Scalable FD Management using Read-Copy-Update
Message-ID: <20010412085118.A26665@va.samba.org>
In-Reply-To: <20010409201311.D9013@in.ibm.com> <20010411182929.A16665@va.samba.org> <20010412211354.A25905@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010412211354.A25905@in.ibm.com>; from smaneesh@in.ibm.com on Thu, Apr 12, 2001 at 09:13:54PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
Hi,

> Base (2.4.2) - 
>         100 Average Throughput = 39.628  MB/sec
>         200 Average Throughput = 22.792  MB/sec
> 
> Base + files_struct patch - 
>         100 Average Throughput = 39.874 MB/sec
>         200 Average Throughput = 23.174 MB/sec  
>          
> I found this value quite less than the one present in the README distributed
> with dbench tarball. I think the numbers in the README were for a similar 
> machine but with 2.2.9 kernel.

If you guestimate that each dbench client uses about 20M of RAM then dbench
100 has no chance of remaining in memory. Once you hit disk then spinlock
optimisations are all in the noise :) Smaller runs (< 30) should see 
it stay in memory.

Also if you turn of kupdated (so old buffers are not flushed out just
because they are old) and make the VM more agressive about filling
memory with dirty buffers then you will not hit the disk and then
hopefully the optimisations will be more obvious.

killall -STOP kupdated
echo "90 64 64 256 500 3000 95 0 0" > /proc/sys/vm/bdflush

Remember to killall -CONT kupdated when you are finished :)

> I am copying this to Andrew also, if he can also help. Also if you have some
> dbench numbers from 2.4.x kernel, please let me have a look into those also.

The single CPU 333MHz POWER 3 I was playing with got 100MB/s when not
touching disk.

Anton
