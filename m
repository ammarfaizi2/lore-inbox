Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269778AbRHIMH1>; Thu, 9 Aug 2001 08:07:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269779AbRHIMHS>; Thu, 9 Aug 2001 08:07:18 -0400
Received: from dmi1fw.dmi.dk ([130.226.64.130]:16086 "EHLO dmi1fw.dmi.dk")
	by vger.kernel.org with ESMTP id <S269778AbRHIMHI>;
	Thu, 9 Aug 2001 08:07:08 -0400
From: Kim Bisgaard <kib@dmi.dk>
Date: Thu, 9 Aug 2001 14:07:20 +0200 (MET DST)
Message-Id: <200108091207.OAA10720@berta>
To: linux-kernel@vger.kernel.org
CC: lastec@dmi.dk, kib@dmi.dk
Subject: Random core dumps, and misreading files
Content-Type: text
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I gets random core dumps and and misreading of files. The chances for provoking
there errors, increases with the amount of memory used.

With misreadings of files I mean eg. copy a large file then compare several
times and get different answers each time.

I have seen this in kernels 2.4.4-7, in both 1GB and 4GB settings, and using
kgcc and gcc-2.96-69. 

The HW is AMD Athlon 1100, 1.5GB memory, VIA Apollo KT133 chipset.

I have used a memory test program, which ran without any problems!
- memtest: http://www.qcc.sk.ca/~charlesc/software/memtester/
     version is v.2.93.1 by Charles Cazabon <memtest@discworld.dyndns.org>
     dynamic version (libc.so.6 and ld-linux.so.2) (28/12/2000)


Good ways to provoke the error is to create a couple of ~2GB files, the files
have to get in and out of the file system cache, in order to go different.

Error scenario:
% cmp clout010629part001.dump.gz clout010629part001.dump.2.gz
clout010629part001.dump.gz clout010629part001.dump.2.gz differ: char 2351101, line 7984
% gunzip -vt clout010629part001.dump.2.gz &
% gunzip -vt clout010629part001.dump.gz&
gunzip: clout010629part001.dump.2.gz: invalid compressed data--crc error
[3]    Done                          gunzip -vt clout010629part001.dump.gz
[2]  - Exit 1                        gunzip -vt clout010629part001.dump.2.gz
% cmp clout010629part001.dump.gz clout010629part001.dump.2.gz
clout010629part001.dump.gz clout010629part001.dump.2.gz differ: char 1253855229, line 4124979
% cmp clout010629part001.dump.gz clout010629part001.dump.2.gz
cmp: clout010629part001.dump.gz: Input/output error
% gunzip -vt clout010629part001.dump.2.gz
clout010629part001.dump.2.gz:        OK
% gunzip -vt clout010629part001.dump.gz
clout010629part001.dump.gz:   OK
% cmp clout010629part001.dump.gz clout010629part001.dump.2.gz
% gunzip -tv clout010629part001.dump.2.gz &
% gunzip -tv clout010629part001.dump.gz &
gunzip: clout010629part001.dump.2.gz: invalid compressed data--crc error
gunzip: clout010629part001.dump.gz: invalid compressed data--crc error
gunzip: clout010629part001.dump.gz: invalid compressed data--length error
% 


A zap from top during these tests:

% top
    1:44pm  up 2 days, 22:04,  6 users,  load average: 2.03, 1.22, 0.81
205 processes: 202 sleeping, 3 running, 0 zombie, 0 stopped
CPU states: 13.3% user, 37.3% system,  0.0% nice, 49.3% idle
Mem:   899996K av,  896940K used,    3056K free,       0K shrd,    3556K buff
Swap: 5210256K av,  224132K used, 4986124K free                  851892K cached

  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
 9290 kib       18   0   352  352   288 R    25.2  0.0   0:20 cmp
 9289 kib       19   0   384  384   316 D    21.6  0.0   0:17 diff

I am available for further tests, and requests for more info.

Best Regards,
Kim Bisgaard

