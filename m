Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266077AbTGDSBi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 14:01:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266078AbTGDSBi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 14:01:38 -0400
Received: from dsl-gte-19434.linkline.com ([64.30.195.78]:31622 "EHLO server")
	by vger.kernel.org with ESMTP id S266077AbTGDSBd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 14:01:33 -0400
Message-ID: <16f701c34258$48057ba0$3400a8c0@W2RZ8L4S02>
From: "Jim Gifford" <maillist@jg555.com>
To: linux-kernel@vger.kernel.org
Subject: Kernel Lockup - Was:  Probably 2.4 kernel or AIC7xxx module trouble
Date: Fri, 4 Jul 2003 11:15:41 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote a small script last night to check my problem.

#!/bin/sh
rm /root/ps.dat
while true; do
  # Date the file, or you could as well use the file's date field.
  date > /root/ps.dat
  echo "====" >> /root/ps.dat
  # Have a snipset of what's running on the machine.
  ps aux >> /root/ps.dat
  # To be sure we didn't crash while ps'ing
  echo "====" >> /root/ps.dat
  # To pevent from FS corruption
  sync
  # Have a little sleep... |-O
  sleep 1
done

The wierd part is that the system didn't lock up, last night like it usually
does.

I also had vmstat -i run all night also, to help locate the problem.

Here is the output of both files and the loadaverage

At startup
top - 13:38:10 up 5 min, 1 user, load average: 3.70, 1.78, 0.72
Tasks: 106 total, 3 running, 103 sleeping, 0 stopped, 0 zombie
Cpu0 : 30.8% user, 13.5% system, 55.8% nice, 0.0% idle
Cpu1 : 39.7% user, 18.6% system, 41.7% nice, 0.0% idle
Mem: 1033896k total, 195548k used, 838348k free, 7188k buffers
Swap: 1060280k total, 0k used, 1060280k free, 45132k cached

vmstat
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu--
--
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id
wa
 4  1      0 840600   5108  39192    0    0    94    29   61   185 44  9 47
0
 4  2      0 835736   5196  39236    0    0    36   524  146   947 78 22  0
0
 5  0      0 845516   5208  39224    0    0     8   272  195   876 87 13  0
0
 3  0      0 845772   5212  39260    0    0    36     0  122   499 92  8  0
0
 4  0      0 845536   5240  39268    0    0     0   236  133   345 91  9  0
0
 6  0      0 840236   5328  39272    0    0     0   480  173   866 82 18  0
0
 7  0      0 838084   5344  39924    0    0   668     0  226   833 84 16  0
0
 3  0      0 838124   5376  39940    0    0     0   344  147   941 80 20  0
0
 4  0      0 837800   5388  39940    0    0     4    64  113   272 93  7  0
0
 5  0      0 838800   5412  39952    0    0     0   296  136  1035 82 18  0
0

ps

    The ps data is the same as the other one.
After 17 hours

top - 11:11:51 up 17:13,  2 users,  load average: 3.72, 3.71, 3.79
Tasks: 114 total,   4 running, 110 sleeping,   0 stopped,   0 zombie
 Cpu0 :  28.7% user,  18.4% system,  52.9% nice,   0.0% idle
 Cpu1 :  33.1% user,  17.0% system,  49.8% nice,   0.0% idle
Mem:   1033896k total,   453256k used,   580640k free,   109232k buffers
Swap:  1060280k total,        0k used,  1060280k free,   158876k cached

vmstat
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu--
--
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id
wa
 6  0      0 580424 109232 158892    0    0     0   112  111   678 74 26  0
0
 4  0      0 580680 109232 158896    0    0     0   352  153   882 70 30  0
0
 3  0      0 579696 109232 158884    0    0     0     0  104   752 70 30  0
0
 4  0      0 579416 109232 158896    0    0     0   280  134   429 73 27  0
0
 4  0      0 579868 109232 158892    0    0     0     0  111   903 62 38  0
0
 5  0      0 580032 109232 158896    0    0     0   324  141   789 68 32  0
0
 2  1      0 580264 109232 158896    0    0     0   280  112   509 81 19  0
0
 3  0      0 579360 109232 158896    0    0     0     0  137   691 72 28  0
0
 3  2      0 578780 109232 158896    0    0     0   208  130   927 65 35  0
0
 2  0      0 579412 109232 158896    0    0     0   172  139   646 73 27  0
0
 5  2      0 580436 109232 158896    0    0     0   408  156   558 73 27  0
0
 3  0      0 580312 109232 158896    0    0     0   112  143   896 74 26  0
0
 2  1      0 580976 109232 158896    0    0     0   304  138  1059 68 32  0
0
 7  0      0 579768 109232 158896    0    0     0     0  116   129 88 13  0
0
 4  1      0 580208 109232 158896    0    0     0   388  119   994 71 29  0
0
 3  0      0 580100 109232 158896    0    0     0     0  132   878 75 25  0
0
 2  0      0 579388 109232 158896    0    0     0   280  135   471 83 17  0
0
 4  0      0 580316 109232 158884    0    0     0     0  105   686 80 20  0
0
 4  0      0 580360 109232 158896    0    0     0   312  138   938 72 28  0
0
 3  0      0 579348 109232 158888    0    0     0   140  120   670 77 23  0
0
 6  0      0 580232 109232 158896    0    0     0   264  150   671 76 24  0
0

ps

Fri Jul  4 11:14:45 PDT 2003
====
USER       PID %CPU %MEM   VSZ  RSS TTY      STAT START   TIME COMMAND
root         1  0.0  0.0  1400  548 ?        S    Jul03   0:05 init
root         2  0.0  0.0     0    0 ?        SW   Jul03   0:00 [keventd]
root         3  0.0  0.0     0    0 ?        SWN  Jul03   0:00
[ksoftirqd_CPU0]
root         4  0.0  0.0     0    0 ?        SWN  Jul03   0:00
[ksoftirqd_CPU1]
root         5  0.0  0.0     0    0 ?        SW   Jul03   0:00 [kswapd]
root         6  0.0  0.0     0    0 ?        SW   Jul03   0:00 [bdflush]
root         7  0.0  0.0     0    0 ?        SW   Jul03   0:03 [kupdated]
root        17  0.0  0.0     0    0 ?        SW   Jul03   0:00 [ahc_dv_0]
root        18  0.0  0.0     0    0 ?        SW   Jul03   0:00 [ahc_dv_1]
root        19  0.0  0.0     0    0 ?        SW   Jul03   0:00 [scsi_eh_1]
root        20  0.0  0.0     0    0 ?        SW   Jul03   0:00 [scsi_eh_2]
root        22  0.0  0.0     0    0 ?        SW   Jul03   0:00 [khubd]
root        31  0.1  0.0     0    0 ?        SW   Jul03   2:00 [kjournald]
root        50  0.0  0.0  1556  808 ?        S    Jul03   0:35 devfsd /dev
root        73  0.0  0.0     0    0 ?        SW   Jul03   0:00 [kjournald]
root        74  0.0  0.0     0    0 ?        SW   Jul03   0:43 [kjournald]
root        75  0.0  0.0     0    0 ?        SW   Jul03   0:10 [kjournald]
root       227  0.0  0.0  1600  596 ?        S    Jul03   0:00 gpm -m
/dev/psaux -t ps2
root       242  0.0  0.0  1888  964 ?        S    Jul03   0:35 syslog-ng
root       271  0.0  0.1  2548 1584 ?        S    Jul03   0:13 dhcpd -cf
/etc/dhcp/dhcpd.conf -q eth1
root      1563  1.4  0.3  5516 3712 ?        S    Jul03  15:30 /usr/bin/perl
/etc/zorbiptraffic/zorbcount.pl
root      1570  0.0  0.1  2404 1192 ?        S    Jul03   0:00 /bin/sh
/usr/bin/safe_mysqld --socket=/var/sockets/mysql.sock
mysql     1588  0.0  1.3 50204 13904 ?       S    Jul03   0:00
/usr/sbin/mysqld --basedir=/usr --datadir=/var/lib/mysql --us$
mysql     1591  0.0  1.3 50204 13904 ?       S    Jul03   0:04
/usr/sbin/mysqld --basedir=/usr --datadir=/var/lib/mysql --us$
mysql     1592  0.0  1.3 50204 13904 ?       S    Jul03   0:00
/usr/sbin/mysqld --basedir=/usr --datadir=/var/lib/mysql --us$
mysql     1593  0.0  1.3 50204 13904 ?       S    Jul03   0:00
/usr/sbin/mysqld --basedir=/usr --datadir=/var/lib/mysql --us$
mysql     1594  0.0  1.3 50204 13904 ?       S    Jul03   0:00
/usr/sbin/mysqld --basedir=/usr --datadir=/var/lib/mysql --us$
mysql     1595  0.0  1.3 50204 13904 ?       S    Jul03   0:00
/usr/sbin/mysqld --basedir=/usr --datadir=/var/lib/mysql --us$
root      1596  0.0  0.6 12360 6968 ?        S    Jul03   0:00 clamd
root      1597  0.0  0.6 12360 6968 ?        S    Jul03   0:04 clamd
root      1598 64.5  0.6 12360 6968 ?        R    Jul03 667:30 clamd
root      1600  0.0  0.6 12360 6968 ?        S    Jul03   0:07 clamd
mysql     1605  0.0  1.3 50204 13904 ?       S    Jul03   0:00
/usr/sbin/mysqld --basedir=/usr --datadir=/var/lib/mysql --us$
mysql     1606  0.2  1.3 50204 13904 ?       S    Jul03   2:52
/usr/sbin/mysqld --basedir=/usr --datadir=/var/lib/mysql --us$
mysql     1607  0.0  1.3 50204 13904 ?       S    Jul03   0:00
/usr/sbin/mysqld --basedir=/usr --datadir=/var/lib/mysql --us$
mysql     1608  0.0  1.3 50204 13904 ?       S    Jul03   0:00
/usr/sbin/mysqld --basedir=/usr --datadir=/var/lib/mysql --us$
mysql     1609  0.3  1.3 50204 13904 ?       S    Jul03   3:09
/usr/sbin/mysqld --basedir=/usr --datadir=/var/lib/mysql --us$
spam      1698  0.0  2.0 23692 21528 ?       S    Jul03   0:08 /usr/bin/perl
/usr/bin/spamd -d -c -a -q -x -u spam
courier   1772  0.0  0.0  1372  436 ?        S    Jul03   0:00
/usr/sbin/courierfilter start
courier   1774  0.0  0.0  1368  344 ?        S    Jul03   0:00 courierlogger
courierfilter
root      1790  0.0  0.0  2840  760 ?        S    Jul03   0:00
/usr/libexec/authlib/authdaemond.mysql start
root      1792  0.0  0.1  2920 1172 ?        S    Jul03   0:01
/usr/libexec/authlib/authdaemond.mysql start
root      1793  0.0  0.1  2920 1172 ?        S    Jul03   0:01
/usr/libexec/authlib/authdaemond.mysql start
root      1794  0.0  0.1  2920 1172 ?        S    Jul03   0:01
/usr/libexec/authlib/authdaemond.mysql start
root      1795  0.0  0.1  2920 1172 ?        S    Jul03   0:02
/usr/libexec/authlib/authdaemond.mysql start
root      1798  0.0  0.1  2920 1172 ?        S    Jul03   0:01
/usr/libexec/authlib/authdaemond.mysql start
root      1815  0.0  0.0  3212 1024 ?        S    Jul03   0:00
/usr/libexec/courier/courierd
courier   1845  0.0  0.0  2488  888 ?        S    Jul03   0:00
/usr/sbin/couriertcpd -stderrlogger=/usr/sbin/courierlogger -$
courier   1858  0.0  0.0  1376  480 ?        S    Jul03   0:00
/usr/sbin/courierlogger courieresmtpd
courier   1872  0.0  0.0  2488  888 ?        S    Jul03   0:00
/usr/sbin/couriertcpd -stderrlogger=/usr/sbin/courierlogger -$
courier   1884  0.0  0.0  1376  480 ?        S    Jul03   0:00
/usr/sbin/courierlogger esmtpd-ssl
root      1899  0.0  0.0  2204  616 ?        S    Jul03   0:00
/usr/sbin/couriertcpd -address=0 -stderrlogger=/usr/sbin/cour$
root      1908  0.0  0.0  1368  344 ?        S    Jul03   0:00
/usr/sbin/courierlogger pop3d
root      1921  0.0  0.0  2204  616 ?        S    Jul03   0:00
/usr/sbin/couriertcpd -address=0 -stderrlogger=/usr/sbin/cour$
root      1931  0.0  0.0  1368  344 ?        S    Jul03   0:00
/usr/sbin/courierlogger pop3d-ssl
root      1951  0.0  0.0  2204  620 ?        S    Jul03   0:00
/usr/sbin/couriertcpd -address=0 -stderrlogger=/usr/sbin/cour$
root      1961  0.0  0.0  1376  480 ?        S    Jul03   0:00
/usr/sbin/courierlogger imapd
root      1979  0.0  0.0  2204  620 ?        S    Jul03   0:01
/usr/sbin/couriertcpd -address=0 -stderrlogger=/usr/sbin/cour$
root      1987  0.0  0.0  1376  480 ?        S    Jul03   0:02
/usr/sbin/courierlogger imapd-ssl
root      1996  0.0  0.0  1480  664 ?        S    Jul03   0:02 fcron
root      2002  0.0  0.1  4812 1912 ?        S    Jul03   0:14 cupsd
bin       2611  0.0  0.0  1484  456 ?        S    Jul03   0:00 portmap
root      2623  0.0  0.0  1816  952 ?        S    Jul03   0:02 chronyd -f
/etc/

