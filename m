Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266004AbRF1P4T>; Thu, 28 Jun 2001 11:56:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266003AbRF1P4K>; Thu, 28 Jun 2001 11:56:10 -0400
Received: from picard.csihq.com ([204.17.222.1]:15747 "EHLO picard.csihq.com")
	by vger.kernel.org with ESMTP id <S265997AbRF1Pz6>;
	Thu, 28 Jun 2001 11:55:58 -0400
Message-ID: <045001c0ffea$c72eb110$e1de11cc@csihq.com>
From: "Mike Black" <mblack@csihq.com>
To: "linux-kernel@vger.kernel.or" <linux-kernel@vger.kernel.org>,
        "raid" <linux-raid@vger.kernel.org>
Subject: 2.2.6-pre6 and ext3 Part III
Date: Thu, 28 Jun 2001 11:55:38 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Had to wait for raid5 resync to finish.
Was then able to do fsck without errors (before was running out of handles
in qlogicfc when both were simultaneous)
Now running the disks on ext2 with 2.2.6-pre6 and performance is better
except for sequential read and random write.
(saga of story is that ext3 and tiobench didn't get along very well with 4G
test files).

This is 7x36G fibre channel
Linux yeti 2.4.6-pre6 #2 SMP Thu Jun 28 07:22:13 EDT 2001 i686 unknown
root@yeti:/usr5# tiobench.pl --size 4000
Size is MB, BlkSz is Bytes, Read, Write, and Seeks are MB/secd . -T

         File   Block  Num  Seq Read    Rand Read   Seq Write  Rand Write
  Dir    Size   Size   Thr Rate (CPU%) Rate (CPU%) Rate (CPU%) Rate (CPU%)
------- ------ ------- --- ----------- ----------- ----------- -----------
   .     4000   4096    1  72.33 62.6% 0.854 0.71% 53.76 50.9% 1.344 1.03%
   .     4000   4096    2  63.60 58.3% 1.139 0.83% 44.38 48.3% 1.347 1.50%
   .     4000   4096    4  56.82 53.5% 1.392 1.51% 38.34 45.4% 1.352 1.52%
   .     4000   4096    8  52.84 50.8% 1.617 2.12% 33.94 42.5% 1.355 1.64%

Old performance with 2.4.5
Done 6/7/01
Linux yeti 2.4.5 #2 SMP Sat May 26 07:13:52 EDT 2001 i686 unknown
root@yeti:/usr5# tiobench.pl --size 4000
Size is MB, BlkSz is Bytes, Read, Write, and Seeks are MB/secd . -T

         File   Block  Num  Seq Read    Rand Read   Seq Write  Rand Write
  Dir    Size   Size   Thr Rate (CPU%) Rate (CPU%) Rate (CPU%) Rate (CPU%)
------- ------ ------- --- ----------- ----------- ----------- -----------
   .     4000   4096    1  81.48 65.7% 0.499 0.54% 34.33 24.0% 1.481 1.51%
   .     4000   4096    2  77.10 77.2% 0.643 0.96% 33.04 23.6% 1.493 1.81%
   .     4000   4096    4  67.18 72.4% 0.797 1.39% 28.03 20.8% 1.494 1.94%
   .     4000   4096    8  58.29 66.2% 0.954 1.95% 24.89 19.8% 1.498 2.15%

Here's performance on another drive set
Linux yeti 2.4.6-pre6 #2 SMP Thu Jun 28 07:22:13 EDT 2001 i686 unknown
root@yeti:/usr4# !tio
tiobench.pl --size 4000
Size is MB, BlkSz is Bytes, Read, Write, and Seeks are MB/secd . -T

         File   Block  Num  Seq Read    Rand Read   Seq Write  Rand Write
  Dir    Size   Size   Thr Rate (CPU%) Rate (CPU%) Rate (CPU%) Rate (CPU%)
------- ------ ------- --- ----------- ----------- ----------- -----------
   .     4000   4096    1  42.55 38.1% 0.809 1.39% 18.54 15.2% 0.967 0.61%
   .     4000   4096    2  32.19 28.8% 0.950 1.55% 17.77 17.9% 0.964 0.77%
   .     4000   4096    4  27.05 25.1% 1.069 1.46% 16.64 18.9% 0.960 0.83%
   .     4000   4096    8  23.78 22.5% 1.199 1.74% 15.37 19.1% 0.966 0.88%


Done 6/7/01
Linux yeti 2.4.5 #2 SMP Sat May 26 07:13:52 EDT 2001 i686 unknown
root@yeti:/usr4# tiobench.pl --size 4000
tiobench.pl --size 4000
Size is MB, BlkSz is Bytes, Read, Write, and Seeks are MB/secd . -T

         File   Block  Num  Seq Read    Rand Read   Seq Write  Rand Write
  Dir    Size   Size   Thr Rate (CPU%) Rate (CPU%) Rate (CPU%) Rate (CPU%)
------- ------ ------- --- ----------- ----------- ----------- -----------
   .     4000   4096    1  43.09 28.8% 0.430 0.44% 11.80 6.96% 1.020 0.65%
   .     4000   4096    2  36.25 24.7% 0.531 0.86% 11.34 6.79% 1.017 0.87%
   .     4000   4096    4  31.07 24.6% 0.624 0.95% 10.66 6.55% 1.022 1.00%
   .     4000   4096    8  27.10 23.7% 0.714 1.09% 9.826 6.38% 1.023 1.19%

________________________________________
Michael D. Black   Principal Engineer
mblack@csihq.com  321-676-2923,x203
http://www.csihq.com  Computer Science Innovations
http://www.csihq.com/~mike  My home page
FAX 321-676-2355

