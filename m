Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129584AbRAWUaj>; Tue, 23 Jan 2001 15:30:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130648AbRAWUa3>; Tue, 23 Jan 2001 15:30:29 -0500
Received: from tstac.esa.lanl.gov ([128.165.46.3]:37534 "EHLO
	tstac.esa.lanl.gov") by vger.kernel.org with ESMTP
	id <S129584AbRAWUaR>; Tue, 23 Jan 2001 15:30:17 -0500
From: Steven Cole <scole@lanl.gov>
Reply-To: scole@lanl.gov
Date: Tue, 23 Jan 2001 13:29:44 -0700
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain;
  charset="us-ascii"
Cc: lkml <linux-kernel@vger.kernel.org>
To: Jens Axboe <axboe@suse.de>, Marcelo Tosatti <marcelo@conectiva.com.br>
In-Reply-To: <01012208583400.01639@spc.esa.lanl.gov> <Pine.LNX.4.21.0101221823070.8054-100000@freak.distro.conectiva> <20010123001155.B8225@suse.de>
In-Reply-To: <20010123001155.B8225@suse.de>
Subject: Re: 2.4.1pre8 slowdown on dbench tests
MIME-Version: 1.0
Message-Id: <01012313294400.01045@spc.esa.lanl.gov>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 22 January 2001 16:11, Jens Axboe wrote:
>
> Stephen,
>
> To rule out other factors, could you try 2.4.1-pre8 with
> blk_started_io() and blk_finished_io() defined to nothing
> in include/linux/blkdev.h? This will disable the max-locked-buffers
> heuristic.
>
> Also, are the numbers above consistent for repeated runs (with
> boots in between)?

In the following table, 2.4.1-pre8x refers to -pre8 with
linux/include/linux/blkdev.h modified as suggested.
A diff to show the changes made is included at the end.

Here is a summary of the data, followed by the data
for the individual runs.  Each of the four runs were performed
in rapid succession, with no boots in between. 

Each run set had at least one boot in between.
This machine is dual 733mhz p-III, 255MB.

I didn't copy to lkml because this is rather lengthy,
but feel free to copy whatever you think is of general
interest.

Steven

2.4.1-pre4  run set 1 average:   9.77876 MB/sec
2.4.1-pre4  run set 2 average:   9.78904 MB/sec

2.4.1-pre8x run set 1 average:   9.56098 MB/sec
2.4.1-pre8x run set 2 average:   9.54694 MB/sec

2.4.1-pre8  run set 1 average:   9.25707 MB/sec
2.4.1-pre8  run set 2 average:   9.64841 MB/sec


2.4.1-pre4  (performed 18-January-2001)
average:   9.77876 MB/sec

Throughput 10.3677 MB/sec (NB=12.9597 MB/sec  103.677 MBit/sec)
Throughput 9.61291 MB/sec (NB=12.0161 MB/sec  96.1291 MBit/sec)
Throughput 9.92944 MB/sec (NB=12.4118 MB/sec  99.2944 MBit/sec)
Throughput 9.20502 MB/sec (NB=11.5063 MB/sec  92.0502 MBit/sec)

2.4.1-pre4  (performed 23-January-2001, repeat of above)
average:   9.78904 MB/sec

Throughput 10.1134 MB/sec (NB=12.6417 MB/sec  101.134 MBit/sec)
Throughput 9.71752 MB/sec (NB=12.1469 MB/sec  97.1752 MBit/sec)
Throughput 9.71035 MB/sec (NB=12.1379 MB/sec  97.1035 MBit/sec)
Throughput 9.6149 MB/sec (NB=12.0186 MB/sec  96.149 MBit/sec)

2.4.1-pre8x (performed 23-January-2001)
average:   9.56098 MB/sec

Throughput 9.98585 MB/sec (NB=12.4823 MB/sec  99.8585 MBit/sec)
Throughput 9.51678 MB/sec (NB=11.896 MB/sec  95.1678 MBit/sec)
Throughput 9.45918 MB/sec (NB=11.824 MB/sec  94.5918 MBit/sec)
Throughput 9.28211 MB/sec (NB=11.6026 MB/sec  92.8211 MBit/sec)

2.4.1-pre8x (performed 23-January-2001, repeat of above)
average:   9.54694 MB/sec

Throughput 9.59079 MB/sec (NB=11.9885 MB/sec  95.9079 MBit/sec)
Throughput 9.35774 MB/sec (NB=11.6972 MB/sec  93.5774 MBit/sec)
Throughput 9.60368 MB/sec (NB=12.0046 MB/sec  96.0368 MBit/sec)
Throughput 9.63557 MB/sec (NB=12.0445 MB/sec  96.3557 MBit/sec)

2.4.1-pre8: (performed 18-January-2001)
Average    9.25707 MB/sec

Throughput 8.93444 MB/sec (NB=11.1681 MB/sec  89.3444 MBit/sec)
Throughput 9.43609 MB/sec (NB=11.7951 MB/sec  94.3609 MBit/sec)
Throughput 9.5075 MB/sec (NB=11.8844 MB/sec  95.075 MBit/sec)
Throughput 9.15026 MB/sec (NB=11.4378 MB/sec  91.5026 MBit/sec)

2.4.1-pre8  (performed 23-January-2001, repeat of above)
average:   9.64841 MB/sec

Throughput 9.75834 MB/sec (NB=12.1979 MB/sec  97.5834 MBit/sec)
Throughput 9.70084 MB/sec (NB=12.1261 MB/sec  97.0084 MBit/sec)
Throughput 9.34317 MB/sec (NB=11.679 MB/sec  93.4317 MBit/sec)
Throughput 9.79128 MB/sec (NB=12.2391 MB/sec  97.9128 MBit/sec)

Here is the modification made to blkdev.h:

--- blkdev.h.orig       Tue Jan 23 09:07:43 2001
+++ blkdev.h    Tue Jan 23 09:08:32 2001
@@ -207,13 +207,7 @@
 }
 
 #define blk_finished_io(nsects)                                \
-       atomic_sub(nsects, &queued_sectors);            \
-       if (atomic_read(&queued_sectors) < 0) {         \
-               printk("block: queued_sectors < 0\n");  \
-               atomic_set(&queued_sectors, 0);         \
-       }
 
 #define blk_started_io(nsects)                         \
-       atomic_add(nsects, &queued_sectors);
 
 #endif

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
