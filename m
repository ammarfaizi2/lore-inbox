Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129641AbRAXQKK>; Wed, 24 Jan 2001 11:10:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129764AbRAXQJu>; Wed, 24 Jan 2001 11:09:50 -0500
Received: from tstac.esa.lanl.gov ([128.165.46.3]:28374 "EHLO
	tstac.esa.lanl.gov") by vger.kernel.org with ESMTP
	id <S129641AbRAXQJj>; Wed, 24 Jan 2001 11:09:39 -0500
From: Steven Cole <scole@lanl.gov>
Reply-To: scole@lanl.gov
Date: Wed, 24 Jan 2001 09:08:57 -0700
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain;
  charset="us-ascii"
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
To: Jens Axboe <axboe@suse.de>
In-Reply-To: <01012208583400.01639@spc.esa.lanl.gov> <01012313294400.01045@spc.esa.lanl.gov> <20010123215419.A7435@suse.de>
In-Reply-To: <20010123215419.A7435@suse.de>
Subject: Re: 2.4.1pre8 slowdown on dbench tests
MIME-Version: 1.0
Message-Id: <01012409085700.02477@spc.esa.lanl.gov>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 23 January 2001 13:54, Jens Axboe wrote:
>
> Thanks! Could I talk you into doing one last run? pre8 with
> include/linux/elevator.h having these values set for
> ELEVATOR_LINUS:
>
Here are two sets of dbench 48 runs with that mod. I can't explain why the
second set is faster.  The second set was performed with no reboot after the 
first set.  The individual runs were performed with no wait in-between.

Steven

2.4.1-pre8 with changes to elevator.h, first run set
average:   9.52569 MB/sec

Throughput 9.51356 MB/sec (NB=11.892 MB/sec  95.1356 MBit/sec)
Throughput 9.43096 MB/sec (NB=11.7887 MB/sec  94.3096 MBit/sec)
Throughput 9.54195 MB/sec (NB=11.9274 MB/sec  95.4195 MBit/sec)
Throughput 9.61631 MB/sec (NB=12.0204 MB/sec  96.1631 MBit/sec)

2.4.1-pre8 same as above, second run set
average:   10.1621 MB/sec

Throughput 10.1236 MB/sec (NB=12.6546 MB/sec  101.236 MBit/sec)
Throughput 10.0304 MB/sec (NB=12.5381 MB/sec  100.304 MBit/sec)
Throughput 10.1844 MB/sec (NB=12.7305 MB/sec  101.844 MBit/sec)
Throughput 10.3099 MB/sec (NB=12.8873 MB/sec  103.099 MBit/sec)

Here is the change I made to elevator.h which you suggested:

--- elevator.h.orig     Wed Jan 24 07:12:00 2001
+++ elevator.h  Wed Jan 24 07:12:47 2001
@@ -94,8 +94,8 @@
 
 #define ELEVATOR_LINUS                                                 \
 ((elevator_t) {                                                              
  \
-       8192,                           /* read passovers */            \
-       16384,                          /* write passovers */           \
+       1000000,                                /* read passovers */          
  \
+       2000000,                                /* write passovers */         
  \
                                                                        \
        elevator_linus_merge,           /* elevator_merge_fn */         \
        elevator_linus_merge_cleanup,   /* elevator_merge_cleanup_fn */ \

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
