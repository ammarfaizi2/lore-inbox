Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268883AbTBZTnl>; Wed, 26 Feb 2003 14:43:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268885AbTBZTnl>; Wed, 26 Feb 2003 14:43:41 -0500
Received: from mailrelay1.lanl.gov ([128.165.4.101]:22933 "EHLO
	mailrelay1.lanl.gov") by vger.kernel.org with ESMTP
	id <S268883AbTBZTnh>; Wed, 26 Feb 2003 14:43:37 -0500
Subject: Results of using tar with 2.5.[60 63 62-mm3] and reiser[fs 4],
	ext3, xfs.
From: Steven Cole <elenstev@mesatop.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@zip.com.au>, Hans Reiser <reiser@namesys.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 26 Feb 2003 12:50:06 -0700
Message-Id: <1046289007.6618.220.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings all,

I ran the following script for several recent kernels with
several journaling filesystems.  I patched in reiser4 from
namesys.com, downloaded yesterday.  Sorry, no jfs data.

#!/bin/sh
for i in 1 2 3 4 5
do
        time rm -rf linux-2.5.63
        time tar zxf linux-2.5.63.tar.gz
        time sync
        echo ' '
done

The following data is from the 5th run in each case.  The data seemed
fairly consistent, so I didn't average the runs.  All the results are
saved if anyone cares.

The tar files were created on the file systems being tested.

Brief summary: It looks like the order of performance for this
particular load is reiserfs, reiser4, ext3, xfs.
Something changed with ext3 behavior following 2.5.60,
and xfs takes the biggest hit from anticipatory i/o scheduler, (for
this load).

Minor footnote: to get reiser4 to compile with 2.5.62-mm3, it was 
necessary to s/UPDATE_ATIME/update_atime/g in some reiser4 files.

Steven

---------------------------------------------------------------------
2.5.60:

reiserfs:
rm -rf linux-2.5.63         0.02user 1.71system 0:02.16elapsed 80%CPU 
tar zxf linux-2.5.63.tar.gz 4.83user 5.86system 0:14.09elapsed 75%CPU 
sync                        0.00user 0.03system 0:00.96elapsed 3%CPU 

reiser4:
rm -rf linux-2.5.63         0.15user 3.26system 0:07.12elapsed 47%CPU 
tar zxf linux-2.5.63.tar.gz 4.86user 7.93system 0:15.18elapsed 84%CPU 
sync                        0.00user 0.35system 0:01.17elapsed 30%CPU 

ext3:
rm -rf linux-2.5.63         0.02user 0.56system 0:03.02elapsed 19%CPU 
tar zxf linux-2.5.63.tar.gz 5.04user 4.85system 0:23.03elapsed 42%CPU 
sync                        0.00user 0.04system 0:08.14elapsed 0%CPU 

xfs:
rm -rf linux-2.5.63         0.06user 2.46system 0:09.97elapsed 25%CPU 
tar zxf linux-2.5.63.tar.gz 4.94user 6.47system 0:35.17elapsed 32%CPU 
sync                        0.00user 0.01system 0:03.53elapsed 0%CPU 

---------------------------------------------------------------------
2.5.63:

reiserfs:
rm -rf linux-2.5.63         0.03user 1.73system 0:01.81elapsed 97%CPU 
tar zxf linux-2.5.63.tar.gz 4.86user 6.22system 0:14.39elapsed 77%CPU 
sync                        0.00user 0.02system 0:01.32elapsed 1%CPU 

reiser4:
rm -rf linux-2.5.63         0.18user 3.30system 0:06.50elapsed 53%CPU 
tar zxf linux-2.5.63.tar.gz 4.86user 8.09system 0:14.82elapsed 87%CPU 
sync                        0.00user 0.36system 0:01.13elapsed 31%CPU 

ext3:
rm -rf linux-2.5.63         0.02user 0.56system 0:00.67elapsed 86%CPU 
tar zxf linux-2.5.63.tar.gz 4.69user 4.77system 0:14.92elapsed 63%CPU 
sync                        0.00user 0.18system 0:15.11elapsed 1%CPU 

xfs:
rm -rf linux-2.5.63         0.04user 2.39system 0:07.07elapsed 34%CPU 
tar zxf linux-2.5.63.tar.gz 5.11user 6.63system 0:38.43elapsed 30%CPU 
sync                        0.00user 0.09system 0:03.59elapsed 2%CPU 

---------------------------------------------------------------------
2.5.62-mm3 elevator=as:

reiserfs:
rm -rf linux-2.5.63         0.03user 1.76system 0:01.82elapsed 98%CPU 
tar zxf linux-2.5.63.tar.gz 4.96user 6.35system 0:14.09elapsed 80%CPU 
sync                        0.00user 0.13system 0:03.74elapsed 3%CPU 

reiser4:
rm -rf linux-2.5.63         0.14user 3.25system 0:06.37elapsed 53%CPU 
tar zxf linux-2.5.63.tar.gz 5.02user 8.31system 0:15.40elapsed 86%CPU 
sync                        0.00user 0.36system 0:01.21elapsed 30%CPU 

ext3:
rm -rf linux-2.5.63         0.03user 0.55system 0:00.75elapsed 77%CPU 
tar zxf linux-2.5.63.tar.gz 4.75user 4.42system 0:16.83elapsed 54%CPU 
sync                        0.00user 0.18system 0:15.94elapsed 1%CPU 

xfs:
rm -rf linux-2.5.63         0.07user 2.46system 0:07.71elapsed 32%CPU 
tar zxf linux-2.5.63.tar.gz 5.11user 6.80system 0:42.07elapsed 28%CPU 
sync                        0.00user 0.11system 0:03.74elapsed 3%CPU 




