Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129242AbRDMLkv>; Fri, 13 Apr 2001 07:40:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129408AbRDMLkl>; Fri, 13 Apr 2001 07:40:41 -0400
Received: from mailout02.sul.t-online.com ([194.25.134.17]:11526 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S129381AbRDMLkf> convert rfc822-to-8bit; Fri, 13 Apr 2001 07:40:35 -0400
Content-Type: text/plain; charset=US-ASCII
From: Andreas Peter <ujq7@rz.uni-karlsruhe.de>
To: linux-kernel@vger.kernel.org
Subject: SW-RAID0 Performance problems
Date: Fri, 13 Apr 2001 13:47:30 +0200
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01041313473002.00533@debian>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I've successfully set up SW-RAID0 with Kernel 2.4.3 and Raidtools 0.9.
I did this to increase the performance of my HD, but nothig happens.
The hdparm results:
hdparm -t /dev/md0 : 20.25 MB/sec
hdparm -t /dev/hda : 20.51 MB/sec
hdaprm -t /dev/hdc : 20.71 MB/sec

I thougt the performnace of RAID0 should near 40MB/sec.
I played with different chunk-sizes, but the result was everytime the same.
The drives are both Maxtor DiamondMax VL40, 30GB, DMA on. 
No other drive is attached on the bus.

Here are also some bonnie++ results:


-- RAID-0 --
-- chunk-size=16 --

Version  1.01        ------Sequential Output------ --Sequential Input- --Random-
                             -Per Chr- --Block-- -Rewrite-     -Per Chr- --Block-- --Seeks--
Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec %CP
debian           1G     7416    99  14277   20   7498     10   6942    90 27007    20 113.0      1
                       ------Sequential Create------ --------Random Create--------
                      -Create-- --Read--- -Delete-- -Create-- --Read--- -Delete--
              files   /sec %CP  /sec %CP    /sec %CP   /sec %CP   /sec %CP    /sec %CP
                 16   267    99  +++++ +++ 10968 100   269  99    +++++ +++  1388  99

-- chunk-size=32 --

Version  1.01       ------Sequential Output------ --Sequential Input- --Random-
                    -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec %CP
debian           1G    7396     99 14075    20  7469    10    6945    90   26960  20   133.7   1
                    ------Sequential Create------ --------Random Create--------
                    -Create-- --Read--- -Delete-- -Create-- --Read--- -Delete--
              files  /sec %CP  /sec %CP   /sec %CP   /sec %CP   /sec %CP    /sec %CP
                 16   265 100 +++++ +++ 10695  99    267   99   +++++ +++  1447 100

-- Single HD /dev/hdc1 --

Version  1.01       ------Sequential Output------ --Sequential Input- --Random-
                           -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec %CP
debian           1G   7173   96    11055  13     5038   6     5999     78    29146  21 90.7       1
                    ------Sequential Create------ --------Random Create--------
                    -Create-- --Read--- -Delete-- -Create-- --Read--- -Delete--
              files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP
                 16   272 100 +++++ +++ 10482  99   274  99 +++++ +++  1437 100

Are there known performanace problems with 2.4.3, or is it necessary to 
apply patches to the kernel? 
Or did I something wrong??
Thank you for every hint!

Andreas
-- 
Andreas Peter *** ujq7@rz.uni-karlsruhe.de

