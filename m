Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130863AbRCFCNa>; Mon, 5 Mar 2001 21:13:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130867AbRCFCNV>; Mon, 5 Mar 2001 21:13:21 -0500
Received: from [38.204.212.32] ([38.204.212.32]:62356 "HELO srv2.ecropolis.com")
	by vger.kernel.org with SMTP id <S130863AbRCFCNI>;
	Mon, 5 Mar 2001 21:13:08 -0500
Date: Mon, 5 Mar 2001 21:13:04 -0500 (EST)
From: Jeremy Hansen <jeremy@xxedgexx.com>
X-X-Sender: <jeremy@srv2.ecropolis.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: scsi vs ide performance on fsync's
In-Reply-To: <97p1ek$10t$1@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33L2.0103052108590.32449-100000@srv2.ecropolis.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2 Mar 2001, Linus Torvalds wrote:

> In article <Pine.LNX.4.33L2.0103021241550.14586-200000@srv2.ecropolis.com>,
> Jeremy Hansen  <jeremy@xxedgexx.com> wrote:
> >
> >The SCSI adapter on the raid array is an Adaptec 39160, the raid
> >controller is a CMD-7040.  Kernel 2.4.0 using XFS for the filesystem on
> >the raid array, kernel 2.2.18 on ext2 on the IDE drive.  The filesystem is
> >not the problem, as I get almost the exact same results running this on
> >ext2 on the raid array.
>
> Did you try a 2.4.x kernel on both?

Finally got around to working on this.

Right now I'm running 2.4.2-ac11 on both machines and getting the same
results:

SCSI:

[root@orville /root]# time /root/xlog file.out fsync

real    0m21.266s
user    0m0.000s
sys     0m0.310s

IDE:

[root@kahlbi /root]# time /root/xlog file.out fsync

real    0m8.928s
user    0m0.000s
sys     0m6.700s

This behavior has been noticed by others, so I'm hoping I'm not just crazy
or that my test is somehow flawed.

We're using MySQL with Berkeley DB for transaction log support.  It was
really confusing when a simple ide workstation was out performing our
Ultra160 raid array.

Thanks
-jeremy

> 2.4.0 has a bad elevator, which may show problems, so please check 2.4.2
> if the numbers change. Also, "fsync()" is very different indeed on 2.2.x
> and 2.4.x, and I would not be 100% surprised if your IDE drive does
> asynchronous write caching and your RAID does not... That would not show
> up in bonnie.
>
> Also note how your bonnie file remove numbers for IDE seem to be much
> better than for your RAID array, so it is not impossible that your RAID
> unit just has a _huge_ setup overhead but good throughput, and that the
> IDE numbers are better simply because your IDE setup is much lower
> latency. Never mistake throughput for _speed_.
>
> 		Linus
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-- 
this is my sig.

