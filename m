Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286243AbRL0LHb>; Thu, 27 Dec 2001 06:07:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286246AbRL0LHL>; Thu, 27 Dec 2001 06:07:11 -0500
Received: from tsunami.iskon.hr ([213.191.128.22]:40197 "EHLO
	tsunami.zg.iskon.hr") by vger.kernel.org with ESMTP
	id <S286243AbRL0LHB>; Thu, 27 Dec 2001 06:07:01 -0500
From: Igor Briski <igor.briski@iskon.hr>
Date: Thu, 27 Dec 2001 12:06:59 +0100
To: linux-kernel@vger.kernel.org
Subject: ext3fs corruption problem?
Message-ID: <20011227120659.O3081@tsunami.iskon.hr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've noticed several files missing in last few days and this 
also started happening:

webmail1 [/space/cwmail/mail/n_z1/f6/jejka74_Pmail_Ixxx_Ixx/2] # ls -la
total 32
drwx--S---    2 www-data www-data     4096 Nov 25 22:47 .
drwx--S---    5 www-data www-data     4096 Dec 26 14:48 ..
-rw-r--r--    1 www-data www-data     1011 Nov 25 22:47 index.dat
-rw-r--r--    1 www-data www-data 18446744069414584903 Nov 23 22:25 m_0.dat
-rw-r--r--    1 www-data www-data      583 Nov 23 22:39 m_1.dat
-rw-r--r--    1 www-data www-data      583 Nov 23 22:39 m_2.dat
-rw-r--r--    1 www-data www-data      479 Nov 25 17:20 m_3.dat
-rw-r--r--    1 www-data www-data      613 Nov 25 22:47 m_4.dat

Details:

webmail1 [~] # uname -a
Linux webmail1.xxxxx.xx 2.4.16-pre1 #1 SMP Mon Nov 26 13:02:35 CET 2001 i686
unknown

webmail1 [~] # mount  
/dev/sda2 on / type ext2 (rw,errors=remount-ro,errors=remount-ro)
proc on /proc type proc (rw)
devpts on /dev/pts type devpts (rw,gid=5,mode=620)
/dev/sda3 on /home type ext2 (rw)
/dev/sda4 on /space type ext3 (rw,data=journal)

webmail1 [~] # uptime
 11:58am  up 3 days, 49 min,  1 user,  load average: 0.16, 0.24, 0.32

webmail1 [~] # df
Filesystem           1k-blocks      Used Available Use% Mounted on
/dev/sda2              2885812    914012   1825208  33% /
/dev/sda3              1921188    118712   1704884   7% /home
/dev/sda4            135152264  76508056  57271136  57% /space

(/dev/sda4 is a RAID-5 array with 5 disks, 36GB each on a ICP-VORTEX
controller).


And when mounted as ext2, the file stays the same:

webmail1 [/space/cwmail/mail/n_z1/f6/jejka74_Pmail_Ixxx_Ixx/2] # ls -la
total 32
drwx--S---    2 www-data www-data     4096 Nov 25 22:47 .
drwx--S---    5 www-data www-data     4096 Dec 26 14:48 ..
-rw-r--r--    1 www-data www-data     1011 Nov 25 22:47 index.dat
-rw-r--r--    1 www-data www-data 18446744069414584903 Nov 23 22:25 m_0.dat
-rw-r--r--    1 www-data www-data      583 Nov 23 22:39 m_1.dat
-rw-r--r--    1 www-data www-data      583 Nov 23 22:39 m_2.dat
-rw-r--r--    1 www-data www-data      479 Nov 25 17:20 m_3.dat
-rw-r--r--    1 www-data www-data      613 Nov 25 22:47 m_4.dat

I've successfully removed the file while mounted as ext2 (haven't tried it
when the partition was mounted as ext3). 

-- 
        v
Igor Briski - igor.briski@iskon.hr
