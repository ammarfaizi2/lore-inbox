Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261392AbSJCS0S>; Thu, 3 Oct 2002 14:26:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261398AbSJCS0S>; Thu, 3 Oct 2002 14:26:18 -0400
Received: from mailout10.sul.t-online.com ([194.25.134.21]:55718 "EHLO
	mailout10.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261392AbSJCS0R>; Thu, 3 Oct 2002 14:26:17 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Andreas Pfaller <apfaller@yahoo.com.au>
To: lkml <linux-kernel@vger.kernel.org>
Subject: linux-2.4.20-pre8-ac3: NFS performance regression
Date: Thu, 3 Oct 2002 20:32:37 +0200
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200210032024.47664.apfaller@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While trying to get the onboard HPT372 working on a new motherboard
(Epox 8k5a2+ - KT333/VT8235) i tried successfully 2.4.20-pre8-ac3.
2.4.19 could read the fs on the HPT372 without any problem at full
media speed but could not write to it at all. I can provide details
if necessary. I did not use any of the raid stuff.

However I noticed a significant NFS performance drop with
2.4.20-pre8-ac3. Other network throughput is not affected.

Server: P-II 300, cheap RTL8139C, 2.4.19 (nearly vanilla).
Client: Athlon 2000+, onboard via-rhine.

### Client with linux-2.4.19 ###

[diavolo inferno-l2#> bonnie -s 1500 -S 100 -y -u
Bonnie 1.3: File './Bonnie.976', size: 1572864000, volumes: 1
Writing with putc_unlocked()...done:  10328 kB/s  10.5 %CPU
Rewriting...                   done:   4280 kB/s   3.2 %CPU
Writing intelligently...       done:  10319 kB/s   3.8 %CPU
Reading with getc_unlocked()...done:  10436 kB/s  14.3 %CPU
Reading intelligently...       done:  10712 kB/s   2.8 %CPU
Seeker 1...Seeker 2...Seeker 3...start 'em...done...done...done...
              ---Sequential Output (sync)----- ---Sequential Input-- --Rnd Seek-
              -CharUnlk- --Block--- -Rewrite-- -CharUnlk- --Block--- --00k (03)-
Machine    MB K/sec %CPU K/sec %CPU K/sec %CPU K/sec %CPU K/sec %CPU   /sec %CPU
diavol 1*1500 10328 10.5 10319  3.8  4280  3.2 10436 14.3 10712  2.8    9.3  3.0

# ftp transfer
1072458941 bytes received in 01:37 (10.53 MB/s)


### Client with linux-2.4.20-pre8-ac3 ###

[diavolo inferno-l2#> bonnie -s 1500 -S 100 -y -u
Bonnie 1.3: File './Bonnie.987', size: 1572864000, volumes: 1
Writing with putc_unlocked()...done:   7356 kB/s   7.6 %CPU
Rewriting...                   done:   3168 kB/s   1.3 %CPU
Writing intelligently...       done:   6939 kB/s   1.7 %CPU
Reading with getc_unlocked()...done:   7389 kB/s   7.0 %CPU
Reading intelligently...       done:   7722 kB/s   2.1 %CPU
Seeker 1...Seeker 3...Seeker 2...start 'em...done...done...done...
              ---Sequential Output (sync)----- ---Sequential Input-- --Rnd Seek-
              -CharUnlk- --Block--- -Rewrite-- -CharUnlk- --Block--- --00k (03)-
Machine    MB K/sec %CPU K/sec %CPU K/sec %CPU K/sec %CPU K/sec %CPU   /sec %CPU
diavol 1*1500  7356  7.6  6939  1.7  3168  1.3  7389  7.0  7722  2.1    9.9  3.8

[diavolo inferno-l2#> cat /proc/mounts | grep l2
inferno:/mnt/l2 /mnt/inferno-l2 nfs rw,v3,rsize=8192,wsize=8192,hard,intr,udp,lock,addr=inferno 0 0

# ftp transfer
1072458941 bytes received in 01:35 (10.69 MB/s)

Cheers,
Andreas

PS: Does a patch for only the HPT372 problem exist for 2.4.19? I get
somewhat nervous running an pre-ac kernel on a machine intended for
production use.



