Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267048AbTB0XYr>; Thu, 27 Feb 2003 18:24:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267222AbTB0XYr>; Thu, 27 Feb 2003 18:24:47 -0500
Received: from mailrelay2.lanl.gov ([128.165.4.103]:56254 "EHLO
	mailrelay2.lanl.gov") by vger.kernel.org with ESMTP
	id <S267048AbTB0XYl>; Thu, 27 Feb 2003 18:24:41 -0500
Subject: 2.5.63-mm1, results of tar test with various elevators and file
	systems.
From: Steven Cole <elenstev@mesatop.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Hans Reiser <reiser@namesys.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 27 Feb 2003 16:31:11 -0700
Message-Id: <1046388671.6617.293.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings all,

I ran the following script on 2.5.63-mm1 with different
elevator options and on several different journaling file systems.

#!/bin/sh
for i in 1 2 3 4 5
do
        time rm -rf linux-2.5.63
        time tar zxf linux-2.5.63.tar.gz
        time sync
        echo ' '
done

The following data is from the 5th run in each case.

It looks like reiserfs likes the cfq elevator while xfs does not
for this particular test.  Sorry, not enough time for a more thorough
analysis.

Steven

---------------------------------------------------------------------
2.5.63-mm1 elevator=as

reiserfs:
rm -rf linux-2.5.63         0.04user 1.76system 0:01.86elapsed 96%CPU 
tar zxf linux-2.5.63.tar.gz 4.82user 5.55system 0:14.38elapsed 72%CPU 
sync                        0.00user 0.01system 0:01.42elapsed 1%CPU 

reiser4:
rm -rf linux-2.5.63         0.14user 3.31system 0:06.55elapsed 52%CPU 
tar zxf linux-2.5.63.tar.gz 4.89user 8.16system 0:15.86elapsed 82%CPU 
sync                        0.00user 0.36system 0:01.24elapsed 29%CPU 

ext3:
rm -rf linux-2.5.63         0.03user 0.56system 0:00.75elapsed 79%CPU 
tar zxf linux-2.5.63.tar.gz 4.77user 4.33system 0:18.36elapsed 49%CPU
sync                        0.00user 0.20system 0:12.80elapsed 1%CPU 

xfs:
rm -rf linux-2.5.63         0.07user 2.53system 0:07.14elapsed 36%CPU
tar zxf linux-2.5.63.tar.gz 4.97user 6.15system 0:35.64elapsed 31%CPU
sync                        0.00user 0.02system 0:03.39elapsed 0%CPU

---------------------------------------------------------------------
2.5.63-mm1 elevator=cfq

reiserfs:
rm -rf linux-2.5.63         0.04user 1.75system 0:01.87elapsed 96%CPU 
tar zxf linux-2.5.63.tar.gz 4.85user 5.55system 0:12.77elapsed 81%CPU 
sync                        0.00user 0.17system 0:02.53elapsed 6%CPU 

reiser4:
rm -rf linux-2.5.63         0.15user 3.25system 0:06.48elapsed 52%CPU 
tar zxf linux-2.5.63.tar.gz 4.92user 8.27system 0:14.27elapsed 92%CPU
sync                        0.00user 0.37system 0:01.21elapsed 30%CPU 

ext3:
rm -rf linux-2.5.63         0.02user 0.56system 0:00.73elapsed 80%CPU 
tar zxf linux-2.5.63.tar.gz 4.71user 4.25system 0:19.80elapsed 45%CPU 
sync                        0.00user 0.16system 0:15.78elapsed 1%CPU 

xfs:
rm -rf linux-2.5.63         0.07user 2.56system 0:07.33elapsed 35%CPU
tar zxf linux-2.5.63.tar.gz 5.06user 6.77system 0:44.77elapsed 26%CPU
sync                        0.00user 0.12system 0:03.72elapsed 3%CPU 

---------------------------------------------------------------------
2.5.63-mm1 elevator=deadline

reiserfs:
rm -rf linux-2.5.63         0.04user 1.77system 0:01.86elapsed 97%CPU 
tar zxf linux-2.5.63.tar.gz 4.97user 5.79system 0:13.18elapsed 81%CPU 
sync                        0.00user 0.09system 0:02.29elapsed 4%CPU 

reiser4:
rm -rf linux-2.5.63         0.15user 3.32system 0:06.70elapsed 51%CPU 
tar zxf linux-2.5.63.tar.gz 4.83user 8.09system 0:15.54elapsed 83%CPU
sync                        0.00user 0.36system 0:01.18elapsed 30%CPU 

ext3:
rm -rf linux-2.5.63         0.03user 0.59system 0:00.77elapsed 80%CPU 
tar zxf linux-2.5.63.tar.gz 4.77user 4.61system 0:19.84elapsed 47%CPU 
sync                        0.00user 0.19system 0:14.55elapsed 1%CPU 

xfs:
rm -rf linux-2.5.63         0.06user 2.46system 0:07.36elapsed 34%CPU
tar zxf linux-2.5.63.tar.gz 5.05user 6.50system 0:36.68elapsed 31%CPU
sync                        0.00user 0.01system 0:03.23elapsed 0%CPU 




