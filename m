Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265791AbTB0RUs>; Thu, 27 Feb 2003 12:20:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265711AbTB0RUs>; Thu, 27 Feb 2003 12:20:48 -0500
Received: from franka.aracnet.com ([216.99.193.44]:21703 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S265791AbTB0RUr>; Thu, 27 Feb 2003 12:20:47 -0500
Date: Thu, 27 Feb 2003 09:31:03 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 417] New: htree much slower than regular ext3 
Message-ID: <11490000.1046367063@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=417

           Summary: htree much slower than regular ext3
    Kernel Version: 2.5.63-bk3
            Status: NEW
          Severity: normal
             Owner: akpm@digeo.com
         Submitter: bwindle-kbt@fint.org


Distribution: Debian Testing

Hardware Environment: x86, 256mb RAM, PIIX4, Maxtor 91728D8 ATA DISK drive

Software Environment: 
Linux razor 2.5.63bk3 #25 Thu Feb 27 10:13:35 EST 2003 i686 Pentium II 
(Klamath) GenuineIntel GNU/Linux

Gnu C                  2.95.4
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
module-init-tools      implemented
e2fsprogs              1.30-WIP
reiserfsprogs          3.6.3
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               4.5.2

Problem Description:
I created a directory ("test") with 32000 (ok, 31998) directories in it,
and  put a file called 'foo' in each of them (for i in `ls`; do cd $i &&
touch bar  && cd .. ; done). Then I took that ext3 partion, umounted it,
did a 'tune2fs -O  dir_index', then 'fsck -fD', and remounted. I then did a
'time du -hs' on the  test directory, and here are the results.

ext3+htree:     
bwindle@razor:/giant/inodes$ time du -hs
126M    .

real    7m21.756s
user    0m2.021s
sys     0m22.190s

I then unmounted, tune2fs -O ^dir_index, e2fsck -fD /dev/hdb1, remounted,
and  did another du -hs on the test directory. It took 1 minute, 48 seconds.

bwindle@razor:/giant/test$ time du -hs
126M    .

real    1m48.760s
user    0m1.986s
sys     0m21.563s


I thought htree was supposed to speed up access with large numbers of 
directories?


