Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316534AbSE0JiH>; Mon, 27 May 2002 05:38:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316535AbSE0JiG>; Mon, 27 May 2002 05:38:06 -0400
Received: from mout0.freenet.de ([194.97.50.131]:21672 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id <S316534AbSE0JiE>;
	Mon, 27 May 2002 05:38:04 -0400
From: Andreas Hartmann <andihartmann@freenet.de>
X-Newsgroups: fa.linux.kernel
Subject: Memory management in Kernel 2.4.x
Date: Mon, 27 May 2002 11:40:50 +0200
Organization: Privat
Message-ID: <acsuv2$30v$1@ID-44327.news.dfncis.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Trace: susi.maya.org 1022492450 3103 192.168.1.3 (27 May 2002 09:40:50 GMT)
X-Complaints-To: abuse@fu-berlin.de
User-Agent: KNode/0.7.1
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all!


Unfortunately, the memory management of kernel 2.4.x didn't get better until 
today. It is very easy to make a machine dead. Take the following script:

http://groups.google.com/groups?q=malloc+bestie&hl=de&lr=&selm=slrn8aiglm.tqd.pfk@c.zeiss.de&rnum=2


The result with kernel 2.4.19pre8ac4:

May 27 11:04:21 athlon kernel: Out of Memory: Killed process 763 (knode).
May 27 11:04:22 athlon kernel: Out of Memory: Killed process 764 (knode).
May 27 11:04:22 athlon kernel: Out of Memory: Killed process 765 (knode).
May 27 11:04:22 athlon kernel: Out of Memory: Killed process 766 (knode).
May 27 11:04:40 athlon kernel: Out of Memory: Killed process 322 
(mozilla-bin).
May 27 11:04:40 athlon kernel: Out of Memory: Killed process 324 
(mozilla-bin).
May 27 11:04:40 athlon kernel: Out of Memory: Killed process 325 
(mozilla-bin).
May 27 11:04:40 athlon kernel: Out of Memory: Killed process 326 
(mozilla-bin).
May 27 11:04:40 athlon kernel: Out of Memory: Killed process 327 
(mozilla-bin).
May 27 11:04:40 athlon kernel: Out of Memory: Killed process 755 
(mozilla-bin).
May 27 11:04:40 athlon kernel: Out of Memory: Killed process 899 
(mozilla-bin).
May 27 11:04:40 athlon kernel: Out of Memory: Killed process 902 
(mozilla-bin).
May 27 11:04:40 athlon kernel: Out of Memory: Killed process 903 
(mozilla-bin).
May 27 11:04:54 athlon kernel: Out of Memory: Killed process 295 (kdeinit).
May 27 11:05:00 athlon kernel: Out of Memory: Killed process 293 (kdeinit).
May 27 11:05:05 athlon kernel: Out of Memory: Killed process 283 (kdeinit).
May 27 11:05:13 athlon kernel: Out of Memory: Killed process 932 (kdeinit).
May 27 11:05:16 athlon kernel: Out of Memory: Killed process 287 (kdeinit).
May 27 11:05:31 athlon kernel: Out of Memory: Killed process 300 (kdeinit).
May 27 11:05:31 athlon kernel: Out of Memory: Killed process 303 (korgac).
May 27 11:05:37 athlon kernel: Out of Memory: Killed process 297 (kwikdisk).
May 27 11:06:05 athlon kernel: Out of Memory: Killed process 292 (kdeinit).
May 27 11:06:46 athlon kernel: Out of Memory: Killed process 289 (kdeinit).
May 27 11:06:52 athlon kernel: Out of Memory: Killed process 269 (kdeinit).
May 27 11:06:57 athlon kernel: Out of Memory: Killed process 304 (kalarmd).
May 27 11:07:18 athlon kernel: Out of Memory: Killed process 286 (kdeinit).
May 27 11:07:21 athlon kernel: Out of Memory: Killed process 1103 (malloc).
May 27 11:07:21 athlon kernel: Out of Memory: Killed process 1103 (malloc).
May 27 11:07:34 athlon kernel: Out of Memory: Killed process 1104 (malloc).
May 27 11:07:52 athlon kernel: Out of Memory: Killed process 1104 (malloc).
May 27 11:08:04 athlon kernel: Out of Memory: Killed process 1105 (malloc).
May 27 11:09:12 athlon last message repeated 5 times
May 27 11:09:16 athlon kernel: Out of Memory: Killed process 1106 (malloc).
May 27 11:09:24 athlon kernel: Out of Memory: Killed process 1107 (malloc).
May 27 11:09:51 athlon kernel: Out of Memory: Killed process 1108 (malloc).
May 27 11:10:01 athlon kernel: Out of Memory: Killed process 1111 (malloc).
May 27 11:10:07 athlon kernel: Out of Memory: Killed process 1112 (malloc).
May 27 11:10:12 athlon kernel: Out of Memory: Killed process 1115 (malloc).
May 27 11:10:58 athlon kernel: Out of Memory: Killed process 1118 (malloc).
May 27 11:10:59 athlon kernel: Out of Memory: Killed process 1118 (malloc).
May 27 11:11:05 athlon kernel: Out of Memory: Killed process 1124 (malloc).
May 27 11:11:10 athlon kernel: Out of Memory: Killed process 1121 (malloc).
May 27 11:11:18 athlon kernel: Out of Memory: Killed process 1127 (malloc).
May 27 11:11:24 athlon kernel: Out of Memory: Killed process 1130 (malloc).
May 27 11:11:33 athlon kernel: Out of Memory: Killed process 1133 (malloc).
May 27 11:11:44 athlon kernel: Out of Memory: Killed process 1134 (malloc).
May 27 11:11:45 athlon kernel: Out of Memory: Killed process 1135 (malloc).
May 27 11:11:50 athlon kernel: Out of Memory: Killed process 1136 (malloc).
May 27 11:11:59 athlon kernel: Out of Memory: Killed process 1137 (malloc).
May 27 11:12:28 athlon kernel: Out of Memory: Killed process 1138 (malloc).
May 27 11:12:32 athlon kernel: Out of Memory: Killed process 1138 (malloc).
May 27 11:13:04 athlon kernel: Out of Memory: Killed process 1139 (malloc).
May 27 11:13:04 athlon kernel: Out of Memory: Killed process 1139 (malloc).


KDE was down. The machine didn't respond during this fork bomb.



I have got the same problem with an remote rsync via ssh when rsnc breaks 
down because of an data-error when rsyncing about 30 G of datas at the end 
of the session. With 2.4.x-kernels I need a lot of more memory for this 
process than with kernel 2.2.


Kind regards,
Andreas Hartmann
