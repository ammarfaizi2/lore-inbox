Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273923AbRIXOIi>; Mon, 24 Sep 2001 10:08:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273921AbRIXOI2>; Mon, 24 Sep 2001 10:08:28 -0400
Received: from mx3.arach.net.au ([203.30.44.5]:12002 "HELO
	mandible.arach.net.au") by vger.kernel.org with SMTP
	id <S273918AbRIXOIR>; Mon, 24 Sep 2001 10:08:17 -0400
X-Qmail-Scanner-Mail-From: kuib-kl@ljbc.wa.edu.au via mandible.arach.net.au
X-Qmail-Scanner: 1.01 (Clean. Processed in 0.28687 secs)
Message-ID: <B0005839269@gollum.logi.net.au>
Content-Type: text/plain; charset=US-ASCII
From: Beau Kuiper <kuib-kl@ljbc.wa.edu.au>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4.10 improved reiserfs a lot, but could still be better
Date: Mon, 24 Sep 2001 22:09:59 +0800
X-Mailer: KMail [version 1.3]
Cc: reiserfs-list@namesys.com
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all again,

I have updated my last set of patches for reiserfs to run on the 2.4.10 
kernel.

The new set of patches create a new method to do kupdated syncs. On 
filesystems that do no support this new method, the regular write_super 
method is used. Then reiserfs on kupdated super_sync, simply calls the 
flush_old_commits code with immediate mode off. 

The reiserfs improvements in 2.4.10 are great, but still not as good as 
2.2.19 was.

I have run two benchmarks on:

   the 2.4.9 kernel (plain, slow, starting point)
   the 2.4.9 kernel (with kupdated disabled, this is where we want to be)
   the 2.4.10 kernel (plain, quite fast though)
   the 2.4.10 kernel with my patches.

The benchmarks are:

   dbench 10 (done 4 times, with first result discarded)
   kernel compliation times (done twice, with first result discarded)

The first result in all benchmarks is discarded because it is used to set up 
the cache to a consistant state.

All benchmarks are run on the following machine:

Duron 700
VIA KT133 northbridge and 686A southbridge.
384meg RAM
40 gig IBM drive (7200rpm, GXP60)

The IBM drive has its internal write caching disabled (because it is damned 
good :-) ) since it hides the problems that my old drive had (I upgraded a 
few days ago)

I was going to use an old Quantum 5400rpm drive for these benchmarks but I 
blew it up ;-) (I got fire!! on one of the chips and everything, somehow 
managed to plug power cable into it backwards) Its smell is still lingering 
as I write this. Could someone with a slow 5400rpm drive do these tests and 
report back.

Anyway, enough yabbering, onto the results

---- 2.4.9 (plain)

dbench: 25.6155, 24.4236, 26.05 MB/Sec

kernel compile: 5.41.744 wall time, 4.43.880 user time, 0.16.380 sys time

---- 2.4.9 (kupdated off)

dbench: 33.763, 36.452, 32.0602 MB/Sec

kernel compile: 5.7.967 wall time, 4.44.140 user time, 0.15.380 sys time

---- 2.4.10 (plain)

dbench: 35.3584, 31.1634, 32.3602 MB/Sec

kernel compile: 5.21.458 wall time, 4.43.840 user time, 0.14.590 sys time

---- 2.4.10 (patched with attached patch)

dbench : 35.028, 33.6774, 38.2342 MB/Sec

kernel compile: 5.4.640 wall time, 4.42.950 user time, 0.15.160 sys time

Conclusions:

The 2.4.10 kernel improved reiserfs performace a lot all by itself, 
especially in dbench. In kernel compiles, however (maybe because dbench 
doesn't stress kupdated much), it still isn't as fast as my new patch.

Also, the performace problems seem to be very dependant on the hardware being 
used. 5400rpm drives get hurt a lot, while 7200 rpm drives seem to handle it 
better. Decent write caching on IDE devices (like the 2meg buffer on the IBM) 
can completely hide this issue.

Thanks to everyone who has helped me so far, and I look forward to further 
comments and assistance,
Beau Kuiper
kuib-kl@ljbc.wa.edu.au
